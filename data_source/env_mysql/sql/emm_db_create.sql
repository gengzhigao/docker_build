create database emm_db character set utf8;
grant all privileges on emm_db.* to 'emm_user'@'%' identified by 'emmpass' with max_user_connections 500;
grant all privileges on emm_db.* to 'emm_user'@'localhost' identified by 'emmpass' with max_user_connections 500;
flush privileges;
create database analy_db character set utf8;
grant all privileges on analy_db.* to 'analy_user'@'%' identified by 'analypass' with max_user_connections 500;
grant all privileges on analy_db.* to 'analy_user'@'localhost' identified by 'analypass' with max_user_connections 500;
grant all privileges on analy_db.* to 'emm_user'@'%' identified by 'emmpass' with max_user_connections 500;
grant all privileges on analy_db.* to 'emm_user'@'localhost' identified by 'emmpass' with max_user_connections 500;
flush privileges;
flush privileges;
