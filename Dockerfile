FROM arm32v6/alpine:3.6
MAINTAINER Stephen Bunn "scbunn@sbunn.org"

COPY docker-entrypoint.sh /
RUN apk update &&\
    apk add --no-cache su-exec && \
    apk add --no-cache squid=3.5.23-r2 && \
    apk add --no-cache httpd && \
    mkdir -p /var/cache/squid &&\
    chmod +x /docker-entrypoint.sh
COPY conf/squid.conf /etc/squid/squid.conf
COPY index.html /var/www/html/
CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "squid" ]
EXPOSE 3128 3130
EXPOSE 80
