# Some example and explanation

In this document, we have two computer (A and B)
Shells is named like this:
1. Shell A>A -> First terminal on computer A
2. Shell A>B -> Second terminal on computer A
3. Shell B>A -> First terminal on computer B
4. Shell B>B -> Second terminal on computer B

# General
I've define some `alias`
```shell
$ ros1ify

#Is alias to
#source /opt/ros/melodic/setup.bash
```

```shell
$ ros2ify

#Is alias to
#export ROS_DOMAIN_ID=10
#source /opt/ros/bouncy/setup.bash
```

## Show topics and informations
To show information about topic, we need a dedicated terminal
```shell
$ ros2ify
```
to have access to ROS2 commands

## Commands on ROS2 nodes

To show the differents topic actually see by ROS2
```shell
$ ros2 topic list
```

To show the number of publisher and subscriber to a certain topic
```shell
$ ros2 topic info *a topic*
```
To show the message emited on a topic
```shell
$ ros2 topic show *un topic*
```

# Kobuki
This expreriment permit to run a Trutlebot2 with a dedicated computer for Joystick part and Kobuki part.

First, on the kobuki computer, we need to have *udev* rule correctly set
```shell
$ ros1ify
$ rosrun kobuki_ftdi create_udev_rules
$ exit
```

## Installation
 - PC A will handle Joystick.
 - PC B will hanlde  Kobuki.

## With Launch file
The default launch file permit to start all node but it will be on the same computer.

```shell
$ ros2ify
$ launch `ros2 pkg prefix turtlebot2_teleop`/share/turtlebot2_teleop/launch/turtlebot_joy.py
```

### LExplanation of Launch file
One of functionality of ROS2 is python launch file. Let read this file

```python
from launch.exit_handler import default_exit_handler, restart_exit_handler
from ros2run.api import get_executable_path


def launch(launch_descriptor, argv):
    ld = launch_descriptor
    
    #Will start Kobuki node
    #The equivalent in Shell is: $ ros2 run turtlebot2_drivers kobuki_node
    package = 'turtlebot2_drivers'
    ld.add_process(
        cmd=[get_executable_path(package_name=package, executable_name='kobuki_node')],
        name='kobuki_node',
        exit_handler=restart_exit_handler,
    )
    
    #Will start teleop_joy_node
    #The equivalent in Shell is: $ ros2 run teleop_twist_joy teleop_node
    package = 'teleop_twist_joy'
    ld.add_process(
        cmd=[get_executable_path(package_name=package, executable_name='teleop_node')],
        name='teleop_node',
        exit_handler=restart_exit_handler,
    )
    
    #Will start joy node
    #The equivalent in Shell is: $ ros2 run joy joy_node
    package = 'joy'
    ld.add_process(
        cmd=[get_executable_path(package_name=package, executable_name='joy_node')],
        name='joy_node',
        # The joy node is required, die if it dies
        exit_handler=default_exit_handler,
    )

    return ld
```



## Without launch file (Separated nodes)
### Start of Kobuki node
First we will create the Kobuki nodes.
The Kobuki librairy is is ROS1... So we need to load ROS1 with `$ ros1ify` to have access to these librairies.

```shell
#Shell B>A
$ ros1ify
$ ros2ify
$ ros2 run turtlebot2_drivers kobuki_node
```When you will pressed *enter* to the last commands, the Kobuki will emits a sound to confirm the connection with him.

It's possible to verify if we see this node by using the command below
```shell
#Shell B>B
$ ros2ify
$ ros2 node list
```
We should see `kobuki_node`

### Start of Joystick Node

It's the first node to handle Joystick
By default, the joystick used will be */dev/js0*
```shell
#Shell A>A
$ ros2ify
$ ros2 run joy joy_node
```
We also could check the status of this node with the commande ` $ ros2 node list`

Then, we will create the node who will tranform message of *joy_node* to a comprehensive *kobuki_node* message.
```shell
#Shell A>B
$ ros2ify
$ ros2 run teleop_twist_joy teleop_node
```
We also could check the status of this node with the commande ` $ ros2 node list`

*This explanation is based on Xbox 360 Controller*
Normally, by pressing **RB** of controller, the Kobuki will go forward. We will set the angular speed by pressing **RT** trigger

**To close a node, we will use an ```CTRL+C``` in different opened shell**

## Why it work?
To understand this, we will look the command:
```shell
#Shell A>C ou B>B
$ ros2ify
$ ros2 node list
```
It's show all three nodes is seen by the two computers. But, we have run (based on wich coputer) but no more than 2 nodes...
ROS2 use * multicast* to share nodes between computer. So when we have start a node, it send a message over he network to share is topics. So all node know each others with this process.


# ROS2 -> ROS1 Bridge
It's possible to have a bridge between ROS
 and ROS1. This bridge will share only some topic. When a ROS1 node will ask for a topic, then the topic will be shared
 
 Start of *roscore*
```shell
#shell A>A
$ ros1ify
$ roscore
```

Bridge start
```shell
#Shell A>B
$ ros2ify;ros1ify
$ ros2 run ros1_bridge dynamic_bridge
```

Now, we will create a *talker* or a *listener* ros1
```shell
#Shell A>C
$ ros1ify
$ rosrun rospy_tutorials talker # ou rosrun rospy_tutorials listener
```

And we will create the missing node in ROS2
```shell
#Shell A>D
$ ros2ify
$ ros2 run demo_nodes_cpp listener # ou ros2 run demo_nodes_cpp talker
```

Shell A>B should say
```
  created 1to2 bridge for topic '/chatter' with ROS 1 type 'std_msgs/String' and ROS 2 type 'std_msgs/String'
  [INFO] [ros1_bridge]: Passing message from ROS 1 std_msgs/String to ROS 2 std_msgs/String (showing msg only once per type)
```
This mean the */chatter* topic is share between ROS2 and ROS1


# Interaction with Gazebo
By following [this link](http://gazebosim.org/tutorials?tut=ros2_installing&branch=ros2), you will have an gazebo simulation with an bot who can go forward or turn.

## Explanation
I supposed you have follow the *gazebosim* tutorial,so you have this folder: `~/ros2_gazebo_demos`

We can start *gazebo* with this world file `gazebo_ros_diff_drive_demo.world`

```shell
$ cd ~/ros2_gazebo_demos
$ gazebo --verbose gazebo_ros_diff_drive_demo.world
```
Gazebo should start with a small robot inside. We have to move this robot

To do this, we take a terminal
```shell
$ ros2ify
$ ros2 topic pub /demo/cmd_demo geometry_msgs/Twist '{linear: {x: 1.0}}' -1 # The robot will go forward in Gazebo
$ ros2 topic pub /demo/cmd_demo geometry_msgs/Twist '{angular: {z: 0.1}}' -1 # The robot will turn in Gazebo
```

## Explanation of world file
This explanation is not complete. But here we have the main part. To understand all of the `world`file, go learn `gazebo-devel`

This ligne permit to convert the topic received message in gazebo physics instruction.
```xml
<plugin name='diff_drive' filename='libgazebo_ros_diff_drive.so'>
```

This part will declare the ROS2 node and topics used.
```xml
<ros>
  <namespace>/demo</namespace>
  <argument>cmd_vel:=cmd_demo</argument>
  <argument>odom:=odom_demo</argument>
</ros>
```
