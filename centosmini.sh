#!/bin/bash

# exit on error
set -e

# install dependance
yum install -y curl git zip unzip nano wget

# update
#yum update -y

# install epel
yum install -y epel-release

#kl folder


#install docker
wget https://download.docker.com/linux/centos/docker-ce.repo -O /etc/yum.repos.d/docker-ce.repo
yum -y install docker-ce
systemctl start docker.service
systemctl enable docker

# install Docker Compose:
# install python-pip
#wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install epel-release
yum install -y python-pip
pip install --upgrade pip
pip install docker-compose

# upgrade your Python packages:
yum upgrade -y python*

yum -y remove postfix
#neorouter
wget http://download.neorouter.com/Downloads/NRFree/Update_2.3.1.4360/Linux/CentOS/nrclient-2.3.1.4360-free-centos-x86_64.rpm
rpm -i nrclient-2.3.1.4360-free-centos-x86_64.rpm
nrclientcmd -d 192.168.0.110 -u serverbox -p Ele10Kha6172

cd /var/lib/docker
mkdir postal
cd postal
git clone https://github.com/layen67/postallastix.git
cd docker-postal
