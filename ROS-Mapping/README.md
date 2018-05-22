# How to map a room with a Turtlebot and Docker
 At the end of this tutorial you will be able to map a room with a turtlebot, from a Docker container.     
 This tutorial shows you two ways of achieving these. Their differences are highlighted further down.

### Prerequisites
- This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.
- You need a turtlebot with a laser on it and a joystick.
- You need to have Docker properly installed on your computer. If needed use my [Docker installation tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/Docker%20Installation).

## 1) The isolated way
Here the docker container created for the mapping process will be temporarily allowed to use the xhost of the host machine to display the RVIZ GUI.    
This allows the mapping process to be completely isolated from the host by remaining entirely in the container.

## 2) The non-isolated way
Here the host will be in charge of displaying the RVIZ GUI used during the mapping process.    
Thus the mapping process won't be completely isolated inside of a container.    
However it may sometimes be preferable, for example to use the graphic card fully without worrying about which drivers are installed in the container.

## Sources
*The Dockerfile and script are based on those I made to [map a room with ros and docker.](https://github.com/CARMinesDouai/PhaROS2/tree/master/ROS-Mapping/IsolatedOption)     
The launchfile and rviz configuration are based on Xuan Sang LE's [adaptive local planner package](https://github.com/lxsang/ROS-packages/tree/master/adaptive_local_planner)*
