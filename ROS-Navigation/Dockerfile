#Docker image for navigating in a map with a Turtlebot

#The initial image already has ROS kinetic installed and several mapping modules, as well as the desktop libraries of xenial
#The Dockerfile of this initial image can be found here: https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Mapping/IsolatedOption/Dockerfile
FROM ros:mapping-desktop

#Downloading the navigation launchfile from github
RUN apt-get update && apt-get install -y wget
RUN wget -O /opt/ros/kinetic/share/turtlebot_navigation/launch/turtlebot_navigation_in_map.launch https://raw.githubusercontent.com/CARMinesDouai/PhaROS2/master/ROS-Navigation/launch/turtlebot_navigation_in_map.launch
