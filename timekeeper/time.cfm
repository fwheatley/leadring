<cfinclude template="header.cfm" >

<cfif isdefined("url.uDate") and len(url.uDate)>
	<cfset dtDate = url.uDate>
<cfelse>
	<cfset dtDate = now()>
</cfif>

<cfset dtFirstDate = oTime.getFirstDateOfWeek(dtDate)>

<cfset dtStartDate = dtFirstDate>
<cfset dtEndDate = dateAdd('d', 6, dtFirstDate)>

<cfset qStoriesDateSprint = oTime.getSprintsDates(dtStartDate, dtEndDate)>


	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<cfinclude template="topnav.cfm" >
		<cfset sCurrPage = 'time'>
		<cfinclude template="sidenav.cfm" >
		</nav>

		<!-- Page Content -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Weekly Time Entry</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel-body">

						<div class="table-responsive">
							<form action="#CGI.SCRIPT_NAME#" method="post" name="frmTime" enctype="x-www-form-encoded">
							<table class="table <!---table-striped---> table-bordered table-hover" id="table-time">

								<cfoutput>
								<thead>
								<tr>
									<td style="width:44%; text-align:center; vertical-align:middle;">
										<cfset mon = dateformat(dateAdd('d', -30, dtDate), "mm/dd/yyyy")>
										<a class="btn btn-info" href="#CGI.SCRIPT_NAME#?uDate=#mon#"><i class="fa fa-fast-backward"></i> Month</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<cfset dec = dateformat(dateAdd('d', -7, dtDate), "mm/dd/yyyy")>
										<a class="btn btn-success" href="#CGI.SCRIPT_NAME#?uDate=#dec#"><i class="fa fa-fast-backward"></i> Prev</a>
										&nbsp;&nbsp;
										<cfset now = dateformat(now(), "mm/dd/yyyy")>
										<a class="btn btn-primary" href="#CGI.SCRIPT_NAME#?uDate=#now#">Current</a>
										&nbsp;&nbsp;					
										<cfset inc = dateformat(dateAdd('d', 7, dtDate), "mm/dd/yyyy")>
										<a class="btn btn-success" href="#CGI.SCRIPT_NAME#?uDate=#inc#">Next <i class="fa fa-fast-forward"></i></a>
										
									</td>
									<cfloop from="1" to="7" index="i">
										<!--- lets add a day to start week on Monday --->
										<cfset d = i+1>
										<cfif d EQ 8><cfset d=1></cfif>
										<td style="width:8%; text-align:center; <cfif d EQ 7>border-left: 3px solid ##BEC1C4;</cfif>"><span style="font-weight:bold;font-size:11px;">#dayOfWeekAsString(d)#</span><br />#dateformat(dtFirstDate, "MMM DD")#</td>
										<cfset dtFirstDate = dateAdd('d', 1, dtFirstDate)>
									</cfloop>
								</tr>
								</thead>
								</cfoutput>
								
								<tbody>

								<!--- loop through static entities (meetings, out of office, production support)--->
								<cfset qEntitiesSprintUser = oTime.getEntitiesSprintUser(1, session.userid)>
								
								<cfif qEntitiesSprintUser.recordcount>
									<cfquery name="qEntitiesSprintUserEffort" datasource="timetracking">
									SELECT userID, entityID, timeData, entityDate, entityEffort 
									FROM [timetracking].[dbo].[UserEntityTime]
									WHERE entityID in (#QuotedValueList(qEntitiesSprintUser.entityID)#)
									  AND userID = #session.userid#;
									</cfquery>
								</cfif>
								
								<cfloop query="qEntitiesSprintUser">
									<cfset dtLoopDate = dtStartDate>

									<tr class="
										<cfif qEntitiesSprintUser.entityID EQ qEntitiesSprintUser.storyID> rowheader<cfelse> <cfoutput>#qEntitiesSprintUser.storyID#</cfoutput></cfif>
 										<cfif qEntitiesSprintUser.projectID EQ 7> prodSupport7<!--- sales prodution support ---> 
										<cfelseif qEntitiesSprintUser.projectID EQ 8> prodSupport8<!--- finance prodution support --->
										<cfelseif qEntitiesSprintUser.projectID EQ 9> prodSupport9<!--- operations prodution support --->
										<cfelseif qEntitiesSprintUser.projectID EQ 10> prodSupport10<!--- IT prodution support --->
 										<cfelseif qEntitiesSprintUser.projectID EQ 11> prodSupport11<!--- marketing prodution support --->
 										<cfelseif qEntitiesSprintUser.projectID EQ 12> prodSupport12<!--- business development prodution support --->
 										<cfelseif qEntitiesSprintUser.projectID EQ 13> prodSupport13<!--- executive/other prodution support --->
 										</cfif>
									">
										<td style="width:45%;" >
											<cfoutput>
											<cfif qEntitiesSprintUser.entityID EQ qEntitiesSprintUser.storyID>
												<cfset nChars = 45>
												<b class="storyhead" id="<cfoutput>#qEntitiesSprintUser.entityID#</cfoutput>">#left(qEntitiesSprintUser.name, nChars)#</b> <span>[+]</span>
												<cfif qEntitiesSprintUser.entityID EQ 3>
													<cfset qUserProdPref = oTime.getUserProdPref(session.userid)>
													<cfloop query="qUserProdPref" >
														&nbsp; <input type="checkbox" class="prodFilter" name="prodSupport#qUserProdPref.projectID#" id="prodSupport#qUserProdPref.projectID#" value="" <cfif qUserProdPref.selected>checked="checked"</cfif> tabindex="-1" />
														<cfif qUserProdPref.projectID EQ 7>Sales
														<cfelseif qUserProdPref.projectID EQ 8>Fin
														<cfelseif qUserProdPref.projectID EQ 9>Ops
														<cfelseif qUserProdPref.projectID EQ 10>IT
														<cfelseif qUserProdPref.projectID EQ 11>Mktg
														<cfelseif qUserProdPref.projectID EQ 12>BD
														<cfelseif qUserProdPref.projectID EQ 13>Exec
														</cfif>
													</cfloop> 
												</cfif>
											<cfelse>
												<cfset nChars = 50>
												&nbsp;&nbsp;
												#left(qEntitiesSprintUser.name, nChars)#
											</cfif>
											<cfif len(qEntitiesSprintUser.name) GT nChars>
											<button type="button" class="btn btn-default btn-xs"  data-container="body" data-toggle="popover" data-placement="right" data-content="#qEntitiesSprintUser.name#">more...</button>
											</cfif>
											</cfoutput>
										</td>
										<cfloop from="1" to="7" index="i">
											<cfset sInputName = dateformat(dtLoopDate, "yyyymmdd")&"-"&qEntitiesSprintUser.entityID>
											<cfquery name="qEntitiesEffort" dbtype="query" >
											select entityEffort from qEntitiesSprintUserEffort where timeData = '#sInputName#'
											</cfquery>
											
											<td <cfif qEntitiesSprintUser.entityID NEQ qEntitiesSprintUser.storyID>class="timedata"</cfif> style="<cfif i EQ 6>border-left: 3px solid #BEC1C4;</cfif>">
												<cfif qEntitiesSprintUser.entityID NEQ qEntitiesSprintUser.storyID>
													<cfoutput><input class="entityTime" name="#sInputName#" id="#sInputName#" value="#qEntitiesEffort.entityEffort#" size="3"
																	data-toggle="tooltip" data-trigger="manual" data-container="body" data-placement="right" data-title="weekly total" ></cfoutput>
												</cfif>	
											</td>
											<cfset dtLoopDate = dateAdd('d', 1, dtLoopDate)>
										</cfloop>
									</tr>
								</cfloop>
								<!--- end - loop through static entities --->

								<!--- loop through stories in current sprint(s) --->
								<cfset qEntitiesSprintUser2 = QueryNew("projectID, entityID, name, storyID, typeID, userID")>
								<cfloop query="qStoriesDateSprint" >
									<cfset qEntitiesSprintUser = oTime.getEntitiesSprintUser(qStoriesDateSprint.GeneralID, session.userid)>

									<cfloop query="qEntitiesSprintUser">
										<cfset rsRow = QueryAddRow(qEntitiesSprintUser2)>
										<cfset rsRow = QuerySetCell(qEntitiesSprintUser2, "projectID", qEntitiesSprintUser.projectID)>
										<cfset rsRow = QuerySetCell(qEntitiesSprintUser2, "entityID", qEntitiesSprintUser.entityID)>
										<cfset rsRow = QuerySetCell(qEntitiesSprintUser2, "name", qEntitiesSprintUser.name)>
										<cfset rsRow = QuerySetCell(qEntitiesSprintUser2, "storyID", qEntitiesSprintUser.storyID)>
										<cfset rsRow = QuerySetCell(qEntitiesSprintUser2, "typeID", qEntitiesSprintUser.typeID)>
										<cfset rsRow = QuerySetCell(qEntitiesSprintUser2, "userID", qEntitiesSprintUser.userID)>		
									</cfloop>
								</cfloop>
								<cfquery name="qEntitiesSprintUser" dbtype="query">
								select distinct * from qEntitiesSprintUser2 ORDER BY projectID, storyID, typeID, entityID ;
								</cfquery>
								
								<cfif qEntitiesSprintUser.recordcount>									
									<cfquery name="qEntitiesSprintUserEffort" datasource="timetracking">
									SELECT userID, entityID, timeData, entityDate, entityEffort 
									FROM [timetracking].[dbo].[UserEntityTime]
									WHERE entityID in (#QuotedValueList(qEntitiesSprintUser.entityID)#)
									  AND userID = #session.userid#;
									</cfquery>
								</cfif>
									
								<cfloop query="qEntitiesSprintUser">
									<cfset dtLoopDate = dtStartDate>

									<tr <cfif qEntitiesSprintUser.typeID EQ 0>class="projectheader" <cfelseif qEntitiesSprintUser.typeID EQ 1>class="storyheader <cfoutput>#qEntitiesSprintUser.projectID#</cfoutput>" <cfelse>class="<cfoutput>#qEntitiesSprintUser.storyID# #qEntitiesSprintUser.projectID#</cfoutput>"</cfif>>
										<td style="width:45%;" >
											<cfoutput>
											<cfif qEntitiesSprintUser.typeID EQ 0>
												<cfset nChars = 45>
												<span class="sprintsub project">Project: ###entityID#</span>&nbsp;
												<b class="projecthead" id="<cfoutput>#qEntitiesSprintUser.entityID#</cfoutput>">#left(qEntitiesSprintUser.name, nChars)#</b><span></span>
											<cfelseif qEntitiesSprintUser.typeID EQ 1>
												<cfset nChars = 45>
												&nbsp;&nbsp;<span class="sprintsub userstory">US: ###entityID#</span>&nbsp;
												<b class="storyhead" id="<cfoutput>#qEntitiesSprintUser.entityID#</cfoutput>">#left(qEntitiesSprintUser.name, nChars)#</b><span></span>
											<cfelseif qEntitiesSprintUser.typeID EQ 2>
												<cfset nChars = 50>
												&nbsp;&nbsp;&nbsp;&nbsp;<span class="sprintsub tasks">Task: ###entityID#</span>&nbsp;
												#left(qEntitiesSprintUser.name, nChars)#
											<cfelse>
												<cfset nChars = 50>
												&nbsp;&nbsp;&nbsp;&nbsp;<span class="sprintsub bugs">Bug: ###entityID#</span>&nbsp;
												#left(qEntitiesSprintUser.name, nChars)#
											</cfif>
											<cfif len(qEntitiesSprintUser.name) GT nChars>
											<button type="button" class="btn btn-default btn-xs" data-container="body" data-toggle="popover" data-placement="right" data-content="#replace(qEntitiesSprintUser.name,'"',"'","All")#">more...</button>
											</cfif>
											</cfoutput>
										</td>
										<cfloop from="1" to="7" index="i">
											<cfset sInputName = dateformat(dtLoopDate, "yyyymmdd")&"-"&qEntitiesSprintUser.entityID>
											<cfquery name="qEntitiesEffort" dbtype="query" >
											select entityEffort from qEntitiesSprintUserEffort where timeData = '#sInputName#'
											</cfquery>
											
											<td class="timedata" style="<cfif i EQ 6>border-left: 3px solid #BEC1C4;</cfif>">
												<cfoutput><input class="entityTime numbersOnly" name="#sInputName#" id="#sInputName#" value="#qEntitiesEffort.entityEffort#" size="3"  
																data-toggle="tooltip" data-trigger="manual" data-container="body" data-placement="right" data-title="weekly total"></cfoutput>	
											</td>
											<cfset dtLoopDate = dateAdd('d', 1, dtLoopDate)>
										</cfloop>
									</tr>
								</cfloop>

								<!--- show list of projects not in current sprint(s) --->
								<cfquery name="qProjectsInSprint" dbtype="query">
								select * from qEntitiesSprintUser where typeID=0	
								</cfquery>

								<cfquery name="qProjectsNotInSprint" datasource="timetracking">
								SELECT a.projectID, a.name, a.createDate, a.deleteDate, a.endDate, a.isActive, b.sprintID, b.typeID
								FROM [timetracking].[dbo].[Project] a, [timetracking].[dbo].[Entity] b
								WHERE a.projectID = b.projectID
								  and b.sprintID = 2
								  <cfif qProjectsInSprint.recordcount>
								  and a.projectID not in (#QuotedValueList(qProjectsInSprint.projectID)#)
								  </cfif>
								  <!---and a.createDate <= '#dateformat(dtStartDate, "yyyy/mm/dd")#'--->
								  and ISNULL(a.endDate,'#dateformat(dtEndDate, "yyyy/mm/dd")#') >= '#dateformat(dtEndDate, "yyyy/mm/dd")#'
								  and ISNULL(a.deleteDate,'#dateformat(dtEndDate, "yyyy/mm/dd")#') >= '#dateformat(dtEndDate, "yyyy/mm/dd")#'
								  <!---and a.isActive = <cfqueryparam value="#strLocal.qTPproject.IsActive#" cfsqltype="cf_sql_bit" >---> 
								</cfquery>
								
								<tr class="rowheader ">
									<td style="width:45%;">
										<b id="0" class="storyhead">Projects</b><span>[+]</span>
									</td>
									<td style=""> </td>
									<td style=""> </td>
									<td style=""> </td>
									<td style=""> </td>
									<td style=""> </td>
									<td style="border-left: 3px solid rgb(190, 193, 196);"> </td>
									<td style=""> </td>
								</tr>
								
								<cfif qProjectsNotInSprint.recordcount>
									<cfquery name="qEntitiesSprintUserEffort" datasource="timetracking">
									SELECT userID, entityID, timeData, entityDate, entityEffort 
									FROM [timetracking].[dbo].[UserEntityTime]
									WHERE entityID in (#QuotedValueList(qProjectsNotInSprint.projectID)#)
									  AND userID = #session.userid#;
									</cfquery>
								</cfif>
																
								<cfloop query="qProjectsNotInSprint" >
									<cfset dtLoopDate = dtStartDate>
									<tr class="<cfoutput>#qProjectsNotInSprint.typeID#</cfoutput>">
										<td style="width:45%;" >
											<cfoutput>
											<cfset nChars = 50>
											&nbsp;&nbsp;
											#left(qProjectsNotInSprint.name, nChars)#
								
											<cfif len(qProjectsNotInSprint.name) GT nChars>
												<button type="button" class="btn btn-default btn-xs"  data-container="body" data-toggle="popover" data-placement="right" data-content="#qProjectsNotInSprint.name#">more...</button>
											</cfif>
											</cfoutput>
										</td>
										<cfloop from="1" to="7" index="i">
											<cfset sInputName = dateformat(dtLoopDate, "yyyymmdd")&"-"&qProjectsNotInSprint.projectID>
											<cfquery name="qEntitiesEffort" dbtype="query" >
												select entityEffort from qEntitiesSprintUserEffort where timeData = '#sInputName#'
											</cfquery>
											<td class="timedata" style="<cfif i EQ 6>border-left: 3px solid #BEC1C4;</cfif>">
												<cfoutput>
												<input class="entityTime" name="#sInputName#" id="#sInputName#" value="#qEntitiesEffort.entityEffort#" size="3"
															data-toggle="tooltip" data-trigger="manual" data-container="body" data-placement="right" data-title="weekly total" ></cfoutput>
											</td>
											<cfset dtLoopDate = dateAdd('d', 1, dtLoopDate)>
										</cfloop>
									</tr>
								</cfloop>
								
								</tbody>
								<tfoot>
									<cfset qUserEntityEffortWeek = oTime.getUserEntityEffortWeek(session.userid, dtStartDate)>
									<td style="text-align:center;vertical-align: middle;"><b>Total Weekly Hours: <span id="weeklyEffort"><cfoutput>#qUserEntityEffortWeek.weeklyEffort#</cfoutput></span></b></td>
									<cfset dtLoopDate = dtStartDate>
									<cfloop from="1" to="7" index="i">
										<cfset d = i+1>
										<cfif d EQ 8><cfset d=1></cfif>
							
										<cfoutput>
										<cfset sInputName = ucase(dateformat(dtLoopDate, "DDD"))>
										<cfset qUserDailyTime = oTime.getUserEntityEffortDate(session.userid, dtLoopDate)>

										<td style="width:8%; text-align:center; <cfif i EQ 6>border-left: 3px solid ##BEC1C4;</cfif>">
											<input name="#sInputName#" id="#sInputName#" value="#qUserDailyTime.dailyEffort#" size="3" disabled="disabled" style="text-align:right;"  ><br />
											<span style="font-weight:bold;font-size:11px;">#dayOfWeekAsString(d)#</span><br />#dateformat(dtLoopDate, "MMM DD")#	
										</td>
										<cfset dtLoopDate = dateAdd('d', 1, dtLoopDate)>
										</cfoutput>
									</cfloop>
								</tfoot>
							</table>

							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /#wrapper -->

<cfset variables.tables = "Y">

<cfinclude template="footer.cfm" >

<script>
$(document).ready( function () {

	/* hide Meetings, Out of Office, Production Support and Projects */
	$('.1').hide().next("span").text(" [+]");
	$('.2').hide().next("span").text(" [+]");
	$('.3').hide().next("span").text(" [+]");	
	$('.0').hide().next("span").text(" [+]");
	
	$('.numbersOnly').keyup(function () {
	    if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
	       this.value = this.value.replace(/[^0-9\.]/g, '');
	    }
	});

	// change tab order to vertical
	$('tr').each(function() {
		$(this).find('td').each(function(i) {
			$(this).find('input').attr('tabindex', i+1);
		});
	});

	$('.entityTime').change(function() {
		var sTimeData = this.id; 
		var nHours = $("#"+sTimeData).val();
		if ( !nHours.length ) { nHours = 0; }
		$.getJSON('com/timekeeper.cfc?method=addUserEntityTime&userid='+<cfoutput>#session.userid#</cfoutput>+'&timedata='+ sTimeData+'&entityEffort='+nHours +'&ReturnFormat=json&queryformat=column', function(res,code) {
			if(res.ROWCOUNT == 1) {
				$('#'+res.DATA.DOW[0]).val(res.DATA.DAILYEFFORT[0]);
				
				var newTitle = "daily total: "+res.DATA.DAILYEFFORT[0];
				$("#"+sTimeData)
					.attr('data-original-title', newTitle)
					.tooltip('fixTitle')
					.tooltip('show');
					
				setTimeout(function() { $('.entityTime').tooltip('hide'); }, 1500);
				$.post("restart_session.cfm");
				requestTime = new Date();
			}
			else {
				alert('n');
			}

			$.getJSON('com/timekeeper.cfc?method=getUserEntityEffortWeek&userid='+<cfoutput>#session.userid#</cfoutput>+'&entityDate=<cfoutput>#dateformat(dtStartDate,"mm/dd/yyyy")#</cfoutput>'+'&ReturnFormat=json&queryformat=column', function(res2,code) {
				if(res2.ROWCOUNT == 1) {
					$('#weeklyEffort').html(res2.DATA.WEEKLYEFFORT[0]);
				}
			},"json");

		},"json");

	}); 

	$('.projecthead').click(function(){
	    if($('.'+this.id+':visible').length) {

    	    $('.'+this.id).hide('slow');
    	    $(this).next("span").text(" [+]");
    	}
    	else {

			$('.'+this.id).show('slow');
			$(this).next("span").text("");
		}
	})
	
	$('.storyhead').click(function(){
	    if($('.'+this.id+':visible').length) {
    	    $('.'+this.id).hide('slow');
    	    $(this).next("span").text(" [+]");
    	}
    	else {
			$('.'+this.id).show('slow');
			
			// show prod sub categories depending on checkboxes
			if ( this.id == 3 ) {
				if ($("#prodSupport7").is(":checked")) { $('.prodSupport7').show();	} else { $('.prodSupport7').hide(); }
				if ($("#prodSupport8").is(":checked")) { $('.prodSupport8').show();	} else { $('.prodSupport8').hide(); }
				if ($("#prodSupport9").is(":checked")) { $('.prodSupport9').show();	} else { $('.prodSupport9').hide(); }
				if ($("#prodSupport10").is(":checked")) { $('.prodSupport10').show();	} else { $('.prodSupport10').hide(); }
				if ($("#prodSupport11").is(":checked")) { $('.prodSupport11').show();	} else { $('.prodSupport11').hide(); }
				if ($("#prodSupport12").is(":checked")) { $('.prodSupport12').show();	} else { $('.prodSupport12').hide(); }
				if ($("#prodSupport13").is(":checked")) { $('.prodSupport13').show();	} else { $('.prodSupport13').hide(); }
			}
			$(this).next("span").text("");
		}
	})

	$('.prodFilter').click(function() {
		if (this.checked) {
			if ( $('.3').is(":visible") ) {
				$('.'+this.id).show('slow');
			}
			var bChecked = true;			
		} 
		else {
			$('.'+this.id).hide('slow');
			var bChecked = false;			
		}
		var nProj = this.id.substring(11);

		$.ajax({ 
			type: 'post', 
			url: 'com/timekeeper.cfc?method=updateUserProdPref',
			data: { userid: <cfoutput>#session.userid#</cfoutput>, projectid: nProj, selected: bChecked }, 
			dataType: 'json'     
		});
	}); 


    <!-- Page-Level Demo Scripts - Notifications - Use for reference -->
    // tooltip demo
    $('.tooltip-demo').tooltip({
        selector: "[data-toggle=tooltip]",
        container: "body"
    })

    // popover demo
    $("[data-toggle=popover]")
        .popover()

	// column highlighting
	$('.timedata').mouseover(function () {
	    $(this).siblings().css('background-color', '#D5DBF2');
	    var ind = $(this).index();
	    $('td:nth-child(' + (ind + 1) + ')').css('background-color', '#D5DBF2');
	});
	$('.timedata').mouseleave(function () {
	    $(this).siblings().css('background-color', '');
	    var ind = $(this).index();
	    $('td:nth-child(' + (ind + 1) + ')').css('background-color', '');
	});

})

</script>
	

