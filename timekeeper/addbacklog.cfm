<cfinclude template="header.cfm" >

<style>
blockquote {
	font-size: 14px;
	}
</style>

<cfset qSprints = oTime.getSprints()>
<cfset qTPProjects = oTime.getTPProjects()>
	
	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<cfinclude template="topnav.cfm" >
		<cfset sCurrPage = 'addbacklog'>
		<cfinclude template="sidenav.cfm" >
		</nav>

		<!-- Page Content -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Add Backlog Stories</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			
			<div class="row">
				<div class="col-lg-12">

					<!---<cfdump var="#stories#" >--->
					
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<!---<div class="panel-heading"><h3>Team Sprints</h3></div>--->
								<div class="panel-body">
									<div class="panel-group" id="accordion">
									<cfloop query="qTPProjects">
										<!---<cfset qStoriesSprint = oTime.getStoriesSprint(qSprints.generalid)>--->
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion" href="#collapse<cfoutput>#qTPProjects.currentRow#</cfoutput>"><cfoutput><b>#qTPProjects.name#</b> <i>(ID:#qTPProjects.generalid#)</i></cfoutput></a>
												</h4>
											</div>
								
											<div id="collapse<cfoutput>#qTPProjects.currentRow#</cfoutput>" class="panel-collapse collapse <cfif qTPProjects.currentRow EQ 1>in</cfif>">
												<div class="panel-body">
													<h4><cfoutput>#dateformat(qTPProjects.createdate, "MMM dd, YYYY")#</cfoutput></h4>
													<blockquote>
														<b>Stories</b>
														<ul>
															<!---<cfoutput query="qStoriesSprint">
																<li>#qStoriesSprint.name#</li>
															</cfoutput>--->
														</ul>
													</blockquote>
												</div>
											</div>
										</div>
										</cfloop>										
										
									</div>
								</div>
								<!-- .panel-body -->
							</div>
						<!-- /.panel -->
						</div>
					<!-- /.col-lg-12 -->
					</div>

				</div>
			</div>
			
			
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->

<cfinclude template="footer.cfm" >


