source ~/.bashrc
container_name="EMMWEB"
if [ $1 ]; then
	container_name=$1
fi
docker-enter ${container_name} <<EOF
	service tomcat7 start && tail -f /data/log/tomcat/catalina.out	
EOF
