#!/bin/sh
sleep 10
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
exit

