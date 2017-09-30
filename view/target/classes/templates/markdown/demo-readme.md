## 1.说明
本demo集合了所有4.0基础包的运行demo（资源库同步除外），后端Java工程依据*《公安事业部技术体系-(2)开发篇-(1)JAVA开发规范.docx》*开发，前端工程使用freemarker模板，整合了基础库的开发指导文档。

后端：[Spring boot](http://projects.spring.io/spring-boot/)
页面模板：[freemarker](http://freemarker.org/)
前端工具和插件：[jQuery](https://jquery.com/) + [Swagger](https://swagger.io/) + [md2html](https://github.com/leanote/markdown-to-html)
前端样式：[adminLTE](https://adminlte.io/themes/AdminLTE/index2.html) + [bootstrap](http://getbootstrap.com/)

## 2. 调试运行DEMO1（seed app）

工程SVN地址：`https://192.0.0.241/PublicSecurity/trunk/commons/hik-ga-demo/V1.0.X/client_app_root`

### 2.1 导入工程
以Maven的方式导入工程到IDE中；

### 2.2 修改配置和启动必要的服务
Spring Boot配置文件位置：`/start/src/main/resources/`
依赖的服务包括：
（1）（已开启）cas服务：用于单点登录，`hik.ga.cas.casServerUrl`指定了cas server的url地址，目前已指定，单纯运行无需修改和启动；
（2）（已开启）redis服务：用于缓存安全会话，`spring.redis.host`指定了redis服务所在的host，目前已指定，单纯运行无需修改和启动；
（3）（已开启）pg数据库：`spring.datasource.url`指定了数据库位置，目前已指定，单纯运行无需修改和启动；
（4）（非必须）[zipkin](http://zipkin.io/)服务：需要查看调用链再开启，配置`spring.zipkin.base-url`指定了zipkin的服务url，只需要安装zipkin服务并且启动即可；
（5）（必须）[zookeeper](https://zookeeper.apache.org/)服务：配置为`spring.cloud.zookeeper.connect-string=localhost:2181`，只需要安装zipkin服务并且启动即可。
简而言之，如果没有修改过配置，只需要本地启动zookeeper服务。

### 2.3 运行工程
以JavaApplication的方式运行main工程：`/start/src/main/java/com/hikvision/ga/seed/SeedApplication.java`

### 2.4 web访问
访问[http://localhost:8081/demo1/](http://localhost:8081/demo1/)（如果没有修改端口配置的话）即可访问4.0基础框架平台网站。

### 2.5 工程打包

demo工程使用maven assembly插件进行打包。在`start/pom.xml`中已经配置好插件，见`<build>`配置项。其中需要将`plugin>configuration>archive>manifest>mainClass`改为当前工程的主类。

	<mainClass>当前工程主类class</mainClass>
	
比如`<mainClass>com.hikvision.ga.seed.SeedApplication</mainClass>`

打包插件工具目录：

    |--start 		//工程启动目录
    |     |--src/assembly
    |     |     |--logs			//空文件夹，用于存放logs
    |     |     |--temp			//空文件夹，用于存放temp文件
    |     |     |--assembly.xml	//assembly插件配置
    |     |--src/bin
    |     |     |--jsw/conf
    |     |     |     |--wrpper.conf //JSW配置，需要根据工程进行修改
    |     |     |--_console.bat  //打包后以控制台方式运行工程
    |     |     |--_install.bat  //工程安装到本地然后退出控制台
    |     |     |--_restart.bat
    |     |     |--_start.bat
    |     |     |--_stop.bat
    |     |     |--_uninstall.bat
    
`start/src/assmebly.xml`文件中包含(includes)Spring工程所有的配置文件，这些文件需要在打包前修改为运行环境的配置：

	<fileSets>
		<fileSet>
			...
			<includes>
				<include>application.properties</include>
				<include>application-dev.properties</include>
				<include>cas-client.properties</include>
				<include>application-config.xml</include>
				<include>logback.xml</include>
			</includes>
		</fileSet>
		...

`src/bin/jsw/conf/wrpper.conf`中需要修改：
	
	...
	# line 21 改为你的启动工程的名称-版本
	wrapper.java.classpath.1=./start-0.0.1-SNAPSHOT.jar
	...
	# line 31  改为你的启动类名
	wrapper.app.parameter.1=com.hikvision.ga.seed.SeedApplication
	# line 41 自定义名称
	wrapper.java.additional.1=-Ddemo-seed
	# line 86 自定义名称
	wrapper.logfile=logs/demo-seed.log
	# line 96 自定义名称
	wrapper.console.title=demo-seed
	# line 102-104 自定义名称
	wrapper.ntservice.name=demo-seed
	wrapper.ntservice.displayname=demo-seed
	wrapper.ntservice.description=demo-seed

部署后运行`start-1.0.0-SNAPSHOT-build.zip\start-1.0.0-SNAPSHOT\bin\_console.bat`即可。

> 注：如果只是调试api接口，请使用`mvn install`将整个工程发布到本地，以确保demo2可以正确地调用接口。

## 3. DEMO1设计说明

### 3.1 工程目录
    |--demo_root
    |    |--api			//对外接口目录
    |    |     |--demo1-api
    |    |     |     |--...
    |    |     |     |--pom.xml
    |    |     |--pom.xml
    |    |--common		//公共基础目录
    |    |     |--pom.xml
    |    |--modules		//业务模块目录
    |    |     |--demo1-ajaxweb   	 //纯页面工程
    |    |     |--demo1-home	  	 //所有页面跳转控制
    |    |     |--demo1-resteasy  	 //纯RESTApi工程
    |    |     |--demo1-software  	 //用于数据访问
    |    |     |--demo1-validator	 //参数验证示例
    |    |     |--pom.xml
    |    |--start 		//工程主目录
    |    |     |--src/main/java 	 //只存放启动类
    |    |     |     |--seedApplication.java	//启动类
    |    |     |     |--config					//对于整个工程的配置
    |    |     |--src/main/resources //存放所有配置信息
    |    |     |     |--init						//初始化脚本
    |    |     |     |--application-config.xml		//参数验证validator的AOP配置
    |    |     |     |--application-dev.properties 	//Spring Boot工程基本配置（dev环境）
    |    |     |     |--application.properties		//Spring Boot工程基本配置
    |    |     |     |--logback.xml
    |    |     |--pom.xml
    |    |--view		//前端页面工程，没有页面可不创建目录
    |    |     |--src/main/resources //存放前端工程
    |    |     |    |--static		 //资源目录
    |    |     |	|--templates	 //模板目录
    |    |     |	|	 |--markdown	 //所有readme文档存放处
    |    |     |--pom.xml

### 3.2 工程基础包

4.0基础包展示分为以下几个部分：
#### Part1: [构建web页面工程](web-api)
依赖的基础包：`hik-ga-boot-session`，内含`hik-ga-boot-cas`和`hik-ga-boot-cache`

提供能力：
（1）CAS client用于单点登入登出，登陆时生成session会话；
（2）集群间共享session会话；
（3）使用CSRF token防御CSRF攻击。

#### Part2: 构建纯rest接口服务，请参考：
1. [使用RESTEasy发布接口](resteasy)
依赖的基础包：`hik-ga-boot-resteasy`

提供能力：
（1）包装了 [resteasy-spring-boot-starter](https://github.com/paypal/resteasy-spring-boot) 和jboss的[jaxrs-api](http://resteasy.jboss.org/)；
（2）在所有发布的API接口路径中添加前缀：`/service/rs/`。
2. [使用feign调用接口](feign-jaxrs)
依赖的基础包：`hik-ga-boot-feign-jaxrs`

提供能力：
（1）包装了spring cloud的`spring-cloud-starter-feign`
3. [支持HTTPS的Rest接口发布和调用](rest-https)
依赖的基础包：`http-ga-boot-rest-https`，包含`hik-ga-boot-feign-https`和`hik-ga-boot-rest-https`

提供能力：
（1）支持https进行接口发布和调用。

#### Part3: [zipkin分析调用链关系](rpc-tracing)
依赖的基础包：无，依赖spring cloud的`spring-cloud-starter-zipkin`和`spring-cloud-sleuth-zipkin`

提供能力：
（1）全链路追踪工具（根据依赖关系）；
（2）查看每个接口、每个service的执行速度（定位问题发生点或者寻找性能瓶颈）；
（3）创造一些追踪标识符（tracingId，spanId，parentId），最终将一个request的流程树构建出来。

#### Part4: [WAF拦截器](waf)
依赖的基础包：`hik-ga-boot-waf`

提供能力：漏洞修复，如xss转义拦截器，见`hik-ga-waf-xss`

#### Part5: [参数验证框架（支持ajax和RESTful）](validator)
依赖的基础包：`hik-ga-validator`

提供能力：类似`Hibernate validator`的参数验证

#### Part6: [异常拦截](exception)
依赖的基础包：基础异常依赖`hik-ga-common`，补充异常依赖`hik-ga-boot-exception`

提供能力：使用http错误码，规范化业务异常。

#### Part7: [日志拦截](operation-log)
依赖的基础包：`hik-ga-boot-operation-log`

提供能力：构建操作日志，并且与日志微服务的通信。

## 4. 调试运行DEMO2（client app）

工程SVN地址：`https://192.0.0.241/PublicSecurity/trunk/commons/hik-ga-demo/V1.0.X/client_app_root`
运行方式同DEMO1
