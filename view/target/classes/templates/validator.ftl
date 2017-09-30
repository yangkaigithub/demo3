<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>参数验证<small>用<a href="swagger-ui.html#/validator-test-controller" target="_blank">Swagger UI </a>查看本工程具体的http请求和响应内容</small></h1>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-8">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">参数验证表单demo</h3>
							</div>
							<!-- /.box-header -->
            				<!-- form start -->	
							<form id="user_form" name="user" class="form-horizontal">
								<div class="box-body">
                					<div class="form-group">
                						<label class="col-sm-2 control-label">姓名</label>
                						<div class="col-sm-6">
	                						<input class="form-control" type="text" name="userId" placeholder="姓名"/>
                						</div>
                					</div>
                					<div class="form-group">
                						<label class="col-sm-2 control-label">密码</label>
                						<div class="col-sm-6">
                							<input class="form-control" type="password" name="password" placeholder="密码"/>
                						</div>
                					</div>
                					<div class="form-group">
                						<label class="col-sm-2 control-label">邮箱</label>
                						<div class="col-sm-6">
                							<input class="form-control" type="email" name="email" placeholder="邮箱"/>
                						</div>
                					</div>
                					<div class="form-group">
                						<label class="col-sm-2 control-label">手机号</label>
                						<div class="col-sm-6">
                							<input class="form-control" type="tel" name="phoneNo" placeholder="手机号"/>
                						</div>
                					</div>
								</div>
							</form>
							<div class="box-footer">
				            	<button onclick="postForm()" class="btn btn-primary">Submit</button>
				            </div>
						</div>
					</div>
				</div>
			</section>
			
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">参数验证拦截器</h3>
								<small>结合Hibernate-validator</small>
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
								<#include "/markdown/validator-readme.md"/>
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
		$("#validator").addClass('active');
		markdownToHtml(document.getElementById('md').value, document.getElementById('readme'),function(html) {
			/* $("#readme").find("a").attr('target','_blank'); */
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
		
		function postForm() {
			$.ajax({
				url : '/demo1/validate/postUser.do',
				type : 'POST',
				data: $('#user_form').serialize(),
				processData: false,
				success : function(data, textStatus, jqXHR) {
					console.log(data);
					console.log(textStatus);
					console.log(jqXHR);
				},
				error : function(xhr, textStatus) {
					console.log('错误');
					console.log(xhr);
					console.log(textStatus);
				},
				complete : function() {
					console.log('结束');
				}
			})
		}
		
	</script>
</body>
</html>
