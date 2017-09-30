<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>构建web页面工程 <small>用<a href="swagger-ui.html#/software-controller" target="_blank">Swagger UI </a>查看本工程具体的http请求和响应内容</small></h1>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-md-4">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">获取Json信息</h3>
								<p>
									<small>/demo1/business/getJson</small>
								</p>
							</div>
							<div class="box-body">
								<div class="form-group">
									<button onclick="getJson()" class="btn btn-primary">getJson</button>
								</div>
								<div class="form-group" id="json_res"></div>
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">获取软件列表信息</h3>
								<p>
									<small>/demo1/business/list</small>
								</p>
							</div>
							<div class="box-body">
								<div class="form-group">
									<button onclick="getDataList()" class="btn btn-primary">getList</button>
								</div>
								<div class="form-group" id="data_res"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">构建CSRF保护的WEB应用程序</h3>
								<small>Spring Security, CAS单点登录</small>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
								<!-- /.box-tools -->
							</div>
							<div class="box-body" id="readme"></div>
							<textarea id="md" style="display: none">
								<#include "/markdown/web-sso-readme.md"/>
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
		$("#web_api").addClass('active');
		markdownToHtml(document.getElementById('md').value, document.getElementById('readme'),function(html) {
			$("#readme").find("a").attr('target','_blank');
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

		function getJson() {
			$.ajax({
				url : '/demo1/business/getJson',
				type : 'GET', //GET
				timeout : 5000, //超时时间
				success : function(data, textStatus, jqXHR) {
					$('#json_res').html('<label>ajax结果</label><p class="help-block">'+data
							+'</p><button onclick="clearJson()" class="btn btn-primary">清除</button>');
					console.log(data);
					console.log(textStatus);
					console.log(jqXHR);
				},
				error : function(xhr, textStatus) {
					$('#json_res').html('<label>ajax结果</label><p class="help-block">'+textStatus
							+'</p><button onclick="clearJson()" class="btn btn-primary">清除</button>');
					console.log('错误');
					console.log(xhr);
					console.log(textStatus);
				},
				complete : function() {
					console.log('结束');
				}
			})
		}
		
		function clearJson(){
			$('#json_res').html('');
		}

		function getDataList() {
			$.ajax({
				url : '/demo1/business/list',
				type : 'GET', //GET
				timeout : 5000, //超时时间
				success : function(data, textStatus, jqXHR) {
					$("#data_res").html('<label>ajax结果</label><p class="help-block">'+jqXHR.responseText
							+'</p><button onclick="clearDataList()" class="btn btn-primary">清除</button>');
					console.log(data);
					console.log(textStatus);
					console.log(jqXHR);
				},
				error : function(xhr, textStatus) {
					$("#data_res").html('<label>ajax结果</label><p class="help-block">'+textStatus
							+'</p><button onclick="clearDataList()" class="btn btn-primary">清除</button>');
					console.log('错误');
					console.log(xhr);
					console.log(textStatus);
				},
				complete : function() {
					console.log('结束');
				}
			})
		}
		
		function clearDataList() {
			$("#data_res").html('');
		}

	</script>
</body>
</html>
