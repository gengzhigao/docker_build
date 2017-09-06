############################################################
# Dockerfile to build Tomcat7 Installed Containers
# Based on Centos6
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
# Install JDK
RUN rpm -ivh http://ovfdlvm00.bkt.clouddn.com/jdk-7u79-linux-x64.rpm
# Install tools
RUN yum install -y vim wget gcc tar
# Install Tomcat7
WORKDIR /usr/share
RUN curl -SL http://ovfdlvm00.bkt.clouddn.com/apache-tomcat-7.0.70.tar.gz | tar xzf -
# Install glusterfs client and haproxy
RUN yum install -y glusterfs glusterfs-cli glusterfs-fuse
RUN yum install -y haproxy
# Install MySQL Client
ADD mysql-community.repo /etc/yum.repos.d/
RUN yum install -y mysql
# Remove the default Tomcat7 log file
RUN rm -rf /usr/share/apache-tomcat-7.0.70/logs
RUN ln -s /data/log/tomcat /usr/share/apache-tomcat-7.0.70/logs
# Create tomcat user 
RUN useradd -M tomcat
RUN chsh tomcat -s /sbin/nologin
RUN chown -R tomcat:tomcat /usr/share/apache-tomcat-7.0.70
# Configure jsvc 
WORKDIR /usr/share/apache-tomcat-7.0.70/bin
RUN tar -zxvf commons-daemon-native.tar.gz
WORKDIR commons-daemon-1.0.15-native-src/unix/
RUN ./configure --with-java=/usr/java/default
RUN make
RUN cp jsvc /usr/share/apache-tomcat-7.0.70/bin 
WORKDIR /root
# Expose ports
EXPOSE 8080
EXPOSE 8443
# Set Environment
ENV JAVA_HOME /usr/java/default
ENV TOMCAT_HOME /usr/share/apache-tomcat-7.0.70
# Configure tomcat7 init start script
ADD tomcat7 /etc/init.d/
RUN chkconfig --add tomcat7
RUN chkconfig tomcat7 on
# Add loader.sh start script
COPY loader.sh /bin/
RUN chmod +x /bin/loader.sh
# Set the default command to execute
CMD /bin/loader.sh
