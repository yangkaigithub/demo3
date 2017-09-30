# hik-ga-validator使用说明 


---

## 1. pom.xml依赖引入

	 <dependency>
	          <groupId>com.hikvision.ga.common</groupId>
	          <artifactId>hik-ga-validator</artifactId>
	          <version>1.0.0-SNAPSHOT</version>
	 </dependency>

## 2. AOP方式校验
 项目通过以下方式配置，将hik-ga-validator以拦截器的方式配置进来
 
	<?xml version="1.0" encoding="UTF-8"?>  
	  
	<beans xmlns="http://www.springframework.org/schema/beans"  
	         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
	         xmlns:aop="http://www.springframework.org/schema/aop"  
	         xmlns:tx="http://www.springframework.org/schema/tx"  
	         xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.0.xsd  
	           http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.0.xsd  
	           http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-2.0.xsd">  
	  
	    <bean id="validatorAdvice" class="com.hikvision.ga.common.validator.ValidatorAdvice" />  
	    <aop:config>  
	        <aop:aspect id="aspect" ref="validatorAdvice">  
	            <aop:pointcut id="pointUserMgr" expression="execution(* com.hik.ga.rest.*.*(..))"/>     
	            <aop:before method="doBefore"  pointcut-ref="pointUserMgr"/>  
	        </aop:aspect>  
	    </aop:config>  
	</beans> 

### 校验注解
1. 对方法参数是基本类型或String类型的验证
采用hibernate-validator的注解进行验证，在参数前面加上相应的注解即可验证。

2. 对方法参数是对象的验证
是否校验通过加`@GaValid`注解来标识。对需要校验方法加上注解`@GaValid`，或者方法对象参数上加上注解`@GaValid`。如果方法上加上注解`@GaValid`则对方法的所有对象参数都进行校验，不管方法对象参数有没有加注解`@GaValid`，如果方法没有加注解`@GaValid`，则只对加注解`@GaValid`的方法对象参数进行校验。

3. 对基本类型（包括String）的hibernate-validator原生验证注解要加在接口上，实现类上如果要加，一定要跟接口保持一致。
对对象的验证注解`@GaValid`则要加在实现类上。切点配置成接口或者实现类其中任意一个。
     
	public class SimpleRest {
		
		@GaValid
		@PostMapping("/mvc1/{id}")
	    public ModelAndView mvc1(@RequestBody  @GaValid SimpleEntity simpleEntity,@PathVariable @Max(value = 100, message = "不能大于100")    int id) {
			ModelAndView mav = new ModelAndView("index");
			return mav;
	    }
	}

另外，如果方法参数是对象，则需要对对象参数进行定义，如本类中的SimpleEntity,代码示例如下：

	public class SimpleEntity {
	
		@NotBlank(message="名字不能为空或者空串")
		@Length(min=2,max=10,message="名字必须由2~10个字组成")
		private String name;
		
		@Past(message="时间不能晚于当前时间")
		private Date date;
		
		@Email(message="邮箱格式不正确")
		private String email;
		
		@Pattern(regexp="(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{5,10}",message="密码必须是5~10位数字和字母的组合")
		private String password;
		
		@AssertTrue(message="字段必须为真")
		private boolean valid;
	
		@NotNull(message = "age不能为空")
		@Max(value = 100, message = "年龄不能大于100岁")
		private int age;
	}

## 3. 编程方式校验
 编程方式示例如下：

     // 对对象进行校验
     ValidationResult result1 = ValidationUtils.validateEntity(simpleEntity); 		
	 if(result1.isHasErrors()){
	    System.out.println(result1.getErrorMsg());
	 }
	 // 对对象某个参数进行校验
	 ValidationResult result2 = ValidationUtils.validateProperty(simpleEntity, "name");
	 if(result1.isHasErrors()){
	    System.out.println(result2.getErrorMsg());
	 }
	 // 对某个值是否符合验证的类的某一属性进行验证
	 ValidationResult result3 = ValidationUtils.validateValue(simpleEntity.getClass(), "age", 280);
	 if(result1.isHasErrors()){
	    System.out.println(result3.getErrorMsg());
	 }
	 // 对方法参数进行验证
	  ValidationResult Result4 = ValidationUtils.validateParameters(target, targetMethod, args);
	   if(result1.isHasErrors()){
	    System.out.println(result4.getErrorMsg());
	 }
