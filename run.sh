#!/bin/sh
sleep 10
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
sleep 30
echo "Your hostname :"
cat /var/lib/tor/hidden_service/hostname
exit

