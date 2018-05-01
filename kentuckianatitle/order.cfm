<cfparam name="form.product" default="0">

<cfset bError = 0>

<cfif structkeyexists(form,"submit") or structkeyexists(form,"submit")>
	<cfif len(form.loanamt) EQ 0>
		<cfset form.loanamt = 0>
	</cfif>
	
	<cfif len(form.purchprice) EQ 0>
		<cfset form.purchprice = 0>
	</cfif>
	
	<cfif form.product EQ 1>
		<cfset form.productdesc = "First Mortgage Purchase">
	<cfelseif form.product EQ 2>
		<cfset form.productdesc = "First Mortgage Refinance">
	<cfelseif form.product EQ 3>
		<cfset form.productdesc = "Second Mortgage">
	<cfelseif form.product EQ 4>
		<cfset form.productdesc = "Property Search Only (No Title Insurance)">
	<cfelseif form.product EQ 5>
		<cfset form.productdesc = "Land Contract Refinance">
	<cfelse>
		<cfset form.productdesc = "">		
	</cfif>
	
	<cfset subdate = CreateDateTime(Year(Now()), Month(Now()), Day(Now()), Hour(Now()), Minute(Now()), Second(Now()))> 
	<cfset source = "Web">
	<cfset variables.orderid = createuuid()>
	
	<cftry>
	<cfquery name="insert_order" datasource="kytitle">
	insert into orders(orderid,company,lender,originator,CPLstreet,CPLcity,CPLstate,CPLzip,CPLphone,CPLfax,
						b1ssn,b1last,b1first,b1middle,b2ssn,b2last,b2first,b2middle,s1ssn,s1last,s1first,s1middle,
						s2ssn,s2last,s2first,s2middle,loanamt,purchprice,street,city,state,zip,county,product,acctnumbers,
						subdate,approvedby,approveddate,email,source)
	values(<cfqueryparam value="#variables.orderid#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.company#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.lender#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.originator#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.CPLstreet#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.CPLcity#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.CPLstate#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.CPLzip#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.CPLphone#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.CPLfax#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b1ssn#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b1last#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b1first#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b1middle#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b2ssn#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b2last#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b2first#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.b2middle#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s1ssn#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s1last#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s1first#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s1middle#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s2ssn#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s2last#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s2first#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.s2middle#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.loanamt#" cfsqltype="cf_sql_double">,
		   <cfqueryparam value="#form.purchprice#" cfsqltype="cf_sql_double">,
		   <cfqueryparam value="#form.street#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.zip#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.county#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.product#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#form.acctnumbers#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#subdate#" cfsqltype="cf_sql_timestamp">,
		   <cfqueryparam value="" cfsqltype="cf_sql_varchar" null="true" >,
		   <cfqueryparam value="" cfsqltype="cf_sql_varchar" null="true">,
		   <cfqueryparam value="" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#source#" cfsqltype="cf_sql_varchar">);
	</cfquery>
	<cfcatch type="any">
		<cfmail to="#request.sTechEmail#" from="error <admin@frankwheatley.net>" subject="KY Title Error" type="html">
			<cfoutput>
			Detail: #cfcatch.detail#<br /><br />
			Message: #cfcatch.message#<br /><br />			
			</cfoutput>
			<cfdump var="#form#">
		</cfmail>
		
		<cfset bError = 1>

	</cfcatch>
	</cftry>
</cfif>

<cfset variables.bShowMenu = 0>
<cfinclude template="header.cfm">

<div id="page">
	<a name="title"></a>
	<div id="content">
		<div>
			<h2 class="title">Order Confirmation</h2>
			<div class="content">
			
			<cfif not bError>

				<p>Your order has been submitted.</p>
	
				<cfoutput>
				<p>You can view and print your order <a href="#request.sUrlLeadring#kentuckianatitle/display_order.cfm?orderid=#variables.orderId#">here</a>.</p>
				</cfoutput>

								
				<cfoutput>
				<p><a href="#request.sUrlKentuckiana#order.htm">Submit another order</a></p>
				</cfoutput>
			
				<cfoutput>
				<cfmail to="#request.sOfficeEmail#" from="order <donotreply@leadring.com>" subject="Title Order Submitted" type="html">
					
					<table class="classic" cellspacing="0" cellpadding="0">
						<tr class="header"><td colspan="2">TITLE ORDER FORM&nbsp;</td></tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td width="50%"><label>Company&nbsp;</label><br />
								<cfoutput>#form.company#</cfoutput>&nbsp;</td>
							<td><label>Lender&nbsp;</label><br />
								<cfoutput>#form.lender#</cfoutput>&nbsp;</td>
						</tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td colspan="2"><label>Originator</label><br />
								<cfoutput>#form.originator#</cfoutput>&nbsp;</td>
						</tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td colspan="2"><label>Borrower 1</label><br />
								<cfoutput>#form.b1last#</cfoutput>&nbsp;</td>
						</tr>
						<cfif len(form.b2last)>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td colspan="2"><label>Borrower 2</label><br />
								<cfoutput>#form.b2last#</cfoutput>&nbsp;</td>
						</tr>
						</cfif>
					</table>
					
					<a href="#request.sUrlLeadring#kentuckianatitle/inbox.cfm">View Orders</a>
					
					
				</cfmail>
				</cfoutput>
			<cfelse>
			
			</cfif>


			</div>
		</div>
	<br clear="both" />
</div>
<hr />
<div id="footer-wrapper">
	<div id="footer">
		<p id="legal">Copyright &copy; 2007 Kentuckiana Title Agency, LLC. All Rights Reserved<br />
			design <a href="http://www.freecsstemplates.org/">Free CSS Templates</a></p>
		<p id="links">
			<a href="#">Privacy Policy</a> 
			| <a href="#">Terms of Use</a> 
		</p>
	</div>
</div>
</body>
</html>


















	

