#!/bin/bash
# Server setup #################################################
# 1. Docker installation
aptitude update 2 > /dev/null

aptitude -y upgrade 2 > /dev/null 
aptitude install linux-image-extra-`uname -r`
/bin/sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"

/bin/sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"


aptitude update -y
aptitude install lxc-docker -y
aptitude install git -y 



## 1.2. UFW configuration


### 1.2.1. Enable fowarding
# Edit /etc/default/ufw and set DEFAULT_FORWARD_POLICY to ACCEPT:
# DEFAULT_FORWARD_POLICY="ACCEPT"

sed -i 's/^DEFAULT_FORWARD_POLICY.*$/DEFAULT_FORWARD_POLICY="ACCEPT"/' /etc/default/ufw
### 1.2.2. Set rules

ufw allow ssh
ufw allow http

ufw allow ftp

ufw allow 5000/tcp

ufw allow 8080/tcp



### 1.2.3. Enable ufw

ufw enable



### 1.2.4. Check ufw's status

ufw status



# 2. Creating FTP folder on host machine
mkdir -p ${appdir}{go,lamp,nodejs,mongodb}

