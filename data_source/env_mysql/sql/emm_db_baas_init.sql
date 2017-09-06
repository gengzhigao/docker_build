INSERT INTO `AdminUserPrivilege` 
(createdAt,className,configSort,hoverIcon,icon,isConfigure,isUse,menueLevel,parentPrivielgeId,privilegeId,privilegeName,privilegeUrl,platForm,interfaceFlag) VALUES 
(now(),'icon-htfu',10,NULL,'其他','T','T','1','baasManage','baasManage','后端服务管理','','EMM','EMM'),
(now(),NULL,1,NULL,'其他','T','T','2','baasManage','baasSubManage','服务管理','https://192.168.1.142:18443/baas/app/index','EMM','EMM');
