# PoC Dockerfile for CPO-20966
# Pull base image
FROM ubuntu
# Install Apache
RUN apt-get update -y && apt-get install apache2 apache2-utils libapache2-mod-jk -y
# Add customised default page
COPY index.html /var/www/html
# Enable HTTP2
RUN a2enmod http2
# Export default web port
EXPOSE 80
# Set contqainer entrypoint for startup
ENTRYPOINT ["/usr/sbin/apache2ctl" ]
CMD [ "-D", "FOREGROUND" ]

