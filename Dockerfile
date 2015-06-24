FROM alpine:latest
RUN apk update
RUN apk add bash nano lighttpd supervisor php-cgi php-gd
# Alpine Linux package management : http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
# http://dl-4.alpinelinux.org/alpine/edge/testing/x86_64/
RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN rm /var/cache/apk/*

ADD ./torrc /etc/tor/torrc
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD ./index.html /var/www/index.html
ADD ./info.php /var/www/info.php

# Allow you to upgrade your relay without having to regenerate keys
VOLUME /.tor

# Generate a random nickname for the relay
RUN echo "Nickname $(head -c 19 /dev/urandom  | sha1sum | cut -c1-19)" >> /etc/tor/torrc

CMD mkdir /var/lib/tor/hidden-service

ADD ./run.sh /run.sh
USER root
ENTRYPOINT [ "/bin/bash","/run.sh" ]

