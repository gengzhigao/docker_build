SET NAMES utf8 ;

SET SQL_MODE='';

CREATE DATABASE IF NOT EXISTS tigasedb7 DEFAULT CHARACTER SET utf8 ;

create user 'tigase_user'@'%' IDENTIFIED BY 'tigase_pass'; 
grant all privileges on tigasedb7.*  to 'tigase_user'@'%'  identified by 'tigase_pass';
grant all privileges on tigasedb7.*  to 'tigase_user'@'127.0.0.1'  identified by 'tigase_pass';
grant all privileges on tigasedb7.*  to 'tigase_user'@'localhost'  identified by 'tigase_pass';

