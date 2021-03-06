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
					<h2 class="headline text-yellow">404</h2>

					<div class="error-content">
						<h3>
							<i class="fa fa-warning text-yellow"></i> Oops! Page not found.
						</h3>

						<p>
							We could not find the page you were looking for. Meanwhile, you
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