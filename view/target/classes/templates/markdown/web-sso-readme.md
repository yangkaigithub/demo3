# hik-ga-boot-session：CAS单点登录和CSRF防御

本节将展示如何构建一个单点登录登出和具有CSRF防御功能的纯web工程。

本节demo涉及的模块

1. 业务模块：`seed_root/modules/demo1-home` 
2. 业务模块：`seed_root/modules/demo1-ajaxweb`
3. 启动模块：`seed_root/start`
4. 前端模块：`seed_root/view`
5. demo2：`client_app_root`

--- 

## 1. pom.xml依赖

引入`hik-ga-boot-session`到相应的模块中。
如：`/modules/demo1-home/pom.xml`：
```
<dependency>
	<groupId>com.hikvision.ga.common</groupId>
	<artifactId>hik-ga-boot-session</artifactId>
	<version>1.0.0-SNAPSHOT</version>
</dependency>
```
`hik-ga-boot-session`模块中已经引入hik-ga-boot-cas、cache、session、redis等

> 注意：如果没有引入该模块，则会报错401（Chrome浏览器会出现一个默认的认证弹窗，但是无法认证）。

## 2. 工程配置

### 2.1 【!重要】cas必须单独使用配置文件`cas-client.properties`

cas-client.properties内容如下：
```
#cas Server的地址，如果配置了casAddressClass后，可忽略该配置
hik.ga.cas.casUrl=http://pc1-shanguoming:8080/cas
#必须，cas登陆地址，不配为默认/login
hik.ga.cas.casLoginUrl=/login
#必须，cas登出地址，不配为默认/logout
hik.ga.cas.casLogoutUrl=/logout
#非必须，cas认证地址，不配置与casUrl保持一致
hik.ga.cas.casServiceValidateUrl=http://pc1-shanguoming:8080/cas
#配置cas忽略权限过滤的地址，符合ant风格,其中"/service/**"表示忽略所有restful APIs的url
hik.ga.cas.ignoreAuthUrls=/bootstrap/**,/dist/**,/plugins/**,/service/**,/template/**
#cas应用的地址，配置了casAddressClass后，可忽略配置（应用地址不可以用localhost）
hik.ga.cas.appUrl=http://hostname:port/context-path
#必须，应用的首页地址，根据实际应用上下文填写
hik.ga.cas.appHomeUrl=/index
#必须，应用的登陆地址，不配为默认/login
hik.ga.cas.appLoginUrl=/login
#必须，应用的登出地址，不配为默认/logout
hik.ga.cas.appLogoutUrl=/logout
#非必须，不配置以cas-client.properties为准
hik.ga.cas.casAddressClass=com.hikvision.rensu.cert.service.CasAddressServiceImpl
```

> 注：cas忽略权限过滤的url必须采用ant通配符，基本规则：
? 匹配任何单字符 
* 匹配0或者任意数量的字符 
** 匹配0或者更多的目录

参考[Ant通配符](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/util/AntPathMatcher.html)。


### 2.2 SpringBoot配置

`application.properties`

[必须*] redis服务配置，用于存储会话、CSRF等
```
spring.redis.database=15
spring.redis.host=(redis server主机IP)
spring.redis.timeout=0
spring.redis.port=6379
spring.redis.password=
spring.redis.pool.maxIdle=8
spring.redis.pool.minIdle=1
spring.redis.pool.maxActive=8
spring.redis.pool.maxWait=-1
# redis连接超时时间（毫秒）
spring.redis.timeout=3600
```
除此之外，**必须**配置服务端session的过期时间（秒）：
```
server.session-timeout=1200
```

### 2.3 启动类配置

`/start/src/main/java/com/hikvision/ga/seed/SeedApplication.java`中把`com.hikvision.ga.common.boot`包加入基础扫描路径中。
```
@SpringBootApplication(scanBasePackages = { "com.hikvision.ga.common.boot", "com.hikvision.ga.seed"})
```

## 3.前端

使用后台模板（如freemarker）的meta标签获取CSRF token，放在请求头中：

FTL中：
`/view/src/main/resources/templates/web-api.ftl`:
```
<meta name="_csrf" content="${_csrf.token}"/>  
<meta name="_csrf_header" content="${_csrf.headerName}"/>  
```
相应的JavaScript（以jQuery为例）
`/view/src/main/resources/templates/web-api.ftl`:
```
var token = $("meta[name='_csrf']").attr("content");  
var header = $("meta[name='_csrf_header']").attr("content");  
$(document).ajaxSend(function(e, xhr, options) {  
    xhr.setRequestHeader(header, token);  
}); 
```
还可以放在form表单中。

---

### 附：CSRF的攻击和防御原理
#### CSRF攻击
csrf又称跨域请求伪造，攻击方通过伪造用户请求访问受信任站点。
要完成一次CSRF攻击，受害者必须依次完成两个步骤：
1. 登录受信任网站A，并在本地生成Cookie。
2. 在不登出A的情况下，访问危险网站B。
攻击过程如图所示：
![csrf attack](img/csrf-attack.png)

#### spring-security中csrf防御原理
在web应用中增加前置过滤器，对需要验证的请求验证是否包含csrf的token信息，如果不包含，则报错。这样攻击网站无法获取到token信息，则跨域提交的信息都无法通过过滤器的校验。

