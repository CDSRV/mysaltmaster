## http://docs.saltstack.com/topics/targeting/grains.html

- standard location as specified in docs
- grains modules in this directory will override all others

EXAMPLES OF GRAINS
The core module in the grains package is where the main grains are loaded by the Salt minion and provides the principal example of how to write grains:

https://github.com/saltstack/salt/blob/develop/salt/grains/core.py

SYNCING GRAINS
Syncing grains can be done a number of ways, they are automatically synced when state.highstate is called, 
or (as noted above) the grains can be manually synced and reloaded by calling the saltutil.sync_grains or saltutil.sync_all functions.