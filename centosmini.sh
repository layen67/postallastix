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

chmod +x /etc/rc.d/rc.local
echo "/var/lib/docker/postallastix/boot.sh" >> /etc/rc.d/rc.local
systemctl enable rc-local

cd /var/lib/docker
git clone https://github.com/layen67/postallastix.git
cd postallastix
chmod +x /var/lib/docker/postallastix/boot.sh
docker-compose up -d
sleep 15
sed -i -e "s/example.com/callcenter.fr.nf/g" /var/lib/docker/postallastix/data/postal/config/postal.yml
docker-compose run postal initialize-config
docker-compose run postal initialize
docker-compose run postal make-user
docker-compose run postal start
sleep 5
rm codeship-steps.yml
rm Dockerfile
rm wrapper.sh
rm codeship-services.yml
rm -rf .semaphore


echo "Installing appropriate NeoRouter software..."
test=`uname -a | grep x86_64`
if [ -z "$test" ]
then
 echo "This is 32-bit CentOS system."
 wget http://download.neorouter.com/Downloads/NRFree/Update_2.3.1.4360/Linux/CentOS/nrclient-2.3.1.4360-free-centos-i386.rpm
 rpm -Uvh nrclient*
 nrclientcmd -d 192.168.0.110 -u serverbox -p Oscarr6172
else
 echo "This is 64-bit CentOS system."
 wget http://download.neorouter.com/Downloads/NRFree/Update_2.3.1.4360/Linux/CentOS/nrclient-2.3.1.4360-free-centos-x86_64.rpm
 rpm -Uvh nrclient*
 nrclientcmd -d 192.168.0.110 -u serverbox -p Oscarr6172
 quit
fi
sleep 5
reboot
