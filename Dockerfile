FROM alpine:latest
RUN apk update
RUN apk add bash sudo lighttpd supervisor
# Alpine Linux package management : http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
# http://dl-4.alpinelinux.org/alpine/edge/testing/x86_64/
RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Ports
EXPOSE 9001
EXPOSE 9050
EXPOSE 8080
EXPOSE 8081

RUN rm /var/cache/apk/*

ADD ./torrc /etc/tor/torrc
#ADD supervisord.conf /etc/supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./lighttpd.conf /etc/lighttpd/lighttpd.conf
# Allow you to upgrade your relay without having to regenerate keys
VOLUME /.tor

# Generate a random nickname for the relay
RUN echo "Nickname $(head -c 19 /dev/urandom  | sha1sum | cut -c1-19)" >> /etc/tor/torrc

CMD mkdir /var/lib/tor/hidden-service

#USER tor
#CMD /usr/bin/tor -f /etc/tor/torrc

ADD ./run.sh /run.sh
USER root
ENTRYPOINT [ "/bin/bash","/run.sh" ]
#ENTRYPOINT ["/usr/bin/supervisord"]
#ENTRYPOINT ["supervisord", "-n", "-c", "/etc/supervisord.conf"]

#CMD ["/usr/bin/supervisord"]
#CMD ["/run.sh"]
