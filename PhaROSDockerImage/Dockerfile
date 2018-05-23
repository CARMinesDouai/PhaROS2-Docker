#This Docker image goal is to use PhaROS with ROS Kinetic inside of a container

#The initial image already has ROS Kinetic installed
FROM osrf/ros:kinetic-desktop-full-xenial

#Install curl && unzip
RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y unzip

#Enabling and installing the 32-bit libraries needed
RUN dpkg --add-architecture i386 
RUN apt-get update && apt-get install -y libx11-6:i386 libgl1-mesa-glx:i386 libfontconfig1:i386 libssl1.0.0:i386

#Install PhaROS
RUN /bin/bash -c "source ros_entrypoint.sh && curl http://car.mines-douai.fr/scripts/PhaROS | bash" 
