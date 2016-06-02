#!/bin/bash
## 3.1. FTP container
cat << EOF > Dockerfile
FROM debian:jessie
MAINTAINER Anatolii Kartashov "freelanceadm@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends vsftpd
RUN apt-get clean

RUN echo "local_enable=YES" >> /etc/vsftpd.conf
RUN echo "chroot_local_user=YES" >> /etc/vsftpd.conf
RUN echo "write_enable=YES" >> /etc/vsftpd.conf
RUN echo "local_umask=022" >> /etc/vsftpd.conf
RUN sed -i "s/anonymous_enable=YES/anonymous_enable=NO/" /etc/vsftpd.conf
RUN sed -i "s/^secure_chroot_dir=.*$/secure_chroot_dir=\/opt\/apps/" /etc/vsftpd.conf

RUN mkdir -p /opt/apps
RUN useradd -s /bin/sh -d ${appdir} ${ftpuser}
RUN echo "${ftpuser}:${ftppass}" | chpasswd

EXPOSE 21

CMD /usr/sbin/vsftpd
EOF

docker build --rm -t vsftp .

# run ftp container
docker run --restart="always" -m 128M -p 21:21 --volume=${appdir}:${appdir} --name vsftp-cont -d vsftp

