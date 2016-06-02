#!/bin/bash
## 3.2. LAMP container ##############################################################
cat << EOF >  Dockerfile
FROM tutum/lamp:latest

MAINTAINER dawnbreather@gmail.com

# Let's switch to non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install PHP-curl and enabling SSL
RUN apt-get update && apt-get install php5-curl -y
RUN a2enmod ssl

# Expose ports
EXPOSE 80
#
CMD ["/run.sh"]
EOF

docker build --rm -t lamp .
docker run --restart="always" -m 512M --volume=${appdir}/lamp:/var/www/html -e MYSQL_PASS="${sqlrootpass}" -d -p 8080:80 lamp

