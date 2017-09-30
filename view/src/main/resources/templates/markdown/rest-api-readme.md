# hik-ga-boot-resteasy：集成Resteasy的RESTful接口发布工具 


本节demo涉及的模块

1. `seed_root/modules/demo1-resteasy` 模块
2. `seed_root/api/demo1-api`模块

--- 

## 1. RESTEasy

RESTEasy是JBoss的一个开源项目，提供各种框架帮助你构建RESTful Web Services和RESTful Java应用程序。它是JAX-RS规范的一个完整实现并通过JCP认证。

JAX-RS提供了一些标注将一个资源类，一个POJOJava类，封装为Web资源。 

标注包括： 

`@Path`，标注资源类或方法的相对路径；

`@GET`，`@PUT`，`@POST`，`@DELETE`，标注方法是用的HTTP请求的类型；

`@Produces`，标注返回的MIME媒体类型 `@Consumes`，标注可接受请求的MIME媒体类型；

`@PathParam`，`@QueryParam`，`@HeaderParam`，`@CookieParam`，`@MatrixParam`，`@FormParam`,分别标注方法的参数来自于HTTP请求的不同位置，例如@PathParam来自于URL的路径，@QueryParam来自于URL的查询参数，@HeaderParam来自于HTTP请求的头信息，@CookieParam来自于HTTP请求的Cookie。

## 2. 基础包依赖引入

根据4.0的Java开发规范，在接口发布端，RESTful接口的目录位置为： `api/xxx-api(子模块)`

在该模块中引入pom依赖： 

```
<dependency>
	<groupId>com.hikvision.ga.common</groupId>
	<artifactId>hik-ga-boot-resteasy</artifactId>
	<version>1.0.0-SNAPSHOT</version>
</dependency>
```

`hik-ga-boot-resteasy`基础包包装了 [resteasy-spring-boot-starter](https://github.com/paypal/resteasy-spring-boot) 和jboss的[jaxrs-api](http://resteasy.jboss.org/)。

它在所有发布的API接口路径中添加前缀：`"/service/rs/"`

## 3. ZooKeeper配置（接口注册）

RESTFul API发布到注册中心ZooKeeper（zk）上才能被其他的服务调用，因此需要引入和配置zk，zk的版本已经在基础依赖包中被管理：

```
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-zookeeper-discovery</artifactId>
</dependency>
```
增加zk配置文件`seed_root/start/src/main/resources/bootstrap.yml`，内容：

```
spring:
  cloud:
    zookeeper:
      connect-string: localhost:2181
      discovery:
        preferIpAddress: true
```
并且需要在`application.properties`中指定应用名称：
```
spring.application.name=Demo1
```

在启动类中加入以下注解：

	@EnableDiscoveryClient

## 4. Restful接口声明

`seed_root/api/demo1-api/src/main/java/com/hikvision/ga/seed/api/v1/SoftwareApiService.java`
```
@Path("v1/softwareService")
public interface SoftwareApiService {

	/**
     * 带参数测试2
     * 注解@PathVariable将某个动态参数放到URL请求路径中
     */
	@GET
	@Path("/response/{param}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces("application/json") 
	public Response responseParam(@PathParam("param") String msg);
}
```

以上述接口发布为例，调用responseParam的访问路径为：`http://ip:port/xx/service/rs/v1/softwareService/response/{param}`

## 5. Restful接口实现

demo1中本程序对应的api实现的业务模块为`modules/demo1-resteasy`，引入依赖：
`seed_root/modules/demo1-resteasy/pom.xml`:
```
<dependency>
	<groupId>com.hikvision.ga.seed</groupId>
	<artifactId>demo1-api</artifactId>
	<version>0.0.1-SNAPSHOT</version>
</dependency>

<dependency>
	<groupId>com.hikvision.ga.common</groupId>
	<artifactId>hik-ga-boot-resteasy-starter</artifactId>
	<version>1.0.0-SNAPSHOT</version>
</dependency>
```
在**业务模块**中实现Api接口**（务必不要放在api包中）**：

`seed_root/modules/demo1-resteasy/src/main/java/com/hikvision/ga/seed/modules/resteasy/rs/SoftwareApiServiceImpl.java`:
```
import com.hikvision.ga.seed.api.v1.SoftwareApiService;
import com.hikvision.ga.seed.api.v1.dto.SoftwareDTO;

/**
 * 为Restful Api Service提供接口
 * @author langyicong
 *
 */
@Service
public class SoftwareApiServiceImpl implements SoftwareApiService {

 	// some other code...
	@Override
	public Response responseParam(String msg) {
		String result = "Restful请求参数为 : " + msg;
		return Response.status(200).entity(result).build();
	}
}

```

使用`hik-ga-boot-feign-jaxrs`基础包的方法在下一节中阐述。
