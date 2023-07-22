#! /bin/bash
# update os
sudo apt-get update -y
sudo apt-get upgrade -y
# set server hostname as mentor-group-server
hostnamectl set-hostname mentor-group-server
# install git
yum install git -y
# uninstall aws cli version 1
rm -rf /bin/aws
# install aws cli version 2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
# install python 3
yum install python3 -y
# install ansible
pip3 install ansible
# install boto3
pip3 install boto3