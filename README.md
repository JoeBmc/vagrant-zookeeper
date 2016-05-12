# TrueSight Pulse Vagrant Zookeeper 

Configures a virtual machine with a Zookeeper instance for testing TrueSight Pulse Plugin for Zookeeper.

## Prerequistes

- Vagrant 1.72. or later, download [here](https://www.vagrantup.com/downloads.html)
- Virtual Box 4.3.26 or later, download [here](https://www.virtualbox.org/wiki/Downloads)
- git 1.7 or later

## Installation

Prior to installation you need to obtain in your Boundary API Token.

1. Clone the GitHub Repository:
```bash
$ git clone https://github.com/boundary/truesightpulse-vagrant-zookeeper
```

2. Start the virtual machine using your TrueSight Pulse API Token:
```bash
$ API_TOKEN=<TrueSight Pulse API Token> vagrant up <virtual machine name>
```
NOTE: Run `vagrant status` to list the name of the virtual machines.

3. Login to the virtual machine
```bash
$ vagrant ssh <virtual machine name>
```

## Known Issues

- Vagrant up centos-7.0 will not install Boundary Meter. Will have to install it manually.
- Three metrices - Zookeeper Followers, Zookeeper Synced Followers, Zookeeper Pending Syncs will not show up in the vagrant installation. We need to setup a Zookeeper ensemble (cluster) for that. Only leader shows these metrics.
