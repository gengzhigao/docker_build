-- update 2016-09-27
CREATE TABLE if not exists conversation_history (                   
    id bigint(20) unsigned NOT NULL AUTO_INCREMENT,     
    ts bigint(20) NOT NULL,                             
    type varchar(4096) DEFAULT NULL,                    
    sender_jid varchar(4096) DEFAULT NULL,              
    receiver_jid varchar(4096) DEFAULT NULL,            
    msg text,                                           
    body text,   
    timestamp timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)                                    
) 
ENGINE=InnoDB default character set utf8;
 
drop PROCEDURE IF EXISTS TigConversationHistoryMessage;
drop PROCEDURE IF EXISTS TigRemoveConversationHistoryMessage;
drop PROCEDURE IF EXISTS TigDealStayMessage;
drop PROCEDURE IF EXISTS  TigGetDisturbOrShieldUsers;
delimiter //
CREATE PROCEDURE TigConversationHistoryMessage(_senderJid varchar(2049) CHARSET utf8, _receiverJid varchar(2049) CHARSET utf8, _type varchar(2049) CHARSET utf8, _ts long,_msg varchar(2049) CHARSET utf8, _body varchar(2049) CHARSET utf8, _time timestamp)
BEGIN
	  case _type
	  when 'chat' then 
		if exists(select 1 from conversation_history where type = 'chat' and ts <= _ts and ((sender_jid = _senderJid and receiver_jid = _receiverJid) or (sender_jid = _receiverJid and receiver_jid = _senderJid)))
		then
		    update conversation_history set ts = _ts, sender_jid = _senderJid, receiver_jid = _receiverJid, msg = _msg, body = _body, timestamp = _time  where type = 'chat' and ts <= _ts and ((sender_jid = _senderJid and receiver_jid = _receiverJid) or (sender_jid = _receiverJid and receiver_jid = _senderJid));
		else
		    insert into conversation_history(ts, type, sender_jid, receiver_jid, msg, body, timestamp) values(_ts, _type, _senderJid, _receiverJid, _msg, _body, _time);
		end if ;
	  when 'groupchat' then
	        if exists(select 1 from conversation_history where type = 'groupchat' and ts <= _ts and sender_jid = _senderJid and receiver_jid = _receiverJid)
	        then
		    update conversation_history set ts = _ts, msg = _msg, body = _body, timestamp = _time where type = 'groupchat' and receiver_jid = _receiverJid ;
	        else
		    insert into conversation_history(ts, type, sender_jid, receiver_jid, msg, body, timestamp) values(_ts, _type, _senderJid, _receiverJid, _msg, _body, _time);
		    update conversation_history set ts = _ts, msg = _msg, body = _body, timestamp = _time where type = 'groupchat' and receiver_jid = _receiverJid ;
	        end if ;
	  end case ;
END //
CREATE PROCEDURE TigRemoveConversationHistoryMessage(_senderJid varchar(2049) CHARSET utf8, _receiverJid varchar(2049) CHARSET utf8, _type varchar(2049) CHARSET utf8)
BEGIN
	delete from conversation_history where sender_jid = _senderJid and receiver_jid = _receiverJid and type = _type;
	/*if exists(select 1 from conversation_history where sender_jid = _senderJid and receiver_jid = _receiverJid and type = _type)
	then
	    delete from conversation_history where sender_jid = _senderJid and receiver_jid = _receiverJid and type = _type;
	else
	    
	end if ;*/
END //
CREATE  PROCEDURE TigDealStayMessage(_domain varchar(2049) CHARSET utf8, _sender_id varchar(2049) CHARSET utf8, _message varchar(2049) CHARSET utf8, _timestamp timestamp)
BEGIN	    
	    insert into all_msg (appidandkey, sendid, msg, date_time) values (_domain, _sender_id, _message, _timestamp);
END //
CREATE PROCEDURE TigGetDisturbOrShieldUsers(_roomJid varchar(2049) CHARSET utf8, _type varchar(2049) CHARSET utf8)
BEGIN
	case _type
	when 'notify' then
	    select substring_index(sm.user_id,'@',1) jid from shield_message sm where sm.group = _roomJid and sm.flag = 'notify';
	when 'shield' then
	    select substring_index(sm.user_id,'@',1) jid from shield_message sm where sm.group = _roomJid and sm.flag = 'shield';
	end case ;
END //
delimiter ;
-- 初始化IM域名,根据情况而定，hostname部分修改执行
update tig_pairs set pval = concat('<vhost anon=\"true\" owner=\"admin@localhost\" register=\"true\" enabled=\"true\" tls-required=\"false\" max-users=\"0\" hostname=\"1846:eportal\" domain-filter=\"ALL\"><comps/><other/></vhost>',pval) where pkey = 'vhosts-lists';

-- update 2016-12-16 修改字段及新增字段
alter table msg_history modify ts bigint;
alter table msg_history add status int(11);
alter table msg_history add uuid char(128);
alter table file_path_web add senderName varchar(255);
-- emoji表情字符设置
alter database tigasedb7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
alter table muc_history CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table muc_history CHANGE body body mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table muc_history CHANGE msg msg mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table msg_history CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table msg_history CHANGE message message mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table conversation_history CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table conversation_history CHANGE msg msg mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
alter table conversation_history CHANGE body body mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS TigAddMsgHistoryMessage;
DROP PROCEDURE IF EXISTS TigGetMessageUser;
DROP PROCEDURE IF EXISTS TigAddMessageUser;
delimiter //
CREATE PROCEDURE TigAddMsgHistoryMessage(_ts long, _expired datetime, _sender_uid long, _receiver_uid long, _msg_type int, _message varchar(2049) CHARSET utf8, _status int, _uuid char(128))
BEGIN
	insert into msg_history ( ts, expired, sender_uid, receiver_uid, msg_type, message, status, uuid) values (_ts, _expired, _sender_uid, _receiver_uid, _msg_type, _message, _status, _uuid);
	select LAST_INSERT_ID() as msg_id;
END //
CREATE PROCEDURE TigGetMessageUser(_jid_sha varchar(2049) CHARSET utf8)
BEGIN
	select jid_id, jid from user_jid where jid_sha = _jid_sha ;
END //
CREATE PROCEDURE TigAddMessageUser(_jid_sha char(128) CHARSET utf8, _jid varchar(2049) CHARSET utf8)
BEGIN
	insert into user_jid ( jid_sha, jid) values (_jid_sha, _jid);
	select LAST_INSERT_ID() as jid_id;
END //
delimiter ;
