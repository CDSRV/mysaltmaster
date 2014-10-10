#!/usr/bin/env bash

REPO=$PWD
ETC_SALT=$REPO/ROOT/etc/salt

echo "## using REPO : $REPO"
echo "## ETC_SALT = $ETC_SALT"

[ -d /etc/salt ] || mkdir /etc/salt

cd /etc/salt
ln -s $ETC_SALT/cloud.profiles.d
ln -s $ETC_SALT/cloud.providers.d
ln -s $ETC_SALT/master.d
ln -s $ETC_SALT/master
ln -s $ETC_SALT/minion

[ -d /srv ] || mkdir /srv

cd /srv
ln -s $REPO/../MINION/STATE salt
ln -s $REPO/../MINION/PILLAR pillar
ln -s $REPO/../MINION/REACTOR reactor