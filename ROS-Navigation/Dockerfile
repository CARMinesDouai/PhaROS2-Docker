#Docker image for navigating in a map with a Turtlebot
FROM ros:mapping-isolated

#Wget the navigation launchfile from github
RUN apt-get update && apt-get install -y wget
RUN wget -O /root/rosws/src/adaptive_local_planner/launch/turtlebot_navigation_in_map.launch https://raw.githubusercontent.com/CARMinesDouai/PhaROS2/master/ROS-Navigation/launch/turtlebot_navigation_in_map.launch
