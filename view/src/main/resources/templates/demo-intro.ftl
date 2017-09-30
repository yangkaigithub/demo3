<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>demo说明</h1>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">demo说明<small></small></h3>
							</div>
							<div class="box-body" id="readme"></div>
							<textarea id="md" style="display: none">
								<#include "/markdown/demo-readme.md"/>
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
		$("#demo_intro").addClass('active');
		markdownToHtml(document.getElementById('md').value, document.getElementById('readme'),function(html) {
			$("#readme").find("a").attr('target','_blank');
			$("#readme").find("img").css('max-width','100%');
		});
	</script>
</body>
</html>
