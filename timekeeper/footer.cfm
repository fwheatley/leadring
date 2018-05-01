    <cfoutput>
    <!-- jQuery Version 1.11.0 -->
    <script src="#request.sSiteUrl#js/jquery-1.11.0.js"></script>
    <script src="#request.sSiteUrl#js/jquery-ui.min.js"></script>
	
    <!-- Bootstrap Core JavaScript -->
    <script src="#request.sSiteUrl#js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="#request.sSiteUrl#js/plugins/metisMenu/metisMenu.min.js"></script>
	</cfoutput>
	
	<cfif isdefined("variables.flot") AND variables.flot EQ "Y">
		<cfoutput>
		<!-- Flot Charts JavaScript -->
	    <script src="#request.sSiteUrl#js/plugins/flot/excanvas.min.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/flot/jquery.flot.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/flot/jquery.flot.pie.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/flot/jquery.flot.resize.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/flot/jquery.flot.tooltip.min.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/flot/flot-data.js"></script>
	    </cfoutput>
	</cfif>

	<cfif isdefined("variables.index") AND variables.index EQ "Y">
    	<cfoutput>
    	<!-- Morris Charts JavaScript -->
    	<script src="#request.sSiteUrl#js/plugins/morris/raphael.min.js"></script>
    	<script src="#request.sSiteUrl#js/plugins/morris/morris.min.js"></script>
    	<script src="#request.sSiteUrl#js/plugins/morris/morris-data.js"></script>
    	</cfoutput>
	</cfif>
	
	<cfif isdefined("variables.morris") AND variables.morris EQ "Y">
		<cfoutput>
		<!-- Morris Charts JavaScript -->
	    <script src="#request.sSiteUrl#js/plugins/morris/raphael.min.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/morris/morris.min.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/morris/morris-data.js"></script>
	    </cfoutput>
	</cfif>

	<cfif isdefined("variables.tables") AND variables.tables EQ "Y">
	    <cfoutput>
	    <!-- DataTables JavaScript -->
	    <script src="#request.sSiteUrl#js/plugins/dataTables/jquery.dataTables.js"></script>
	    <script src="#request.sSiteUrl#js/plugins/dataTables/dataTables.bootstrap.js"></script>
		</cfoutput>
		
	    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
	    <script>
	    $(document).ready(function() {
	        $('#dataTables-example').dataTable();
	    });
	    </script>
	</cfif>
	
	<cfoutput>
    <!-- Custom Theme JavaScript -->
    <script src="#request.sSiteUrl#js/sb-admin-2.js"></script>
    </cfoutput>

	<!--- logout alerts --->
	<script>
	//Your timing variables in number of seconds
	//total length of session in seconds
	var sessionLength = 1500;  // 30min*60sec
	//time warning shown (10 = warning box shown 10 seconds before session starts)
	var warning = 60; 
	//time redirect forced (10 = redirect forced 10 seconds after session ends)    
	var forceRedirect = 60;
 
	$(document).ready(function() {
		//event to check session time left (times 1000 to convert seconds to milliseconds)
		checkSessionTimeEvent = setInterval("checkSessionTime(requestTime)",60*1000);
	});
 
	//event to check session time variable declaration
	var checkSessionTimeEvent = "";
 
	//time session started
	var requestTime = new Date();
 
	//initial set of number of seconds to count down from for countdown ticker (10,9,8,7...you get the idea)
	var countdownTime = warning;
	//create event to start/stop countdownTicker
	var countdownTickerEvent = "";
 
	//initially set to false. if true - warning dialog open; countdown underway
	var warningStarted = false;
 
	function checkSessionTime(reqTime) {
		//get time now
		var timeNow = new Date();
     
		//clear any countdownTickerEvents that may be running  
		clearInterval(countdownTickerEvent);
     
		//difference between time now and time session started variable declartion
		var timeDifference = 0;
     
		//session timeout length
		var timeoutLength = sessionLength*1000;
     
		//set time for first warning, ten seconds before session expires
		var warningTime = timeoutLength - (warning*1000);
     
		//force redirect to log in page length (session timeout plus 10 seconds)
		var forceRedirectLength = timeoutLength + (forceRedirect*1000);
     
		timeDifference = timeNow - reqTime;
 
		if (timeDifference > warningTime && warningStarted === false) {                  
			//reset number of seconds to count down from for countdown ticker
			countdownTime = warning;
     
			//call now for initial dialog box text (time left until session timeout)
			countdownTicker();
             
			//set as interval event to countdown seconds to session timeout
			countdownTickerEvent = setInterval("countdownTicker()", 1000);
             
			$('#dialogWarning').dialog('open');
			warningStarted = true;
		}
		else if (timeDifference > timeoutLength) {
			//close warning dialog box if open
			if ($('#dialogWarning').dialog('isOpen')) $('#dialogWarning').dialog('close');
             
			$('#dialogExpired').dialog('open');
		}
         
		if (timeDifference > forceRedirectLength) {   
			//clear (stop) checksession event
			clearInterval(checkSessionTimeEvent);
             
			//force relocation
			window.location="login.cfm?expired=true";
		}
	}

	//The countdownTicker function provides a countdown inside the warning dialog box to prompt the user to act now. It uses a timer that fires every second for a 5,4,3,2,1 effect inside the dialog box.
	function countdownTicker() {
		//put countdown time left in dialog box
		$("span#dialogText-warning").html(countdownTime);
     
		//decrement countdownTime
		countdownTime--;
	}

	$(function(){             
		// jQuery UI Dialog   
		$('#dialogWarning').dialog({
			autoOpen: false,
			width: 400,
			modal: true,
			resizable: false,
			buttons: {
				"Restart Session": function() {
					//reset session on server
					$.post("restart_session.cfm");
	                     
					//reset the variables
					requestTime = new Date();
					warningStarted = false;
					countdownTime = warning;
	                     
					//clear current checkSessionTimeEvent and start a new one
					clearInterval(checkSessionTimeEvent);
					checkSessionTimeEvent = "";
					checkSessionTimeEvent = setInterval("checkSessionTime(requestTime)",10*1000);
	                     
					$('#dialogWarning').dialog('close');
				}
			}
		});
	         
		$('#dialogExpired').dialog({
			autoOpen: false,
			width: 400,
			modal: true,
			resizable: false,
			close: function() {
				window.location="login.cfm?expired=true";
			},
			buttons: {
				"Login": function() {
					window.location="login.cfm?expired=true";
				}
			}
		});
	});
		
	</script>
	
	<!--Dialog box contents-->
	<div id="dialogExpired" title="Session (Page) Expired!"><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 0 0;"></span> Your session has expired!<p id="dialogText-expired"></p></div>
 	<div id="dialogWarning" title="Session (Page) Expiring!"><p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 0 0;"></span> Your session will expire in <span id="dialogText-warning"></span> seconds!</div>

</body>

</html>