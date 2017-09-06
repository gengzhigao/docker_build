-- 换域名时，把t.appcan.cn替换成目标域名
use emm_db;
update AdminUserPrivilege set privilegeUrl = 'https://t.appcan.cn:18443/sso/login?service=https://t.appcan.cn:18443/ydyy/mobileoa/oams/index.html' where id = 200;
update AdminUserPrivilege set privilegeUrl = 'https://t.appcan.cn:18443/sso/login?service=https://t.appcan.cn:18443/ydyy/mobileoa/appdo-web-flow/settingMeta/metaCustomList' where id = 270;
update AdminUserPrivilege set privilegeUrl = 'https://t.appcan.cn:18443/sso/login?service=https://t.appcan.cn:18443/ydyy/mobileoa/appdo-web-flow/settingModel/modelList' where id = 271;
update AdminUserPrivilege set privilegeUrl = 'https://t.appcan.cn:18443/sso/login?service=https://t.appcan.cn:18443/ydyy/mobileoa/crmms/index.html' where id = 280;
update AdminUserPrivilege set privilegeUrl = 'https://t.appcan.cn:18443/baas/app/index' where id = 301;
