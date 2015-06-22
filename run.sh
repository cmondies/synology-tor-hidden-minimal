#!/bin/sh
/usr/bin/tor -f /etc/tor/torrc
exec "$@"
