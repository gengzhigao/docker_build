############################################################
# Dockerfile to build REDIS Installed Containers
# Based on Centos
############################################################
# Set the base image to Centos
FROM docker.io/centos:7
# File Author / Maintainer
MAINTAINER Maintaner gengzhi
# Modify the zone
RUN echo "" > /etc/sysconfig/clock; \
    echo "ZONE=Asia/Shanghai" >> /etc/sysconfig/clock; \
    mv /etc/localtime /etc/localtime_bak; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# Add epel.repo source
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# Download and Install REDIS
RUN yum clean -y all
RUN yum install -y redis
# Backup redis configuration file
RUN cp /etc/redis.conf /etc/redis.conf_init
# Expose ports
EXPOSE 6379
EXPOSE 26379
EXPOSE 6380
EXPOSE 26380
# Add loader.sh start script
ADD loader.sh /bin/
RUN chmod +x /bin/loader.sh
# Set the default command to execute
CMD /bin/loader.sh
