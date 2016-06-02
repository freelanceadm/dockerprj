#!/bin/bash
## 3.4 install nodejs ####
cat << EOF >  Dockerfile
FROM node:argon

# Create app directory
RUN mkdir -p /usr/src/app
RUN mkdir -p /data/db

WORKDIR /usr/src/app/mongodb

# Install app dependencies
#COPY package.json /usr/src/app/
#RUN npm install

# Bundle app source
#COPY server.js /usr/src/app

# add mongodb to this container
RUN apt-get -y update
RUN apt-get -y install mongodb-clients mongodb-server
#COPY ./mongo.sh /

EXPOSE 8080
CMD [ "/usr/bin/mongod" ]
EOF

docker build --rm -t nodejs-mongo .
docker run --name nodejs-mongo --restart="always" -p 8080:6000 -m 756M --volume=${appdir}/mongodb:/data/db --volume=${appdir}/nodejs:/usr/src/app -d nodejs-mongo
