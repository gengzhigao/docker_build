/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.71
Source Server Version : 50625
Source Host           : 192.168.1.71:3306
Source Database       : workflow_db_969

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2016-09-09 16:48:28
*/
SET names utf8;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ACT_EVT_LOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_EVT_LOG`;
CREATE TABLE `ACT_EVT_LOG` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_GE_BYTEARRAY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;
CREATE TABLE `ACT_GE_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_GE_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;
CREATE TABLE `ACT_GE_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_GE_PROPERTY` VALUES ('next.dbid', '15001', '10');
INSERT INTO `ACT_GE_PROPERTY` VALUES ('schema.history', 'create(5.18.0.0)', '1');
INSERT INTO `ACT_GE_PROPERTY` VALUES ('schema.version', '5.18.0.0', '1');

-- ----------------------------
-- Table structure for ACT_HI_ACTINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ACTINST`;
CREATE TABLE `ACT_HI_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_ATTACHMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;
CREATE TABLE `ACT_HI_ATTACHMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_COMMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_COMMENT`;
CREATE TABLE `ACT_HI_COMMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_DETAIL
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_DETAIL`;
CREATE TABLE `ACT_HI_DETAIL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_IDENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;
CREATE TABLE `ACT_HI_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_PROCINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_PROCINST`;
CREATE TABLE `ACT_HI_PROCINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_TASKINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_TASKINST`;
CREATE TABLE `ACT_HI_TASKINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `CLAIM_TIME_` datetime DEFAULT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_HI_VARINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_VARINST`;
CREATE TABLE `ACT_HI_VARINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_ID_GROUP
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_GROUP`;
CREATE TABLE `ACT_ID_GROUP` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_ID_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_INFO`;
CREATE TABLE `ACT_ID_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_ID_MEMBERSHIP
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;
CREATE TABLE `ACT_ID_MEMBERSHIP` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_ID_USER
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_USER`;
CREATE TABLE `ACT_ID_USER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RE_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;
CREATE TABLE `ACT_RE_DEPLOYMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RE_MODEL
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_MODEL`;
CREATE TABLE `ACT_RE_MODEL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RE_PROCDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;
CREATE TABLE `ACT_RE_PROCDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RU_EVENT_SUBSCR
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;
CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RU_EXECUTION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;
CREATE TABLE `ACT_RU_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RU_IDENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;
CREATE TABLE `ACT_RU_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RU_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_JOB`;
CREATE TABLE `ACT_RU_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RU_TASK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_TASK`;
CREATE TABLE `ACT_RU_TASK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DUE_DATE_` datetime DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ACT_RU_VARIABLE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;
CREATE TABLE `ACT_RU_VARIABLE` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bpm_approve
-- ----------------------------
DROP TABLE IF EXISTS `bpm_approve`;
CREATE TABLE `bpm_approve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instanceid` varchar(50) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  `taskName` varchar(225) DEFAULT NULL COMMENT '任务节点名称',
  `approve` varchar(30) DEFAULT NULL,
  `approveresult` varchar(1000) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `tenantId` varchar(50) DEFAULT NULL,
  `targetkey` varchar(50) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL COMMENT '年度',
  `userId` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `userName` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1481 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bpm_todo
-- ----------------------------
DROP TABLE IF EXISTS `bpm_todo`;
CREATE TABLE `bpm_todo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `instanceid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `metaid` varchar(50) DEFAULT NULL,
  `createtime` varchar(50) DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `tenantId` varchar(50) DEFAULT NULL,
  `busiid` varchar(50) DEFAULT NULL,
  `businessKey` varchar(50) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL COMMENT '年度',
  `userId` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `userName` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `isback` varchar(2) DEFAULT '0' COMMENT '是否被退回单据',
  `isrevoke` varchar(2) DEFAULT '0' COMMENT '是否是我收回的单据',
  `busicode` varchar(100) DEFAULT NULL COMMENT '模版类型 如001请假',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for meta_busi
