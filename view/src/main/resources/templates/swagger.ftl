<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>
<style type="text/css">

#iframe_wrapper{
	position: relative;
	height: 500px;
}

.swagger-iframe {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	height: 100%;
	/* padding: 0 10px 0 20px; */
	background-color: white;
}
</style>

<#include "/global/foot-script.ftl"/>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("ready");
		$(".sidebar-menu>li.active").removeClass('active');
		$("#swagger").addClass('active');
		createIframe("http://localhost:8081/demo1/swagger-ui.html");
	})

	function createIframe(isrc) {
		var iframe = document.createElement("iframe");
		iframe.src = isrc;
		iframe.className = "swagger-iframe";
		iframe.scrolling = "auto";
		iframe.frameborder = "0";
		iframe.onload = iframeOnload;
		document.getElementById("iframe_wrapper").appendChild(iframe);
	};

	function iframeOnload(event, obj) {
		var e = (event) ? event : window.event;
		if (window.event) {
			e.cancelBubble = true;// ie下阻止冒泡  
		} else {
			//e.preventDefault();  
			e.stopPropagation();// 其它浏览器下阻止冒泡  
		}
		console.log("iframe ready");
		window.iframeWindow = e.target.contentWindow;
		/* 为swagger中的请求设置csrf头 */
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var SwaggerClient = window.iframeWindow.SwaggerClient;
		var tokenHeader = new SwaggerClient.ApiKeyAuthorization(header, token,"header");
		var interval = self.setInterval(function(){
			console.log('swaggerUi is NOT ready...');
			if(!!window.iframeWindow.swaggerUi && !!window.iframeWindow.swaggerUi.api){
				console.log('swaggerUi is ready');
				window.iframeWindow.swaggerUi.api.clientAuthorizations.add(header, tokenHeader);
				window.clearInterval(interval);
			}
		},100);
	}
	
</script>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper" id="iframe_wrapper"></div>

		<#include "/global/footer.ftl"/>
	</div>

</body>
</html>
