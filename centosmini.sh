#!/bin/sh
domain=$1;
# exit on error
set -e

# install dependance
yum install -y curl git zip unzip nano wget
# update
#yum update -y

# install epel
#yum install -y epel-release

#kl folder


#install docker
curl https://releases.rancher.com/install-docker/17.12.sh | sh
systemctl enable docker
systemctl start docker.service

# install Docker Compose:
# install python-pip
#wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install epel-release
yum install -y python-pip
pip install docker-compose

# upgrade your Python packages:
yum upgrade -y python*

yum -y remove postfix
yum -y install openvpn

chmod +x /etc/rc.d/rc.local
echo "/var/lib/docker/postallastix/boot.sh" >> /etc/rc.d/rc.local
systemctl enable rc-local

cd /var/lib/docker
git clone https://github.com/layen67/postallastix.git
cd postallastix
chmod +x /var/lib/docker/postallastix/boot.sh
docker-compose up -d
sleep 15
sed -i -e "s/example.com/$1/g" /var/lib/docker/postallastix/data/postal/config/postal.yml
docker-compose run postal initialize-config
docker-compose run postal initialize
docker-compose run postal make-user
docker-compose run postal start
