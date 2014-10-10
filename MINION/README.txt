## these files ALSO go on the master..
## but these are the MINION configs .and would expect to be drawn from various remote sources
## roughly put, these subdirectories link into /srv/[salt|pillar|reactor]

# STATE   > /srv/salt   (or file_root )
# PILLAR  > /srv/pillar (or pillar_root)
# REACTOR > /srv/reactor (or reactor_root if it existed..)

# .. changing up the names a little because its hard to keep track of a million directories and files called 'salt' .. thus, "STATE"