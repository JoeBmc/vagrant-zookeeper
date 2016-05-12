#!/usr/bin/env bash

#This file is only for Ubuntu 7.0 - The base repository does not have zookeeper version above 3.4.

# Extract the package.
tar -xvf /vagrant/zookeeper-3.4.6.tar.gz -C /vagrant/
sleep 5

# Make a copy of the configuration file with the name zoo.cfg.
cp /vagrant/zookeeper-3.4.6/conf/zoo_sample.cfg /vagrant/zookeeper-3.4.6/conf/zoo.cfg

#Starting zookeeper service.
/vagrant/zookeeper-3.4.6/bin/zkServer.sh start
sleep 10

sed -i 's/127.0.1.1/127.0.0.1/' /etc/hosts
