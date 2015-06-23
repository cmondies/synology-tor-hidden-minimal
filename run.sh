#!/bin/sh
sleep 30
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
sleep 60
echo "Your hostname :"
cat /var/lib/tor/hidden_service/hostname
exit

