FROM debian:jessie

MAINTAINER "Dylan Miles" <dylan.g.miles@gmail.com>

WORKDIR /tmp

# Install Nginx
RUN apt-get update -y && \
    apt-get install -y nginx

# Apply Nginx configuration
ADD config/nginx.conf /opt/etc/nginx.conf
ADD config/site /etc/nginx/sites-available/site
RUN ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site && \
    rm /etc/nginx/sites-enabled/default

# Nginx startup script
ADD config/nginx-start.sh /opt/bin/nginx-start.sh
RUN chmod u=rwx /opt/bin/nginx-start.sh

RUN mkdir -p /data
VOLUME ["/data"]

# PORTS
EXPOSE 80
EXPOSE 443

WORKDIR /opt/bin
ENTRYPOINT ["/opt/bin/nginx-start.sh"]
