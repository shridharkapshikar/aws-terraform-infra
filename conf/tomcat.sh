#!/bin/bash
sudo yum install -y java-1.8.0-openjdk-devel

#tomcat download
cd /opt/
sudo wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz
sudo tar -zxvf apache-tomcat-7.0.53.tar.gz
sudo rm apache-tomcat-7.0.53.tar.gz
sleep 25
echo "starting tomcat process"
cd /opt/apache-tomcat-7.0.53/bin/
sudo sh startup.sh
echo "tomcat started"
