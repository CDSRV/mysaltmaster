#!/bin/bash -x

## this will clear out various areas from the master to make it new and squeaky
echo "PRESS ANY KEY TO CLEAR KEYS AND CACHES"
read GO
rm -rf /etc/salt/pki
rm -rf /etc/salt/minion.d
rm -f /etc/salt/minion_id
rm -rf /var/cache/salt/master
rm -rf /var/cache/salt/minion
rm -f /var/log/salt/*
echo "DONE.."
