#!/bin/bash
if [ $# -ne 1 ]
 then
  echo "This script needs one argument : the path to the premade map.yaml"
fi

#Creating the container using a turtlebot to navigate in the room
#/dev/ttyACM0 is the laser; /dev/input/js0 is the joystick; /dev/kobuki is the turtlebot
sudo docker container create -it \
    --device=/dev/ttyACM0 --device=/dev/input/js0 --device=/dev/kobuki \
    --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env TURTLEBOT_MAP_FILE=$1 \
    ros:navigation-in-map \
    roslaunch adaptive_local_planner turtlebot_navigation_in_map.launch

#Opening up xhost to the container, allowing rviz to start its GUI
containerId=$(sudo docker container ps -l -q --no-trunc)
xhost +local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Starting the container in interactive mode
sudo docker container start -i $containerId

#Closing xhost access opened for the container
xhost -local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Removing container
sudo docker container rm $containerId
