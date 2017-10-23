mysaltmaster
================

A starting point for salt master/minion configs, formulas, recipes, etc

based on : https://docs.saltstack.com/en/develop/topics/development/hacking.html

Introduction :

Why use this framework?
- run the latest upstream version of salt in a python virtualenv
- use default variables and paths for config files, enabling portability
- use separate locations for salt source, python code, logs, keys, cache and runtime config
- maintain configs in source control without binaries or keys in the tree
- deploy a read-only runtime config (this repo) in a container


Features:
( please review these files and edit before running/deploying )
- includes all relevant config files for setting up master+minion
- starts services with localhost as minion of itself
- includes minimal test states and web interface
- modular configuration of virtualenv location and package dependencies

Getting Started:
----------------
- with a clean VM or container -
## currently only supports ubuntu

#!/bin/bash
## start setup
## checkout upstream
git clone https://github.com/CDSRV/mysaltmaster.git
cd mysaltmaster
git remote add upstream https://github.com/CDSRV/mysaltmaster.git
git fetch upstream
git fetch --tags upstream

## set local origin
git remote remove origin
git remote add origin $my-repo
#..etc..

## (as root)
## optionally set defaults - not required

export MYSALT=$full/path/to/this-repo
# defaults to $PWD

export BASE_DIR=$full/path/where-to-setup-the-code
# defaults to /usr/local/src

export PY_ENV=name-of-your-python-venv
# defaults to python-salt-develop
  
./setup 
# single entry point, re-run to reconfigure locations or update packages
# - will stop any running services before proceeding
# - adds local user 'saltrunner' (with random password) to access halite UI
# - adds hooks to ~/.bash_profile to source the custom environment 
# - debug logging on by default

./bin/start-services
# - starts services in foreground windows if Xserver is detected
# - otherwise starts services in background

./MASTER/CLEAN.sh
# run this as needed to clear out keys, logs and cache

##

## 
Package Requirement Files:

base-packages-[apt|yum].list
# per linux distribution type

virtualenv-packages.list
# for pip



Directory Structure:

================
 -> /bin    << setup scripts
 
		-> these are all handled by INSTALL.sh

================
MASTER/rootfs <<  "/"

 -> etc/salt	<< runtime config files
 

 -> usr/local/bin 	<< operational scripts
 
		-> test-states << runs highstate in test mode

================
MINION/STATE	<< linked at /srv/salt

 -> /test		<< simple test state for installation verification

================
MINION/PILLAR	<< linked at /srv/pillar

================
MINION/REACTOR   << linked at /srv/reactor

 