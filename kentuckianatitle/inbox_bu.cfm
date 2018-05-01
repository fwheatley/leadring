<cfparam name="form.product" default="0">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Kentuckiana Title Agency, LLC. - Louisville, KY</title>
<!---<link rel="stylesheet" type="text/css" href="app_style.css" />--->

<script src="http://www.leadring.com/jquery/jquery.min.js" type="text/javascript"></script>
<link href="default.css" rel="stylesheet" type="text/css" />

<script>
$(document).ready(function() {
	zebraRows('tr:odd td', 'odd');
	
	$('tbody tr').hover(function(){
	  $(this).find('td').addClass('hovered');
	}, function(){
	  $(this).find('td').removeClass('hovered');
	});
	
	//default each row to visible
	$('tbody tr').addClass('visible');
	
	//overrides CSS display:none property
	//so only users w/ JS will see the
	//filter box
	$('#search').show();
	
	$('#filter').keyup(function(event) {
		//if esc is pressed or nothing is entered
    if (event.keyCode == 27 || $(this).val() == '') {
			//if esc is pressed we want to clear the value of search box
			$(this).val('');
			
			//we want each row to be visible because if nothing
			//is entered then all rows are matched.
      $('tbody tr').removeClass('visible').show().addClass('visible');
    }

		//if there is text, lets filter
		else {
      filter('tbody tr', $(this).val());
    }

		//reapply zebra rows
		$('.visible td').removeClass('odd');
		zebraRows('.visible:even td', 'odd');
	});
	
	//grab all header rows
	$('thead th').each(function(column) {
		$(this).addClass('sortable')
					.click(function(){
						var findSortKey = function($cell) {
							return $cell.find('.sort-key').text().toUpperCase() + ' ' + $cell.text().toUpperCase();
						};
						
						var sortDirection = $(this).is('.sorted-asc') ? -1 : 1;
						
						//step back up the tree and get the rows with data
						//for sorting
						var $rows		= $(this).parent()
																.parent()
																.parent()
																.find('tbody tr')
																.get();
						
						//loop through all the rows and find 
						$.each($rows, function(index, row) {
							row.sortKey = findSortKey($(row).children('td').eq(column));
						});
						
						//compare and sort the rows alphabetically
						$rows.sort(function(a, b) {
							if (a.sortKey < b.sortKey) return -sortDirection;
							if (a.sortKey > b.sortKey) return sortDirection;
							return 0;
						});
						
						//add the rows in the correct order to the bottom of the table
						$.each($rows, function(index, row) {
							$('tbody').append(row);
							row.sortKey = null;
						});
						
						//identify the column sort order
						$('th').removeClass('sorted-asc sorted-desc');
						var $sortHead = $('th').filter(':nth-child(' + (column + 1) + ')');
						sortDirection == 1 ? $sortHead.addClass('sorted-asc') : $sortHead.addClass('sorted-desc');
						
						//identify the column to be sorted by
						$('td').removeClass('sorted')
									.filter(':nth-child(' + (column + 1) + ')')
									.addClass('sorted');
						
						$('.visible td').removeClass('odd');
						zebraRows('.visible:even td', 'odd');
					});
	});
});


//used to apply alternating row styles
function zebraRows(selector, className)
{
	$(selector).removeClass(className)
							.addClass(className);
}

//filter results based on query
function filter(selector, query) {
	query	=	$.trim(query); //trim white space
  query = query.replace(/ /gi, '|'); //add OR for regex
  
  $(selector).each(function() {
    ($(this).text().search(new RegExp(query, "i")) < 0) ? $(this).hide().removeClass('visible') : $(this).show().addClass('visible');
  });
}
</script>
</head>

<body>

<cfmail to="frank@wheatley.net" from="error <donotreply@leadring.com>" subject="KY Title Error" type="html" server="mail.frankwheatley.net" username="frank" password="flw387inxs">
Test
</cfmail>

