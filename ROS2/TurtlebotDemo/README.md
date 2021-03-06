# How to set-up a TurtlebotDemo with ROS2 and Docker
At the end of this tutorial you will be able to control a turtlebot with a joystick, using ROS2 from a Docker container.

### Prerequisites
- This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.
- You need a joystick and a turtlebot.
- You need to have Docker properly installed on your computer. If needed use my [Docker installation tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/Docker%20Installation).

## Building the ROS2-Turtlebot-Demo docker image
Download this [Dockerfile](https://github.com/CARMinesDouai/PhaROS2/blob/master/ROS2/TurtlebotDemo/Dockerfile), which describes a docker image containing the packages to teleop a turtlebot with ROS2.  
Then to build the docker image, use the following command :
```bash
$ sudo docker build -t ros2:turtlebotdemo /path_of/directory_containing/the_Dockerfile
```
Command explanation :
- **Replace "/path_of/directory_containing/the_Dockerfile" by the path of the directory containing the Dockerfile**.
- "ros2" will be the docker image repository, you can change this if you want.
- "turtlebotdemo" will be the docker image tag; you can change this if you want.

## Running the ROS2-Turtlebot-Demo docker container
Here we are going to create a docker container from the ROS2-Turtlebot-Demo docker image built previously and use this container to run the demo launch file.  
To do this use the following command :
```bash
$ sudo docker run -it --rm --device=/dev/input/js0 --device=/dev/kobuki \
  ros2:turtlebotdemo \
  launch /opt/ros/ardent/share/turtlebot2_teleop/launch/turtlebot_joy.py
```
Command explanation :
- If you build the image with another repository and/or tag, replace "ros2:turtlebotdemo" by "repository:tag".
- The option "--device=/dev/input/js0 --device=/dev/kobuki" allows the container to access to two device connected to the host: "/dev/input/js0" is the joystick and "/dev/kobuki" is the kobuki turtlebot.   
**Make sure these are indeed the paths to the devices on your machine !**
- "launch /opt/ros/ardent/share/turtlebot2_teleop/launch/turtlebot_joy.py" is the command run at the start of the container, this one will run the demo launchfile allowing you to pilot the turtlebot with your joystick.
*(Note: you can replace this command by "bash" to instead use the bash of the new container after its creation and inspect the container)*.
- The option "--rm" will delete the container after it is exited.  

When this step is correctly done the ros2 turtlebot teleop demo launchs, allowing you to pilot the turtlebot with the joystick.

### Extra: Xbox 360 Controller Handling 
The [original demo](https://github.com/ros2/turtlebot2_demo) assumes you are using a logitech controller as a joystick, but you can use other joysticks aswell. However the button mapping will differ from one controller to another.  

Here is a guide on how to use a Xbox 360 controller to pilot the turtlebot.  
*Warning: by default it is a quite weird button mapping !   
I will adapt the demo to better match the Xbox 360 controller in the near future.* 
- First you need to press "RT" (Right Trigger) to unlock the turtlebot wheels.
- "RB" (Right Button) will move the turtlebot forward.
- "RB"+"RT" will move the turtlebot backward.
- Here the turtlebot moves by default to the right, you can press the "LT" (Left Trigger) to switch direction.

## Sources
*My sources were the [ROS2 installation guide](https://github.com/ros2/ros2/wiki/Linux-Install-Debians) and the [ROS2 Turtlebot demo guide](https://github.com/ros2/turtlebot2_demo)*
