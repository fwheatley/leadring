<cfinclude template="header.cfm">

<cfif not client.bLoggedIn or DateDiff("h", client.timeLoggedIn, now()) GT 12>
	<cflocation url="login.cfm?referrer=inbox.cfm" addtoken="true"> 
</cfif>

<script type="text/javascript">
$(document).ready(function() {
	$('input#filter-box').val('')

	$.ajax({
		url: 'grid.cfm', data: 'statusVal=all', success: function(result) {

			$('#grid').append(result);
			$("#orders").tablesorter({debug: false, widgets: ['zebra'], sortList: [[4,1]],
				headers: {0: {sorter: false},7: {sorter: false}}
			})
//			$("#orders").tablesorterFilter({filterContainer: "#filter-box",
//				filterClearContainer: "#filter-clear-button",
//				filterColumns: [1,2,3]
//			});
        }
	}); 

	$("input:radio[@name=status]").click(function() {
	    $('input#filter-box').val('')
		var statusValue = $(this).val();

		$.ajax({
			url: 'grid.cfm', data: 'statusVal='+statusValue, success: function(result) {
            	$("#grid").empty().append(result);
				$("#orders").tablesorter({debug: false, widgets: ['zebra'], sortList: [[4,1]],
					headers: {0: {sorter: false},7: {sorter: false}}
				})
//				$("#orders").tablesorterFilter({filterContainer: "#filter-box",
//					filterClearContainer: "#filter-clear-button",
//					filterColumns: [1,2,3]
//				});
            }
		});
	}); 
});
</script>

<cfmail to="frank@wheatley.net" from="error <donotreply@leadring.com>" subject="KY Title Inbox" type="html">
Inbox accessed
</cfmail>

<cfif structkeyexists(url,"approve")>
	<cfquery name="getOrdersById" datasource="kytitle">
	select * from orders where orderid=<cfqueryparam value="#url.approve#" cfsqltype="cf_sql_varchar">;
	</cfquery>

	<cfif not len(getOrdersById.approveddate)>
		<cfset approveDate = CreateDateTime(Year(Now()), Month(Now()), Day(Now()), Hour(Now()), Minute(Now()), Second(Now()))>
		
		<cfquery name="approveOrders" datasource="kytitle">
		update orders
		set approvedby = <cfqueryparam value="#client.user#" cfsqltype="cf_sql_varchar">,
		    approveddate = <cfqueryparam value="#approveDate#" cfsqltype="cf_sql_timestamp">
		where orderid=<cfqueryparam value="#url.approve#" cfsqltype="cf_sql_varchar">;
		</cfquery>
	</cfif>	
</cfif>

<cfif structkeyexists(url,"delete")>
	<cfquery name="deleteOrders" datasource="kytitle">
	delete from orders
	where orderid=<cfqueryparam value="#url.delete#" cfsqltype="cf_sql_varchar">;
	</cfquery>		
</cfif>

<div id="filter">
	<fieldset class="fieldset">
	<legend>Filter Orders</legend>
		<div id="filter1">
			<input type="radio" name="status" value="all">All Orders<br />
			<input type="radio" name="status" value="pending">Pending Orders<br />
			<input type="radio" name="status" value="completed">Completed Orders
		</div>
		<div id="filter2">
			Search: <input name="filter" id="filter-box" value="" maxlength="30" size="30" type="text">
			<input id="filter-clear-button" type="submit" value="Clear"/><br />
	      
		<!---	<input type="radio" name="method" value="electronic">Electronic Orders<br />
				<input type="radio" name="method" value="faxed">Faxed Orders<br />--->
		</div>
	</fieldset>

	<div id="grid"></div>
</div>



<cfinclude template="footer.cfm">
	
