<aside class="main-sidebar" ng-controller="sideBarCtrl">
	<section class="sidebar">
		<div class="user-panel">
			<div class="pull-left image">
				<img src="dist/img/user4-128x128.jpg" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>公安事业部</p>
			</div>
		</div>
		<ul class="sidebar-menu">
			<li id="demo_intro">
				<a href="intro">
					<i class="fa fa-coffee"></i>
					<span>demo说明</span>
				</a>
			</li>
			
			<li id="overview">
				<a href="overview">
					<i class="fa fa-eye"></i>
					<span>基础包总览</span>
				</a>
			</li>
			
			<li id="web_api">
				<a href="web-api">
					<i class="fa fa-file-word-o"></i>
					<span>构建web页面工程</span>
				</a>
			</li>
			
			<li id="rest_api" class="treeview">
				<a href="#">
					<i class="fa fa-cloud"></i>
					<span>构建API服务</span>
					<span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span>
				</a>
				<ul class="treeview-menu menu-open" id="rest_api">
					<li id="resteasy">
						<a href="resteasy"><i class="fa fa-circle-o"></i>接口发布RESTEasy</a>
					</li>
            		<li id="feign_jaxrs" >
            			<a href="feign-jaxrs"><i class="fa fa-circle-o"></i>接口调用feign</a>
            		</li>
            		<li id="rest_https" >
            			<a href="rest-https"><i class="fa fa-circle-o"></i>RESTful HTTPS</a>
            		</li>
          		</ul>
			</li>
			
			<li id="rpc_tracing">
				<a href="rpc-tracing">
					<i class="fa fa-gears"></i>
					<span>调用链分析</span>
				</a>
			</li>
			
			<li id="waf">
				<a href="waf">
					<i class="fa fa-ban"></i>
					<span>WAF拦截器</span>
				</a>
			</li>
			
			<li id="exception">
				<a href="exception">
					<i class="fa fa-exclamation"></i>
					<span>异常拦截</span>
				</a>
			</li>
			
			<li id="validator">
				<a href="validator">
					<i class="fa fa-check"></i>
					<span>参数验证</span>
				</a>
			</li>
			
			<li id="operation_log">
				<a href="operation-log">
					<i class="fa fa-calendar"></i>
					<span>日志拦截</span>
				</a>
			</li>
			
			<li id="swagger">
				<a href="swagger-ui.html" target="_blank">
					<i class="fa fa-desktop"></i>
					<span>Swagger接口演示</span>
				</a>
			</li>
			<!-- 
			<li>
				<a href="http://localhost:8082/demo2" target="_blank">
					<i class="fa fa-plus-square-o"></i>
					<span>DEMO2</span>
				</a>
			</li> -->
			
			<li id="logout">
				<a href="logout-page"> 
					<i class="fa fa-arrow-left"></i>
					<span>单点登出</span>
				</a>
			</li>
			
			<li>
				<a href="http://10.6.130.127:8080/cas/logout">
					<i class="fa fa-arrow-left"></i>
					<span>cas登出</span>
				</a>
			</li>
		</ul>
	</section>
</aside>