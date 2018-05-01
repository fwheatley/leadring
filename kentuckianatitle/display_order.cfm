<cfsetting showdebugoutput="false">

<cfquery name="qOrder" datasource="kytitle">
	select company,lender,originator,CPLstreet,CPLcity,CPLstate,CPLzip,CPLphone,CPLfax,
		   b1ssn,b1last,b1first,b1middle,b2ssn,b2last,b2first,b2middle,s1ssn,s1last,s1first,s1middle,
		   s2ssn,s2last,s2first,s2middle,loanamt,purchprice,street,city,state,zip,county,product,acctnumbers,
		   subdate,approvedby,approveddate,email,source
	from orders
	where orderid = <cfqueryparam value="#url.orderId#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfparam name="form.company" default="#qOrder.company#">
<cfparam name="form.lender" default="#qOrder.lender#">
<cfparam name="form.originator" default="#qOrder.originator#">
<cfparam name="form.CPLstreet" default="#qOrder.CPLstreet#">
<cfparam name="form.CPLcity" default="#qOrder.CPLcity#">
<cfparam name="form.CPLstate" default="#qOrder.CPLstate#">
<cfparam name="form.CPLzip" default="#qOrder.CPLzip#">
<cfparam name="form.CPLphone" default="#qOrder.CPLphone#">
<cfparam name="form.CPLfax" default="#qOrder.CPLfax#">
<cfparam name="form.b1ssn" default="#qOrder.b1ssn#">
<cfparam name="form.b1last" default="#qOrder.b1last#">
<cfparam name="form.b1first" default="#qOrder.b1first#">
<cfparam name="form.b1middle" default="#qOrder.b1middle#">
<cfparam name="form.b2ssn" default="#qOrder.b2ssn#">
<cfparam name="form.b2last" default="#qOrder.b2last#">
<cfparam name="form.b2first" default="#qOrder.b2first#">
<cfparam name="form.b2middle" default="#qOrder.b2middle#">
<cfparam name="form.s1ssn" default="#qOrder.s1ssn#">
<cfparam name="form.s1last" default="#qOrder.s1last#">
<cfparam name="form.s1first" default="#qOrder.s1first#">
<cfparam name="form.s1middle" default="#qOrder.s1middle#">
<cfparam name="form.s2ssn" default="#qOrder.s2ssn#">
<cfparam name="form.s2last" default="#qOrder.s2last#">
<cfparam name="form.s2first" default="#qOrder.s2first#">
<cfparam name="form.s2middle" default="#qOrder.s2middle#">
<cfparam name="form.loanamt" default="#qOrder.loanamt#">
<cfparam name="form.purchprice" default="#qOrder.purchprice#">
<cfparam name="form.street" default="#qOrder.street#">
<cfparam name="form.city" default="#qOrder.city#">
<cfparam name="form.state" default="#qOrder.state#">
<cfparam name="form.zip" default="#qOrder.zip#">
<cfparam name="form.county" default="#qOrder.county#">
<cfparam name="form.product" default="#qOrder.product#">
<cfparam name="form.acctnumbers" default="#qOrder.acctnumbers#">

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

<cfdocument format="PDF" margintop=".25" marginbottom=".25">
<link rel="stylesheet" type="text/css" href="app_style.css" />
<table>
	<tr class="letterhead">
		<td colspan="2" valign="center">
			<img src="kytitle.jpg" id="logo" />
			<p id="company">Kentuckiana Title Agency, LLC.</p>
			<p id="address">
				3419 Stony Spring Circle<br />
				Louisville, KY 40220<br /><br />
				Phone: 502.491.9029&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax: 502.491.9398<br />
				Toll Free: 877.491.9029
			</p>
		</td>
	</tr>
</table>
	
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td colspan="2">TITLE ORDER FORM&nbsp;</td></tr>
	<tr>
		<td width="50%"><label>Company&nbsp;</label><br />
			<cfoutput>#form.company#</cfoutput>&nbsp;</td>
		<td><label>Lender&nbsp;</label><br />
			<cfoutput>#form.lender#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><label>Originator</label><br />
			<cfoutput>#form.originator#</cfoutput>&nbsp;</td>
	</tr>
</table>
<br />
	
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td colspan="3">Address for Closing Protection Letters:</td></tr>
	<tr>
		<td colspan="3"><label>Street&nbsp;</label><br />
			<cfoutput>#form.CPLstreet#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td width="50%"><label>City&nbsp;</label><br />
			<cfoutput>#form.CPLcity#</cfoutput>&nbsp;</td>
		<td><label>State&nbsp;</label><br />
			<cfoutput>#form.CPLstate#</cfoutput>&nbsp;</td>
		<td><label>Zip&nbsp;</label><br />
			<cfoutput>#form.CPLzip#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td><label>Phone&nbsp;</label><br />
			<cfoutput>#form.CPLphone#</cfoutput>&nbsp;</td>
		<td colspan="2"><label>Fax&nbsp;</label><br />
			<cfoutput>#form.CPLfax#</cfoutput>&nbsp;</td>			
	</tr>
