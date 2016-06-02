#!/bin/bash
sqlrootpass='passwordforsqlserver'
ftpuser='ftpuser'
ftppass='denden123'
export appdir='/opt/apps/'
export instscrdir='./install_scripts/'
### set password and login
echo "Please select good password and username, on"
echo "github if your repository is public everyone can see your password."
echo "That is why you have to change it during script start."
echo "Please provide your desired ftp user name:"
read $ftpuser
export ftpuser
echo "Please provide your desired ftp password:"
read $ftppass
export ftppass
echo "Please provide your desired mysql root password:"
read $sqlrootpass
export sqlrootpass

### setup ubuntu server
echo "--Setup server--"
./${instscrdir}/setup.ubuntu.server.sh > ./install.log

# 3. Building and running containers

## 3.1. FTP container
echo "--Install and run ftp container--"
./${instscrdir}/ftp.container.sh >> ./install.log

## 3.2. LAMP container #################
echo "--Install and run LAMP container--"
./${instscrdir}/lamp.container.sh >> ./install.log

## 3.4 install nodejs ####
echo "--Install and run NODEJS+mongo container--"
./${instscrdir}/nodejs.container.sh >> ./install.log

## 3.5 install golang with ostgresql
echo "--Install and run golang with postgresql container--"
./${instscrdir}/golang.postgres.sh >> ./install.log

### Print info about installation ########
echo "Your instaled and running containers"
docker ps
echo "Save this information:"
echo "Your ftp user:${ftpuser} password:${ftppass}"
echo "Your mysql password for root: ${sqlrootpass}"
echo "Your data directory ${appdir}"
