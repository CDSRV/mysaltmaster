#!/bin/bash -eax

# here you are, now that you've cloned the repo
# cd $THIS_DIRECTORY (really important..)
#
MSG="##> START : $0 : $(date)"

# check root
[ "$EUID" == "0" ] || { echo "##> this needs to run as root"; exit 1; }

bin/stop-services

# check parameters
MYSALT="${MYSALT:-$PWD}"
BASE_DIR="${BASE_DIR:-/usr/local/src}"
[ -d $BASE_DIR ] || mkdir -p $BASE_DIR
PY_ENV="${PY_ENV:-python-salt-develop}"
PY_ENV_PATH=$BASE_DIR/$PY_ENV

# check directory
[ -d $MYSALT/bin ] || { echo "##> $MYSALT/bin : not found"; exit 1; }

PATH=$MYSALT/bin:$PATH

# determine platform type
[ -d /etc/apt ] || { MSG="##> only apt toolchain is currently supported"; exit 1; }
HIGHLEVEL_PACKAGE_MANAGER=apt  ## re-using var from etckeeper

# to setup a MASTER
## install package repos and update everything
init-instance-$HIGHLEVEL_PACKAGE_MANAGER

## install saltmaster + minion with stub configurations
bootstrap-git-develop-$HIGHLEVEL_PACKAGE_MANAGER

# link default config paths to this repo
link-configs

# setup shell environment
setup-bash_profile

[ -z $SUDO_USER ] || chown -R $SUDO_USER:$SUDO_USER $BASE_DIR/salt /etc/salt

( cd $BASE_DIR/salt; git status )

MSG="##> DONE : $0 : $(date)"
