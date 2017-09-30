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
					<div class="col-md-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">封装了HTTPS的RESTFul接口发布和调用</h3>
								<small></small>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>
							<div class="box-body" id="readme3"></div>
							<textarea id="md3" style="display: none">
								<#include "/markdown/https-api-readme.md"/>
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
		$("#rest_https").addClass('active');
		markdownToHtml(document.getElementById('md3').value, document.getElementById('readme3'),function(html) {
			$("#readme3").find("a").attr('target','_blank');
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
		
	</script>
</body>
</html>
