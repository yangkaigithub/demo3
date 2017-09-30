<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>异常拦截器</h1>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">统一（业务）异常拦截器</h3>
								<small>exception handler</small>
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
								<#include "/markdown/exception-interceptor-readme.md"/>
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
		$("#exception").addClass('active');
		markdownToHtml(document.getElementById('md').value, document.getElementById('readme'),function(html) {
			$("#readme").find("a").attr('target','_blank');
		});
	</script>
</body>
</html>
