<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>构建API服务</h1>
				<small>RESTEasy&Feign</small>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-md-6">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">RESTFul获取自身Json信息</h3>
								<p><small>用ajax调用本地rest接口示例，请求地址：/demo1/service/rs/v1/softwareService/test/这是我的参数</small></p>
							</div>
							<div class="box-body">
								<div class="form-group">
									<button onclick="getApiJson()" class="btn btn-primary">getJson</button>
								</div>
								<div class="form-group" id="api_json_res"></div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">RESTFul获取自身Json信息</h3>
								<p><small>用ajax调用本地rest接口示例，请求地址：/demo1/service/rs/v1/softwareService/list</small></p>
							</div>
							<div class="box-body">
								<div class="form-group">
									<button onclick="getApiList()" class="btn btn-primary">getList</button>
								</div>
								<div class="form-group" id="api_json_res2"></div>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">基于JAX-RS规范的RESTFul接口发布</h3>
								<small></small>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>
							<div class="box-body" id="readme1"></div>
							<textarea id="md1" style="display: none">
								<#include "/markdown/rest-api-readme.md"/>
							</textarea>
						</div>
					</div>
				</div>
			</section>

		</div>

		<#include "/global/footer.ftl"/>
	</div>

	<#include "/global/foot-script.ftl"/>
	<script type="text/javascript">
		$(".sidebar-menu>li.active").removeClass('active');
		$("#rest_api").addClass('active');
		$("#resteasy").addClass('active');
		markdownToHtml(document.getElementById('md1').value, document.getElementById('readme1'),function(html) {
			$("#readme1").find("a").attr('target','_blank');
		});
		
		$(function() {
			'use strict';
			
			/* 设置csrf头 */
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader(header, token);
			});

		});

		function getApiJson() {
			$.ajax({
				url : '/demo1/service/rs/v1/softwareService/test/这是我的参数',
				type : 'GET', //GET
				timeout : 5000, //超时时间
				success : function(data, textStatus, jqXHR) {
					$("#api_json_res").html('<label>ajax结果</label><p class="help-block">'+data
							+'</p><button onclick="clearApiJson()" class="btn btn-primary">清除</button>');
					console.log(data);
					console.log(textStatus);
					console.log(jqXHR);
				},
				error : function(xhr, textStatus) {
					$("#api_json_res").html('<label>ajax结果</label><p class="help-block">'+textStatus
							+'</p><button onclick="clearApiJson()" class="btn btn-primary">清除</button>');
					console.log('错误');
					console.log(xhr);
					console.log(textStatus);
				},
				complete : function() {
					console.log('结束');
				}
			})
		}
		
		function clearApiJson() {
			$("#api_json_res").html('');
		}
		
		function getApiList() {
			$.ajax({
				url : '/demo1/service/rs/v1/softwareService/list',
				type : 'GET', //GET
				timeout : 5000, //超时时间
				success : function(data, textStatus, jqXHR) {
					$("#api_json_res2").html('<label>ajax结果</label><p class="help-block">'+JSON.stringify(data)
							+'</p><button onclick="clearApiList()" class="btn btn-primary">清除</button>');
					console.log(JSON.stringify(data));
					console.log(textStatus);
					console.log(jqXHR);
				},
				error : function(xhr, textStatus) {
					$("#api_json_res2").html('<label>ajax结果</label><p class="help-block">'
							+'</p><button onclick="clearApiList()" class="btn btn-primary">清除</button>');
					console.log('错误');
					console.log(xhr);
					console.log(textStatus);
				},
				complete : function() {
					console.log('结束');
				}
			})
		}

		function clearApiList() {
			$("#api_json_res2").html('');
		}

	</script>
</body>
</html>
