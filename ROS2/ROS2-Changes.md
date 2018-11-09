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


#What have changed between ROS1 & ROS2

1. Compatibility
	Linux, MAC OS, Windows support ROS2 now.
	ROS2 is based on Python and C++
2. Master?
	ROS2 does'nt have "master" like ROS1, they use a service discovery through network multicast
	In fact, ROS2 use a DDS (Data Distribution Service)
3. Improvment of "Launch"
	ROS1 launch file is only xml file
	ROS2 support Pyton launch file. So we can imagine more complex launch file
4. Real-time nodes
	It's possible to write real-time nodes in ROS2 due to the internal process of DDS
	[This link](https://index.ros.org/doc/ros2/Real-Time-Programming/) permit to install and run a pendulum demo
	
#ROS2 & DDS
DDS: Data Distribution Service

##DDS Discovery
The goal of DDS is to 'replace' the master
So ROS2 is fully distributed and does'nt have a central or critical node.


##Pattern Observer
With ROS2 and DDS, we have two way of communication between process.
 - Inter-process communication. It's possible to have an share pointers between process so we directly deal with the process without network
 - Use **multicast** over network. By default, we share a node over network. The communication is based on *UDP* and not TCP.
The best way to communicate is define by the DDS.


#ROS2 et son interface *middleware*
ROS2 directly build on DDS. Is this DDS and is implementation who will choose the best way to communicate with other (depends on local aspect or over the network)

#ROS2 in few lines
1. ROS2 network is separate in 255 domain with `ROS_DOMAIN_ID` environment variable.
2. When a node start, he noitify is status to other node through *multicast*. He also share is topic.
	Others nodes in the same *ROS_DOAMIN_ID* answer and share these topics
3. Keep connections
	A node regulary send informations to say "I'm here". It's with this signalment who can have the knowledge of new nodes.
4. A Node send a signal when is turn off
5. Use less resources than ROS1, in two way: Ram comsuption and Network consumption
6. The "master" is replace with P2P connection between nodes.