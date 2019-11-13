#!/bin/bash -ea

echo "##> START : $0 : $(date)"

# check root
[ "$EUID" == "0" ] || { echo "##> this needs to run as root"; exit 1; }

bin/stop-services

# check parameters
SALT_HOME="${SALT_HOME:-$PWD}"
BASE_DIR="${BASE_DIR:-/usr/local/src}"
[ -d $BASE_DIR ] || mkdir -p $BASE_DIR
PY_ENV="${PY_ENV:-python-salt-develop}"
PY_ENV_PATH=$BASE_DIR/$PY_ENV

# check directory
[ -d $SALT_HOME/bin ] || { echo "##> $SALT_HOME/bin : not found"; exit 1; }

PATH=$SALT_HOME/bin:$PATH

# to setup a MASTER
## install package repos and update everything
init-instance

## install saltmaster + minion with stub configurations
bootstrap-git-develop

# link default config paths to this repo
link-configs

# setup shell environment
setup-bash_profile

[ -z $SUDO_USER ] || chown -R $SUDO_USER:$SUDO_USER $BASE_DIR/salt /etc/salt

( cd $BASE_DIR/salt; git status )

echo "##> DONE : $0 : $(date)"
