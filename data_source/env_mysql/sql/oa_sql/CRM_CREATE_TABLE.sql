/*
Navicat MySQL Data Transfer

Source Server         : 10.0.20.12-2
Source Server Version : 50629
Source Host           : 10.0.20.12:3306
Source Database       : crm_db_1677

Target Server Type    : MYSQL
Target Server Version : 50629
File Encoding         : 65001

Date: 2016-06-22 09:04:58
*/

SET names utf8;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for clue
-- ----------------------------
DROP TABLE IF EXISTS `clue`;
CREATE TABLE `clue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `tele_no` varchar(255) DEFAULT NULL,
  `QQ` varchar(255) DEFAULT NULL,
  `microblog` varchar(255) DEFAULT NULL,
  `we_chat` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `post` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `data_source` varchar(255) DEFAULT NULL,
  `conference_name` varchar(255) DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `csm_nature` varchar(255) DEFAULT NULL,
  `csm_scale` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `address` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `company_tele_no` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `csm_num` varchar(255) DEFAULT NULL,
  `upper_company` varchar(255) DEFAULT NULL,
  `lower_company` varchar(255) DEFAULT NULL,
  `channel_type` varchar(255) DEFAULT NULL,
  `channel_level` varchar(255) DEFAULT NULL,
  `market_user_id` varchar(255) DEFAULT NULL,
  `sales_user_id` varchar(255) DEFAULT NULL,
  `assigner` varchar(255) DEFAULT NULL,
  `data_type` varchar(255) DEFAULT NULL,
  `clue_state` varchar(255) DEFAULT NULL,
  `submit_state` varchar(255) DEFAULT NULL,
  `read_state` varchar(255) DEFAULT NULL,
  `submit_time` datetime DEFAULT NULL,
  `distribution_time` datetime DEFAULT NULL,
  `close_time` datetime DEFAULT NULL,
  `clue_type` varchar(255) DEFAULT NULL,
  `close_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_profession` (`profession`) USING BTREE,
  KEY `ind_region` (`region`) USING BTREE,
  KEY `ind_market_user_id` (`market_user_id`) USING BTREE,
  KEY `ind_sales_user_id` (`sales_user_id`) USING BTREE,
  KEY `ind_data_type` (`clue_state`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `birth_day` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `post` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `tele_no` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `QQ` varchar(255) DEFAULT NULL,
  `we_chat` varchar(255) DEFAULT NULL,
  `custom_id` int(11) DEFAULT NULL,
  `contact_type_id` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `market_user_id` varchar(255) DEFAULT NULL,
  `sales_user_id` varchar(255) DEFAULT NULL,
  `assigner` varchar(255) DEFAULT NULL,
  `clue_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_custom_id` (`custom_id`) USING BTREE,
  KEY `ind_sales_user_id` (`sales_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for custom
-- ----------------------------
DROP TABLE IF EXISTS `custom`;
CREATE TABLE `custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `csm_name` varchar(255) DEFAULT NULL,
  `csm_stat_id` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `csm_nature` varchar(255) DEFAULT NULL,
  `csm_scale` varchar(255) DEFAULT NULL,
  `upper_company` int(11) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `market_user_id` varchar(255) DEFAULT NULL,
  `sales_user_id` varchar(255) DEFAULT NULL,
  `assigner` varchar(255) DEFAULT NULL,
  `csm_num` varchar(255) DEFAULT NULL,
  `clue_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_region` (`region`) USING BTREE,
  KEY `ind_profession` (`profession`) USING BTREE,
  KEY `ind_sales_user_id` (`sales_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '字典值',
  `super_id` int(11) DEFAULT NULL COMMENT '上级标识',
  `order_id` int(11) DEFAULT NULL COMMENT '排序号',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '待确认', '0', '1', '待确认');
INSERT INTO `dictionary` VALUES ('2', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '待确认', '1', '2', '待确认');


