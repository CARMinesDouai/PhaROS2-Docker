# How to navigate in a mapped room with a Turtlebot and Docker
 At the end of this tutorial you will be able to navigate a turtlebot inside a mapped room, using RVIZ from a Docker container.

### Prerequisites
- This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.
- You need a turtlebot with a laser on it.
- You need to have Docker properly installed on your computer. If needed use my [Docker installation tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/Docker%20Installation).
- You need to have already mapped the room. If needed use my [Mapping with a Turtlebot and Docker tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/ROS-Mapping).

## Building the ROS-navigation-in-map docker image    
First you need to have previously built the ROS-mapping-desktop docker image. [Here is the guide on how to build it](https://github.com/CARMinesDouai/PhaROS2/tree/master/ROS-Mapping#a-building-the-ros-mapping-desktop-docker-image) if you haven't built this image already.       
*(Note: the ROS-mapping-desktop docker image is needed because it is the initial image of the ROS-navigation-in-map docker image build.)*

Now for the ROS-navigation-in-map docker image itself download this [Dockerfile](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Navigation/Dockerfile). It describes a docker image containing the necessary packages for navigating a turtlebot inside a mapped room through RVIZ.     
Then to build the docker image, use the following command :
```bash
$ sudo docker build -t ros:navigation-in-map /path_of/directory_containing/the_Dockerfile
```
Command explanation :
- **Replace "/path_of/directory_containing/the_Dockerfile" by the path of the directory containing the Dockerfile**.
- "ros:navigation-in-map" will be the image repository and tag; these are used in the script executed later.

## Using a ROS-navigation-in-map docker container to navigate in a mapped room
Download this [navigation script](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS-Navigation/ros-turtlebot-navigation-in-map.bash), which first creates a docker container from the previously built docker image and then opens the RVIZ GUI from this container.   
To execute it, first connect the turtlebot and laser to the computer, then use the following command :
```bash
$ source ros-turtlebot-navigation-in-map.bash /tmp/turtlebot_map
```
Command explanation :
- The script assumes that the path to the turtlebot is "/dev/kobuki" and the path to the laser is "/dev/ttyACM0".   
**Make sure these are indeed the paths to the devices on your machine !**
- The argument "/tmp/turtlebot_map" allows the script to locate the map stored under the duo "/tmp/turtlebot_map.yaml" & "/tmp/turtlebot_map.pgm". **If needed adapt this argument to the path to your map !**
- As stated earlier, this script assumes that the docker image built previously can be found under the name "ros:navigation-in-map".  

When this step is correctly done RVIZ will launch, allowing you to pilot the turtlebot in the mapped room. To do this:    
- First indicate the initial position of your turtlebot in the map by using the "2D Pose Estimate" tool in RVIZ.
- Then indicate where you want the turtlebot to go by using the "2D Nav Goal" tool in RVIZ.    

All this is done within a docker container, including the RVIZ GUI display.

## Sources
*The Dockerfile and script are based on those I made to [map a room with ros and docker.](https://github.com/CARMinesDouai/PhaROS2/tree/master/ROS-Mapping/IsolatedOption)     
The launchfile and rviz configuration are based on Xuan Sang LE's [adaptive local planner package](https://github.com/lxsang/ROS-packages/tree/master/adaptive_local_planner)*
