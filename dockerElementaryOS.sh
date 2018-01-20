#!/bin/bash

echo "=== Docker installation ==="

sudo apt-get install -y \
     apt-transport-https \
     ca-certificates

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -u -cs) \
   stable"
sudo apt-get update

sudo apt-get purge lxc-docker

sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install docker-ce

if [ $? = 0 ]
then
  echo "=== Docker installed ! ==="
else
  echo "=== Error during docker installation ==="
  exit 1
fi

sudo service docker start

echo "=== Creating docker group and adding ${USER} to it ==="

sudo groupadd docker
sudo usermod -aG docker "${USER}"
