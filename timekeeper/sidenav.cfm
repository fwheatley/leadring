<cfparam name="sCurrPage" default="">

<div class="navbar-default sidebar" role="navigation">
	<div class="sidebar-nav navbar-collapse">
		<ul class="nav" id="side-menu">
			<li>&nbsp;</li>

			<li>
				<a <cfif sCurrPage EQ "index">class="active"</cfif> href="index.cfm"><i class="fa fa-inbox fa-fw"></i> Home</a>
			</li>
			<li>
				<a <cfif sCurrPage EQ "time">class="active"</cfif> href="time.cfm"><i class="fa fa-inbox fa-fw"></i> Track My Time</a>
			</li>

			<li>
				<a <cfif sCurrPage EQ "addbacklog">class="active"</cfif> href="addbacklog.cfm"><i class="fa fa-files-o fa-fw"></i> Add Backlog Stories</a>
			</li>
<!---
			<li>
				<a href="#"><i class="fa fa-legal fa-fw"></i> Tasks<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li>
						<a href="tasks.cfm">Completed Tasks</a>
					</li>
					<li>
						<a href="tasks.cfm">To Do Tasks</a>
					</li>
				</ul>
				<!-- /.nav-second-level -->
			</li>--->
			<li>
				<a <cfif sCurrPage EQ "sprints">class="active"</cfif> href="sprints.cfm"><i class="fa fa-dashboard fa-fw"></i> Current Sprint</a>
			</li>
<!---			<li>
				<a href="tables.cfm"><i class="fa fa-tasks fa-fw"></i> Menu Item Y</a>
			</li>
			<li>
				<a href="forms.cfm"><i class="fa fa-home fa-fw"></i> Menu Item Z</a>
			</li>--->

			
			<li>&nbsp;</li>

<!---<cfif GetAuthUser() NEQ ""> 
    <cfoutput> 
    <form action="securitytest.cfm" method="Post"> 
    <input type="submit" Name="Logout" value="Logout"> 
    </form> 
    </cfoutput> 
</cfif>--->

			<li>
				<a <cfif sCurrPage EQ "login">class="active"</cfif> href="logout.cfm"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
			</li>
		</ul>
	</div>
	<!-- /.sidebar-collapse -->
</div>
<!-- /.navbar-static-side -->