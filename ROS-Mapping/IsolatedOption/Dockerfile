#Docker image for Mapping with a Turtlebot
FROM osrf/ros:kinetic-desktop-full-xenial

#Arguments for building
ARG PYTHONPATH=/opt/ros/kinetic/lib/python2.7/dist-packages
ARG CMAKE_PREFIX_PATH=/opt/ros/kinetic

#Create new workspace at the home folder 
RUN mkdir ~/rosws ~/rosws/src
RUN ./opt/ros/kinetic/bin/catkin_make -C ~/rosws

#Install the default ros navigation stack and suitesparse library needed by Karto SLAM
RUN apt-get update && apt-get install -y ros-kinetic-navigation libsuitesparse-dev
#Install the turtlebot dependencies
RUN apt-get update && apt-get install -y ros-kinetic-kobuki ros-kinetic-kobuki-core
#Install necessary packages for the turlebot and the laser drivers
RUN apt-get update && apt-get install -y ros-kinetic-turtlebot-* ros-kinetic-urg-node
#Install rviz
RUN apt-get update && apt-get install -y ros-kinetic-rviz

#Clone all the packages in the github repository and rename it to src
RUN git clone https://github.com/lxsang/ROS-packages && rm -r ~/rosws/src && mv ROS-packages ~/rosws/src
#Ignore these packages for now
RUN touch ~/rosws/src/pharos_probabilistic_merging/CATKIN_IGNORE
RUN touch ~/rosws/src/dslam/CATKIN_IGNORE

#Generate dependent messages
RUN ./opt/ros/kinetic/bin/catkin_make multi_master_bridge_generate_messages -C ~/rosws
#Build all of the packages
RUN ./opt/ros/kinetic/bin/catkin_make -C ~/rosws

#Source our workspace environment
RUN sed -i '5 a source "/root/rosws/devel/setup.sh"' /ros_entrypoint.sh
