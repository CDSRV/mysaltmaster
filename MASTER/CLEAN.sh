#!/bin/env bash

## this will clear out various areas from the master to make it new and squeaky
echo "PRESS ANY KEY TO CLEAR KEYS AND CACHES"
read GO
rm -rf /etc/salt/pki
rm -rf /var/cache/salt/master
rm -rf /var/cache/salt/minion
echo "DONE.."