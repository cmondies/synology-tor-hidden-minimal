#!/bin/sh
sleep 5
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
exit

