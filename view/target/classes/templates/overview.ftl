<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<section class="content-header">
				<h1>4.0基础包总览</h1>
				<small>参考：《iVMS-8200产品系列4.0总体架构设计说明书.docx》、《公安事业部技术体系-(2)开发篇-(3)安全开发规范.docx》、《公安事业部技术体系-(2)开发篇-(1)JAVA开发规范.docx》</small>
			</section>

			<section class="content">
				<div class="row">
        			<div class="col-md-12">
	                	<div class="panel box box-primary">
	                  		<div class="box-header with-border">
	                    		<h4 class="box-title"><a data-toggle="collapse" href="#collapseOne">4.0总体设计</a></h4>
	                  		</div>
	                  		<div id="collapseOne" class="panel-collapse collapse in">
	                    		<div class="box-body" id="readme1"></div>
								<textarea id="md1" style="display: none">
									<#include "/markdown/overview-framework-readme.md"/>
								</textarea>
		                  	</div>
                		</div>
	                	<div class="panel box box-primary">
	                  		<div class="box-header with-border">
	                    		<h4 class="box-title"><a data-toggle="collapse" href="#collapseTwo">基础包能力说明</a></h4>
	                  		</div>
	                  		<div id="collapseTwo" class="panel-collapse collapse in">
	                    		<div class="box-body" id="readme2"></div>
								<textarea id="md2" style="display: none">
									<#include "/markdown/overview-basic-readme.md"/>
								</textarea>
		                  	</div>
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
		$("#overview").addClass('active');
		markdownToHtml(document.getElementById('md1').value, document.getElementById('readme1'),function(html) {
			$("#readme1").find("a").attr('target','_blank');
			$("#readme1").find("img").css('max-width','100%');
		});
		markdownToHtml(document.getElementById('md2').value, document.getElementById('readme2'),function(html) {
			$("#readme2").find("a").attr('target','_blank');
			$("#readme2").find("img").css('max-width','100%');
		});
	</script>
</body>
</html>
