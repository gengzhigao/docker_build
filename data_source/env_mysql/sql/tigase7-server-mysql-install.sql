-- SET NAMES utf8 ;

-- SET SQL_MODE='';

-- CREATE DATABASE IF NOT EXISTS tigasedb7 DEFAULT CHARACTER SET utf8 ;

USE tigasedb7;

-- tigase-desinger
CREATE TABLE if not exists all_msg (                                     
	id int(11) unsigned NOT NULL AUTO_INCREMENT,             
	appidandkey varchar(256) DEFAULT NULL,                   
	sendid varchar(64) DEFAULT NULL,                         
	msg varchar(4096) DEFAULT NULL,                          
	date_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                         
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists appid_appkey (                
	id int(11) NOT NULL AUTO_INCREMENT,      
	appidanduserkey char(128) DEFAULT NULL,  
	appkey char(200) DEFAULT NULL,           
	tenantid char(200) DEFAULT NULL,         
	PRIMARY KEY (id)                         
) 
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists auto_reply (                                                                
	id int(11) NOT NULL AUTO_INCREMENT,                                                    
	userid char(128) DEFAULT NULL,                                                         
	isReply char(128) DEFAULT NULL,                                                        
	reply varchar(4096) DEFAULT NULL,                                                      
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                                                       
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists count_result (                                  
	id int(11) unsigned NOT NULL AUTO_INCREMENT,               
	appidandkey varchar(256) DEFAULT NULL,                     
	online_num int(11) DEFAULT NULL,                           
	today_send_msg_user_num int(11) DEFAULT NULL,              
	today_msg_count int(11) DEFAULT NULL,                      
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists delrecentlist (                                 
	id int(11) NOT NULL AUTO_INCREMENT,                        
	ContactsUser char(128) DEFAULT NULL,                       
	CurrentUser char(128) DEFAULT NULL,                        
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists file_path (               
	id int(11) NOT NULL AUTO_INCREMENT,  
	uuid char(128) DEFAULT NULL,         
	path char(200) DEFAULT NULL,         
	size int(11) DEFAULT NULL,           
	PRIMARY KEY (id)                     
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists file_path_web (                                 
	Screenshot char(128) DEFAULT NULL,                         
	id int(11) NOT NULL AUTO_INCREMENT,                        
	uuid char(128) DEFAULT NULL,                               
	path mediumtext,                                           
	size int(11) DEFAULT NULL,                                 
	ContactsUser char(128) DEFAULT NULL,                       
	CurrentUser char(128) DEFAULT NULL,                        
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists muc_unread_message (      
	user_id char(128) DEFAULT NULL,      
	uuid char(128) DEFAULT NULL,         
	id int(11) NOT NULL AUTO_INCREMENT,  
	PRIMARY KEY (id)                     
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists offline_count (           
	id int(11) NOT NULL AUTO_INCREMENT,  
	user_id varchar(255) NOT NULL,       
	count int(11) DEFAULT '1',           
	PRIMARY KEY (id),                    
	UNIQUE KEY user_id (user_id)       
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists offline_time (            
	id int(10) NOT NULL AUTO_INCREMENT,  
	user_id varchar(255) DEFAULT NULL,   
	off_time varchar(255) DEFAULT NULL,  
	PRIMARY KEY (id),                    
	UNIQUE KEY user_id (user_id)       
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists recentcontactslist (                            
	id int(11) NOT NULL AUTO_INCREMENT,                        
	ContactsUser char(128) DEFAULT NULL,                       
	CurrentUser char(128) DEFAULT NULL,                        
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8; 

CREATE TABLE if not exists recentgrouplist (                               
	id int(11) NOT NULL AUTO_INCREMENT,                        
	groupid char(128) DEFAULT NULL,                            
	CurrentUser char(128) DEFAULT NULL,                        
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists recentvoiplist (                                
	id int(11) NOT NULL AUTO_INCREMENT,                        
	ContactsUser char(128) DEFAULT NULL,                       
	CurrentUser char(128) DEFAULT NULL,                        
	calltime char(128) DEFAULT NULL,                           
	userName char(128) DEFAULT NULL,                           
	phone char(128) DEFAULT NULL,                              
	callstatus char(128) DEFAULT NULL,                         
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists shield_message (          
	id int(11) NOT NULL AUTO_INCREMENT,  
	user_id char(128) DEFAULT NULL,      
	`group` char(128) DEFAULT NULL,        
	flag char(20) DEFAULT NULL,          
	PRIMARY KEY (id)                     
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists software_version (                                                          
	id int(11) NOT NULL AUTO_INCREMENT,                                                    
	version varchar(4096) DEFAULT NULL,                                                    
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                                                       
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists suggest (                                       
	id int(11) NOT NULL AUTO_INCREMENT,                        
	userid char(128) DEFAULT NULL,                             
	suggest varchar(4096) DEFAULT NULL,                        
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists t_base_pinyin (                         
	pin_yin_ varchar(255) CHARACTER SET gbk NOT NULL,  
	code_ int(11) NOT NULL,                            
	PRIMARY KEY (code_)                                
)
ENGINE=InnoDB default character set utf8 ;

CREATE TABLE if not exists useronlinestate (                               
	id int(11) NOT NULL AUTO_INCREMENT,                        
	user_id char(128) DEFAULT NULL,                            
	online_state char(128) DEFAULT NULL,                       
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  
	PRIMARY KEY (id)                                           
)
ENGINE=InnoDB default character set utf8;

-- tigase-code-create
CREATE TABLE if not exists user_jid (                                
	jid_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,  
	jid_sha char(128) NOT NULL,                          
	jid varchar(2049) NOT NULL,                          
	history_enabled int(11) DEFAULT '0',                 
	PRIMARY KEY (jid_id),                                
	UNIQUE KEY jid_id (jid_id),                        
	UNIQUE KEY jid_sha (jid_sha),                      
	KEY jid (jid(255))                                 
)
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists msg_history (                             
	msg_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,  
	ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,   
	-- ts bigint(20) unsigned DEFAULT NULL,     
	expired datetime DEFAULT NULL,                       
	sender_uid bigint(20) unsigned DEFAULT NULL,         
	receiver_uid bigint(20) unsigned NOT NULL,           
	msg_type int(11) NOT NULL DEFAULT '0',               
	message varchar(4096) NOT NULL,                      
	-- status int(11) NOT NULL DEFAULT '0', 
	-- uuid char(128) ,
	UNIQUE KEY msg_id (msg_id),                        
	KEY expired (expired),                             
	KEY sender_uid (sender_uid,receiver_uid),        
	KEY receiver_uid (receiver_uid,sender_uid)       
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC ;

CREATE TABLE if not exists muc_history (                 
	room_name char(128) NOT NULL,            
	event_type int(11) DEFAULT NULL,         
	timestamp bigint(20) DEFAULT NULL,       
	sender_jid varchar(2049) DEFAULT NULL,   
	sender_nickname char(128) DEFAULT NULL,  
	body text,                               
	public_event tinyint(1) DEFAULT NULL,    
	msg text,                                
	uuid char(128) DEFAULT NULL              
) 
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists broadcast_msgs (       
	  id varchar(128) NOT NULL,         
	  expired datetime NOT NULL,        
	  msg varchar(4096) NOT NULL,       
	  PRIMARY KEY (id)                  
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

CREATE TABLE if not exists tig_ma_jids (                             
	jid_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,  
	jid varchar(2049) DEFAULT NULL,                      
	PRIMARY KEY (jid_id)                                 
) 
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists broadcast_msgs_recipients (  
	 msg_id varchar(128)  NOT NULL,           
	 jid_id bigint(20) unsigned NOT NULL,    
	 PRIMARY KEY (msg_id,jid_id)           
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

CREATE TABLE if not exists tig_ma_msgs (                                                                     
	msg_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,                                          
	owner_id bigint(20) unsigned DEFAULT NULL,                                                   
	buddy_id bigint(20) unsigned DEFAULT NULL,                                                   
	ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,                 
	direction smallint(6) DEFAULT NULL,                                                          
	type varchar(10) DEFAULT NULL,                                                               
	body text,                                                                                   
	msg text,                                                                                    
	PRIMARY KEY (msg_id),                                                                        
	KEY buddy_id (buddy_id),                                                                   
	KEY owner_id (owner_id),                                                                   
	KEY owner_id_2 (owner_id,buddy_id),                                                      
	KEY owner_id_3 (owner_id,ts,buddy_id),                                                 
	CONSTRAINT tig_ma_msgs_ibfk_1 FOREIGN KEY (buddy_id) REFERENCES tig_ma_jids (jid_id),  
	CONSTRAINT tig_ma_msgs_ibfk_2 FOREIGN KEY (owner_id) REFERENCES tig_ma_jids (jid_id)   
) 
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists tig_ma_tags (                                                                                      
	tag_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,                                                           
	tag varchar(255) DEFAULT NULL,                                                                                
	owner_id bigint(20) unsigned NOT NULL,                                                                        
	PRIMARY KEY (tag_id),                                                                                         
	UNIQUE KEY tig_ma_tags_tag_owner_id (owner_id,tag),                                                       
	KEY tig_ma_tags_owner_id (owner_id),                                                                        
	CONSTRAINT tig_ma_tags_ibfk_1 FOREIGN KEY (owner_id) REFERENCES tig_ma_jids (jid_id) ON DELETE CASCADE  
) 
ENGINE=InnoDB default character set utf8;

CREATE TABLE if not exists tig_ma_msgs_tags (                                                                                     
	msg_id bigint(20) unsigned NOT NULL,                                                                              
	tag_id bigint(20) unsigned NOT NULL,                                                                              
	KEY tig_ma_msgs_tags_msg_id (msg_id),                                                                           
	KEY tig_ma_msgs_tags_tag_id (tag_id),                                                                           
	CONSTRAINT tig_ma_msgs_tags_ibfk_1 FOREIGN KEY (msg_id) REFERENCES tig_ma_msgs (msg_id) ON DELETE CASCADE,  
	CONSTRAINT tig_ma_msgs_tags_ibfk_2 FOREIGN KEY (tag_id) REFERENCES tig_ma_tags (tag_id) ON DELETE CASCADE   
) 
ENGINE=InnoDB default character set utf8;

-- tigase-server-base
create table if not exists tig_users (
	uid bigint unsigned NOT NULL auto_increment,
	user_id varchar(2049) NOT NULL,
	sha1_user_id char(128) NOT NULL,
	user_pw varchar(255) default NULL,
	acc_create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	last_login timestamp DEFAULT 0,
	last_logout timestamp DEFAULT 0,
	online_status int default 0,
	failed_logins int default 0,
	account_status int default 1,
	primary key (uid),
	unique key sha1_user_id (sha1_user_id),
	key user_pw (user_pw),
    -- key user_id (user_id(765)),
	key last_login (last_login),
	key last_logout (last_logout),
	key account_status (account_status),
	key online_status (online_status)
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8;

CREATE INDEX  part_of_user_id ON tig_users (user_id(255));

create table if not exists tig_nodes (
       nid bigint unsigned NOT NULL auto_increment,
       parent_nid bigint unsigned,
       uid bigint unsigned NOT NULL,
       node varchar(255) NOT NULL,
       primary key (nid),
       unique key tnode (parent_nid, uid, node),
       key node (node),
       key uid (uid),
       key parent_nid (parent_nid),
       constraint tig_nodes_constr foreign key (uid) references tig_users (uid)
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;

create table if not exists tig_pairs (
       nid bigint unsigned,
       uid bigint unsigned NOT NULL,
       pkey varchar(255) NOT NULL,
       pval mediumtext,
       key pkey (pkey),
       key uid (uid),
       key nid (nid),
       constraint tig_pairs_constr_1 foreign key (uid) references tig_users (uid),
       constraint tig_pairs_constr_2 foreign key (nid) references tig_nodes (nid)
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8;

create table if not exists short_news (
  snid            bigint unsigned NOT NULL auto_increment,
  publishing_time timestamp,
  news_type       varchar(10),
  author          varchar(128) NOT NULL,
  subject         varchar(128) NOT NULL,
  body            varchar(1024) NOT NULL,
  primary key(snid),
  key publishing_time (publishing_time),
  key author (author),
  key news_type (news_type)
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;

create table if not exists xmpp_stanza (
  id bigint unsigned NOT NULL auto_increment,
  stanza text NOT NULL,
  primary key (id)
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;

-- insert  into tig_users(uid,user_id,sha1_user_id,user_pw,acc_create_time,last_login,last_logout,online_status,failed_logins,account_status) values (1,'db-properties','aa546827cea73b2c960c2f16f4acb88f6972ff3d',NULL,'2016-06-07 19:51:29','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(2,'vhost-manager','af51856190a694c5a46d7a5131063caedbbaf809',NULL,'2016-06-07 19:55:09','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(4,'multi-user-chat','f1b366b1c9cc087c0f5a1873894f48cc3381443b',NULL,'2016-06-07 19:55:10','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(5,'tigase-pubsub','cc55433036963175e03d4e3df92063dc368acfd8',NULL,'2016-06-07 19:55:11','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(6,'srecv@robert','08c59836fe39b7a526ef27fc56b833797f3fded2',NULL,'2016-06-07 19:55:11','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1);
-- insert  into tig_nodes(nid,parent_nid,uid,node) values (1,NULL,1,'root'),(2,NULL,2,'root'),(3,NULL,4,'root'),(4,NULL,5,'root'),(6,NULL,6,'root'),(5,4,5,'default-node-config');
-- insert  into tig_pairs(nid,uid,pkey,pval) values (NULL,1,'schema-version','5.1'),(3,4,'last-start','1465300510688'),(5,5,'configuration','<x xmlns=\"jabber:x:data\" type=\"form\"><field type=\"hidden\" var=\"FORM_TYPE\"><value>http://jabber.org/protocol/pubsub#node_config</value></field><field type=\"list-single\" var=\"pubsub#node_type\"><value/><option><value>leaf</value></option><option><value>collection</value></option></field><field type=\"text-single\" var=\"pubsub#title\" label=\"A friendly name for the node\"><value/></field><field type=\"boolean\" var=\"pubsub#deliver_payloads\" label=\"Whether to deliver payloads with event notifications\"><value>1</value></field><field type=\"boolean\" var=\"pubsub#notify_config\" label=\"Notify subscribers when the node configuration changes\"><value>0</value></field><field type=\"boolean\" var=\"pubsub#persist_items\" label=\"Persist items to storage\"><value>1</value></field><field type=\"text-single\" var=\"pubsub#max_items\" label=\"Max # of items to persist\"><value>10</value></field><field type=\"text-single\" var=\"pubsub#collection\" label=\"The collection with which a node is affiliated\"><value/></field><field type=\"list-single\" var=\"pubsub#access_model\" label=\"Specify the subscriber model\"><value>open</value><option><value>authorize</value></option><option><value>open</value></option><option><value>presence</value></option><option><value>roster</value></option><option><value>whitelist</value></option></field><field type=\"list-single\" var=\"pubsub#publish_model\" label=\"Specify the publisher model\"><value>publishers</value><option><value>open</value></option><option><value>publishers</value></option><option><value>subscribers</value></option></field><field type=\"list-single\" var=\"pubsub#send_last_published_item\" label=\"When to send the last published item\"><value>on_sub</value><option><value>never</value></option><option><value>on_sub</value></option><option><value>on_sub_and_presence</value></option></field><field type=\"text-multi\" var=\"pubsub#domains\" label=\"The domains allowed to access this node (blank for any)\"/><field type=\"boolean\" var=\"pubsub#presence_based_delivery\" label=\"Whether to deliver notifications to available users only\"><value>0</value></field><field type=\"boolean\" var=\"tigase#presence_expired\" label=\"Whether to subscription expired when subscriber going offline.\"><value>0</value></field><field type=\"text-multi\" var=\"pubsub#embedded_body_xslt\" label=\"The XSL transformation which can be applied to payloads in order to generate an appropriate message body element.\"/><field type=\"text-single\" var=\"pubsub#body_xslt\" label=\"The URL of an XSL transformation which can be applied to payloads in order to generate an appropriate message body element.\"><value/></field><field type=\"text-multi\" var=\"pubsub#roster_groups_allowed\" label=\"Roster groups allowed to subscribe\"/><field type=\"boolean\" var=\"pubsub#notify_sub_aff_state\" label=\"Notify subscribers when owner change their subscription or affiliation state\"><value>1</value></field><field type=\"boolean\" var=\"tigase#allow_view_subscribers\" label=\"Allows get list of subscribers for each sybscriber\"><value>0</value></field><field type=\"list-single\" var=\"tigase#collection_items_odering\" label=\"Whether to sort collection items by creation date or update time\"><value>byUpdateDate</value><option><value>byCreationDate</value></option><option><value>byUpdateDate</value></option></field></x>') ,(2,2,'vhosts-lists','<vhost anon=\"true\" owner=\"admin@localhost\" register=\"true\" enabled=\"true\" tls-required=\"false\" max-users=\"0\" hostname=\"localhost\" domain-filter=\"ALL\"><comps/><other/></vhost>');

insert  into tig_users(uid,user_id,sha1_user_id,user_pw,acc_create_time,last_login,last_logout,online_status,failed_logins,account_status) values (2,'db-properties','aa546827cea73b2c960c2f16f4acb88f6972ff3d',NULL,'2016-06-07 20:23:17','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(3,'vhost-manager','af51856190a694c5a46d7a5131063caedbbaf809',NULL,'2016-06-07 20:23:43','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(5,'rest@http','468993d5315858231e4ad0d99dcfcf919bcf80ef',NULL,'2016-06-07 20:23:44','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(7,'dns-webservice@http','c3305d6566d67982b70d697c86c2732d554d08a5',NULL,'2016-06-07 20:23:45','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(9,'server@http','df48c9ec1166d8ec1aeb9fae79603853b2e525c1',NULL,'2016-06-07 20:23:45','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(11,'setup@http','f5e9c0f25ef02eece09e33d92aa895003e277807',NULL,'2016-06-07 20:23:45','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(13,'ui@http','2b802b90452637a0266c85b9fa40156e4332487b',NULL,'2016-06-07 20:23:46','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(15,'multi-user-chat','f1b366b1c9cc087c0f5a1873894f48cc3381443b',NULL,'2016-06-07 20:23:46','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1),(16,'tigase-pubsub','cc55433036963175e03d4e3df92063dc368acfd8',NULL,'2016-06-07 20:23:48','0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,-1);
insert  into tig_nodes(nid,parent_nid,uid,node) values (2,NULL,2,'root'),(3,NULL,3,'root'),(4,NULL,5,'root'),(5,NULL,7,'root'),(6,NULL,9,'root'),(7,NULL,11,'root'),(8,NULL,13,'root'),(9,NULL,15,'root'),(10,NULL,16,'root'),(11,9,15,'rooms'),(12,10,16,'default-node-config');;
insert  into tig_pairs(nid,uid,pkey,pval) values (NULL,2,'schema-version','5.1'),(9,15,'last-start','1465302226133'),(11,16,'configuration','<x xmlns=\"jabber:x:data\" type=\"form\"><field var=\"FORM_TYPE\" type=\"hidden\"><value>http://jabber.org/protocol/pubsub#node_config</value></field><field var=\"pubsub#node_type\" type=\"list-single\"><value/><option><value>leaf</value></option><option><value>collection</value></option></field><field var=\"pubsub#title\" label=\"A friendly name for the node\" type=\"text-single\"><value/></field><field var=\"pubsub#deliver_payloads\" label=\"Whether to deliver payloads with event notifications\" type=\"boolean\"><value>1</value></field><field var=\"pubsub#notify_config\" label=\"Notify subscribers when the node configuration changes\" type=\"boolean\"><value>0</value></field><field var=\"pubsub#persist_items\" label=\"Persist items to storage\" type=\"boolean\"><value>1</value></field><field var=\"pubsub#max_items\" label=\"Max # of items to persist\" type=\"text-single\"><value>10</value></field><field var=\"pubsub#collection\" label=\"The collection with which a node is affiliated\" type=\"text-single\"><value/></field><field var=\"pubsub#access_model\" label=\"Specify the subscriber model\" type=\"list-single\"><value>open</value><option><value>authorize</value></option><option><value>open</value></option><option><value>presence</value></option><option><value>roster</value></option><option><value>whitelist</value></option></field><field var=\"pubsub#publish_model\" label=\"Specify the publisher model\" type=\"list-single\"><value>publishers</value><option><value>open</value></option><option><value>publishers</value></option><option><value>subscribers</value></option></field><field var=\"pubsub#send_last_published_item\" label=\"When to send the last published item\" type=\"list-single\"><value>on_sub</value><option><value>never</value></option><option><value>on_sub</value></option><option><value>on_sub_and_presence</value></option></field><field var=\"pubsub#domains\" label=\"The domains allowed to access this node (blank for any)\" type=\"text-multi\"/><field var=\"pubsub#presence_based_delivery\" label=\"Whether to deliver notifications to available users only\" type=\"boolean\"><value>0</value></field><field var=\"tigase#presence_expired\" label=\"Whether to subscription expired when subscriber going offline.\" type=\"boolean\"><value>0</value></field><field var=\"pubsub#embedded_body_xslt\" label=\"The XSL transformation which can be applied to payloads in order to generate an appropriate message body element.\" type=\"text-multi\"/><field var=\"pubsub#body_xslt\" label=\"The URL of an XSL transformation which can be applied to payloads in order to generate an appropriate message body element.\" type=\"text-single\"><value/></field><field var=\"pubsub#roster_groups_allowed\" label=\"Roster groups allowed to subscribe\" type=\"text-multi\"/><field var=\"pubsub#notify_sub_aff_state\" label=\"Notify subscribers when owner change their subscription or affiliation state\" type=\"boolean\"><value>1</value></field><field var=\"tigase#allow_view_subscribers\" label=\"Allows get list of subscribers for each sybscriber\" type=\"boolean\"><value>0</value></field><field var=\"tigase#collection_items_odering\" label=\"Whether to sort collection items by creation date or update time\" type=\"list-single\"><value>byUpdateDate</value><option><value>byCreationDate</value></option><option><value>byUpdateDate</value></option></field></x>') ,(3,3,'vhosts-lists','<vhost anon=\"true\" owner=\"admin@localhost\" register=\"true\" enabled=\"true\" tls-required=\"false\" max-users=\"0\" hostname=\"localhost\" domain-filter=\"ALL\"><comps/><other/></vhost>');


drop procedure if exists TigInitdb;
drop procedure if exists TigAddUser;
drop procedure if exists TigAddUserPlainPw;
drop procedure if exists TigGetUserDBUid;
drop procedure if exists TigRemoveUser;
drop procedure if exists TigUpdatePassword;
drop procedure if exists TigUpdatePasswordPlainPw;
drop procedure if exists TigUpdatePasswordPlainPwRev;
drop procedure if exists TigGetPassword;
drop procedure if exists TigUserLogin;
drop procedure if exists TigUserLoginPlainPw;
drop procedure if exists TigUserLogout;
drop procedure if exists TigOnlineUsers;
drop procedure if exists TigOfflineUsers;
drop procedure if exists TigAllUsers;
drop procedure if exists TigAllUsersCount;
drop procedure if exists TigDisableAccount;
drop procedure if exists TigEnableAccount;
drop procedure if exists TigActiveAccounts;
drop procedure if exists TigDisabledAccounts;
drop procedure if exists TigAddNode;
drop procedure if exists TigTestAddUser;
drop procedure if exists TigUsers2Ver4Convert;
drop procedure if exists TigPutDBProperty;
drop function if exists TigGetDBProperty;
drop procedure if exists TigUpdatePairs;
delimiter //
create function TigGetDBProperty(_tkey varchar(255) CHARSET utf8) returns mediumtext CHARSET utf8
READS SQL DATA
begin
	declare _result mediumtext CHARSET utf8;
	select pval into _result from tig_pairs, tig_users
		where (pkey = _tkey) AND (sha1_user_id = sha1(lower('db-properties')))
					AND (tig_pairs.uid = tig_users.uid);
	return (_result);
end //
create procedure TigPutDBProperty(_tkey varchar(255) CHARSET utf8, _tval mediumtext CHARSET utf8)
begin
  if exists( select 1 from tig_pairs, tig_users where
    (sha1_user_id = sha1(lower('db-properties'))) AND (tig_users.uid = tig_pairs.uid)
    AND (pkey = _tkey))
  then
    update tig_pairs, tig_users set pval = _tval
    where (sha1_user_id = sha1(lower('db-properties'))) AND (tig_users.uid = tig_pairs.uid)
      AND (pkey = _tkey);
  else
    insert into tig_pairs (pkey, pval, uid)
      select _tkey, _tval, uid from tig_users
        where (sha1_user_id = sha1(lower('db-properties')));
  end if;
end //
create procedure TigInitdb()
begin
  update tig_users set online_status = 0;
end //
create procedure TigAddUser(_user_id varchar(2049) CHARSET utf8, _user_pw varchar(255) CHARSET utf8)
begin
	declare res_uid bigint unsigned;
	insert into tig_users (user_id, sha1_user_id, user_pw)
		values (_user_id, sha1(lower(_user_id)), _user_pw);
	select LAST_INSERT_ID() into res_uid;
	insert into tig_nodes (parent_nid, uid, node)
		values (NULL, res_uid, 'root');
	if _user_pw is NULL then
		update tig_users set account_status = -1 where uid = res_uid;
	end if;
	select res_uid as uid;
end //
create procedure TigAddUserPlainPw(_user_id varchar(2049) CHARSET utf8, _user_pw varchar(255) CHARSET utf8)
begin
	case TigGetDBProperty('password-encoding')
		when 'MD5-PASSWORD' then
			call TigAddUser(_user_id, MD5(_user_pw));
		when 'MD5-USERID-PASSWORD' then
			call TigAddUser(_user_id, MD5(CONCAT(_user_id, _user_pw)));
		when 'MD5-USERNAME-PASSWORD' then
			call TigAddUser(_user_id, MD5(CONCAT(substring_index(_user_id, '@', 1), _user_pw)));
		else
			call TigAddUser(_user_id, _user_pw);
		end case;
end //
create procedure TigGetUserDBUid(_user_id varchar(2049) CHARSET utf8)
begin
	select uid from tig_users where sha1_user_id = sha1(lower(_user_id));
end //
create procedure TigRemoveUser(_user_id varchar(2049) CHARSET utf8)
begin
	declare res_uid bigint unsigned;
	select uid into res_uid from tig_users where sha1_user_id = sha1(lower(_user_id));
	delete from tig_pairs where uid = res_uid;
	delete from tig_nodes where uid = res_uid;
	delete from tig_users where uid = res_uid;
end //
create procedure TigGetPassword(_user_id varchar(2049) CHARSET utf8)
begin
	select user_pw from tig_users where sha1_user_id = sha1(lower(_user_id));
end //
create procedure TigUpdatePasswordPlainPw(_user_id varchar(2049) CHARSET utf8, _user_pw varchar(255) CHARSET utf8)
begin
	case TigGetDBProperty('password-encoding')
		when 'MD5-PASSWORD' then
			call TigUpdatePassword(_user_id, MD5(_user_pw));
		when 'MD5-USERID-PASSWORD' then
			call TigUpdatePassword(_user_id, MD5(CONCAT(_user_id, _user_pw)));
		when 'MD5-USERNAME-PASSWORD' then
			call TigUpdatePassword(_user_id, MD5(CONCAT(substring_index(_user_id, '@', 1), _user_pw)));
		else
			call TigUpdatePassword(_user_id, _user_pw);
		end case;
end //
create procedure TigUpdatePasswordPlainPwRev(_user_pw varchar(255) CHARSET utf8, _user_id varchar(2049) CHARSET utf8)
begin
	call TigUpdatePasswordPlainPw(_user_id, _user_pw);
end //
create procedure TigUpdatePassword(_user_id varchar(2049) CHARSET utf8, _user_pw varchar(255) CHARSET utf8)
begin
	update tig_users set user_pw = _user_pw where sha1_user_id = sha1(lower(_user_id));
end //
create procedure TigOnlineUsers()
begin
	select user_id, last_login, last_logout, online_status, failed_logins, account_status
		from tig_users where online_status > 0;
end //
create procedure TigOfflineUsers()
begin
	select user_id, last_login, last_logout, online_status, failed_logins, account_status
		from tig_users where online_status = 0;
end //
create procedure TigAllUsers()
begin
	select user_id, last_login, last_logout, online_status, failed_logins, account_status
		from tig_users;
end //
create procedure TigAllUsersCount()
begin
	select count(*) from tig_users;
end //
create procedure TigUserLoginPlainPw(_user_id varchar(2049) CHARSET utf8, _user_pw varchar(255) CHARSET utf8)
begin
	case TigGetDBProperty('password-encoding')
		when 'MD5-PASSWORD' then
			call TigUserLogin(_user_id, MD5(_user_pw));
		when 'MD5-USERID-PASSWORD' then
			call TigUserLogin(_user_id, MD5(CONCAT(_user_id, _user_pw)));
		when 'MD5-USERNAME-PASSWORD' then
			call TigUserLogin(_user_id, MD5(CONCAT(substring_index(_user_id, '@', 1), _user_pw)));
		else
			call TigUserLogin(_user_id, _user_pw);
		end case;
end //
create procedure TigUserLogin(_user_id varchar(2049) CHARSET utf8, _user_pw varchar(255) CHARSET utf8)
begin
	if exists(select 1 from tig_users
		where (account_status > 0) AND (sha1_user_id = sha1(lower(_user_id))) AND (user_pw = _user_pw) AND (user_id = _user_id))
	then
		update tig_users
			set online_status = online_status + 1, last_login = CURRENT_TIMESTAMP
			where sha1_user_id = sha1(lower(_user_id));
		select _user_id as user_id;
	else
		update tig_users set failed_logins = failed_logins + 1 where sha1_user_id = sha1(lower(_user_id));
		select NULL as user_id;
	end if;
end //
create procedure TigUserLogout(_user_id varchar(2049) CHARSET utf8)
begin
	update tig_users
		set online_status = greatest(online_status - 1, 0),
			last_logout = CURRENT_TIMESTAMP
		where user_id = _user_id;
end //
create procedure TigDisableAccount(_user_id varchar(2049) CHARSET utf8)
begin
	update tig_users set account_status = 0 where sha1_user_id = sha1(lower(_user_id));
end //
create procedure TigEnableAccount(_user_id varchar(2049) CHARSET utf8)
begin
	update tig_users set account_status = 1 where sha1_user_id = sha1(lower(_user_id));
end //
create procedure TigActiveAccounts()
begin
	select user_id, last_login, last_logout, online_status, failed_logins, account_status
		from tig_users where account_status > 0;
end //
create procedure TigDisabledAccounts()
begin
	select user_id, last_login, last_logout, online_status, failed_logins, account_status
		from tig_users where account_status = 0;
end //
create procedure TigAddNode(_parent_nid bigint, _uid bigint, _node varchar(255) CHARSET utf8)
begin
	insert into tig_nodes (parent_nid, uid, node)
		values (_parent_nid, _uid, _node);
	select LAST_INSERT_ID() as nid;
end //
create procedure TigUpdatePairs(_nid bigint, _uid bigint, _tkey varchar(255) CHARSET utf8, _tval mediumtext CHARSET utf8)
begin
  if exists(SELECT 1 FROM tig_pairs WHERE nid = _nid AND uid = _uid AND pkey = _tkey)
  then
    UPDATE tig_pairs SET pval = _tval WHERE nid = _nid AND uid = _uid AND pkey = _tkey;
  ELSE
    INSERT INTO tig_pairs (nid, uid, pkey, pval) VALUES (_nid, _uid, _tkey, _tval);
  END IF;
end //
create procedure TigTestAddUser(_user_id varchar(2049) CHARSET utf8, _user_passwd varchar(255) CHARSET utf8,
			 success_text text CHARSET utf8, failure_text text CHARSET utf8)
begin
	declare insert_status int default 0;
	DECLARE CONTINUE HANDLER FOR 1062 SET insert_status=1;
	call TigAddUserPLainPw(_user_id, _user_passwd);
	if insert_status = 0 then
		 select success_text;
 	else
		 select failure_text;
	end if;
end //
create procedure TigUsers2Ver4Convert()
begin
	declare _user_id varchar(2049) CHARSET utf8;
	declare _password varchar(255) CHARSET utf8;
	declare _parent_nid bigint;
	declare _uid bigint;
	declare _node varchar(255) CHARSET utf8;
	declare l_last_row_fetched int default 0;
	DECLARE cursor_users CURSOR FOR
		select user_id, pval as password
			from tig_users, tig_pairs
			where tig_users.uid = tig_pairs.uid and pkey = 'password';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET l_last_row_fetched=1;
	START TRANSACTION;
		SET l_last_row_fetched=0;
		OPEN cursor_users;
			cursor_loop:LOOP
				FETCH cursor_users INTO _user_id, _password;
    		IF l_last_row_fetched=1 THEN
      		LEAVE cursor_loop;
    		END IF;
				call TigUpdatePasswordPlainPw(_user_id, _password);
			END LOOP cursor_loop;
		CLOSE cursor_users;
		SET l_last_row_fetched=0;
	COMMIT;
end //
delimiter ;
drop procedure if exists TigUpdatePairs;
delimiter //
create procedure TigUpdatePairs(_nid bigint, _uid bigint, _tkey varchar(255) CHARSET utf8, _tval mediumtext CHARSET utf8)
begin
  if exists(SELECT 1 FROM tig_pairs WHERE nid = _nid AND uid = _uid AND pkey = _tkey)
  then
    UPDATE tig_pairs SET pval = _tval WHERE nid = _nid AND uid = _uid AND pkey = _tkey;
  ELSE
    INSERT INTO tig_pairs (nid, uid, pkey, pval) VALUES (_nid, _uid, _tkey, _tval);
  END IF;
end //
delimiter ;

-- call TigAddUserPlainPw('db-properties', NULL);

-- select NOW(), ' - Setting schema version to 5.1';

-- call TigPutDBProperty('schema-version', '5.1');

-- tigase-pubsub-3.0

drop function if exists TigPubSubEnsureServiceJid;
drop function if exists TigPubSubEnsureJid;
drop procedure if exists TigPubSubCreateNode;
drop procedure if exists TigPubSubRemoveNode;
drop procedure if exists TigPubSubGetItem;
drop procedure if exists TigPubSubWriteItem;
drop procedure if exists TigPubSubDeleteItem;
drop procedure if exists TigPubSubGetNodeId;
drop procedure if exists TigPubSubGetNodeItemsIdsSince;
drop procedure if exists TigPubSubGetAllNodes;
drop procedure if exists TigPubSubGetNodeItemsIds;
drop procedure if exists TigPubSubGetRootNodes;
drop procedure if exists TigPubSubGetChildNodes;
drop procedure if exists TigPubSubDeleteAllNodes;
drop procedure if exists TigPubSubSetNodeConfiguration;
drop procedure if exists TigPubSubSetNodeAffiliation;
drop procedure if exists TigPubSubGetNodeConfiguration;
drop procedure if exists TigPubSubGetNodeAffiliations;
drop procedure if exists TigPubSubGetNodeSubscriptions;
drop procedure if exists TigPubSubSetNodeSubscription;
drop procedure if exists TigPubSubDeleteNodeSubscription;
drop procedure if exists TigPubSubGetUserAffiliations;
drop procedure if exists TigPubSubGetUserSubscriptions;
drop procedure if exists TigPubSubGetNodeItemsMeta;
drop procedure if exists TigPubSubFixNode;
drop procedure if exists TigPubSubFixItem;
create table if not exists tig_pubsub_service_jids (
	service_id bigint not null auto_increment,
	service_jid varchar(2049) not null,
	service_jid_sha1 char(40) not null,
	
	primary key ( service_id ),
	index using hash ( service_jid(255) ),
	unique index using hash ( service_jid_sha1(40) )
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;
create table if not exists tig_pubsub_jids (
	jid_id bigint not null auto_increment,
	jid varchar(2049) not null,
	jid_sha1 char(40) not null,

	primary key ( jid_id ),
	index using hash ( jid(255) ),
	unique index using hash ( jid_sha1(40) )
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;
create table if not exists tig_pubsub_nodes (
	node_id bigint not null auto_increment,
	service_id bigint not null,
	name varchar(1024) not null,
	name_sha1 char(40) not null,
	type int not null,
	title varchar(1000),
	description mediumtext,
	creator_id bigint,
	creation_date datetime,
	configuration mediumtext,
	collection_id bigint,
	primary key ( node_id ),
	index using hash ( service_id ),
	index using hash ( name(255) ),
	index using hash ( service_id, name(255) ),
	unique index using hash ( service_id, name_sha1(40) ),
	index using hash ( collection_id ),

	constraint
		foreign key ( service_id )
		references tig_pubsub_service_jids ( service_id )
		match full
		on delete cascade,
	constraint
		foreign key ( creator_id )
		references tig_pubsub_jids ( jid_id )
		match full,
	constraint
		foreign key ( collection_id )
		references tig_pubsub_nodes ( node_id )
		match full
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;
create table if not exists tig_pubsub_affiliations (
	node_id bigint not null,
	jid_id bigint not null,
	affiliation varchar(20) not null,
	primary key ( node_id, jid_id ),
	index using hash ( node_id ),
	index using hash ( jid_id ),
	unique index using hash ( node_id, jid_id ),
	constraint
		foreign key ( node_id )
		references tig_pubsub_nodes ( node_id )
		match full
		on delete cascade,
	constraint
		foreign key ( jid_id )
		references tig_pubsub_jids ( jid_id )
		match full
		on delete cascade
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;
create table if not exists tig_pubsub_subscriptions (
	node_id bigint not null references tig_pubsub_nodes ( node_id ),
	jid_id bigint not null references tig_pubsub_jids ( jid_id ),
	subscription varchar(20) not null,
	subscription_id varchar(40) not null,
	primary key ( node_id, jid_id ),
	index using hash ( node_id ),
	index using hash ( jid_id ),
	unique index using hash ( node_id, jid_id ),
	constraint
		foreign key ( node_id )
		references tig_pubsub_nodes ( node_id )
		match full
		on delete cascade,
	constraint
		foreign key ( jid_id )
		references tig_pubsub_jids ( jid_id )
		match full
		on delete cascade
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;
create table if not exists tig_pubsub_items (
	node_id bigint not null,
	id varchar(1024) not null,
	id_sha1 char(40) not null,
	creation_date datetime,
	publisher_id bigint,
	update_date datetime,
	data mediumtext,
	primary key ( node_id, id_sha1(40) ),
	index using hash ( node_id, id(255) ),
	index using hash ( node_id ),
	constraint
		foreign key ( node_id )
		references tig_pubsub_nodes ( node_id )
		match full
		on delete cascade,
	constraint
		foreign key ( publisher_id )
		references tig_pubsub_jids ( jid_id )
		match full
		on delete cascade
)
ENGINE=InnoDB default character set utf8 ROW_FORMAT=DYNAMIC;

delimiter //
create function TigPubSubEnsureServiceJid(_service_jid varchar(2049)) returns bigint DETERMINISTIC
begin
	declare _service_id bigint;
	declare _service_jid_sha1 char(40);
	select SHA1(_service_jid) into _service_jid_sha1;
	select service_id into _service_id from tig_pubsub_service_jids where service_jid_sha1 = _service_jid_sha1;
	if _service_id is null then
		insert into tig_pubsub_service_jids (service_jid, service_jid_sha1)
			values (_service_jid, _service_jid_sha1);
		select LAST_INSERT_ID() into _service_id;
	end if;
	return (_service_id);
end //
create function TigPubSubEnsureJid(_jid varchar(2049)) returns bigint DETERMINISTIC
begin
	declare _jid_id bigint;
	declare _jid_sha1 char(40);
	select SHA1(_jid) into _jid_sha1;
	select jid_id into _jid_id from tig_pubsub_jids where jid_sha1 = _jid_sha1;
	if _jid_id is null then
		insert into tig_pubsub_jids (jid, jid_sha1)
			values (_jid, _jid_sha1)
			on duplicate key update jid_id = LAST_INSERT_ID(jid_id);
		select LAST_INSERT_ID() into _jid_id;
	end if;

	return (_jid_id);
end //

create procedure TigPubSubCreateNode(_service_jid varchar(2049), _node_name varchar(1024), _node_type int, 
	_node_creator varchar(2049), _node_conf text, _collection_id bigint) 
begin
	declare _service_id bigint;
	declare _node_creator_id bigint;
	declare _node_id bigint;
	select TigPubSubEnsureServiceJid(_service_jid) into _service_id;
	select TigPubSubEnsureJid(_node_creator) into _node_creator_id;
	insert into tig_pubsub_nodes (service_id,name,name_sha1,`type`,creator_id,configuration,collection_id)
		values (_service_id, _node_name, SHA1(_node_name), _node_type, _node_creator_id, _node_conf, _collection_id);
	select LAST_INSERT_ID() into _node_id;	
	select _node_id as node_id;
end //
create procedure TigPubSubRemoveNode(_node_id bigint)
begin
	delete from tig_pubsub_items where node_id = _node_id;
	delete from tig_pubsub_subscriptions where node_id = _node_id;
	delete from tig_pubsub_affiliations where node_id = _node_id;
	delete from tig_pubsub_nodes where node_id = _node_id;	
end //
create procedure TigPubSubGetItem(_node_id bigint, _item_id varchar(1024))
begin
	select `data`, p.jid, creation_date, update_date 
		from tig_pubsub_items pi 
		inner join tig_pubsub_jids p on p.jid_id = pi.publisher_id 
		where node_id = _node_id and id_sha1 = SHA1(_item_id) and id = _item_id;	
end //
create procedure TigPubSubWriteItem(_node_id bigint, _item_id varchar(1024), _publisher varchar(2049),
	 _item_data mediumtext)
begin
	declare _publisher_id bigint;
	select TigPubSubEnsureJid(_publisher) into _publisher_id;
	insert into tig_pubsub_items (node_id, id_sha1, id, creation_date, update_date, publisher_id, data)
		values (_node_id, SHA1(_item_id), _item_id, now(), now(), _publisher_id, _item_data)
		on duplicate key update publisher_id = _publisher_id, data = _item_data, update_date = now();	
end //
create procedure TigPubSubDeleteItem(_node_id bigint, _item_id varchar(1024))
begin
	delete from tig_pubsub_items where node_id = _node_id and id_sha1 = SHA1(_item_id) and id = _item_id;
end //
create procedure TigPubSubGetNodeId(_service_jid varchar(2049), _node_name varchar(1024)) 
begin
	select n.node_id from tig_pubsub_nodes n 
		inner join tig_pubsub_service_jids sj on n.service_id = sj.service_id
		where sj.service_jid_sha1 = SHA1(_service_jid) and n.name_sha1 = SHA1(_node_name)
			and sj.service_jid = _service_jid and n.name = _node_name;	
end //
create procedure TigPubSubGetNodeItemsIds(_node_id bigint)
begin 
	select id from tig_pubsub_items where node_id = _node_id order by creation_date;
end //
create procedure TigPubSubGetNodeItemsIdsSince(_node_id bigint,_since datetime)
begin 
	select id from tig_pubsub_items where node_id = _node_id 
		and creation_date >= _since order by creation_date;
end //
create procedure TigPubSubGetAllNodes(_service_jid varchar(2049))
begin
	select n.name, n.node_id from tig_pubsub_nodes n 
		inner join tig_pubsub_service_jids sj on n.service_id = sj.service_id 
		where sj.service_jid_sha1 = SHA1(_service_jid) and sj.service_jid = _service_jid;
end //
create procedure TigPubSubGetRootNodes(_service_jid varchar(2049))
begin
	select n.name, n.node_id from tig_pubsub_nodes n 
		inner join tig_pubsub_service_jids sj on n.service_id = sj.service_id 
		where sj.service_jid_sha1 = SHA1(_service_jid) and sj.service_jid = _service_jid
			and n.collection_id is null;
end //
create procedure TigPubSubGetChildNodes(_service_jid varchar(2049),_node_name varchar(1024))
begin
	select n.name, n.node_id from tig_pubsub_nodes n 
		inner join tig_pubsub_service_jids sj on n.service_id = sj.service_id 
		inner join tig_pubsub_nodes p on p.node_id = n.collection_id and p.service_id = sj.service_id
		where sj.service_jid_sha1 = SHA1(_service_jid) and p.name_sha1 = SHA1(_node_name)
			and sj.service_jid = _service_jid and p.name = _node_name;
end //
create procedure TigPubSubDeleteAllNodes(_service_jid varchar(2049))
begin
	declare _service_id bigint;
	select service_id into _service_id from tig_pubsub_service_jids 
		where service_jid_sha1 = SHA1(_service_jid) and service_jid = _service_jid;
	delete from tig_pubsub_items where node_id in (
		select n.node_id from tig_pubsub_nodes n where n.service_id = _service_id);
	delete from tig_pubsub_affiliations where node_id in (
		select n.node_id from tig_pubsub_nodes n where n.service_id = _service_id);
	delete from tig_pubsub_subscriptions where node_id in (
		select n.node_id from tig_pubsub_nodes n where n.service_id = _service_id);
	delete from tig_pubsub_nodes where service_id = _service_id;
end //
create procedure TigPubSubSetNodeConfiguration(_node_id bigint, _node_conf mediumtext, _collection_id bigint)
begin
	update tig_pubsub_nodes set configuration = _node_conf, collection_id = _collection_id where node_id = _node_id;
end //
create procedure TigPubSubSetNodeAffiliation(_node_id bigint, _jid varchar(2049), _affil varchar(20))
begin
	declare _jid_id bigint;
	declare _exists int;
	
	select jid_id into _jid_id from tig_pubsub_jids where jid_sha1 = SHA1(_jid) and jid = _jid;
	if _jid_id is not null then 
		select 1 into _exists from tig_pubsub_affiliations pa where pa.node_id = _node_id and pa.jid_id = _jid_id;
	end if;
	if _affil != 'none' then
		if _jid_id is null then
			select TigPubSubEnsureJid(_jid) into _jid_id;
		end if;
		if _exists is not null then
			update tig_pubsub_affiliations set affiliation = _affil where node_id = _node_id and jid_id = _jid_id;
		else 
			insert into tig_pubsub_affiliations (node_id, jid_id, affiliation)
				values (_node_id, _jid_id, _affil);
		end if;
	else
		if _exists is not null then
			delete from tig_pubsub_affiliations where node_id = _node_id and jid_id = _jid_id;
		end if;
	end if;	
end //
create procedure TigPubSubGetNodeConfiguration(_node_id bigint)
begin
  select configuration from tig_pubsub_nodes where node_id = _node_id;
end //
create procedure TigPubSubGetNodeAffiliations(_node_id bigint)
begin
	select pj.jid, pa.affiliation from tig_pubsub_affiliations pa 
		inner join tig_pubsub_jids pj on pa.jid_id = pj.jid_id
		where pa.node_id = _node_id;
end //
create procedure TigPubSubGetNodeSubscriptions(_node_id bigint)
begin
	select pj.jid, ps.subscription, ps.subscription_id 
		from tig_pubsub_subscriptions ps 
		inner join tig_pubsub_jids pj on ps.jid_id = pj.jid_id
		where ps.node_id = _node_id;
end //
create procedure TigPubSubSetNodeSubscription(_node_id bigint, _jid varchar(2049),
	_subscr varchar(20), _subscr_id varchar(40))
begin
	declare _jid_id bigint;
	declare _exists int;
	select TigPubSubEnsureJid(_jid) into _jid_id;
	select 1 into _exists from tig_pubsub_subscriptions where node_id = _node_id and jid_id = _jid_id;
	if _exists is not null then
		update tig_pubsub_subscriptions set subscription = _subscr 
			where node_id = _node_id and jid_id = _jid_id;
	else
		insert into tig_pubsub_subscriptions (node_id,jid_id,subscription,subscription_id)
			values (_node_id,_jid_id,_subscr,_subscr_id);
	end if;
end //
create procedure TigPubSubDeleteNodeSubscription(_node_id bigint, _jid varchar(2049))
begin
	delete from tig_pubsub_subscriptions where node_id = _node_id and jid_id = (
		select jid_id from tig_pubsub_jids where jid_sha1 = SHA1(_jid) and jid = _jid
	);
end //
create procedure TigPubSubGetUserAffiliations(_service_jid varchar(2049), _jid varchar(2049))
begin
	select n.name, pa.affiliation from tig_pubsub_nodes n 
		inner join tig_pubsub_service_jids sj on sj.service_id = n.service_id
		inner join tig_pubsub_affiliations pa on pa.node_id = n.node_id
		inner join tig_pubsub_jids pj on pj.jid_id = pa.jid_id
		where pj.jid_sha1 = SHA1(_jid) and sj.service_jid_sha1 = SHA1(_service_jid) 
			and pj.jid = _jid and sj.service_jid = _service_jid;
end //
create procedure TigPubSubGetUserSubscriptions(_service_jid varchar(2049), _jid varchar(2049))
begin
	select n.name, ps.subscription, ps.subscription_id from tig_pubsub_nodes n 
		inner join tig_pubsub_service_jids sj on sj.service_id = n.service_id
		inner join tig_pubsub_subscriptions ps on ps.node_id = n.node_id
		inner join tig_pubsub_jids pj on pj.jid_id = ps.jid_id
		where pj.jid_sha1 = SHA1(_jid) and sj.service_jid_sha1 = SHA1(_service_jid) 
			and pj.jid = _jid and sj.service_jid = _service_jid;
end //
create procedure TigPubSubGetNodeItemsMeta(_node_id bigint)
begin
	select id, creation_date, update_date from tig_pubsub_items where node_id = _node_id order by creation_date;	
end //
create procedure TigPubSubFixNode(_node_id bigint, _node_creation_date datetime)
begin
	update tig_pubsub_nodes set creation_date = _node_creation_date where node_id = _node_id;
end //
create procedure TigPubSubFixItem(_node_id bigint, _item_id varchar(1024), 
	_creation_date datetime, _update_date datetime)
begin
	update tig_pubsub_items set creation_date = _creation_date, update_date = _update_date
		where node_id = _node_id and id_sha1 = SHA1(_item_id) and id = _item_id;
end //
