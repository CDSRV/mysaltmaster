#!/usr/bin/env bash


## edit and copy or symlink ROOT/etc/salt/master > /etc/salt/master
## (( need more script logic to call this from where?))

## turn off iptables 
service iptables stop
chkconfig iptables off

## or set allow rule for ports 4505, 4506

## for halite web interface..

## may want to configure this for accurate cert details
cd /etc/pki/tls/certs/
openssl req -batch -new -nodes -out localhost.csr -keyout localhost.key
openssl x509 -in localhost.csr -out localhost.crt -req -signkey localhost.key -days 999
chmod 600 localhost.*

## step 3: check 'external_auth' settings
## if LDAP is configured, change provider from 'pam' to 'ldap'

## otherwise, add local user "saltrunner"
adduser -m saltrunner
echo halite | passwd --stdin saltrunner

## step 4: make sure to restart service when initially setting up
## service salt-master restart

## check /etc/salt/master.d/halite.conf
## allow rule for port configured there..
