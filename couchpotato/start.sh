#!/bin/sh
echo "$(date): STARTING COUCHPOTATO"

. /etc/couchpotato/userSetup.sh

exec sudo -Hu ${RUN_AS} python /CouchPotatoServer/CouchPotato.py --data_dir=/data --config_file=/config/settings.ini --console_log
