#!/bin/sh
/usr/bin/tor -f /etc/tor/torrc
sleep 30
cat /var/lib/tor/hidden_service/hostname
# exec "$@"