-- ----------------------------
DROP TABLE IF EXISTS `meta_busi`;
CREATE TABLE `meta_busi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `businame` varchar(50) DEFAULT NULL,
  `busicode` varchar(50) DEFAULT NULL,
  `busipath` varchar(50) DEFAULT NULL,
  `metaid` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `isapp` varchar(10) DEFAULT 'pc',
  `createtime` datetime DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `tenantId` int(11) DEFAULT NULL,
  `enable` char(1) DEFAULT NULL,
  `fileBlob` mediumblob COMMENT '对应html/jsp/js模版源文件',
  `year` varchar(10) DEFAULT NULL COMMENT '年度',
  `userId` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `userName` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `flowid` varchar(100) DEFAULT NULL COMMENT '绑定流程id',
  `orderNum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10072 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for meta_class
-- ----------------------------
DROP TABLE IF EXISTS `meta_class`;
CREATE TABLE `meta_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增+1',
  `classModelName` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `tenantId` varchar(225) DEFAULT NULL COMMENT '租户编号',
  `classOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for meta_custom
-- ----------------------------
DROP TABLE IF EXISTS `meta_custom`;
CREATE TABLE `meta_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `metaname` varchar(50) DEFAULT NULL,
  `metacode` varchar(30) DEFAULT NULL,
  `classpath` varchar(50) DEFAULT NULL,
  `metaService` varchar(100) DEFAULT NULL,
  `functionid` varchar(32) DEFAULT NULL,
  `parentid` varchar(32) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `tenantId` varchar(32) DEFAULT NULL,
  `querymethod` varchar(100) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL COMMENT '年度',
  `userId` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `userName` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `flowName` varchar(255) DEFAULT NULL COMMENT '流程绑定名称',
  `orderNum` int(11) DEFAULT '0' COMMENT '排序',
  `isDisabled` int(2) DEFAULT '0' COMMENT '是否启用 1是0否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for meta_custom_field
-- ----------------------------
DROP TABLE IF EXISTS `meta_custom_field`;
CREATE TABLE `meta_custom_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldname` varchar(200) DEFAULT NULL,
  `fieldcode` varchar(200) DEFAULT NULL,
  `fieldtype` varchar(100) DEFAULT NULL,
  `metaid` int(11) DEFAULT NULL,
  `checktype` varchar(20) DEFAULT NULL,
  `fieldtodo` varchar(10) DEFAULT NULL,
  `todotemplate` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `tenantId` int(11) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL COMMENT '年度',
  `userId` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `userName` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `ifEdit` char(1) DEFAULT '0' COMMENT '是否可编辑',
  `ifVisible` char(1) DEFAULT '1' COMMENT '是否显示',
  `defaultValue` varchar(255) DEFAULT NULL COMMENT '默认值',
  `ifAuto` char(1) DEFAULT '0' COMMENT '是否自动输入',
  `ifVariable` char(1) DEFAULT '0' COMMENT '是否变量',
  `isOpinion` char(1) DEFAULT '0' COMMENT '是否意见',
  `ifVariableValue` varchar(500) DEFAULT NULL COMMENT '变量值',
  `isMust` varchar(1) DEFAULT '1' COMMENT '是否必填项',
  `isEnable` varchar(1) DEFAULT '1' COMMENT '是否启用，1是，0否',
  `orderByNum` int(100) DEFAULT NULL COMMENT '排序字段',
  `numberFormter` varchar(255) DEFAULT NULL COMMENT '精确小数位',
  `columnNames` varchar(255) DEFAULT NULL COMMENT '表格列名',
  `columnNamesType` varchar(225) DEFAULT NULL COMMENT '列表字段类型',
  `minLen` varchar(255) DEFAULT NULL COMMENT '输入最小长度',
  `maxLen` varchar(255) DEFAULT NULL COMMENT '输入最大长度',
  `dateFormter` varchar(255) DEFAULT NULL COMMENT '选择日期格式',
  `errorTip` varchar(255) DEFAULT NULL COMMENT '错误提示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=602 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for meta_tenant
-- ----------------------------
DROP TABLE IF EXISTS `meta_tenant`;
CREATE TABLE `meta_tenant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenantId` varchar(32) DEFAULT NULL,
  `metaid` int(11) DEFAULT NULL,
  `modelname` varchar(50) DEFAULT NULL,
  `singler` varchar(32) DEFAULT NULL,
  `singletype` char(1) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `modelid` varchar(32) DEFAULT NULL,
  `modelkey` varchar(50) DEFAULT NULL,
  `deploystate` char(1) DEFAULT NULL COMMENT '是否已经部署',
  `year` varchar(10) DEFAULT NULL COMMENT '年度',
  `userId` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `userName` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wf_circulate
-- ----------------------------
DROP TABLE IF EXISTS `wf_circulate`;
CREATE TABLE `wf_circulate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `billNum` varchar(225) NOT NULL COMMENT '单据编号',
  `metaId` varchar(50) NOT NULL COMMENT '单据类型',
  `metaName` varchar(225) DEFAULT NULL COMMENT '单据类型名称',
  `instanceId` varchar(225) NOT NULL COMMENT '工单流程编号',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `toUserId` varchar(200) DEFAULT NULL COMMENT '传阅接收人',
  `toUserName` varchar(200) DEFAULT NULL COMMENT '传阅接收人名称',
  `fromUserId` varchar(100) DEFAULT NULL COMMENT '传阅发起人/发送人ID',
  `fromUserName` varchar(255) DEFAULT NULL COMMENT '传阅发起人/发送人名称',
  `isRead` int(1) DEFAULT '0' COMMENT '是否查看0 否 1 是',
  `createTime` varchar(50) DEFAULT NULL COMMENT '传阅发起时间',
  `readTime` varchar(50) DEFAULT NULL COMMENT '查看时间',
  `tenantId` varchar(225) DEFAULT NULL COMMENT '租户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=653 DEFAULT CHARSET=utf8 COMMENT='工单传阅表';

