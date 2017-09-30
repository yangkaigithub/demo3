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
								<h3 class="box-title">基于JAX-RS规范的RESTFul接口调用</h3>
								<small></small>
								<div class="box-tools pull-right">
									<button type="button" class="btn btn-box-tool"
										data-widget="collapse">
										<i class="fa fa-minus"></i>
									</button>
								</div>
							</div>
							<div class="box-body" id="readme2"></div>
							<textarea id="md2" style="display: none">
								<#include "/markdown/feign-api-readme.md"/>
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
		$("#feign_jaxrs").addClass('active');
		markdownToHtml(document.getElementById('md2').value, document.getElementById('readme2'),function(html) {
			$("#readme2").find("a").attr('target','_blank');
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
