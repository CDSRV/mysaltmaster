#!/usr/bin/env bash

# here you are, now that you've cloned the repo
# cd $THIS_DIRECTORY (really important..)

# to setup a MASTER
## install package repos and update everything
./ROOT/root/bin/init-instance.sh
## install saltmaster + minion with stub configurations
./ROOT/root/bin/bootstrap-git-develop.sh
## copy in our configs from this repo, overwrite what packages installed
./link-configs.sh
## now we can actually configure things..
./ROOT/root/bin/configure-git-develop.sh

grep $(dirname $PWD)/MASTER/ROOT/root/bin $HOME/.bash_profile || echo "PATH=\$PATH:$PWD/ROOT/root/bin ; export PATH" >> $HOME/.bash_profile


echo "HIT ENTER TO REBOOT"
read GO

## lets reboot to enable new kernel..
init 6;exit