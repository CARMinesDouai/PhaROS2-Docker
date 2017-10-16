# How to install the needed tools
This tutorial assumes that your system is Ubuntu, with the Xenial version or a more recent one.
## Docker installation
```bash
# These are the commands for the core installation of docker
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

# The next steps are to configure the docker proxy if needed, replace "A.B.C.D:PORT" by your http proxy
$ sudo mkdir -p /etc/systemd/system/docker.service.d
$ sudo su
$ echo '[Service]
Environment="HTTP_PROXY=http://A.B.C.D:PORT/" "NO_PROXY=localhost"' > /etc/systemd/system/docker.service.d/http-proxy.conf
$ echo '[Service]
Environment="HTTPS_PROXY=https://A.B.C.D:PORT/" "NO_PROXY=localhost"' > /etc/systemd/system/docker.service.d/https-proxy.conf
$ exit
$ sudo systemctl daemon-reload 
$ sudo systemctl restart docker 


# The following command is to verify that docker is running correctly (by using a 'hello world' image)
$ sudo docker run hello-world 
# After a small download time you should see:
# 'Hello from Docker!
#  This message shows that your installation appears to be working correctly'.
```
My sources were the [official installation guide](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu) and the [proxy configuration guide](https://docs.docker.com/engine/admin/systemd/#httphttps-proxy).
