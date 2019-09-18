#!/bin/bash
echo "install java"
yum install -y java-1.8.0-openjdk-devel
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sleep 5
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
echo "instal jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins

sudo service jenkins start

sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp /tmp/basic-security.groovy /var/lib/jenkins/init.groovy.d/
systemctl restart jenkins
cd /var/lib/jenkins/
rm -rf init.groovy.d 

sudo chkconfig --add jenkins

echo "Install Ansible"
cd /tmp
sudo wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh epel-release-latest-7.noarch.rpm
sudo yum-config-manager --enable epel
yum -y install ansible

