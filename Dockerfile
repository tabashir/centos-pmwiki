FROM centos:7
MAINTAINER "Jeff Geiger" <jeff@geigerlabs.io>
ENV PMWIKI_VERSION 2.2.85

RUN yum makecache fast && yum install -y httpd php && yum clean all && \
    curl -k -o /tmp/pmwiki-${PMWIKI_VERSION}.tgz https://pkgs.blackops.blue/other/pmwiki-${PMWIKI_VERSION}.tgz && \
    tar -xvzC /tmp/ -f /tmp/pmwiki-${PMWIKI_VERSION}.tgz && \
    cp -r /tmp/pmwiki-${PMWIKI_VERSION}/* /var/www/html/ && \
    mkdir /var/www/html/wiki.d/ &&  \
    chown -R apache:apache /var/www/html

COPY index.php /var/www/html/

EXPOSE 80

VOLUME ["/var/www/html/wiki.d/","/var/www/html/local/","/var/www/html/cookbook/"]

CMD ["--port 80"]

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
