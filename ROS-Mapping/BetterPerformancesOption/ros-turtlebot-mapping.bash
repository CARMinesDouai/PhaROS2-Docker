#!/bin/bash

#Getting the IP of the future container (by running a temporary container)
sudo docker run -d --rm ros:mapping
containerId=$(sudo docker container ps -l -q --no-trunc)
containerIP=$(sudo docker container inspect --format '{{ .NetworkSettings.IPAddress }}' $containerId)
sudo docker container stop $containerId

#Creating the container using a turtlebot to map the room
#/dev/ttyACM0 is the laser; /dev/input/js0 is the joystick; /dev/kobuki is the turtlebot
sudo docker run -d --rm \
    --device=/dev/ttyACM0 --device=/dev/input/js0 --device=/dev/kobuki \
    --env ROS_IP=$containerIP \
    ros:mapping \
    roslaunch adaptive_local_planner simple_exploration_karto.launch
containerId=$(sudo docker container ps -l -q --no-trunc)

#Launching RVIZ on the host
ROS_MASTER_URI=http://$containerIP:11311 rviz

#When user exit RVIZ the map will be saved, then the container will stop and be removed
ROS_MASTER_URI=http://$containerIP:11311 rosrun map_server map_saver -f /tmp/ros_map
echo "Map saved to: /tmp/ros_map.pgm & /tmp/ros_map.yml"
sudo docker container stop $containerId