<cfif structkeyexists(url,"approve")>
	<cfset sDocKey="kentuckianatitle"&day(now())>
	<cfset sOrderId=decrypt(url.approve,sDocKey)>
	<cfset approveDate = CreateDateTime(Year(Now()), Month(Now()), Day(Now()), Hour(Now()), Minute(Now()), Second(Now()))>
	
	<cfquery name="getOrdersById" datasource="kytitle">
	select * from orders where orderid=<cfqueryparam value="#sOrderId#" cfsqltype="cf_sql_varchar">;;
	</cfquery>

	<cfif not len(getOrdersById.approveddate)>
		<cfquery name="approveOrders" datasource="kytitle">
		update orders
		set approvedby = <cfqueryparam value="frank" cfsqltype="cf_sql_varchar">,
		    approveddate = <cfqueryparam value="#approveDate#" cfsqltype="cf_sql_timestamp">
		where orderid=<cfqueryparam value="#sOrderId#" cfsqltype="cf_sql_varchar">;
		</cfquery>
	</cfif>	
</cfif>

<cfif structkeyexists(url,"delete")>
	<cfset sDocKey="kentuckianatitle"&day(now())>
	<cfset sOrderId=decrypt(url.delete,sDocKey)>
	
	<cfquery name="deleteOrders" datasource="kytitle">
	delete from orders
	where orderid=<cfqueryparam value="#sOrderId#" cfsqltype="cf_sql_varchar">;
	</cfquery>		
</cfif>

<cfquery name="getOrders" datasource="kytitle">
select * from orders;
</cfquery>

<body>
<div id="header">
	<div id="logo">
		<h2>"Service is our Key to Success"</a></h2>
	</div>
</div>
<div id="header2">
	<div id="menu">
		<ul>
			<li id="first"><a href="http://www.kentuckianatitle.com/index.htm">Home</a></li>
			<li><a href="#">Open Orders</a></li>
			<li><a href="#">All Orders</a></li>
			<li><a href="#"></a></li>
			<li><a href="#"></a></li>			
		</ul>
	</div>
	<div id="splash"><a href="index.htm"><img src="images/kytitle.gif" alt="" width="560" height="200" /></a></div>
</div>
<hr />

<!---
orders
	(orderid,company,lender,originator,CPLstreet,CPLcity,CPLstate,CPLzip,CPLphone,CPLfax,b1ssn,b1last,b1first,b1middle,
	 b2ssn,b2last,b2first,b2middle,s1ssn,s1last,s1first,s1middle,s2ssn,s2last,s2first,s2middle,loanamt,purchprice,
	 street,city,state,zip,county,product,acctnumbers,subdate,approvedby,approveddate,email) 
--->

<div id="page">

	<fieldset class="fieldset">
	<legend>Filter Orders</legend>
		<div id="filter1">
			<input type="radio" name="status" value="all">All Orders<br />
			<input type="radio" name="status" value="pending">Pending Orders<br />
			<input type="radio" name="status" value="completed">Completed Orders
		</div>
		<div id="filter2">
			<label for="filter">Filter</label> <input type="text" name="filter" value="" id="filter" /><br />
      
			<input type="radio" name="method" value="electronic">Electronic Orders<br />
			<input type="radio" name="method" value="faxed">Faxed Orders<br />
		</div>
	</fieldset>
	<br />
	<table class="orders" cellpadding=0 cellspacing=0>
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
		<cfset sDocKey="kentuckianatitle"&day(now())>
		<cfset sOrderIdEnc=URLEncodedFormat(encrypt(getOrders.orderId,#sDocKey#))>
		<tr>
			<td><img src="images/print2.png" alt="Print Order" /></td>
			<td>#getOrders.company#</td>
			<td>#getOrders.lender#</td>
			<td>#getOrders.originator#</td>
			<td align=center>#dateformat(getOrders.subdate,"mm/dd/yyyy")# #timeformat(getOrders.subdate,"hh:mm:ss tt")#</td>
			<td>#getOrders.approvedby#</td>
			<td align=center>
				<cfif len(getOrders.approveddate)>
					#dateformat(getOrders.approveddate,"mm/dd/yyyy")# #timeformat(getOrders.approveddate,"hh:mm:ss tt")#</td>
				<cfelse>
					<a href="inbox.cfm?approve=#sOrderIdEnc#">approve</a>
				</cfif>					
			<td><a href="inbox.cfm?delete=#sOrderIdEnc#">delete</a></td>
		</tr>
		</cfoutput>
		</tbody>
	</table>

</div>	


</body>
</html>
	
