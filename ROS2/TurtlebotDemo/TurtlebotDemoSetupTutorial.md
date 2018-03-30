# How to set-up a TurtlebotDemo with ROS2 and Docker
This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.  

### Prerequisites
- You need to have Docker properly installed on your computer. You can find a full tutorial [here](https://github.com/CARMinesDouai/PhaROS2/blob/master/Docker%20Installation/DockerInstallationTutorial.md) to achieve this.
- You need a joystick and a turtlebot.
### Sources
*My sources were the [ROS2 installation guide](https://github.com/ros2/ros2/wiki/Linux-Install-Debians) and the [ROS2 Turtlebot demo guide](https://github.com/ros2/turtlebot2_demo)*

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
Here we are going to create a container from the ROS2-Turtlebot-Demo image and use this container to run the demo launch file.  
To do this use the following command :
```bash
$ sudo docker run -it --rm --device=/dev/input/js0 --device=/dev/kobuki ros2:turtlebotdemo launch /opt/ros/ardent/share/turtlebot2_teleop/launch/turtlebot_joy.py
```
Command explanation :
- If you build the image with another repository and/or tag, replace "ros2:turtlebotdemo" by "repository:tag".
- "launch /opt/ros/ardent/share/turtlebot2_teleop/launch/turtlebot_joy.py" is the command run at the start of the container, this one will run the demo launchfile allowing you to pilot the turtlebot with your joystick. *(Note: you can replace this command by "bash" to instead use the bash of the new container after its creation and inspect the container)*.
- The option "--device=/dev/input/js0 --device=/dev/kobuki" allows the container to access to two device connected to the host: "/dev/input/js0" is the joystick and "/dev/kobuki" is the kobuki turtlebot. **Make sure these are indeed the paths to the devices on your machine !**
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
