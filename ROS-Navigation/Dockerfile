#Docker image for navigating in a map with a Turtlebot
FROM osrf/ros:kinetic-desktop-full-xenial

#Arguments for building
#ARG PYTHONPATH=/opt/ros/kinetic/lib/python2.7/dist-packages
#ARG CMAKE_PREFIX_PATH=/opt/ros/kinetic

#Install the default ros navigation stack and suitesparse library needed by Karto SLAM
RUN apt-get update && apt-get install -y ros-kinetic-navigation libsuitesparse-dev
#Install the turtlebot dependencies
RUN apt-get update && apt-get install -y ros-kinetic-kobuki ros-kinetic-kobuki-core
#Install necessary packages for the turlebot and the laser drivers
RUN apt-get update && apt-get install -y ros-kinetic-turtlebot-* ros-kinetic-urg-node
#Install rviz
RUN apt-get update && apt-get install -y ros-kinetic-rviz

#Wget the navigation launchfile from github
RUN apt-get update && apt-get install -y wget
RUN wget -O /opt/ros/kinetic/share/turtlebot_navigation/launch/turtlebot_navigation_in_map.launch https://raw.githubusercontent.com/CARMinesDouai/PhaROS2/master/ROS-Navigation/launch/turtlebot_navigation_in_map.launch
RUN mkdir /opt/ros/kinetic/share/turtlebot_navigation/rviz && wget -O /opt/ros/kinetic/share/turtlebot_navigation/rviz/robot_navigation.rviz https://raw.githubusercontent.com/CARMinesDouai/PhaROS2/master/ROS-Navigation/rviz/robot_navigation.rviz
