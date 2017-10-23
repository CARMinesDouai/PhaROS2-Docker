# How to install the needed tools
This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.    
For some of the steps you have the option to use a script (found on this repository) rather than the command lines.
## Docker installation
*My sources were the [official installation guide](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu) and the [proxy configuration guide](https://docs.docker.com/engine/admin/systemd/#httphttps-proxy).*
### Through script
Download the `docker-install.sh` script and use it the following way:
```bash
$ bash docker-install.sh -e -p A.B.C.D:PORT
```
The `-e` option is to enable docker to start on boot.    
The `-p` option is to set a proxy for docker if needed, of course **change `A.B.C.D:PORT` to your http proxy**.
### Through commands
These are the commands for the core installation of docker:
```bash
$ sudo apt-get update 
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common 
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
$ sudo add-apt-repository "deb [arch=$(arch)] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable" 
$ sudo apt-get update 
$ sudo apt-get install docker-ce 
```

These are the commands to configure the docker proxy if needed, of course **change `A.B.C.D:PORT` to your http proxy**
```bash
$ sudo mkdir -p /etc/systemd/system/docker.service.d
$ sudo su
$ echo '[Service]
Environment="HTTP_PROXY=http://A.B.C.D:PORT/" "NO_PROXY=localhost"' > /etc/systemd/system/docker.service.d/http-proxy.conf
$ echo '[Service]
Environment="HTTPS_PROXY=https://A.B.C.D:PORT/" "NO_PROXY=localhost"' > /etc/systemd/system/docker.service.d/https-proxy.conf
$ exit
$ sudo systemctl daemon-reload 
$ sudo systemctl restart docker 
```
Finally if you want docker to start on boot:  
```bash
$ sudo systemctl enable docker
```
### Checking that docker works correctly
The following command is to verify that docker is running correctly (by using a 'hello world' image)    
 ```bash
 $ sudo docker run hello-world
  ```
 After failing to find the image locally and a small download time you should see:
 ```bash
    Hello from Docker!
    This message shows that your installation appears to be working correctly.
```
