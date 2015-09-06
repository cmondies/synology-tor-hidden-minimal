FROM alpine:latest
RUN apk update

# Adding bash, lighttpd, ...
RUN apk add bash nano lighttpd supervisor

# Alpine Linux package management : 
# http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
# http://dl-4.alpinelinux.org/alpine/edge/testing/x86_64/
RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Cleaning ...
RUN rm /var/cache/apk/*
RUN rm -r /var/www/localhost

# Creating directories
CMD mkdir /var/lib/tor/hidden-service

# Adding configuration and default webserver files
ADD ./torrc /etc/tor/torrc
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD ./index.html /var/www/index.html
ADD ./info.php /var/www/info.php
ADD ./run.sh /run.sh

# Generate a random nickname for the relay
RUN echo "Nickname $(head -c 19 /dev/urandom  | sha1sum | cut -c1-19)" >> /etc/tor/torrc

# Running supervisord
USER root
ENTRYPOINT [ "/bin/bash","/run.sh" ]

