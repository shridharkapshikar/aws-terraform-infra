#!/bin/bash
sudo yum install -y java-1.8.0-openjdk-devel

#tomcat download
sudo cd /opt/
sudo wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz
sudo tar -zxvf apache-tomcat-7.0.53.tar.gz
sleep 25
sudo rm apache-tomcat-7.0.53.tar.gz
sleep 25
cd /opt/apache-tomcat-7.0.53/bin/
sudo ./startup.sh
