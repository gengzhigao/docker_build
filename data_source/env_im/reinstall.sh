docker export IM > /opt/docker_source/images/appcan.im.1.0.tar

docker rm -f IM;
#docker rmi appcan/im:1.0;

cat /opt/docker_source/images/appcan.im.1.0.tar | docker import - appcan/im:1.0
echo -e "\n"
./start.sh
