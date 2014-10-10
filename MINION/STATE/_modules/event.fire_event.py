# Import the proper library
import salt.utils.event
# Fire deploy action
sock_dir = '/var/run/salt/minion'
payload = {'sample-msg': 'this is a test',
           'example': 'this is the same test'}
event = salt.utils.event.SaltEvent('master', sock_dir)
event.fire_event(payload, 'tag')