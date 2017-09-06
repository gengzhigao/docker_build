# delete docker con;
docker rm -f `docker ps -qa`;
docker rmi `docker images -q`;

#clean GFS DOCKER data;
rm -rf /data/gfs/GFS/export;

#clean MYSQL DOCKER data;
rm -rf /data/mysql/MYSQL/mysql;
rm -rf /data/mysql/MYSQL/log;

#clean MONGO DOCKER data;
rm -rf /data/mongo/MONGO/mongo;

#clean IM DOCKER data;
rm -rf /data/redis/REDIS63*/redis.rdb;

#clean BAASADMIN DOCKER data;
rm -rf /data/mas/BAASADMIN/log;

#clean IM DOCKER data;
rm -rf /data/im/IM/log;

#clean EMMWEB DOCKER data;
rm -rf /data/tomcat/EMMWEB/log;
rm -rf /data/tomcat/EMMWEB/tomcat/*;

#clean NGINX DOCKER data;
rm -rf /data/nginx/NGINX/log;
