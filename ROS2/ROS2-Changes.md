# Changes between ROS1 & ROS2    
- [New Design](http://design.ros2.org/articles/why_ros2.html), adapted to systems with several robots.    
- [Now uses external open-sources middlewares](https://design.ros2.org/articles/ros_middleware_interface.html), allowing better performances and to focus future developments on robotics rather than middleware.    
- [Handles wider array of Quality of Service](https://github.com/ros2/ros2/wiki/About-Quality-of-Service-Settings). (Example: bad connections can now use “UDP” rather than “TCP”)    
- New API (among other things [“Node” and “Nodelets” APIs were streamlined  into the “Component” API](https://github.com/ros2/ros2/wiki/Composition)).    
- Client Interfaces are now developed based on the [RCL library](https://github.com/ros2/rcl) (coded in C) to wrap into the desired programming language. For more information on these libraries visit the [RCL library guide](https://github.com/ros2/rcl)    
# Notions to include in PhaROS2
- Nodes (Component, Composition, etc) using Client Library    
- Topics & Messages    
- Services    
- Parameters    
- Quality of Services   
- Discovery