-- ----------------------------
-- Table structure for wf_meta_flow_field
-- ----------------------------
DROP TABLE IF EXISTS `wf_meta_flow_field`;
CREATE TABLE `wf_meta_flow_field` (
  `id` int(225) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号id',
  `wf_node_id` varchar(500) DEFAULT NULL COMMENT '当前流程节点id',
  `wf_node_name` varchar(200) DEFAULT NULL COMMENT '当前流程节点name',
  `wf_meta_busi_id` varchar(100) DEFAULT NULL COMMENT '对应流程模版id',
  `wf_tenantId` varchar(100) DEFAULT NULL COMMENT '租户id',
  `wf_meta_custom_field_code` varchar(200) DEFAULT NULL COMMENT '意见填充字段编码',
  `wf_meta_custom_field_name` varchar(200) DEFAULT NULL COMMENT '意见填充字段名称',
  `wf_modelkey` varchar(200) DEFAULT NULL COMMENT '流程部署key',
  `wf_meta_customs_id` varchar(100) DEFAULT NULL COMMENT '对应流程模版类型metaid',
  `wf_meta_customs_code` varchar(100) DEFAULT NULL COMMENT '对应流程模版类型meatacode',
  `WF_ASSIGNEE` varchar(100) DEFAULT NULL COMMENT '环节办理人id',
  `wf_assignee_name` varchar(100) DEFAULT NULL COMMENT '环节办理人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wf_oa_remind
-- ----------------------------
DROP TABLE IF EXISTS `wf_oa_remind`;
CREATE TABLE `wf_oa_remind` (
  `oa_id` varchar(200) NOT NULL COMMENT '主键自增UUID',
  `billNum` varchar(225) NOT NULL COMMENT '业务单据id',
  `tenantId` varchar(200) DEFAULT NULL COMMENT '租户id',
  `isRead` varchar(2) DEFAULT NULL COMMENT '是否阅读0否1是',
  `createTime` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `createUser` varchar(200) DEFAULT NULL COMMENT '创建提醒人',
  `remindUser` varchar(200) DEFAULT NULL COMMENT '提醒接收人',
  `instanceId` varchar(200) DEFAULT NULL COMMENT '流程实例id',
  `opinionField` varchar(200) DEFAULT NULL COMMENT '意见字段',
  `taskId` varchar(200) DEFAULT NULL COMMENT '任务编号',
  `metaId` varchar(50) DEFAULT NULL COMMENT '单据类型编号',
  `title` varchar(225) DEFAULT NULL COMMENT '单据标题',
  PRIMARY KEY (`oa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wf_seestampflow
-- ----------------------------
DROP TABLE IF EXISTS `wf_seestampflow`;
CREATE TABLE `wf_seestampflow` (
  `stampId` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号id',
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `status` varchar(5) DEFAULT NULL COMMENT '流程状态 流转中、已办结',
  `applyUserId` varchar(50) DEFAULT NULL COMMENT '盖章申请人id',
  `applyUserName` varchar(50) DEFAULT NULL COMMENT '盖章申请人 姓名',
  `orgCode` varchar(500) DEFAULT NULL COMMENT '申请人所属部门编号',
  `orgName` varchar(500) DEFAULT NULL COMMENT '申请人所属部门名称',
  `processInstanceId` varchar(200) DEFAULT NULL COMMENT '关联流程实例id',
  `seeUserId` varchar(50) DEFAULT NULL COMMENT '查看盖章申请人',
  `createTime` varchar(50) DEFAULT NULL COMMENT '流程创建时间',
  `endTime` varchar(50) DEFAULT NULL COMMENT '流程结束时间',
  `tenantId` varchar(50) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`stampId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wf_task_base_bill
-- ----------------------------
DROP TABLE IF EXISTS `wf_task_base_bill`;
CREATE TABLE `wf_task_base_bill` (
  `id` INT(225) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `dataSources` VARCHAR(10) NOT NULL DEFAULT 'PC' COMMENT '数据来源 [App端,PC端]',
  `year` VARCHAR(4) DEFAULT NULL COMMENT '当前年度',
  `title` VARCHAR(255) DEFAULT NULL,
  `instanceId` VARCHAR(225) DEFAULT '0' COMMENT '流程实例Id 没有提交都是 0',
  `taskId` VARCHAR(225) DEFAULT NULL COMMENT '当前任务Id 不保存 查询使用',
  `createUser` VARCHAR(50) DEFAULT NULL COMMENT '创建人',
  `createUserName` VARCHAR(50) DEFAULT NULL COMMENT '创建人名称',
  `userType` VARCHAR(30) DEFAULT NULL COMMENT '用户类型',
  `dept` VARCHAR(100) DEFAULT NULL COMMENT '部门',
  `createTime` VARCHAR(30) DEFAULT NULL COMMENT '创建时间',
  `endTime` VARCHAR(30) DEFAULT NULL COMMENT '结束时间',
  `systemId` VARCHAR(10) DEFAULT NULL COMMENT '所属系统编号',
  `metaId` VARCHAR(100) DEFAULT NULL COMMENT '模型类别编号',
  `metaName` VARCHAR(100) DEFAULT NULL COMMENT '模型类别名称',
  `ascription` VARCHAR(10) DEFAULT 'ALL' COMMENT '作用域、使用权 [APP端,PC端,ALL所有] 默认 ALL 所有',
  `billNum` VARCHAR(225) NOT NULL DEFAULT '' COMMENT '业务单据编号',
  `objectDataString` MEDIUMTEXT COMMENT '工单实体数据 使用json格式存储',
  `isBack` VARCHAR(2) DEFAULT '0' COMMENT '是否查看被退回 值不能为空，默认为0',
  `isRevoke` VARCHAR(2) DEFAULT '0' COMMENT '是否查看收回数据 值不能为空，默认为0',
  `tenantId` VARCHAR(225) DEFAULT NULL COMMENT '租户Id',
  `remind_user_info` VARCHAR(500) DEFAULT NULL COMMENT '工单传阅人id',
  `remind_user_info_name` VARCHAR(5000) DEFAULT NULL COMMENT '工单传阅人name',
  `leaveBeginDate` varchar(50) DEFAULT NULL COMMENT '考勤相关工单开始时间',
  `leaveEndDate` varchar(50) DEFAULT NULL COMMENT '考勤相关工单结束时间',
  `leaveDay` int(10) DEFAULT NULL COMMENT '考勤相关工单天数',
  `leaveHour` int(10) DEFAULT NULL COMMENT '考勤相关工单小时数',
  `leaveMinute` int(10) DEFAULT NULL COMMENT '考勤相关工单分钟数',
  `leaveType` varchar(10) DEFAULT NULL COMMENT '请假类型 事假,病假,婚假,丧假,年假,产假,其他,外出,出差',
  `temp1` VARCHAR(225) DEFAULT NULL COMMENT '临时字段',
  `temp2` VARCHAR(225) DEFAULT NULL COMMENT '临时字段',
  PRIMARY KEY (`id`,`billNum`),
  UNIQUE KEY `unBillKey` (`id`,`instanceId`,`billNum`) USING HASH,
  KEY `searchBillText` (`objectDataString`(255),`title`,`createUserName`,`createTime`) USING HASH
) ENGINE=INNODB AUTO_INCREMENT=940 DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for v_bpm_todo
-- ----------------------------
DROP VIEW IF EXISTS `v_bpm_todo`;
CREATE VIEW `v_bpm_todo` AS select `todo`.`id` AS `id`,`todo`.`title` AS `title`,`todo`.`code` AS `code`,`todo`.`instanceid` AS `instanceid`,`todo`.`name` AS `name`,`todo`.`metaid` AS `metaid`,`todo`.`createtime` AS `createtime`,`todo`.`remark` AS `remark`,`todo`.`tenantId` AS `tenantId`,`todo`.`busiid` AS `busiid`,`todo`.`businessKey` AS `businessKey`,`todo`.`year` AS `year`,`todo`.`userId` AS `userId`,`todo`.`userName` AS `userName`,`todo`.`isback` AS `isback`,`todo`.`isrevoke` AS `isrevoke`,`todo`.`busicode` AS `busicode`,`busi`.`businame` AS `businame`,`busi`.`busicode` AS `busi_code`,`busi`.`flowid` AS `flowid`,`meta`.`metaname` AS `metaname`,`meta`.`metacode` AS `metacode` from ((`bpm_todo` `todo` join `meta_busi` `busi`) join `meta_custom` `meta`) where ((`todo`.`busiid` = `busi`.`id`) and (`todo`.`metaid` = `meta`.`id`)) ;

-- ----------------------------
-- View structure for v_bpm_todo_hi_task
-- ----------------------------
DROP VIEW IF EXISTS `v_bpm_todo_hi_task`;
CREATE VIEW `v_bpm_todo_hi_task` AS select `todo`.`id` AS `id`,`todo`.`title` AS `title`,`todo`.`code` AS `code`,`todo`.`instanceid` AS `instanceid`,`todo`.`name` AS `name`,`todo`.`metaid` AS `metaid`,`todo`.`createtime` AS `createtime`,`todo`.`remark` AS `remark`,`todo`.`tenantId` AS `tenantId`,`todo`.`busiid` AS `busiid`,`todo`.`businessKey` AS `businessKey`,`todo`.`year` AS `year`,`todo`.`userId` AS `userId`,`todo`.`userName` AS `userName`,`todo`.`isback` AS `isback`,`todo`.`isrevoke` AS `isrevoke`,`todo`.`busicode` AS `busicode`,`todo`.`businame` AS `businame`,`todo`.`busi_code` AS `busi_code`,`todo`.`flowid` AS `flowid`,`todo`.`metaname` AS `metaname`,`todo`.`metacode` AS `metacode`,`task`.`ID_` AS `ID_`,`task`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`task`.`TASK_DEF_KEY_` AS `TASK_DEF_KEY_`,`task`.`PROC_INST_ID_` AS `PROC_INST_ID_`,`task`.`EXECUTION_ID_` AS `EXECUTION_ID_`,`task`.`NAME_` AS `NAME_`,`task`.`PARENT_TASK_ID_` AS `PARENT_TASK_ID_`,`task`.`DESCRIPTION_` AS `DESCRIPTION_`,`task`.`ASSIGNEE_` AS `ASSIGNEE_`,`task`.`START_TIME_` AS `START_TIME_`,`task`.`CLAIM_TIME_` AS `CLAIM_TIME_`,`task`.`END_TIME_` AS `END_TIME_`,`task`.`DURATION_` AS `DURATION_`,`task`.`PRIORITY_` AS `PRIORITY_`,`task`.`DUE_DATE_` AS `DUE_DATE_`,`task`.`FORM_KEY_` AS `FORM_KEY_`,`task`.`CATEGORY_` AS `CATEGORY_`,`task`.`TENANT_ID_` AS `TENANT_ID_` from (`v_bpm_todo` `todo` join `ACT_HI_TASKINST` `task`) where ((`todo`.`instanceid` = `task`.`PROC_INST_ID_`) and (`todo`.`tenantId` = `task`.`TENANT_ID_`)) ;

-- ----------------------------
-- View structure for v_bpm_todo_procinst
-- ----------------------------
DROP VIEW IF EXISTS `v_bpm_todo_procinst`;
CREATE VIEW `v_bpm_todo_procinst` AS select `todo`.`id` AS `id`,`todo`.`title` AS `title`,`todo`.`code` AS `code`,`todo`.`instanceid` AS `instanceid`,`todo`.`name` AS `name`,`todo`.`metaid` AS `metaid`,`todo`.`createtime` AS `createtime`,`todo`.`remark` AS `remark`,`todo`.`tenantId` AS `tenantId`,`todo`.`busiid` AS `busiid`,`todo`.`businessKey` AS `businessKey`,`todo`.`year` AS `year`,`todo`.`userId` AS `userId`,`todo`.`userName` AS `userName`,`todo`.`isback` AS `isback`,`todo`.`isrevoke` AS `isrevoke`,`todo`.`busicode` AS `busicode`,`todo`.`businame` AS `businame`,`todo`.`busi_code` AS `busi_code`,`todo`.`flowid` AS `flowid`,`todo`.`metaname` AS `metaname`,`todo`.`metacode` AS `metacode`,`proc`.`ID_` AS `ID_`,`proc`.`PROC_INST_ID_` AS `PROC_INST_ID_`,`proc`.`BUSINESS_KEY_` AS `BUSINESS_KEY_`,`proc`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`proc`.`START_TIME_` AS `START_TIME_`,`proc`.`END_TIME_` AS `END_TIME_`,`proc`.`DURATION_` AS `DURATION_`,`proc`.`START_USER_ID_` AS `START_USER_ID_`,`proc`.`START_ACT_ID_` AS `START_ACT_ID_`,`proc`.`END_ACT_ID_` AS `END_ACT_ID_`,`proc`.`SUPER_PROCESS_INSTANCE_ID_` AS `SUPER_PROCESS_INSTANCE_ID_`,`proc`.`DELETE_REASON_` AS `DELETE_REASON_`,`proc`.`TENANT_ID_` AS `TENANT_ID_`,`proc`.`NAME_` AS `NAME_` from (`v_bpm_todo` `todo` left join `ACT_HI_PROCINST` `proc` on(((`todo`.`instanceid` = `proc`.`ID_`) and (`todo`.`tenantId` = `proc`.`TENANT_ID_`)))) ;

-- ----------------------------
-- View structure for v_bpm_todo_ru_task
-- ----------------------------
DROP VIEW IF EXISTS `v_bpm_todo_ru_task`;
CREATE VIEW `v_bpm_todo_ru_task` AS select `task`.`ID_` AS `ID_`,`task`.`REV_` AS `REV_`,`task`.`EXECUTION_ID_` AS `EXECUTION_ID_`,`task`.`PROC_INST_ID_` AS `PROC_INST_ID_`,`task`.`PROC_DEF_ID_` AS `PROC_DEF_ID_`,`task`.`NAME_` AS `NAME_`,`task`.`PARENT_TASK_ID_` AS `PARENT_TASK_ID_`,`task`.`DESCRIPTION_` AS `DESCRIPTION_`,`task`.`TASK_DEF_KEY_` AS `TASK_DEF_KEY_`,`task`.`ASSIGNEE_` AS `ASSIGNEE_`,`task`.`DELEGATION_` AS `DELEGATION_`,`task`.`PRIORITY_` AS `PRIORITY_`,`task`.`CREATE_TIME_` AS `CREATE_TIME_`,`task`.`DUE_DATE_` AS `DUE_DATE_`,`task`.`CATEGORY_` AS `CATEGORY_`,`task`.`SUSPENSION_STATE_` AS `SUSPENSION_STATE_`,`task`.`FORM_KEY_` AS `FORM_KEY_`,`todo`.`id` AS `id`,`todo`.`title` AS `title`,`todo`.`code` AS `code`,`todo`.`instanceid` AS `instanceid`,`todo`.`name` AS `name`,`todo`.`metaid` AS `metaid`,`todo`.`createtime` AS `createtime`,`todo`.`remark` AS `remark`,`todo`.`tenantId` AS `tenantId`,`todo`.`busiid` AS `busiid`,`todo`.`businessKey` AS `businessKey`,`todo`.`year` AS `year`,`todo`.`userId` AS `userId`,`todo`.`userName` AS `userName`,`todo`.`isback` AS `isback`,`todo`.`isrevoke` AS `isrevoke`,`todo`.`busicode` AS `busicode`,`todo`.`businame` AS `businame`,`todo`.`busi_code` AS `busi_code`,`todo`.`flowid` AS `flowid`,`todo`.`metaname` AS `metaname`,`todo`.`metacode` AS `metacode`,`hitask`.`CLAIM_TIME_` AS `CLAIM_TIME_`,`hitask`.`END_TIME_` AS `END_TIME_` from ((`ACT_RU_TASK` `task` join `v_bpm_todo` `todo` on(((`task`.`PROC_INST_ID_` = `todo`.`instanceid`) and (`task`.`TENANT_ID_` = `todo`.`tenantId`)))) join `ACT_HI_TASKINST` `hitask` on((`task`.`ID_` = `hitask`.`ID_`))) ;

-- 应袁鹏鹏要求，增加于2017年3月7日
ALTER TABLE meta_custom_field ADD COLUMN ifNegativeNumber CHAR(1) DEFAULT '0' NULL COMMENT '是否允许输入负数1是0否';
ALTER TABLE meta_custom_field ADD COLUMN ifDecimalNumber CHAR(1) DEFAULT '0' NULL COMMENT '是否允许输入小数1是0否';
ALTER TABLE wf_task_base_bill ADD COLUMN leaveBeginDate varchar(50) DEFAULT NULL COMMENT '考勤相关工单开始时间';
ALTER TABLE wf_task_base_bill ADD COLUMN leaveEndDate varchar(50) DEFAULT NULL COMMENT '考勤相关工单结束时间';
ALTER TABLE wf_task_base_bill ADD COLUMN leaveDay int(10) DEFAULT NULL COMMENT '考勤相关工单天数';
ALTER TABLE wf_task_base_bill ADD COLUMN leaveHour int(10) DEFAULT NULL COMMENT '考勤相关工单小时数';
ALTER TABLE wf_task_base_bill ADD COLUMN leaveMinute int(10) DEFAULT NULL COMMENT '考勤相关工单分钟数';
ALTER TABLE wf_task_base_bill ADD COLUMN leaveType varchar(10) DEFAULT NULL COMMENT '请假类型 事假,病假,婚假,丧假,年假,产假,其他,外出,出差';
