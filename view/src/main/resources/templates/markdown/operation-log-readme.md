
## 1. 基础包pom依赖

	<dependency>
		<groupId>com.hikvision.ga.common</groupId>
		<artifactId>hik-ga-boot-operation-log</artifactId>
		<version>1.0.0-SNAPSHOT</version>
	</dependency>

## 2. 配置

通过rabbitMQ将日志写进fsc的日志微服务中，配置输出通道`operationLogChannel`，下面是`application.yml`的例子：
```
spring:
  cloud:
    stream:
      bindings:
        output:
          destination: operationLogChannel
          binder: rabbit

  rabbitmq:
    host: localhost
    port: 5672
    username: guest
    password: guest

  application:
    name: demo
```
或者配置`application.properties`:
```
spring.cloud.stream.bindings.output.destination=operationLogChannel
spring.rabbitmq.host=localhost
spring.rabbitmq.port=5672
spring.rabbitmq.username=guest
spring.rabbitmq.password=guest

```

### 3. 使用OperationLogBuilder构造操作日志
```
@ResponseBody
@RequestMapping("/addUser")
public String addUser() {
  OperationLogBuilder.build().appType("imp").appCode("100001").act("新增").business("imp_10001")
    .operateObjectType("USER").operateObjectKeys(",2,").operateObjectValues(",test,")
    .operateResult(1).log();
  return "addUser success";
}
```

### 4.运行
开启rabbitMQ与日志微服务，操作日志由日志微服务管理和存储。