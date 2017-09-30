<!DOCTYPE html>
<html>
<#include "/global/head-meta.ftl"/>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<#include "/global/header.ftl"/>
		<#include "/global/sidebar.ftl"/>

		<div class="content-wrapper">
			<!-- Main content -->
			<section class="content">
				<div class="error-page">
					<h2 class="headline text-red">500</h2>

					<div class="error-content">
						<h3>
							<i class="fa fa-warning text-red"></i> Oops! Something went wrong.
						</h3>
						<p>We will work on fixing that right away. Meanwhile, you may
							may <a href="intro">return to main page</a>
						</p>
					</div>
					<!-- /.error-content -->
				</div>
				<!-- /.error-page -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<#include "/global/footer.ftl"/>
	</div>
	<#include "/global/foot-script.ftl"/>
</body>
</html>