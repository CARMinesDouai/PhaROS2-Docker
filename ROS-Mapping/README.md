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

### a) Building the ROS-mapping-desktop docker image
Download this [Dockerfile](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Mapping/IsolatedOption/Dockerfile), which describes a docker image with the necessary packages to map a room with a turtlebot and displaying the RVIZ GUI.  
Then to build the docker image, use the following command :
```bash
$ sudo docker build -t ros:mapping-desktop /path_of/directory_containing/the_Dockerfile
```
Command explanation :
- **Replace "/path_of/directory_containing/the_Dockerfile" by the path of the directory containing the Dockerfile**.
- "ros:mapping-desktop" will be the image repository and tag; these are used in the script executed later.

### b) Using a ROS-mapping-desktop docker container to map a room
Download this [navigation script](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Mapping/IsolatedOption/ros-turtlebot-mapping.bash). This script first creates a docker container from the previously built docker image, then opens a temporary xhost acces for it and finally launches the mapping process inside the container.   
To execute it, first connect the turtlebot and the laser and the joystick to the computer, then use the following command :
```bash
$ source ros-turtlebot-mapping.bash
```
Command explanation :
- The script assumes that the path to the turtlebot is "/dev/kobuki", the one to the laser is "/dev/ttyACM0" and the one to the joystick is "/dev/input/js0".   
**Make sure these are indeed the paths to the devices on your machine!**
- As stated earlier, this script assumes that the docker image built previously can be found under the name "ros:mapping-desktop".

Now that the mapping process is launched, you can use the joystick to move the turtlebot in the room to generate a map.
(*Note: if you are using a Xbox360 controller, to move the turtlebot hold the Left Button "LB" while using its joystick.*)   

When the map is complete and you want the save it, press the ENTER key inside the launching shell (as indicated). After a few seconds the map will be saved to /tmp/turtlebot_map.pgm & /tmp/turtlebot_map.yml.    
The script will then end after a few seconds.

## 2) The non-isolated way
Here the host will be in charge of displaying the RVIZ GUI used during the mapping process.    
Thus the mapping process won't be completely isolated inside of a container.    
However it may sometimes be preferable, for example to use the graphic card fully without worrying about which drivers are installed in the container.

### a) Building the ROS-mapping docker image
Download this [Dockerfile](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Mapping/BetterPerformancesOption/Dockerfile), which describes a docker image with the necessary packages to map a room with a turtlebot.  
Then to build the docker image, use the following command :
```bash
$ sudo docker build -t ros:mapping /path_of/directory_containing/the_Dockerfile
```
Command explanation :
- **Replace "/path_of/directory_containing/the_Dockerfile" by the path of the directory containing the Dockerfile**.
- "ros:mapping" will be the image repository and tag; these are used in the script executed later.

### b) Using a ROS-mapping docker container to map a room
Download this [navigation script](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Mapping/BetterPerformancesOption/ros-turtlebot-mapping.bash). This script first creates a docker container from the previously built docker image, then launches the mapping process inside this container and finally launches from the host a RVIZ GUI connected to the mapping process of the container.   
To execute it, first connect the turtlebot and the laser and the joystick to the computer, then use the following command :
```bash
$ source ros-turtlebot-mapping.bash
```
Command explanation :
- The script assumes that the path to the turtlebot is "/dev/kobuki", the one to the laser is "/dev/ttyACM0" and the one to the joystick is "/dev/input/js0".   
**Make sure these are indeed the paths to the devices on your machine!**
- As stated earlier, this script assumes that the docker image built previously can be found under the name "ros:mapping".

Now that the mapping process is launched, you can use the joystick to move the turtlebot in the room to generate a map.
(*Note: if you are using a Xbox360 controller, to move the turtlebot hold the Left Button "LB" while using its joystick.*)   

When the map is complete and you want the save it, close the RVIZ GUI. After a few seconds the map will be automatically be saved to /tmp/turtlebot_map.pgm & /tmp/turtlebot_map.yml.    
The script will then end after a few seconds.

## Sources
*This tutorial is a dockerization of [Xuan Sang LE's work on the subject](https://blog.lxsang.me/r:id:14).    
I also used the [Using GUI's with Docker tutorial](https://wiki.ros.org/docker/Tutorials/GUI#The_ssh_way) found on ros.org*
