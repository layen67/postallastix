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

cd /var/lib/docker
git clone https://github.com/layen67/postallastix.git
cd postallastix
docker-compose up -d

sed -i -e "s/example.com/callcenter.fr.nf/g" /var/lib/docker/postallastix/data/postal/config/postal.yml
docker-compose run postal initialize

docker-compose run postal make-user
#neorouter
wget http://download.neorouter.com/Downloads/NRFree/Update_2.3.1.4360/Linux/CentOS/nrclient-2.3.1.4360-free-centos-x86_64.rpm
rpm -i nrclient-2.3.1.4360-free-centos-x86_64.rpm
nrclientcmd -d 192.168.0.110 -u serverbox -p Oscarr6172
