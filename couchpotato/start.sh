#!/bin/sh
echo "$(date): STARTING COUCHPOTATO"

. /etc/couchpotato/userSetup.sh

#dockerize -template /etc/couchpotato/environment-variables.tmpl:/etc/couchpotato/environment-variables.sh /bin/true
exec sudo -Hu ${RUN_AS} python /app/CouchPotatoServer/CouchPotato.py --console_log $COUCHPOTATO_OPTS
echo "$(date): Couchpotato startup script complete."
