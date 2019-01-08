# Index Table
Each section contains its own tutorial and each files are thoroughly commented, so don't be afraid to read their code if you want to know more about them !    
**Note :** Most of the work on this GitHub uses Docker. If you don't have it installed follow my [Docker Installation tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/Docker%20Installation).    

## [Docker Installation](https://github.com/CARMinesDouai/PhaROS2-Docker/tree/master/Docker%20Installation)    
Here you will find a tutorial on how to properly install Docker on your machine, including the optionnal configuration steps needed to use it behind an internet proxy.    
A script is included for an automatic installation (with or without proxy) if you wish to use it.

## [PhaROS Docker image](https://github.com/CARMinesDouai/PhaROS2-Docker/tree/master/PhaROSDockerImage)
Here you will find a Docker image for PhaROS, a client for Pharo-based ROS nodes.    
Startup scripts are included for PhaROS GUI to work properly inside of the container.

## [ROS-Mapping](https://github.com/CARMinesDouai/PhaROS2-Docker/tree/master/ROS-Mapping)
Here you will find a Docker images for mapping a room with a turtlebot, as well as their their startup scripts.

## [ROS-Navigation](https://github.com/CARMinesDouai/PhaROS2-Docker/tree/master/ROS-Navigation)
Here you will find a Docker image for navigating inside a mapped room with a turtlebot, as well as its startup script.    
This tutorial is usually meant to be a follow-up to the mapping tutorial mentionned above.

## [ROS2](https://github.com/CARMinesDouai/PhaROS2-Docker/tree/master/ROS2)    
Here you will find a Docker image for controlling a turtlebot with a joystick using ROS2.    
There is also a file regrouping some preliminary research on the needed steps and concepts to develop PhaROS2.
