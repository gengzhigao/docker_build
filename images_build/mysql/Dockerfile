############################################################
# Dockerfile to build MySQL Installed Containers
# Based on Centos
############################################################
# Set the base image to Centos
FROM docker.io/centos:6.6
# File Author / Maintainer
MAINTAINER Maintaner gengzhi
# Modify the zone
RUN echo "" > /etc/sysconfig/clock; \
    echo "ZONE=Asia/Shanghai" >> /etc/sysconfig/clock; \
    mv /etc/localtime /etc/localtime_bak; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# Add mysql.repo to the default sources
ADD mysql-community.repo /etc/yum.repos.d/
# Download and Install MySQL
RUN yum clean all
RUN yum install -y mysql-community-server
# Remove the default MySQL configuration file
RUN rm -v /etc/my.cnf
# Copy a configuration file from the current directory
ADD my.cnf /etc/
# Expose ports
EXPOSE 3306
# Add loader.sh start script
ADD loader.sh /bin/
RUN chmod +x /bin/loader.sh
# Set the default command to execute
CMD /bin/loader.sh
