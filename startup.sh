#!/bin/sh
service tor start & sleep 10; service tor stop ; echo "Your hostname:" ; cat /var/lib/tor/hidden_service/hostname
