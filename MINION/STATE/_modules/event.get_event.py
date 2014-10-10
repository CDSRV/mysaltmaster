import salt.utils.event

event = salt.utils.event.MasterEvent('/var/run/salt/master')

data = event.get_event()