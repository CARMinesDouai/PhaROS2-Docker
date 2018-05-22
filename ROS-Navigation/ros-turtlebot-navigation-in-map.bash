#!/bin/bash
#This script will use the ros:navigation-in-map docker image to navigate in a already mapped room with a turtlebot and a laser

#Error if script doesn't have exactly one argument
if [ $# -ne 1 ]
 then
  echo -e "\e[1;31mERROR! This script needs one argument : the path to the premade map (without any extension).\e[0m"
  return 1
fi

#Creating the container
#/dev/ttyACM0 is the laser; /dev/kobuki is the turtlebot
sudo docker container create -it --rm \
    --device=/dev/ttyACM0 --device=/dev/kobuki \
    --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env TURTLEBOT_MAP_FILE=/tmp/turtlebot_map.yaml \
    ros:navigation-in-map \
    roslaunch turtlebot_navigation turtlebot_navigation_in_map.launch
containerId=$(sudo docker container ps -l -q --no-trunc)

#Transfering the map to the container
sudo docker cp $1.yaml $containerId:/tmp/turtlebot_map.yaml
sudo docker cp $1.pgm $containerId:/tmp/turtlebot_map.pgm

#Opening up xhost to the container, allowing rviz to start its GUI
xhost +local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Starting the container in interactive mode
sudo docker container start -i $containerId

#Closing xhost access opened for the container
xhost -local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`
