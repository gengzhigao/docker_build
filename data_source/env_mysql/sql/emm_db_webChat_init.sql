INSERT INTO `AdminUserPrivilege` (createdAt,className,configSort,hoverIcon,icon,isConfigure,isUse,menueLevel,parentPrivielgeId,privilegeId,privilegeName,privilegeUrl,platForm,interfaceFlag) VALUES
(now(),'icon-wx',9,NULL,'其他','T','T','1','weixinManage','weixinManage','微信管理',null,'EMM','EMM'),
(now(),NULL,1,NULL,'其他','T','T','2','weixinManage','weixinSubManager','微信管理','http://weixin.appcan.cn/unionLogin/login','EMM','EMM'),
(now(),NULL,1,NULL,'其他','T','F','3','weixinSubManager','publicNumberManager','公众号管理',NULL,'EMM','EMM');
