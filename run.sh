#!/bin/sh
service tor start & sleep 30; 
service tor stop ; 
echo "Your hostname :" ; 
cat /var/lib/tor/hidden_service/hostname ;

# exec "$@"
