<cfinclude template="header.cfm" >

<style>
blockquote {
	font-size: 14px;
	}
</style>

<cfset qSprints = oTime.getSprints()>
	
	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<cfinclude template="topnav.cfm" >
		<cfset sCurrPage = 'sprints'>
		<cfinclude template="sidenav.cfm" >
		</nav>

		<!-- Page Content -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Team Sprints</h1>
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
										<cfloop query="qSprints">
										<cfset qStoriesSprint = oTime.getStoriesSprint(qSprints.generalid)>
										<div class="panel panel-default">
											<div class="panel-heading">
												<h4 class="panel-title">
												<a data-toggle="collapse" data-parent="#accordion" href="#collapse<cfoutput>#qSprints.currentRow#</cfoutput>"><cfoutput><b>#qSprints.name#</b> <i>(ID:#qSprints.generalid#)</i></cfoutput></a>
												</h4>
											</div>
											<div id="collapse<cfoutput>#qSprints.currentRow#</cfoutput>" class="panel-collapse collapse <cfif qSprints.currentRow EQ 1>in</cfif>">
												<div class="panel-body">
													<h4><cfoutput>#dateformat(qSprints.startdate, "MMM dd, YYYY")# - #dateformat(qSprints.enddate, "MMM dd, YYYY")#</cfoutput></h4>
													<blockquote>
														<b>Stories</b>
														<ul>
															<cfoutput query="qStoriesSprint">
																<li>#qStoriesSprint.name#</li>
															</cfoutput>
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


