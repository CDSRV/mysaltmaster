#!/usr/bin/env bash


## SETUP DEVELOPMENT VERSION OF SALT
# http://docs.saltstack.com/topics/installation/index.html?highlight=dependencies
# http://docs.saltstack.com/topics/hacking.html#installing-salt-from-the-python-package-index

## base prerequisites
yum install -y gcc gcc-c++ kernel-devel kernel-headers dkms make bzip2 mlocate openssl-devel

## general python tools
yum install -y python-setuptools python-pip python-virtualenv swig python-crypto 

## PYTHON VIRTUAL ENV
## where to install this?
CALLER_DIR=$PWD
BASE_DIR=/usr/local/src
PY_ENV=python-salt-develop

cd $BASE_DIR

[ -d $PY_ENV ] || mkdir $PY_ENV
[ -d $HOME/bin ] || mkdir $HOME/bin

virtualenv $PY_ENV
virtualenv --system-site-packages $PY_ENV

echo "
source $BASE_DIR/$PY_ENV/bin/activate
" > $HOME/bin/activate-$PY_ENV
chmod 755 $HOME/bin/activate-$PY_ENV
. $HOME/bin/activate-$PY_ENV

grep $BASE_DIR/$PY_ENV $HOME/.bash_profile ||  echo ". $HOME/bin/activate-$PY_ENV" >> $HOME/.bash_profile


## yaml 
yum install -y yaml-cpp yaml-cpp-devel libyaml libyaml-devel

## zeromq
yum install -y zeromq3-devel python-zmq msgpack msgpack-devel python-msgpack

## jinja
yum install -y python-jinja2

GIT_CURL_VERBOSE=1

cd $BASE_DIR

## why is M2Crypto problematic here?

#pip install M2Crypto    # Don't install on Debian/Ubuntu (see below)

## this may or may not be needed
[ -d ./M2Crypto/.git ] || git clone https://github.com/martinpaljak/M2Crypto.git
[ -d ./M2Crypto/.git ] && (cd ./M2Crypto; git pull)
cd M2Crypto
python setup.py build
python setup.py install
python setup.py test

pip install pyzmq PyYAML pycrypto msgpack-python jinja2 psutil

cd $BASE_DIR

[ -d ./salt/.git ] || git clone https://github.com/saltstack/salt.git
[ -d ./salt/.git ] && (cd ./salt; git pull)
cd salt
git remote add upstream https://github.com/saltstack/salt.git
git fetch upstream
git fetch --tags upstream

##
cd $BASE_DIR
pip install -e ./salt   # the path to the salt git clone from above

pip install pyOpenSSL cherrypy halite

echo "## SALT development branch is now installed at $BASE_DIR/$PY_ENV"
echo "## environment initialization script is at $HOME/bin/activate-$PY_ENV"
echo "## this has been added to $HOME/.bash_profile"
echo "## all services will need to be started manually" 
echo "## look at the README file for more hints on what to do next.."
