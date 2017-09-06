#
# Data for table "TenantInfo"
#

DROP TABLE IF EXISTS TenantInfo;
CREATE TABLE TenantInfo (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  createdAt datetime DEFAULT NULL,
  tenantAddr varchar(255) DEFAULT NULL,
  tenantAuthStatus varchar(255) DEFAULT NULL,
  tenantFullName varchar(255) DEFAULT NULL,
  tenantId varchar(255) DEFAULT NULL,
  tenantInternetAddr varchar(255) DEFAULT NULL,
  tenantLogo varchar(255) DEFAULT NULL,
  tenantName varchar(255) DEFAULT NULL,
  tenantTel varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
-- 导入租户信息
INSERT INTO TenantInfo (id,createdAt,tenantAddr,tenantAuthStatus,tenantFullName,tenantId,tenantInternetAddr,tenantLogo,tenantName,tenantTel) VALUES (1,now(),'',NULL,'','1846','','','zyyd','');
-- 导入OA的默认应用
INSERT INTO AppBaseInfo (id,createdAt,activeUser,addByPkgName,appCategory,appId,appKey,appSource,appType,applyInterfaceStatus,createdAtMs,creator,curVersion,description,downloadCnt,greatApp,iconLoc,isContainer,isUploadPushCert,lastCommitAt,name,platform,shortImg1,shortImg2,shortImg3,shortImg4,startTotal,total,tag) VALUES (2,'2016-08-05 18:30:19','0','F',4,'MOBILEOA','appcanmobileoa','company','3','F',1470393019754,'admin','00.00.0001','MOBILEOA',0,'F','','F','F','2016-08-09','正益工作','android,iphone','','','',NULL,0,0,'');
-- 导入OA应用的配置信息
INSERT INTO AppConfigInfo (id,createdAt,anReportMethod,appDomains,appId,appJsonPolicy,auditStatus,auditType,authType,autoUpdateStatus,codeAuth,columnIds,identityValidation,mySpaceMoreAppSwitch,mySpaceSwitch,pushMsgSwitch,sandboxEncryption,userWithTermOneToOne,widgetAdStatus,widgetCloseHints,widgetSwitch,enableScreenshot,versionSwitch) VALUES (2,'2016-08-05 18:30:20',0,NULL,'MOBILEOA','',2,3,0,'T','F',NULL,'T','F','F','T','T','F','F',NULL,'T','T','T');
-- 导入OA应用的渠道信息
INSERT INTO t_ChannelInfo (id,createdAt,appId,channelCode,channelDesc,channelName,creatorId) VALUES (1,'2016-08-05 18:30:20','MOBILEOA','0000','默认渠道','默认渠道',0);
-- 导入应用与应用组关系数据
INSERT INTO MdmApplication VALUES (1,'2015-08-04 20:54:20',2,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);


-- INSERT INTO AdminUserPrivilege (id,createdAt,className,configSort,hoverIcon,icon,isConfigure,isUse,menueLevel,parentPrivielgeId,privilegeId,privilegeName,privilegeUrl,platForm,interfaceFlag) VALUES 
-- (199,now(),'icon-oa',11,NULL,'其他','T','T','1','oaTeamWork','oaTeamWork','协同办公',NULL,'EMM','EMM'),
-- (200,now(),NULL,1,NULL,'其他','T','T','2','oaTeamWork','teamWork','协同办公','http://123.56.105.64:10004/manager/ssoLogin','EMM','EMM'),
-- (201,now(),NULL,15,NULL,'其他','T','T','1','OA_notice','OA_notice','公告管理',NULL,'OA','OA'),
-- (202,now(),NULL,16,NULL,'其他','T','T','1','OA_rules','OA_rules','规章制度',NULL,'OA','OA'),
-- (203,now(),NULL,17,NULL,'其他','T','T','1','enterpriseCIS','enterpriseCIS','企业CIS',NULL,'OA','OA'),
-- (204,now(),NULL,18,NULL,'其他','T','T','1','OA_attendanceMng','OA_attendanceMng','考勤管理',NULL,'OA','OA'),
-- (205,now(),NULL,19,NULL,'其他','T','T','1','OA_permissions','OA_permissions','权限设置',NULL,'OA','OA'),
-- (206,now(),NULL,20,NULL,'其他','T','T','1','OA_workFlow','OA_workFlow','流程引擎',NULL,'OA','OA'),
-- (207,now(),NULL,22,NULL,'其他','T','T','1','OA_crmMng','OA_crmMng','CRM管理',NULL,'OA','OA'),
-- (210,now(),NULL,1,NULL,'其他','T','T','2','OA_notice','OA_subNotice','公告管理',NULL,'OA','OA'),
-- (220,now(),NULL,1,NULL,'其他','T','T','2','OA_rules','OA_subRules','规章制度',NULL,'OA','OA'),
-- (230,now(),NULL,1,NULL,'其他','T','T','2','enterpriseCIS','OA_enterpriseCulture','企业文化',NULL,'OA','OA'),
-- (231,now(),NULL,2,NULL,'其他','T','T','2','enterpriseCIS','OA_recreational','文体活动',NULL,'OA','OA'),
-- (232,now(),NULL,3,NULL,'其他','T','T','2','enterpriseCIS','OA_trainingActivity','培训活动',NULL,'OA','OA'),
-- (240,now(),NULL,1,NULL,'其他','T','T','2','OA_attendanceMng','OA_attendanceRule','考勤规则',NULL,'OA','OA'),
-- (250,now(),NULL,2,NULL,'其他','T','T','2','OA_attendanceMng','OA_punchLocation','考勤地点',NULL,'OA','OA'),
-- (251,now(),NULL,3,NULL,'其他','T','T','2','OA_attendanceMng','OA_attendanceOrder','考勤相关工单',NULL,'OA','OA'),
-- (252,now(),NULL,4,NULL,'其他','T','T','2','OA_attendanceMng','OA_attendanceSummary','考勤汇总',NULL,'OA','OA'),
-- (260,now(),NULL,1,NULL,'其他','T','T','2','OA_permissions','OA_relationshipSetting','功能授权',NULL,'OA','OA'),
-- (270,now(),NULL,1,NULL,'其他','T','T','2','OA_workFlow','OA_metaDataMng','元数据管理','https://saas.appcan.cn/tenantName/appId/appdo-web-flow/settingMeta/metaCustomList','OA','OA'),
-- (271,now(),NULL,2,NULL,'其他','T','T','2','OA_workFlow','OA_modelMng','模型管理','https://saas.appcan.cn/tenantName/appId/appdo-web-flow/settingModel/modelList','OA','OA'),
-- (280,now(),NULL,1,NULL,'其他','T','T','2','OA_crmMng','OA_subCrmMng','CRM管理','https://saas.appcan.cn/tenantName/appId/crmms/index.html','OA','OA')



-- INSERT INTO NodulePrivilege (id,createdAt,isuse,name,parentId,privilegeId,url )VALUES 
-- (300,now(),'T','添加','OA_subNotice','subNotice_add',''),
-- (301,now(),'T','编辑','OA_subNotice','subNotice_edit',''),
-- (302,now(),'T','删除','OA_subNotice','subNotice_delete',''),
-- (303,now(),'T','批量删除','OA_subNotice','subNotice_batchDelete',''),
-- (304,now(),'T','发布','OA_subNotice','subNotice_release',''),
-- (305,now(),'T','关闭','OA_subNotice','subNotice_close',''),
-- (310,now(),'T','添加','OA_subRules','subRules_add',''),
-- (311,now(),'T','编辑','OA_subRules','subRules_edit',''),
-- (312,now(),'T','删除','OA_subRules','subRules_delete',''),
-- (313,now(),'T','批量删除','OA_subRules','subRules_batchDelete',''),
-- (314,now(),'T','发布','OA_subRules','subRules_release',''),
-- (315,now(),'T','关闭','OA_subRules','subRules_close',''),
-- (320,now(),'T','添加','OA_enterpriseCulture','enterpriseCulture_add',''),
-- (321,now(),'T','编辑','OA_enterpriseCulture','enterpriseCulture_edit',''),
-- (322,now(),'T','删除','OA_enterpriseCulture','enterpriseCulture_delete',''),
-- (323,now(),'T','批量删除','OA_enterpriseCulture','enterpriseCulture_batchDelete',''),
-- (324,now(),'T','发布','OA_enterpriseCulture','enterpriseCulture_release',''),
-- (325,now(),'T','关闭','OA_enterpriseCulture','enterpriseCulture_close',''),
-- (330,now(),'T','添加','OA_recreational','recreational_add',''),
-- (331,now(),'T','编辑','OA_recreational','recreational_edit',''),
-- (332,now(),'T','删除','OA_recreational','recreational_delete',''),
-- (333,now(),'T','批量删除','OA_recreational','recreational_batchDelete',''),
-- (334,now(),'T','报名入口','OA_recreational','recreational_signUp',''),
-- (335,now(),'T','调整状态','OA_recreational','recreational_changeStat',''),
-- (340,now(),'T','添加','OA_trainingActivity','trainingActivity_add',''),
-- (341,now(),'T','编辑','OA_trainingActivity','trainingActivity_edit',''),
-- (342,now(),'T','删除','OA_trainingActivity','trainingActivity_delete',''),
-- (343,now(),'T','批量删除','OA_trainingActivity','trainingActivity_batchDelete',''),
-- (344,now(),'T','报名入口','OA_trainingActivity','trainingActivity_signUp',''),
-- (345,now(),'T','调整状态','OA_trainingActivity','trainingActivity_changeStat',''),
-- (350,now(),'T','添加','OA_attendanceRule','attendanceRule_add',''),
-- (351,now(),'T','编辑','OA_attendanceRule','attendanceRule_edit',''),
-- (352,now(),'T','删除','OA_attendanceRule','attendanceRule_delete',''),
-- (360,now(),'T','删除','OA_attendanceOrder','attendanceOrder_delete',''),
-- (370,now(),'T','导出','OA_attendanceSummary','attendanceSummary_export',''),
-- (380,now(),'T','授权','OA_relationshipSetting','relationshipSetting_set',''),
-- (381,now(),'T','解除','OA_relationshipSetting','relationshipSetting_unset','')

