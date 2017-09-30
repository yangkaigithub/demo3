## http-ga-boot-rest-https：结合https的RESTful接口发布和调用工具

---

## 能力说明
1. RestTemplate支持https
2. 默认引入了hik-ga-boot-feign-https和httpclient

## rest-https

引入依赖：

	<dependency>
	    <groupId>com.hikvision.ga.common</groupId>
	    <artifactId>hik-ga-boot-rest-https</artifactId>
	    <version>1.0.0-SNAPSHOT</version>
	</dependency>

配置文件

	server:
	  ssl-client:
	    trust-store: classpath:servertrust.jks
	    trust-store-password: 88075998

不需其他操作.

## Feign调用

https的接口同样是加上头,见hik-ga-boot-feign-https说明

	@FeignClient("https://aaa")

## restTemplate

	@Autowired
	@Qulifier("scLbRestTemplate")
	private RestTemplate restTemplate;
	
	restTemplate.getForObject("https://xx-service/xx/service/rs/v1/...", ...);

> 注：不建议使用restTemplate进行接口调用。