-- ----------------------------
-- Table structure for dynamic
-- ----------------------------
DROP TABLE IF EXISTS `dynamic`;
CREATE TABLE `dynamic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `obj_entity_id` int(11) DEFAULT NULL,
  `obj_entity_type_id` varchar(255) DEFAULT NULL,
  `dynamic_content` varchar(1000) DEFAULT NULL,
  `dynamic_type` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `psty` varchar(255) DEFAULT NULL,
  `pstx` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_obj_entity_id` (`obj_entity_id`) USING BTREE,
  KEY `ind_obj_entity_type_id` (`obj_entity_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for examine
-- ----------------------------
DROP TABLE IF EXISTS `examine`;
CREATE TABLE `examine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `obj_entity_id` int(11) DEFAULT NULL COMMENT '对象标识',
  `examine_state` int(11) DEFAULT NULL COMMENT '审核状态',
  `advice` varchar(500) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL COMMENT '二级模块',
  `link` varchar(255) DEFAULT NULL,
  `btn_group` varchar(500) DEFAULT NULL,
  `is_leaf` int(2) DEFAULT NULL,
  `sort_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '4', '商机查看', 'opport', '', 'opport_list.html?flag=2', 'view,export,reply,contact', '1', '2');
INSERT INTO `menu` VALUES ('2', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '4', '我下属的商机', 'opport', '', 'opport_list.html?flag=3', 'view,export,reply,contact', '1', '3');
INSERT INTO `menu` VALUES ('3', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '4', '我负责的商机', 'opport', '', 'opport_list.html?flag=1', 'view,edit,export,rlsdynamic,reply,adjust,deldynamic,contact,delRelationId', '1', '5');
INSERT INTO `menu` VALUES ('4', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '商机管理', '', '', '', '', '0', '6');
INSERT INTO `menu` VALUES ('5', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '8', '联系人查看', 'contact', '', 'contact_list.html?flag=2', 'view,export,reply,contact', '1', '7');
INSERT INTO `menu` VALUES ('6', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '8', '我下属的联系人', 'contact', '', 'contact_list.html?flag=3', 'view,export,reply', '1', '8');
INSERT INTO `menu` VALUES ('7', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '8', '我负责的联系人', 'contact', '', 'contact_list.html?flag=1', 'view,add,edit,export,expedm,rlsdynamic,reply,deldynamic', '1', '9');
INSERT INTO `menu` VALUES ('8', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '联系人管理', '', '', '', '', '0', '10');
INSERT INTO `menu` VALUES ('9', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '12', '客户查看', 'custom', '', 'Customer_list.html', 'view,export,reply', '1', '11');
INSERT INTO `menu` VALUES ('10', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '12', '我下属的客户', 'custom', '', 'MyCustomer_list.html', 'view,export,reply', '1', '12');
INSERT INTO `menu` VALUES ('11', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '12', '我负责的客户', 'custom', '', 'MyResponsCustomer_list.html', 'view,add,edit,export,expedm,rlsdynamic,reply,adjust,deliver,delRelationId', '1', '13');
INSERT INTO `menu` VALUES ('12', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '客户管理', '', '', '', '', '0', '14');
INSERT INTO `menu` VALUES ('13', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '19', '线索管理', 'clue', '', 'clue_manage.html', 'view,export,assign,transfer,cancel', '1', '15');
INSERT INTO `menu` VALUES ('14', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '19', '线索查看', 'clue', '', 'cluesList.html', 'view,export,reply', '1', '16');
INSERT INTO `menu` VALUES ('15', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '19', '我下属的线索', 'clue', '', 'myStaffCluesList.html', 'view,export,reply', '1', '17');
INSERT INTO `menu` VALUES ('16', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '19', '我负责的线索', 'clue', '', 'myResponsibleCluesList.html', 'view,add,edit,export,rlsdynamic,reply,toopp,change,deldynamic,transfer', '1', '18');
INSERT INTO `menu` VALUES ('17', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '19', '我分配的线索', 'clue', '', 'clue_page2.html', 'view,export,reply,assign', '1', '19');
INSERT INTO `menu` VALUES ('18', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '19', '我上报的线索', 'clue', '', 'clue_page.html', 'view,export,resubmit,reply,pageNotAssign,pageIsAssign', '1', '20');
INSERT INTO `menu` VALUES ('19', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '线索管理', '', '', '', '', '0', '21');
INSERT INTO `menu` VALUES ('20', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '24', '营销数据管理', 'marketing', '', 'marketing_manage.html', 'view,add,del,export,expedm,assign', '1', '22');
INSERT INTO `menu` VALUES ('21', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '24', '营销数据查看', 'marketing', '', 'marketing_listview.html', 'view,export,reply', '1', '23');
INSERT INTO `menu` VALUES ('22', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '24', '我下属的营销数据', 'marketing', '', 'marketing_mystaff.html', 'view,export', '1', '24');
INSERT INTO `menu` VALUES ('23', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '24', '我负责的营销数据', 'marketing', '', 'marketing_list.html', 'view,add,edit,del,import,expedm,report,rlsdynamic,reply,deldynamic,transfer', '1', '25');
INSERT INTO `menu` VALUES ('24', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '营销数据', '', '', '', '', '0', '26');
INSERT INTO `menu` VALUES ('25', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '统计分析', '', '', '', '', '0', '27');
INSERT INTO `menu` VALUES ('26', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '25', '个人动态汇总', 'statistics', '', 'summary.html', 'view,exportAll', '1', '28');
INSERT INTO `menu` VALUES ('27', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '25', '团队动态汇总', 'statistics', '', 'team_summary.html', 'view,exportAll', '1', '29');
INSERT INTO `menu` VALUES ('28', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '-1', '伙伴管理', '', '', '', '', '0', '30');
INSERT INTO `menu` VALUES ('29', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '28', '我负责的伙伴', 'partner', '', 'myResponsiblePartner.html', 'view,add,edit,del,convert,export', '1', '31');
INSERT INTO `menu` VALUES ('30', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '28', '我下属的伙伴', 'partner', '', 'mySubordinatePartner.html', 'view,export', '1', '32');
INSERT INTO `menu` VALUES ('31', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '28', '伙伴查看', 'partner', '', 'partnerAll.html', 'view,export', '1', '33');
INSERT INTO `menu` VALUES ('32', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '4', '商机审核', 'opport', '', 'opportAudit.html', 'view,listExamine,examine', '1', '1');
INSERT INTO `menu` VALUES ('33', 'admin', 'admin', '2016-09-05 16:01:00', '2016-09-05 16:01:00', '4', '我上报的商机', 'opport', '', 'myReport.html', 'view,add,edit,againExamine,listExamine,transfer', '1', '4');

-- ----------------------------
-- Table structure for operatelog
-- ----------------------------
DROP TABLE IF EXISTS `operatelog`;
CREATE TABLE `operatelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `obj_entity_id` int(11) DEFAULT NULL,
  `obj_entity_type_id` varchar(255) DEFAULT NULL,
  `obj_name` varchar(255) DEFAULT NULL,
  `csm_operate_type` varchar(255) DEFAULT NULL,
  `old_oppt_stat` varchar(255) DEFAULT NULL,
  `new_oppt_stat` varchar(255) DEFAULT NULL,
  `custom_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for opport
-- ----------------------------
DROP TABLE IF EXISTS `opport`;
CREATE TABLE `opport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `oppt_ttl` varchar(255) DEFAULT NULL,
  `oppt_stat_id` varchar(255) DEFAULT NULL,
  `vndt_amt` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `sttl_date` varchar(255) DEFAULT NULL,
  `custom_id` int(11) DEFAULT NULL,
  `data_source` varchar(255) DEFAULT NULL,
  `conference_name` varchar(255) DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `market_user_id` varchar(255) DEFAULT NULL,
  `sales_user_id` varchar(255) DEFAULT NULL,
  `assigner` varchar(255) DEFAULT NULL,
  `clue_id` int(11) DEFAULT NULL,
  `history_opp_id` int(11) DEFAULT NULL COMMENT '历史商机ID',
  PRIMARY KEY (`id`),
  KEY `ind_custom_id` (`custom_id`) USING BTREE,
  KEY `ind_sales_user_id` (`sales_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for opport_temp
-- ----------------------------
DROP TABLE IF EXISTS `opport_temp`;
CREATE TABLE `opport_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `oppt_ttl` varchar(255) DEFAULT NULL,
  `oppt_stat_id` varchar(255) DEFAULT '0',
  `vndt_amt` varchar(255) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `sttl_date` varchar(255) DEFAULT NULL,
  `custom_id` int(11) DEFAULT NULL,
  `data_source` varchar(255) DEFAULT NULL,
  `conference_name` varchar(255) DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `market_user_id` varchar(255) DEFAULT NULL,
  `sales_user_id` varchar(255) DEFAULT NULL,
  `assigner` varchar(255) DEFAULT NULL,
  `clue_id` int(11) DEFAULT NULL,
  `examine_state` int(11) DEFAULT '0' COMMENT '审核状态：  0待审核、1通过、2驳回',
  `history_csm_name` varchar(255) DEFAULT NULL COMMENT '历史客户名称',
  `history_con_name` varchar(255) DEFAULT NULL COMMENT '历史联系人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `partner`;
CREATE TABLE `partner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL COMMENT '企业名称',
  `contact_name` varchar(255) DEFAULT NULL COMMENT '联系人姓名',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机',
  `tele_no` varchar(255) DEFAULT NULL COMMENT '电话',
  `region` varchar(255) DEFAULT NULL COMMENT '所属团队',
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `city` varchar(255) DEFAULT NULL COMMENT '市',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `postcode` varchar(255) DEFAULT NULL COMMENT '邮编',
  `legal_person` varchar(255) DEFAULT NULL COMMENT '企业法人',
  `register_fund` varchar(255) DEFAULT NULL COMMENT '注册资金',
  `authority_region` varchar(255) DEFAULT NULL COMMENT '授权地区',
  `authority_profession` varchar(255) DEFAULT NULL COMMENT '授权行业',
  `start_time` varchar(255) DEFAULT NULL COMMENT '授权期限开始时间',
  `end_time` varchar(255) DEFAULT NULL COMMENT '授权期限结束时间',
  `agency_authority` int(11) DEFAULT NULL COMMENT '代理权限',
  `pledge_money` varchar(255) DEFAULT NULL COMMENT '保证金',
  `product_discount` int(11) DEFAULT NULL COMMENT '产品折扣',
  `price` varchar(255) DEFAULT NULL COMMENT '价格',
  `task_amount` varchar(255) DEFAULT NULL COMMENT '任务额',
  `contract_type` int(11) DEFAULT NULL COMMENT '合同类型',
  `attachment` varchar(500) DEFAULT NULL COMMENT '附件',
  `partner_user_id` varchar(255) DEFAULT NULL COMMENT '伙伴负责人',
  `data_type` varchar(255) DEFAULT NULL COMMENT '数据类型',
  `change_time` datetime DEFAULT NULL COMMENT '转交时间',
  `exist_type` varchar(11) DEFAULT NULL COMMENT '存在类型',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for partner_clue
-- ----------------------------
DROP TABLE IF EXISTS `partner_clue`;
CREATE TABLE `partner_clue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `partner_id` varchar(255) DEFAULT NULL COMMENT '伙伴ID',
  `contact_name` varchar(255) DEFAULT NULL COMMENT '联系人姓名',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机',
  `tele_no` varchar(255) DEFAULT NULL COMMENT '电话',
  `QQ` varchar(255) DEFAULT NULL,
  `we_chat` varchar(255) DEFAULT NULL COMMENT '微信',
  `email` varchar(255) DEFAULT NULL COMMENT '电子邮件',
  `department` varchar(255) DEFAULT NULL COMMENT '部门',
  `post` varchar(255) DEFAULT NULL COMMENT '职务',
  `company_name` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `data_source` varchar(255) DEFAULT NULL COMMENT '数据来源',
  `conference_name` varchar(255) DEFAULT NULL COMMENT '会议名称',
  `product_type` varchar(255) DEFAULT NULL COMMENT '产品类型',
  `level` varchar(255) DEFAULT NULL COMMENT '客户级别',
  `profession` varchar(255) DEFAULT NULL COMMENT '行业类别',
  `csm_nature` varchar(255) DEFAULT NULL COMMENT '客户性质',
  `csm_scale` varchar(255) DEFAULT NULL COMMENT '客户规模',
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `address` varchar(255) DEFAULT NULL COMMENT 'address',
  `postcode` varchar(255) DEFAULT NULL COMMENT '邮编',
  `website` varchar(255) DEFAULT NULL COMMENT '官方网址',
  `fax` varchar(255) DEFAULT NULL COMMENT '公司传真',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `clue_state` varchar(255) DEFAULT NULL COMMENT '线索状态',
  `change_time` datetime DEFAULT NULL COMMENT '转商机时间',
  `close_time` datetime DEFAULT NULL COMMENT '关闭时间',
  `close_reason` varchar(255) DEFAULT NULL COMMENT '线索关闭理由',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partner_clue
-- ----------------------------

-- ----------------------------
-- Table structure for partner_contact
-- ----------------------------
DROP TABLE IF EXISTS `partner_contact`;
CREATE TABLE `partner_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `partner_id` varchar(255) DEFAULT NULL COMMENT '伙伴ID',
  `contact_name` varchar(255) DEFAULT NULL COMMENT '联系人姓名',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `birth_day` varchar(255) DEFAULT NULL COMMENT '出生日期',
  `department` varchar(255) DEFAULT NULL COMMENT '所在部门',
  `post` varchar(255) DEFAULT NULL COMMENT '职位',
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `postcode` varchar(255) DEFAULT NULL COMMENT '邮编',
  `tele_no` varchar(255) DEFAULT NULL COMMENT '座机',
  `mail` varchar(255) DEFAULT NULL COMMENT '电子邮件',
  `QQ` varchar(255) DEFAULT NULL,
  `we_chat` varchar(255) DEFAULT NULL COMMENT '微信',
  `custom_id` varchar(255) DEFAULT NULL COMMENT '所属客户标识',
  `contact_type_id` varchar(255) DEFAULT NULL COMMENT '联系人类型',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `clue_id` varchar(255) DEFAULT NULL COMMENT '线索标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partner_contact
-- ----------------------------

-- ----------------------------
-- Table structure for partner_custom
-- ----------------------------
DROP TABLE IF EXISTS `partner_custom`;
CREATE TABLE `partner_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `csm_name` varchar(255) DEFAULT NULL COMMENT '客户名称',
  `csm_stat_id` varchar(255) DEFAULT NULL COMMENT '客户状态',
  `level` varchar(255) DEFAULT NULL COMMENT '客户级别',
  `profession` varchar(255) DEFAULT NULL COMMENT '行业类别',
  `csm_nature` varchar(255) DEFAULT NULL COMMENT '客户性质',
  `csm_scale` varchar(255) DEFAULT NULL COMMENT '客户规模',
  `upper_company` varchar(255) DEFAULT NULL COMMENT '上级公司',
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `postcode` varchar(255) DEFAULT NULL COMMENT '邮编',
  `website` varchar(255) DEFAULT NULL COMMENT '官网',
  `fax` varchar(255) DEFAULT NULL COMMENT '公司传真',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `partner_id` varchar(255) DEFAULT NULL COMMENT '伙伴ID',
  `clue_id` varchar(255) DEFAULT NULL COMMENT '线索标识 ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partner_custom
-- ----------------------------

-- ----------------------------
-- Table structure for partner_operatelog
-- ----------------------------
DROP TABLE IF EXISTS `partner_operatelog`;
CREATE TABLE `partner_operatelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `obj_entity_id` varchar(255) DEFAULT NULL COMMENT '对象实体标识',
  `obj_entity_type_id` varchar(255) DEFAULT NULL COMMENT '对象实体类型',
  `obj_name` varchar(255) DEFAULT NULL COMMENT '对象名称',
  `csm_operate_type` varchar(255) DEFAULT NULL COMMENT '客户操作类型',
  `old_oppt_stat` varchar(255) DEFAULT NULL COMMENT '操作前机会阶段',
  `new_oppt_stat` varchar(255) DEFAULT NULL COMMENT '操作后机会阶段',
  `partner_id` varchar(255) DEFAULT NULL COMMENT '伙伴ID',
  `custom_id` varchar(255) DEFAULT NULL COMMENT '所属客户标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for partner_opport
-- ----------------------------
DROP TABLE IF EXISTS `partner_opport`;
CREATE TABLE `partner_opport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `oppt_ttl` varchar(255) DEFAULT NULL COMMENT '机会名称',
  `oppt_stat_id` varchar(255) DEFAULT NULL COMMENT '机会阶段ID',
  `vndt_amt` varchar(255) DEFAULT NULL COMMENT '金额',
  `start_date` varchar(255) DEFAULT NULL COMMENT '发现日期',
  `sttl_date` varchar(255) DEFAULT NULL COMMENT '结单时间',
  `custom_id` varchar(255) DEFAULT NULL COMMENT '所属客户标识',
  `data_source` varchar(255) DEFAULT NULL COMMENT '机会来源',
  `product_type` varchar(255) DEFAULT NULL COMMENT '产品类型',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `partner_id` varchar(255) DEFAULT NULL COMMENT '伙伴ID',
  `clue_id` varchar(255) DEFAULT NULL COMMENT '线索标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for region_trade
-- ----------------------------
DROP TABLE IF EXISTS `region_trade`;
CREATE TABLE `region_trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `data_id` int(11) DEFAULT NULL,
  `region_id` varchar(100) DEFAULT NULL,
  `trade` varchar(100) DEFAULT NULL,
  `save_type` varchar(11) DEFAULT NULL COMMENT '保存类型：0、选择行业   1、全部行业',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for relation_key
-- ----------------------------
DROP TABLE IF EXISTS `relation_key`;
CREATE TABLE `relation_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `history_opp_id` int(11) DEFAULT NULL COMMENT '初步商机ID',
  `opport_id` int(11) DEFAULT NULL COMMENT '机会ID',
  `contact_id` int(11) NOT NULL COMMENT '联系人ID',
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for remind
-- ----------------------------
DROP TABLE IF EXISTS `remind`;
CREATE TABLE `remind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `obj_entity_id` int(11) DEFAULT NULL,
  `obj_entity_type_id` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `csm_name` varchar(255) DEFAULT NULL,
  `remind_user_id` varchar(255) DEFAULT NULL,
  `if_read` varchar(255) DEFAULT NULL,
  `oppt_ttl` varchar(255) DEFAULT NULL COMMENT '商机名称',
  `market_user_id` varchar(255) DEFAULT NULL COMMENT '上报人',
  `sales_user_id` varchar(255) DEFAULT NULL COMMENT '负责人',
  `remind_type` int(11) DEFAULT NULL COMMENT '提醒类型',
  `clue_id` int(11) DEFAULT NULL COMMENT '线索ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_data
-- ----------------------------
DROP TABLE IF EXISTS `role_data`;
CREATE TABLE `role_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `btn_group` varchar(200) DEFAULT NULL,
  `menu_type` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `login_name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `real_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `status` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_sys_user_ln` (`login_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'admin', '2015-09-22 11:20:39', '2016-09-05 17:06:42', 'admin', '111111', 'admin', '13020202020', '', '2016-09-05 17:06:42', '2016-09-05 17:02:49', '342', '1');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `staff_id` varchar(20) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `data_id` int(11) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `data_name` varchar(255) DEFAULT NULL,
  `role_type1` int(1) DEFAULT NULL,
  `role_type2` int(1) DEFAULT NULL,
  `role_type3` int(1) DEFAULT NULL,
  `role_type4` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_user_role_1` (`staff_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for word
-- ----------------------------
DROP TABLE IF EXISTS `word`;
CREATE TABLE `word` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL COMMENT '留言内容',
  `rcv_user_id` varchar(255) DEFAULT NULL COMMENT '接收人',
  `obj_entity_id` varchar(255) DEFAULT NULL COMMENT '实体标识',
  `obj_entity_type_id` varchar(255) DEFAULT NULL COMMENT '实体类型（dynamic/动态:01）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

