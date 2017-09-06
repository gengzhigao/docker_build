create user 'hive' identified by 'hive';
create database hive;
alter database hive character set latin1;
grant all on hive.* to hive@'%'  identified by 'hive';
grant all on hive.* to hive@'localhost'  identified by 'hive';
flush privileges; 
