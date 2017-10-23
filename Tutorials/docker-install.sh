#!/bin/bash

while getopts "ep:" opt; do
	case $opt in
		e)
			ENABLE=true
			;;
		p)
			PROXY=$OPTARG
			;;
	esac
done

#Commands for the core installation of docker:
sudo apt-get update 
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=$(arch)] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable" 
sudo apt-get update 
sudo apt-get install docker-ce 

#Commands to configure the docker proxy if needed:
if test $PROXY;
	then
		sudo mkdir -p /etc/systemd/system/docker.service.d
		sudo su
		echo '[Service]
Environment="HTTP_PROXY=http://$PROXY/" "NO_PROXY=localhost"' > /etc/systemd/system/docker.service.d/http-proxy.conf
		echo '[Service]
Environment="HTTPS_PROXY=https://$PROXY/" "NO_PROXY=localhost"' > /etc/systemd/system/docker.service.d/https-proxy.conf
		exit
		sudo systemctl daemon-reload 
		sudo systemctl restart docker 
fi

#Command to enable docker to start on boot:
if test $ENABLE;
	then
		sudo systemctl enable docker
fi

