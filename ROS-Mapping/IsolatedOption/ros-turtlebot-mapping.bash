#!/bin/bash

#Creating the container from the ros:mapping image, it uses a turtlebot to map a room
#/dev/ttyACM0 is the laser; /dev/input/js0 is the joystick; /dev/kobuki is the turtlebot
sudo docker container create -it \
    --device=/dev/ttyACM0 --device=/dev/input/js0 --device=/dev/kobuki \
    --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ros:mapping \
    roslaunch adaptive_local_planner simple_exploration_karto.launch

#Opening up xhost to the container, allowing rviz to start its GUI
containerId=$(sudo docker container ps -l -q --no-trunc)
xhost +local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Starting the container in interactive mode
sudo docker container start -i $containerId

#Closing xhost access opened for the container
xhost -local:`sudo docker inspect --format='{{ .Config.Hostname }}' $containerId`

#Removing container
sudo docker container rm $containerId
