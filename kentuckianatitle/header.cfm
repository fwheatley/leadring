<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<cfparam name="variables.bShowMenu" default="1">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Kentuckiana Title Agency, LLC. - Louisville, KY</title>

<link href="default.css" rel="stylesheet" type="text/css" />
<cfoutput>
<script src="#request.sUrlLeadring#jquery/jquery.min.js" type="text/javascript"></script>
</cfoutput>
<script src="tablesorter/tablesorter.js" type="text/javascript"></script>
<!---<script src="tablesorter/tablesorter_filter.js" type="text/javascript"></script>--->
<script src="jquery.tools.min.js" type="text/javascript"></script>
</head>

<body>
<div id="header">
	<div id="logo">
		<h2>"Service is our Key to Success"</a></h2>
	</div>
</div>
<div id="header2">
	<div id="menu">
		<ul>
			<cfif variables.bShowMenu>
			<cfoutput>
			<li id="first"><a href="#request.sUrlKentuckiana#index.htm">Home</a></li>
			</cfoutput>
			<li><a href="inbox.cfm?filter=open">Open Orders</a></li>
			<li><a href="inbox.cfm?filter=all">All Orders</a></li>
			<li>
				<cfif client.bLoggedIn>
					<a href="login.cfm?action=logout">Logout</a>
				</cfif>
			</li>
			</cfif>			
		</ul>
	</div>
	<div id="splash"><a href="index.htm"><img src="images/kytitle.gif" alt="" width="560" height="200" /></a></div>
</div>
<hr />