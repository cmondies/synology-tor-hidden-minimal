#!/bin/sh
#exec sudo -u tor /usr/bin/tor -f /etc/tor/torrc ;
#exec sudo -u root lighttpd -f /etc/lighttpd/lighttpd.conf ;
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
#service tor start
#service lighttpd start

