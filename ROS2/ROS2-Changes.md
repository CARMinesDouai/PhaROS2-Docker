# Changes between ROS1 & ROS2    
- New Design, adapted to systems with several robots.    
- Now uses external open-sources middlewares, allowing better performances and to focus future developments on robotics rather than middleware.    
- Handles wider array of Quality of Service. (Example: bad connections can now use “UDP” rather than “TCP”)    
- New API (among other things “Node” and “Nodelets” APIs were streamlined  into the “Component” API).    
- Client Interfaces are now developed based on the RCL library (coded in C) to wrap into the desired programming language.    
# Notions to include in PhaROS2
- Nodes (Component, Composition, etc) using Client Library    
- Topics & Messages    
- Services    
- Parameters    
- Quality of Services   
- Discovery
