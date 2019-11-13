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
	- deploy a complete runtime config (this repo) in a container


Features:
( please review these files and edit before running/deploying )
	- includes all relevant config files for setting up master+minion
	- starts services with localhost as minion of itself
	- includes minimal test states and web interface
	- modular configuration of virtualenv location and package dependencies
	- container workflow scripts

Getting Started:
----------------

VM workflow
	- checkout this repo & change/enter directory

Step 1 - setup
## (as root)

./setup 

# single entry point, re-run to reconfigure locations or update packages
# - will stop any running services before proceeding
# - adds local user 'saltrunner' to access halite UI
# - adds hooks to ~/.bash_profile to source the custom environment 
# - debug logging on by default

Step 2 - run
## (as root)

./bin/start-services

# - starts services in foreground windows if Xserver is detected
# - otherwise starts services in background

./MASTER/CLEAN.sh
# - run this as needed to clear out keys, logs and cache


Docker workflow
## (as user in docker group)

./build-docker 
# - creates 'salt-develop' container from contents of current directory

./run-docker-service 
# - starts a 'salt-develop' container with logging to foreground of current window

./run-docker-interactive
# - login to a running 'salt-develop' container or create one for manual installation



Directory Structure:
================
/bin 				# setup scripts invoked by INSTALL.sh

================
## salt-master tree
MASTER/rootfs 			# overlay filesystem
	etc/salt		# runtime config files
	usr/local/bin		# operational scripts
		test-states	# runs highstate in test mode
================
## salt-minion tree
MINION/STATE			# linked at /srv/salt
	/test			# simple test state for installation verification
================
## pillar tree
MINION/PILLAR			# linked at /srv/pillar
## reactor tree
================
MINION/REACTOR			# linked at /srv/reactor

..
