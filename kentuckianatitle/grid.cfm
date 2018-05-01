<script type="text/javascript">
$(document).ready(function() {

	$(function() { 
	    // if the function argument is given to overlay, 
	    // it is assumed to be the onBeforeLoad event listener 
	    $("a[rel]").overlay({ 
	        expose: 'grey', 
	        effect: 'apple', 
	 
	        onBeforeLoad: function() { 
	            // grab wrapper element inside content 
	            var wrap = this.getContent().find(".contentWrap"); 
	 
	            // load the page specified in the trigger 
	            wrap.load(this.getTrigger().attr("href")); 
	        } 
	    }); 
	});				

});
</script>

<cfsetting showDebugOutput="false" />
<cfif not client.bLoggedIn>
	<cflocation url="login.cfm?referrer=inbox.cfm" addtoken="true"> 
</cfif>

<cfparam name="url.statusVal" default="all">

<cfquery name="getOrders" datasource="kytitle">
select * from orders 
<cfif url.statusVal EQ "pending">
where approveddate is null
<cfelseif url.statusVal EQ "completed">
where approveddate is not null
</cfif>
</cfquery>

<!---
orders
	(orderid,company,lender,originator,CPLstreet,CPLcity,CPLstate,CPLzip,CPLphone,CPLfax,b1ssn,b1last,b1first,b1middle,
	 b2ssn,b2last,b2first,b2middle,s1ssn,s1last,s1first,s1middle,s2ssn,s2last,s2first,s2middle,loanamt,purchprice,
	 street,city,state,zip,county,product,acctnumbers,subdate,approvedby,approveddate,email) 
--->

<table id="orders" cellpadding=0 cellspacing=1>
	<thead>
	<tr>
		<th></th>
		<th>Company</th>
		<th>Lender</th>
		<th>Originator</th>
		<th>Date Submitted</th>
		<th>Approved By</th>
		<th>Approval Date</th>
		<th></th>
	</tr>
	</thead>
	
	<tbody>
	<cfoutput query="getOrders">
	<tr>
		<td><a rel="##overlay" Title="Item Title" href="display.cfm?orderid=#getOrders.orderId#"><img src="images/print2.png" alt="Print Order" /></a></td>
		<td>#getOrders.company#</td>
		<td>#getOrders.lender#</td>
		<td>#getOrders.originator#</td>
		<td align=center>#dateformat(getOrders.subdate,"mm/dd/yyyy")# #timeformat(getOrders.subdate,"hh:mm:ss tt")#</td>
		<td>#getOrders.approvedby#</td>
		<td align=center>
			<cfif len(getOrders.approveddate)>
				#dateformat(getOrders.approveddate,"mm/dd/yyyy")# #timeformat(getOrders.approveddate,"hh:mm:ss tt")#</td>
			<cfelse>
				<a href="inbox.cfm?approve=#getOrders.orderId#">approve</a>
			</cfif>					
		<td><a href="inbox.cfm?delete=#getOrders.orderId#">delete</a></td>
	</tr>
	</cfoutput>
	</tbody>
</table>

<div class="overlay" id="overlay"> 
    <!-- the external content is loaded inside this tag --> 
    <div class="contentWrap"></div> 
</div>
