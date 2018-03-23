# How to set-up a TurtlebotDemo with ROS2 and Docker
*My sources were the [ROS2 installation guide](https://github.com/ros2/ros2/wiki/Linux-Install-Debians) and the [ROS2 Turtlebot demo guide](https://github.com/ros2/turtlebot2_demo)*

## Prerequisites
You need to have Docker properly installed on your computer. You can find a full tutorial [here](https://github.com/CARMinesDouai/PhaROS2/blob/master/Docker%20Installation/DockerInstallationTutorial.md) to achieve this.

## Building the ROS2-Turtlebot-Demo image
Download the [Dockerfile](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS2/TurtlebotDemo/Dockerfile) and place it in an empty directory on your computer.  
Then to build the docker image, use the following command :
```bash
$ sudo docker build -t ros2:turtlebotdemo .
```
Command explanation :
- "ros2" will be the image repository, you can change it if you want.
- "turtlebotdemo" will be the image tag; you can change it if you want.
- "." tells the command to use the current context for the build.

## Running the ROS2-Turtlebot-Demo container
Once you've build the docker image, you need to run a container created from said image.  
To do this use the following command :
```bash
$ sudo docker run -it ros2:turtlebotdemo bash
```
Command explanation :
- If you build the image with another repository and/or tag, replace "ros2:turtlebotdemo" by "repository:tag".
- "bash" will allow you to use the bash of the new container after its creation.

## More to come  
*Work still in progress*
