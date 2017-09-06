//部署配置【私有化1，线上4.0设置0】
var domain = "t.appcan.cn";

//MBAAS调用
var serverIp = "";
var emmIp = "http://emmconsole:8080";
var appInIp = "http://emmconsole:80";
var mumIp = "http://emmconsole:80";
//var appInMumIp = "http://emmfront:8082";
var avatorLocIp = "http://emmconsole:80";
var ssoIp = "http://emmconsole:8080";
var baasIp = "http://emmconsole:80";
var pushIp = "http://emmconsole:80";
var localIp = "http://127.0.0.1:28080";
var tenantPath = "/data/tenant/tenant.dat";
var appDomainUrl = domain + "";

var manageDomainUrl = domain + ":18443";

exports.tenantPath = tenantPath;
exports.fileInterface = '/baas/4.0/files';
exports.baasConfig = {
    objectInterface : baasIp + "/baas/4.0/classes", // 对象操作接口
    batchInterface : baasIp + "/baas/4.0/batch", // 批量操作接口
    batchPathPrefix : "/4.0/classes", // 批处理中单个请求的接口前缀
    fileInterface : baasIp + "/baas/4.0/files" // 批处理中单个请求的接口前缀
};
//emm接口url
exports.emmConfig = {
    baseUrl : mumIp, // 接口地址
    appInIp : appInIp,
    emmIp : emmIp, // 接口地址
    avatorLocIp : avatorLocIp, // 头像IP
    mumPersonnel : "/v4/OA/", // 接口类型
    uploadIconPath : "/v4/OA/", // 头像接口类型
    emmInter : "/emm/inter/", // 接口类型
    emmOa : "/OA", // 接口类型
    emmPriInterface : "/v4/systemIntegrate/", // 接口类型
    appIn : "/v4/user/", // 接口类型
    sso : "/sso/" // 接口类型/sso/
};
//crm调用
exports.crmConfig = {
    crmUrl : localIp, // 接口地址
    value : "bwsbzlyzwcgzff",//不为失败找理由 只为成功找方法
    use : true//部署CRM服务true 不部署CRM false 
};
//流程引擎调用
exports.workFlowConfig = {
    workFlowUrl : localIp, // 接口地址
    value : "bwsbzlyzwcgzff",//不为失败找理由 只为成功找方法
    use : true//部署流程引擎服务true 不部署流程引擎 false 
};
//门户静态资源访问
exports.appConfig = {
    domainUrl : appDomainUrl //domainUrl
};
//管理后台sso登录
exports.ssoConfig = {
    domainUrl : manageDomainUrl, //domainUrl
    emmUrl : ssoIp, // 接口地址
    curDomain : serverIp + "/oams/index.html",
    deploymentType : 1 //私有化1，线上4.0设置0
};
//推送调用
exports.pushConfig = {
    pushUrl : pushIp + "/notify/4.0/pushMsg"
};
