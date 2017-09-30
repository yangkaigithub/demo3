<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>调用链分析</h1>
				<small>spring cloud</small>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">调用链分析</h3>
								<small>Demo2使用Feign调用Demo1的接口，并且使用Zipkin查看RPC调用链</small>
							</div>
							<div class="box-body" id="readme"></div>
							<textarea id="md" style="display: none">
								<#include "/markdown/rpc-tracing-readme.md"/>
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
		$("#rpc_tracing").addClass('active');
		markdownToHtml(document.getElementById('md').value, document.getElementById('readme'),function(html) {
			$("#readme").find("a").attr('target','_blank');
		});
	</script>
</body>
</html>
