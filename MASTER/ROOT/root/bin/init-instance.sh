#!/usr/bin/env bash

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

## this isn't installed by default on the base image
yum -y install yum-utils
yum-config-manager --enable epel-testing

## important for change tracking, should also pull in 'git'
yum -y install etckeeper
cd /etc/
etckeeper init
etckeeper commit -m "INIT"

## lets make sure everything is current
yum update -y