# How to use PhaROS inside a Docker container
 At the end of this tutorial you will be able to use PhaROS, a client for Pharo-based ROS nodes, inside a Docker container.

### Prerequisites
- This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.
- You need to have Docker properly installed on your computer. If needed use my [Docker installation tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/Docker%20Installation).

## Building the PhaROS Docker image
Download this [Dockerfile](https://github.com/CARMinesDouai/PhaROS2/blob/master/PhaROSDockerImage/Dockerfile), which describes a docker image with the necessary packages for using PhaROS with ROS Kinetic.  
Then to build the docker image, use the following command :
```bash
$ sudo docker build -t pharos:kinetic /path_of/directory_containing/the_Dockerfile
```
Command explanation :
- **Replace "/path_of/directory_containing/the_Dockerfile" by the path of the directory containing the Dockerfile**.
- "pharos:kinetic" will be the image repository and tag; these are used in the scripts executed later.

## Using the PhaROS GUI inside a Docker container
### Starting the PhaROS Docker container
[This startup script](https://github.com/CARMinesDouai/PhaROS2/blob/master/PhaROSDockerImage/pharos-container.start) will create a Docker container and give it temporary acces to the xhost of the host so that you can use the PhaROS GUI inside the isolated container.    

**Warning : when the container is exited, by default the script will delete it !**

### Starting the PhaROS Docker container nehind an internet proxy
If you are working behind an internet proxy use [this similar startup script instead](https://github.com/CARMinesDouai/PhaROS2/blob/master/PhaROSDockerImage/pharos-container-behind-httpproxy.start).   
If needed make sure that your Docker is configurated correctly to work behind an internet proxy by checking my [Docker installation tutorial](https://github.com/CARMinesDouai/PhaROS2/tree/master/Docker%20Installation).    

**Warning : when the shell on the container is exited, by default the script will delete the container !**

### Using PhaROS
To start with your first PhaROS package use these commands :
```bash
$ pharos create myfirstpharospackage
$ rosrun myfirstpharospackage edit
```
To go further check the [PhaROS GitHub](https://github.com/CARMinesDouai/pharos).

### Transferring files from container to host
To transfer files from the container to the host (or vice versa), use the following commands :
```bash
#Getting the id of the last container
$ containerId=$(sudo docker container ps -l -q --no-trunc)
#To transfer a file from container to host
$ sudo docker cp $containerId:/path_to/file_in_container /path_to/file_in_host
#To transfer a file from host to container
$ sudo docker cp /path_to/file_in_host $containerId:/path_to/file_in_container
```
This will come handy notably for saving files on the host before deleting the container.

## Sources
*[PhaROS Installation Tutorial](https://github.com/CARMinesDouai/pharos/wiki/Install-PhaROS)*
