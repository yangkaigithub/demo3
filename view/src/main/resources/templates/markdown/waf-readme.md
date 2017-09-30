## hik-ga-boot-waf 

> 支持web和rest api两种通信模式。

引入依赖`hik-ga-boot-waf`到相应的工程模块中

	<dependency>
		<groupId>com.hikvision.ga</groupId>
		<artifactId>hik-ga-boot-waf</artifactId>
		<version>1.0.0-SNAPSHOT</version>
	</dependency>

http敏感字符转义，则引入`hik-ga-waf-xss`

	<dependency>
		<groupId>com.hikvision.ga.common</groupId>
		<artifactId>hik-ga-waf-xss</artifactId>
		<version>1.0.0-SNAPSHOT</version>
	</dependency>

WAF的补漏包需要自己实现，可参考`hik-ga-waf-xss`工程的模式。