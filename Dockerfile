FROM alpine:latest
RUN apk update
RUN apk add lighttpd
# Alpine Linux package management : http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
# http://dl-4.alpinelinux.org/alpine/edge/testing/x86_64/
RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Ports
EXPOSE 9001
EXPOSE 9050
EXPOSE 8080

RUN rm /var/cache/apk/*

ADD ./index.html /var/www/localhost/htdocs/index.html
ADD ./torrc /etc/tor/torrc
# Allow you to upgrade your relay without having to regenerate keys
VOLUME /.tor

# Generate a random nickname for the relay
RUN echo "Nickname $(head -c 19 /dev/urandom  | sha1sum | cut -c1-19)" >> /etc/tor/torrc

CMD mkdir /var/lib/tor/hidden-service

#USER www
#CMD /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf
CMD /etc/init.d/lighttpd start

USER tor
CMD /usr/bin/tor -f /etc/tor/torrc

CMD	less /var/lib/tor/hidden_service/hostname