</table>
<br />
	
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td colspan="2">Borrower</td></tr>
	<tr>
		<td width="30%"><label>SSN <em>(last 4 digits)</em>&nbsp;</label><br />
			<cfoutput>#form.b1ssn#</cfoutput>&nbsp;</td>
		<td><label>Name <em>(last, first, middle)</em>&nbsp;</label><br />
			<cfoutput>#form.b1last#, #form.b1first#, #form.b1middle#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td><label>SSN <em>(last 4 digits)</em>&nbsp;</label><br />
			<cfoutput>#form.b2ssn#</cfoutput>&nbsp;</td>
		<td><label>Name <em>(last, first, middle)</em>&nbsp;</label><br />
			<cfoutput>#form.b2last#, #form.b2first#, #form.b2middle#</cfoutput>&nbsp;</td>
	</tr>
</table>
<br />
	
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td colspan="2">Seller</td></tr>
	<tr>
		<td width="30%"><label>SSN <em>(last 4 digits)</em>&nbsp;</label><br />
			<cfoutput>#form.s1ssn#</cfoutput>&nbsp;</td>
		<td><label>Name <em>(last, first, middle)</em>&nbsp;</label><br />
			<cfoutput>#form.s1last#, #form.s1first#, #form.s1middle#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td><label>SSN <em>(last 4 digits)</em>&nbsp;</label><br />
			<cfoutput>#form.s2ssn#</cfoutput>&nbsp;</td>
		<td><label>Name <em>(last, first, middle)</em>&nbsp;</label><br />
			<cfoutput>#form.s2last#, #form.s2first#, #form.s2middle#</cfoutput>&nbsp;</td>
	</tr>
</table>
<br />
	
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td colspan="4">Property Information</td></tr>
	<tr>
		<td colspan="2" width="50%"><label>Loan Amount &nbsp;</label><br />
			<cfoutput>#form.loanamt#</cfoutput>&nbsp;</td>
		<td colspan="2"><label>Purchase Price&nbsp;</label><br />
			<cfoutput>#form.purchprice#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4"><label>Street&nbsp;</label><br />
			<cfoutput>#form.street#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td width="35%"><label>City&nbsp;</label><br />
			<cfoutput>#form.city#</cfoutput>&nbsp;</td>
		<td width="15"><label>State&nbsp;</label><br />
			<cfoutput>#form.state#</cfoutput>&nbsp;</td>
		<td><label>Zip&nbsp;</label><br />
			<cfoutput>#form.zip#</cfoutput>&nbsp;</td>
		<td><label>County&nbsp;</label><br />
			<cfoutput>#form.county#</cfoutput>&nbsp;</td>	
	</tr>
</table>
<br />
	 
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td colspan="2">Title/Search Products</td></tr>
	<tr>
		<td width="50%"><cfif form.product EQ 1><img src="checkbox_on.gif" height="15" width="15" border="0"><cfelse><img src="checkbox_off.gif" height="15" width="15" border="0"></cfif> First Mortgage Purchase</td>
		<td width="50%"><cfif form.product EQ 3><img src="checkbox_on.gif" height="15" width="15" border="0"><cfelse><img src="checkbox_off.gif" height="15" width="15" border="0"></cfif> Second Mortgage</td>
	</tr>
	<tr>
		<td width="50%"><cfif form.product EQ 2><img src="checkbox_on.gif" height="15" width="15" border="0"><cfelse><img src="checkbox_off.gif" height="15" width="15" border="0"></cfif> First Mortgage Refinance</td>
		<td width="50%"><cfif form.product EQ 5><img src="checkbox_on.gif" height="15" width="15" border="0"><cfelse><img src="checkbox_off.gif" height="15" width="15" border="0"></cfif> Land Contract Refinance</td>
	</tr>
	<tr>
		<td colspan="2"><cfif form.product EQ 4><img src="checkbox_on.gif" height="15" width="15" border="0"><cfelse><img src="checkbox_off.gif" height="15" width="15" border="0"></cfif> Property Search Only (No Title Insurance)</td>
	</tr>
</table>
<br />
	 
<table class="classic" cellspacing="0" cellpadding="0">
	<tr class="header"><td>Please Order Pay(s) Off</td></tr>
	<tr>
		<td><label>Mortgage Holder and Account Numbers&nbsp;</label><br />
			<cfoutput>#acctnumbers#</cfoutput>&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><strong>*Must have Account Numbers and Signed Customer Authorization to release.</strong></td>
	</tr>
</table>
<br />
	
<table width="100%">
	<tr><td align="center">FAX Title Orders to <b>(502)491-9398</b> or Email: <b>kta@insightbb.com</b></td></tr>
</table>
	
</cfdocument>

