mysaltmaster
================

A starting point for salt master/minion configs, formulas, recipes, etc

(This sets up a development environment)

Contents:
(currently only explicitly supporting CentOS 6)
-- please review these files and edit before running/deploying

Getting Started:
----------------
cd MASTER < this is very important, the script doesn't know where you unpacked it, so change directories in..

./INSTALL.sh < run this first, it will do everything except make toast

./CLEAN.sh < run this as needed to clear out keys so you can start fresh with a new master or minion

================
MASTER/ROOT <<  "/" for saltmaster config files

 -> etc/salt	<< sample config files
 
 -> root/bin 	<< initial setup scripts for master/minion
 
 		-> these are all handled by MASTER/INSTALL.sh
 			
 		-- to manage minion binding :
 			+ on master, run 'salt-key' command

 -> root/bin 	<< other ditties for general productivity
 
  		-> s		<< cmd-alias for "salt '*'"
  		-> test-states << runs highstate in test mode
 
 			

================
MINION/STATE	<< mapped to the file_roots (standard is /srv/salt)

 -> /test		<< simple test state for installation verification
 
 -> /$PLATFORM_$COMPONENT_$ENV << use variables for REGULAR directory structure. 
 .. create modules to be layered into general>>specific configs
 .. change scope up and down application stack
 -> $GENERIC_SCOPE-$SPECIFIC_SCOPE-$LOCAL_CONFIG
 
((*****))
 	naming convention for config-file templates
 	goals:
 	* preserve original filename
 	* explicitly define the template type (no assumptions)

	$FILENAME-$TEMPLATE_TYPE

		eg,

	resolv.conf-jinja

	nsswitch.conf-redhat
	nsswitch.conf-ubuntu

((*****))
	path spec for storing config files:
	goals:
	* preserve original filename
	* preserve original full path

	$STATE/ROOT/$OS_PATH/$FILENAME

		eg,

	OS_NET/ROOT/etc/resolv.conf
	OS_NET/ROOT/etc/resolv.conf-jinja

	OS_BASE/ROOT/etc/profile
 
 
 
================
MINION/PILLAR	<< mapped to the pillar_roots (standard is /srv/pillar)

((*****))
 	naming convention for pillar files
 	goals:
 	* match relevant STATE name exactly
 	* append customer/environment/specifics

	$STATE-$CUSTOM.sls

		eg,

	OS_AUTH-customer.sls


((*****))
	variable spec for templating config files:
	goals:
	* preserve original package names
	* preserve original variable names
	
	$PILLAR/$STATE.sls
	  $PKG:
	  	VAR = {{ VAR }}
 
 ================
MINION/REACTOR   << mapped to /srv/reactor on master (is there a reactor_root variable?)

(mappings are defined in /etc/salt/master.d/reactor.conf on master)
 