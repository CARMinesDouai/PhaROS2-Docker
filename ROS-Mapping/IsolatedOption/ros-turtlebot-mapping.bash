#!/bin/bash 
#This script will use the ros:mapping-desktop docker image to map a room with a turtlebot, a laser and a joystick

#By default this script uses a teleop mapping launchfile, but can also use an autonomous one (not maintained)
launchfile=simple_exploration_karto.launch
while getopts "a" opt; do
	case $opt in
		a)
			launchfile=autonomous_single_robot_exploration_karto.launch
			;;
	esac
done

#Creating the docker container
#/dev/ttyACM0 is the laser; /dev/input/js0 is the joystick; /dev/kobuki is the turtlebot
sudo docker container create -it --rm \
    --device=/dev/ttyACM0 --device=/dev/input/js0 --device=/dev/kobuki \
    --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ros:mapping-desktop \
    roslaunch adaptive_local_planner $launchfile \
    > /dev/null
containerId=$(sudo docker container ps -l -q --no-trunc)

#Opening up xhost to the container, allowing rviz to start its GUI
xhost +local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Starting the container in interactive mode
sudo docker container start $containerId > /dev/null
echo "RVIZ will start in a few seconds..."
sleep 10s #to allow mapping process to start

#At the user initiative, saving the built map and transferring it to the host
read -p "Press <ENTER> to save the current map and stop mapping process." _
echo "Saving the map..."
sudo docker container exec -it $containerId /bin/bash -c "source /ros_entrypoint.sh && rosrun map_server map_saver -f /tmp/turtlebot_map" > /dev/null
sudo docker cp $containerId:/tmp/turtlebot_map.yaml /tmp/turtlebot_map.yaml > /dev/null
sudo docker cp $containerId:/tmp/turtlebot_map.pgm /tmp/turtlebot_map.pgm > /dev/null
echo "Map saved to: /tmp/turtlebot_map.pgm & /tmp/turtlebot_map.yml"
echo "Stopping mapping process..."

#Closing xhost access opened for the container
xhost -local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Stoping and removing container
sudo docker container stop $containerId > /dev/null
