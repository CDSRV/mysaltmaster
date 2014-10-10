## http://docs.saltstack.com/ref/configuration/master.html

## these files go on the master..
## -- required to bootstrap a master config before any states can be applied 

## this sets up a 'continuous integration' environment 
## similar to this : http://thiglife.com/2013/08/07/managing-a-saltstack-salt-master-with-git/

INSTRUCTIONS:

1) this is tailored for develpment & testing and..
-- works only on CENTOS 
this installer creates links where system directories should be.. a great way to use this is share the folder in virtual box, open the filesystem in your favorite editor on the host, and be able to test changes in realtime since the system is using configs which are actually on the host system
this works just as well with a local or remote git repo


cd (here)
sudo -i (etc, become root)
./INSTALL.sh

the installer will reboot your VM and then...

2) when you login again, things will be in the custom python environment. in this case, because its installed as "root", thats the account that will get the custom bash environment to initialize the custom python environment.. 

salt will be installed but not running.
it will be reading config files from *this repo* 

open up a few windows and startup master and/or minion processes as needed

# to put in the background as a daemon, logging normally (as configured)
> salt-master -d
> salt-minion -d

# to run in the foreground in debug mode
> salt-master -l debug
> salt-minion -l debug

#make sure to accept the master as a minion of itself!

> salt-key -A

you'll see files created in /etc/salt/pki and /var/cache/salt

3) use salt on the commandline or via web interface running at https://$HOSTNAME:8080
the web interface will authenticate any local user, but this package installs a custom user

login with these credentials:

user: saltrunner
pass: halite 

## NOTE:
this repo depends on numerous resources on the network.. sometimes github is slow to respond. if the installer hangs up, just hit control-C and start it again.
not much support is built in for 'upgrading' everything automatically, so you'll need to do that selectively for each component
everything gets installed at /usr/local/src

..
.
:wq!
:)