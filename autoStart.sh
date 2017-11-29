#!/bin/bash

USER=$(echo $USER)

sudo apt-get update

if [ $? = 0  ]
then
  echo "=== Update successful ===l"
fi

# List all of the packages you want to install
sudo apt-get install -y git \
     bash-completion \
     apache2-utils \
     python3-pip \

if [ $? = 0  ]
then
  echo "=== Packages installed ==="
fi

echo "=== Docker installation ==="

sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     fail2ban \
     iptables \
     iptables-persistent


curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo apt-get update

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

sudo apt-get install -y docker-ce

if [ $? = 0 ]
then
  echo "=== Docker installed !  ==="
else
  echo "=== Error during docker installation ==="
  exit 1
fi

sudo groupadd docker
sudo usermod -aG docker "${USER}"

echo "=== Dockercompose installation === "

sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

if [ $? = 0 ]
then
  echo "=== docker-compose installed==="
else
  echo "=== Error during docker-compose installation ==="
  exit 1
fi

sudo chmod +x /usr/local/bin/docker-compose

echo "=== Get neovim configuration ==="

sudo apt-get install -y neovim

cd ~/.config/

git clone git@github.com:Hurobaki/nvim.git && cd

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install wheel 
pip3 install setuptools

pip3 install --user neovim

if [ $? = 0 ]
then
  echo "=== Neovim installed ! ==="
else
  echo "Error during Neovim installation ==="
  exit 1
fi

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
