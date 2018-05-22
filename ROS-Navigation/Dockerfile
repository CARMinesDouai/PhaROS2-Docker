#Docker image for navigating in a map with a Turtlebot

#The initial image already has ROS kinetic installed, as well as the desktop libraries of xenial
FROM osrf/ros:kinetic-desktop-full-xenial

#Install the default ros navigation stack and suitesparse library needed by Karto SLAM
RUN apt-get update && apt-get install -y ros-kinetic-navigation libsuitesparse-dev
#Install the turtlebot dependencies
RUN apt-get update && apt-get install -y ros-kinetic-kobuki ros-kinetic-kobuki-core
#Install necessary packages for the turlebot and the laser drivers
RUN apt-get update && apt-get install -y ros-kinetic-turtlebot-* ros-kinetic-urg-node
#Install rviz
RUN apt-get update && apt-get install -y ros-kinetic-rviz

#Downloading the navigation launchfile from github
RUN apt-get update && apt-get install -y wget
RUN wget -O /opt/ros/kinetic/share/turtlebot_navigation/launch/turtlebot_navigation_in_map.launch https://raw.githubusercontent.com/CARMinesDouai/PhaROS2/master/ROS-Navigation/launch/turtlebot_navigation_in_map.launch
RUN mkdir /opt/ros/kinetic/share/turtlebot_navigation/rviz && wget -O /opt/ros/kinetic/share/turtlebot_navigation/rviz/robot_navigation.rviz https://raw.githubusercontent.com/CARMinesDouai/PhaROS2/master/ROS-Navigation/rviz/robot_navigation.rviz
