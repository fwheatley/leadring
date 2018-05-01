<cfinclude template="header.cfm" >

<div id="wrapper">
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
 	<cfinclude template="topnav.cfm" >
	<cfset sCurrPage = 'index'>
	<cfinclude template="sidenav.cfm" >
	</nav>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Dashboard</h1>
			<!---<cfset qXXX = oTime.addUsers()>--->
			<cfset qXXX = oTime.addProjects()>
			<cfset qXXX = oTime.addEntities()>
			
			
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<cfset qUserEntityEffortWeek = oTime.getUserEntityEffortWeek(session.userid, now())>
		<div class="col-lg-3 col-md-6">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<div class="row">
						<div class="col-xs-3">
							<i class="fa fa-clock-o fa-5x"></i>
						</div>
						<div class="col-xs-9 text-right">
							<div class="huge"><cfoutput>#qUserEntityEffortWeek.weeklyEffort#</cfoutput></div>
							<div>Hours this week</div>
						</div>
					</div>
				</div>
				<a href="#">
					<div class="panel-footer">
						<span class="pull-left">View Details</span>
						<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
						<div class="clearfix"></div>
					</div>
				</a>
			</div>
		</div>
		
		<div class="col-lg-3 col-md-6">
			<div class="panel panel-green">
				<div class="panel-heading">
					<div class="row">
						<div class="col-xs-3">
							<i class="fa fa-legal fa-5x"></i>
						</div>
						<div class="col-xs-9 text-right">
							<div class="huge">13</div>
							<div>Time Tracking</div>
						</div>
					</div>
				</div>
				<a href="#">
					<div class="panel-footer">
						<span class="pull-left">View Details</span>
						<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
						<div class="clearfix"></div>
					</div>
				</a>
			</div>
		</div>
        
		<div class="col-lg-3 col-md-6">
			<div class="panel panel-yellow">
				<div class="panel-heading">
					<div class="row">
						<div class="col-xs-3">
							<i class="fa  fa-tasks fa-5x"></i>
						</div>
						<div class="col-xs-9 text-right">
							<div class="huge">124</div>
							<div>User Stories</div>
						</div>
					</div>
				</div>
				<a href="#">
					<div class="panel-footer">
						<span class="pull-left">View Details</span>
						<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
						<div class="clearfix"></div>
					</div>
				</a>
			</div>
		</div>
		<div class="col-lg-3 col-md-6">
			<div class="panel panel-red">
				<div class="panel-heading">
					<div class="row">
						<div class="col-xs-3">
							<i class="fa fa-home fa-5x"></i>
						</div>
						<div class="col-xs-9 text-right">
							<div class="huge">13</div>
							<div>Release</div>
						</div>
					</div>
				</div>
				<a href="#">
					<div class="panel-footer">
						<span class="pull-left">View Details</span>
						<span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
						<div class="clearfix"></div>
					</div>
				</a>
			</div>
		</div>
		
		
	</div>

	<cfif isdefined("url.uDate") and len(url.uDate)>
		<cfset dtDate = url.uDate>
	<cfelse>
		<cfset dtDate = now()>
	</cfif>
	<cfset dtFirstDate = oTime.getFirstDateOfWeek(dtDate)>
	<cfset qAllOutOfOffice = oTime.getAllOutOfOfficeStartDate(dtFirstDate)>

	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading" id="OoOCal">
					<i class="fa fa-bar-chart-o fa-fw"></i> Out of Office Calendar
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body OoOCal">
					<table class="table table-bordered table-hover" id="table-time">
						<thead>
							<tr>
								<cfloop from="1" to="7" index="i">
									<!--- lets add a day to start week on Monday --->
									<cfset d = i+1>
									<cfif d EQ 8><cfset d=1></cfif>
									<cfif listfind("2,3,4,5,6", d)>
										<td style="width:8%; text-align:center;vertical-align:top;">
											<cfoutput>
											<span style="font-weight:bold;font-size:14px;">#dayOfWeekAsString(d)#</span><br />
											</cfoutput>
										</td>
									</cfif>
								</cfloop>
							</tr>
						</thead>
	
						<tbody>
						<cfloop from="1" to="6" index="j">
							<tr>
								<cfloop from="1" to="7" index="i">
									<!--- lets add a day to start week on Monday --->
									<cfset d = i+1>
									<cfif d EQ 8><cfset d=1></cfif>
									<cfif listfind("2,3,4,5,6", d)>
										<td style="width:8%; text-align:left;vertical-align:top;">
											<cfoutput>
											<span style="font-weight:bold;font-size:14px;">#dateformat(dtFirstDate, "MMM DD")#</span><br />
											</cfoutput>
											<!---<hr style=" margin-bottom:5px;margin-top:5px;" />--->
											<cfquery name="qOOODaily" dbtype="query" >
											select * from qAllOutOfOffice where entitydate = '#dateformat(dtFirstDate, "yyyy/mm/dd")#'
											</cfquery>
											<cfif qOOODaily.recordCount EQ 0><br /></cfif>
											<cfoutput query="qOOODaily">
												<cfif qOOODaily.entityEffort>
													#qOOODaily.fname# #qOOODaily.lname# (#qOOODaily.entityEffort#)<br />
												</cfif>
											</cfoutput>
										</td>
									</cfif>
									<cfset dtFirstDate = dateAdd('d', 1, dtFirstDate)>
								</cfloop>
							</tr>
						</cfloop>
						</tbody>
					</table>					
				</div>
				<!-- /.panel-body -->
			</div>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->


	<!-- /.row -->
	<div class="row">
		<div class="col-lg-8">
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-bar-chart-o fa-fw"></i> Area Chart Example
					<div class="pull-right">
						<div class="btn-group">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
							Actions
							<span class="caret"></span>
							</button>
							<ul class="dropdown-menu pull-right" role="menu">
								<li><a href="#">Action</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li class="divider"></li>
								<li><a href="#">Separated link</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div id="morris-area-chart"></div>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-bar-chart-o fa-fw"></i> Bar Chart Example
					<div class="pull-right">
						<div class="btn-group">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
								Actions
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu pull-right" role="menu">
								<li><a href="#">Action</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li class="divider"></li>
								<li><a href="#">Separated link</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-4">
							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped">
									<thead>
										<tr>
											<th>#</th>
											<th>Date</th>
											<th>Time</th>
											<th>Amount</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>3326</td>
											<td>10/21/2013</td>
											<td>3:29 PM</td>
											<td>$321.33</td>
										</tr>
										<tr>
											<td>3325</td>
											<td>10/21/2013</td>
											<td>3:20 PM</td>
											<td>$234.34</td>
										</tr>
										<tr>
											<td>3324</td>
											<td>10/21/2013</td>
											<td>3:03 PM</td>
											<td>$724.17</td>
										</tr>
										<tr>
											<td>3323</td>
											<td>10/21/2013</td>
											<td>3:00 PM</td>
											<td>$23.71</td>
										</tr>
										<tr>
											<td>3322</td>
											<td>10/21/2013</td>
											<td>2:49 PM</td>
											<td>$8345.23</td>
										</tr>
										<tr>
											<td>3321</td>
											<td>10/21/2013</td>
											<td>2:23 PM</td>
											<td>$245.12</td>
										</tr>
										<tr>
											<td>3320</td>
											<td>10/21/2013</td>
											<td>2:15 PM</td>
											<td>$5663.54</td>
										</tr>
										<tr>
											<td>3319</td>
											<td>10/21/2013</td>
											<td>2:13 PM</td>
											<td>$943.45</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- /.col-lg-4 (nested) -->
						<div class="col-lg-8">
							<div id="morris-bar-chart"></div>
						</div>
						<!-- /.col-lg-8 (nested) -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-8 -->
        
		<div class="col-lg-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-bell fa-fw"></i> Login Activity
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="list-group">
						<div class="list-group-item">
							<i class="fa fa-sign-out fa-fw"></i> 
							<span class="pull-right text-muted small"><em></em></span>
						</div>
					</div>
				</div>
				<!-- /.panel-body -->
			</div>
			
			<!-- /.panel -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-bar-chart-o fa-fw"></i> Donut Chart Example
				</div>
				<div class="panel-body">
					<div id="morris-donut-chart"></div>
					<a href="#" class="btn btn-default btn-block">View Details</a>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
            
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i>
					Chat
					<div class="btn-group pull-right">
						<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
							<i class="fa fa-chevron-down"></i>
						</button>
						<ul class="dropdown-menu slidedown">
							<li>
								<a href="#">
									<i class="fa fa-refresh fa-fw"></i> Refresh
								</a>
							</li>
							<li>
								<a href="#">
									<i class="fa fa-check-circle fa-fw"></i> Available
								</a>
							</li>
							<li>
								<a href="#">
									<i class="fa fa-times fa-fw"></i> Busy
								</a>
							</li>
							<li>
								<a href="#">
									<i class="fa fa-clock-o fa-fw"></i> Away
								</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="#">
									<i class="fa fa-sign-out fa-fw"></i> Sign Out
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- /.panel-heading -->
                
				<div class="panel-body">
					<ul class="chat">
						<li class="left clearfix">
							<span class="chat-img pull-left">
								<img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />
							</span>
							<div class="chat-body clearfix">
								<div class="header">
									<strong class="primary-font">Jack Sparrow</strong> 
									<small class="pull-right text-muted">
										<i class="fa fa-clock-o fa-fw"></i> 12 mins ago
									</small>
								</div>
								<p>
									Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
								</p>
							</div>
						</li>
						<li class="right clearfix">
							<span class="chat-img pull-right">
								<img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar" class="img-circle" />
							</span>
							<div class="chat-body clearfix">
								<div class="header">
									<small class=" text-muted">
										<i class="fa fa-clock-o fa-fw"></i> 13 mins ago</small>
									<strong class="pull-right primary-font">Bhaumik Patel</strong>
								</div>
								<p>
									Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
								</p>
							</div>
						</li>
						<li class="left clearfix">
							<span class="chat-img pull-left">
								<img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />
							</span>
							<div class="chat-body clearfix">
								<div class="header">
									<strong class="primary-font">Jack Sparrow</strong> 
									<small class="pull-right text-muted">
										<i class="fa fa-clock-o fa-fw"></i> 14 mins ago
									</small>
								</div>
								<p>
									Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
								</p>
							</div>
						</li>
						<li class="right clearfix">
							<span class="chat-img pull-right">
								<img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar" class="img-circle" />
							</span>
							<div class="chat-body clearfix">
								<div class="header">
									<small class=" text-muted">
										<i class="fa fa-clock-o fa-fw"></i> 15 mins ago</small>
									<strong class="pull-right primary-font">Bhaumik Patel</strong>
								</div>
								<p>
									Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
								</p>
							</div>
						</li>
					</ul>
				</div>
				<!-- /.panel-body -->
				<div class="panel-footer">
					<div class="input-group">
						<input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
						<span class="input-group-btn">
							<button class="btn btn-warning btn-sm" id="btn-chat">
								Send
							</button>
						</span>
					</div>
				</div>
				<!-- /.panel-footer -->
			</div>
			<!-- /.panel .chat-panel -->
		</div>
		<!-- /.col-lg-4 -->
	</div>
	<!-- /.row -->

</div>
<!-- /#page-wrapper -->




</div>
<!-- /#wrapper -->

<cfset variables.index = "Y">
<cfinclude template="footer.cfm" >

<script>
$(document).ready( function () {

	$('#OoOCal').click(function(){
	    if($('.'+this.id+':visible').length) {
    	    $('.'+this.id).hide('slow');
    	}
    	else {
			$('.'+this.id).show('slow');
		}
	})


})

</script>