#This Docker image goal is to run a Turtlebot demo with ROS2

#Built from ros:kinetic to allow access to ROS1 packages needed for Turtlebot demo
FROM ros:kinetic

#Setup Sources
RUN apt-get update && apt-get install -y curl
RUN curl http://repo.ros2.org/repos.key | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main xenial main" > /etc/apt/sources.list.d/ros2-latest.list'

#Install ROS2 packages
RUN apt-get update && apt-get install -y `apt list "ros-ardent-*" 2> /dev/null | grep "/" | awk -F/ '{print $1}' | grep -v -e ros-ardent-ros1-bridge -e ros-ardent-turtlebot2- | tr "\n" " "`

#Turtlebo2 demo specific packages
RUN apt-get update && apt-get install -y ros-ardent-turtlebot2* ros-kinetic-kobuki-ftdi

#Environment setup at run start
ENV ROS_DISTRO ardent
ENTRYPOINT  ["/ros_entrypoint.sh"]
