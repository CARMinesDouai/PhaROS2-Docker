#This Docker image goal is to run a Turtlebot demo with ROS2
FROM osrf/ros2:ardent-basic

#Setup ROS1 Sources
RUN apt-get update && apt-get install -y lsb-release
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

#Setup ROS1 Environment at run start
RUN sed -i '4 a source "/opt/ros/$ROS_DISTRO/setup.bash"' /ros2_entrypoint.sh

#Install Turtlebot demo specific packages
RUN apt-get update && apt-get install -y ros-ardent-turtlebot2* ros-kinetic-kobuki-ftdi
