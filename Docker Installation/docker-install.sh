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

#Commands to configure the proxies if needed:
if test $PROXY;
	then
		#daemon proxy configuration
		sudo mkdir -p /etc/systemd/system/docker.service.d
		echo "[Service]
Environment=\"HTTP_PROXY=http://$PROXY/\" \"NO_PROXY=localhost\"" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf > /dev/null
		echo "[Service]
Environment=\"HTTPS_PROXY=https://$PROXY/\" \"NO_PROXY=localhost\"" | sudo tee /etc/systemd/system/docker.service.d/https-proxy.conf > /dev/null
		sudo systemctl daemon-reload 
		sudo systemctl restart docker 
		#containers proxy configuration
		echo "{
 \"proxies\":
 {
   \"default\":
   {
     \"httpProxy\": \"http://$PROXY\",
     \"httpsProxy\": \"https://$PROXY\",
     \"noProxy\": \"localhost\"
   }
 }
}" | sudo tee ~/.docker/config.json > /dev/null
fi

#Command to enable docker to start on boot:
if test $ENABLE;
	then
		sudo systemctl enable docker
fi
