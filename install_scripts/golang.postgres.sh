#!/bin/bash

cat << EOF > Dockerfile
FROM golang:1.6

MAINTAINER freelanceadm@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Upgrading Ubuntu
RUN apt-get update

# Install PostgreSQL
#RUN apt-get install supervisor -y
RUN apt-get -y install postgresql postgresql-contrib

# Expose ports
EXPOSE 80 5000
EOF

docker build --rm -t golangapp .
docker run --restart="always" -m 512M --volume=${appdir}/go:/go/src -p 80:80 -p 5000:5000 -d golangapp
