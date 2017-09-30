# hik-ga-boot-feign-jaxrs：RESTful接口调用

## 1. pom依赖

### 1.1 基础包依赖
基础包`hik-ga-boot-feign-jaxrs`包装了Openfeign的`feign-jaxrs`和Spring Cloud的`spring-cloud-starter-feign`，调用方（本例的FeignClient在`AnotherSeedApplication`中）引入其pom依赖：

	<dependency>
	    <groupId>com.hikvision.ga</groupId>
	    <artifactId>hik-ga-boot-feign-jaxrs</artifactId>
	    <version>1.0-SNAPSHOT</version>
	</dependency>

### 1.2 api依赖
另外，需要引入被调用方发布的api包，在此案例中为demo1的demo1-api包：

	<dependency>
		<groupId>com.hikvision.ga.seed</groupId>
		<artifactId>demo1-api</artifactId>
		<version>0.0.1-SNAPSHOT</version>
	</dependency>

调用方也需要配置zookeeper，同[RESTEasy中的说明](resteasy)，此处不赘述。

## 2. 配置

启动类开启FeignClient和服务发现

	@EnableFeignClients
	@EnableDiscoveryClient


## 3.Feign调用

FeignClient接口`SoftServiceClient`需要继承被调用的接口类`SoftwareApiService`，它定义在demo1的api模块中。
接口上需要加上注解`@FeignClient`，这个注解用于通知Feign组件对该接口进行代理 **（不需要编写接口实现）**，使用者可直接通过@Autowired注入。

FeignClient接口`SoftServiceClient`定义代码如下：

	@FeignClient(value = "Demo1", path = "demo1/service/rs")
	public interface SoftServiceClient extends SoftwareApiService {
	  //不需要写实现
	}

> 使用@FeignClient注解，由工具包`org.springframework.cloud.netflix.feign.FeignClient`提供，已经放在基础包中，无需额外引入。

在`SoftClientController.java`中使用FeignClient，只需要@Autowired注入Bean即可：

	package com.hikvision.ga.seed2.business.controller;

	@Controller
	@RequestMapping(value = "/business")
	public class SoftClientController {
	
    @Autowired
    private SoftServiceClient softServiceClient;
    
    @RequestMapping("/testRpc")
    @ResponseBody
    public String testRpc(){
		try {
			String res = softServiceClient.getApiJson();
	        System.out.println(res);
	        return res+", testRpc of demo2 is being called";
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return "...error";
    }


### restTemplate
不建议使用restTemplate，忽略。

注：FeignClient接口调用可参考：[使用Spring Cloud Feign作为HTTP客户端调用远程HTTP服务](http://blog.csdn.net/neosmith/article/details/52449921)

> 通过Feign， 我们能把HTTP远程调用对开发者完全透明，得到与调用本地方法一致的编码体验。这一点与阿里Dubbo中暴露远程服务的方式类似，区别在于Dubbo是基于私有二进制协议，而Feign本质上还是个HTTP客户端。如果是在用Spring Cloud Netflix搭建微服务，那么Feign无疑是最佳选择。
