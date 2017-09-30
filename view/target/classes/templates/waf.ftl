<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>WAF拦截器
					<small>用<a href="swagger-ui.html#/waf-controller" target="_blank">Swagger UI </a>查看本模块具体的http请求和响应内容</small>
				</h1>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">统一WAF过滤器</h3>
								<small>对可预见的安全问题进行过滤</small>
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
								<#include "/markdown/waf-readme.md"/>
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
		$("#waf").addClass('active');
		markdownToHtml(document.getElementById('md').value, document.getElementById('readme'),function(html) {
			$("#readme").find("a").attr('target','_blank');
		});
	</script>
</body>
</html>
