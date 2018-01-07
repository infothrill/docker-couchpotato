#!/bin/sh
echo "$(date): STARTING COUCHPOTATO"

. /etc/couchpotato/userSetup.sh

if test -f /config/settings.ini; # optional, defaults to /data/.couchpotato/settings.ini
then
	exec sudo -Hu ${RUN_AS} python /CouchPotatoServer/CouchPotato.py --data_dir=/data --config_file=/config/settings.ini --console_log
else
	exec sudo -Hu ${RUN_AS} python /CouchPotatoServer/CouchPotato.py --data_dir=/data --console_log
fi
