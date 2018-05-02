#!/bin/bash

#Creating the container using a turtlebot to map the room
#/dev/ttyACM0 is the laser; /dev/input/js0 is the joystick; /dev/kobuki is the turtlebot
sudo docker container create -it --rm \
    --device=/dev/ttyACM0 --device=/dev/input/js0 --device=/dev/kobuki \
    --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ros:mapping \
    roslaunch adaptive_local_planner $launchfile \
    > /dev/null
containerId=$(sudo docker container ps -l -q --no-trunc)

#Opening up xhost to the container, allowing rviz to start its GUI
xhost +local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId` > /dev/null

#Starting the container in interactive mode
sudo docker container start $containerId > /dev/null
echo "RVIZ will start in a few seconds..."

#At the user initiative, saving the built map and transferring it to the host
read -p "Press <ENTER> to save the current map and stop mapping process." _
echo "Saving the map..."
sudo docker container exec -it $containerId /bin/bash -c "source /ros_entrypoint.sh && rosrun map_server map_saver -f /tmp/turtlebot_map" > /dev/null
sudo docker cp $containerId:/tmp/turtlebot_map.yaml /tmp/turtlebot_map.yaml > /dev/null
sudo docker cp $containerId:/tmp/turtlebot_map.pgm /tmp/turtlebot_map.pgm > /dev/null
echo "Map saved to: /tmp/turtlebot_map.pgm & /tmp/turtlebot_map.yml"

#Closing xhost access opened for the container
xhost -local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId` > /dev/null

#Stoping and removing container
sudo docker container stop $containerId > /dev/null
