## 1. 基础包架构
基础包主要作用在于安全拦截，请求和数据经过过滤器和拦截器的流程如下图：
![过滤器和拦截器顺序](img/filters-interceptors.png)
图：过滤器和拦截器顺序


## 2. 基础包maven依赖关系
![基础包maven依赖关系](img/maven-dependency.png)

## 3. Maven工程结构
### 3.1 pom.xml依赖引入
工程根目录*_root的顶级pom依赖引入父级依赖`hik-ga-dependencies`，统一管理工程所有依赖版本，避免子项目版本依赖不一致。

```
<parent>
	<groupId>com.hikvision.ga</groupId>
	<artifactId>hik-ga-dependencies</artifactId>
	<version>1.0.0-SNAPSHOT</version>
</parent>
```
工程中的pom依赖命名规范：
> groupId格式规范：com.hikvision.ga.组件标识.服务标识

### 3.2 Maven目录规范
Maven目录包括：
```
<!-- api：对外接口目录(可选)，packaging:pom -->
<module>api</module>
<!-- common：公共基础目录(必选*)，packaging:pom -->
<module>common</module>
<!-- modules：业务模块目录(必选*)，packaging:pom -->
<module>modules</module>
<!-- tool：内部工具目录(可选)，packaging:pom -->
<module>tool</module>
<!-- ws：存放第三方webservice的wsdl文件(可选)，packaging:pom -->
<module>ws</module>
<!-- view：前端工程目录(可选)，packaging:jar -->
<module>view</module>
<!-- start：工程主目录(必选*)，packaging:jar -->
<module>start</module>
```
