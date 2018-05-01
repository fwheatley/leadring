<cfscript>
// config
sSubject = "Closing Order Form Attached";
sAddyTo = "fwheatley@gmail.com";//"kta@insightbb.com";//"jclark@kentuckianatitle.com";//"kentuckianatitle@bellsouth.net"; //"frank@wheatley.net";
sAddyFrom = "orders <donotreply@leadring.com>";
// create the boundary marker indicating each new multi-part section
sBoundary = createUUID();
// create the CID for the embedded image
sCID = "23abc@pc27";
</cfscript>

<cftry>
<cfmail to="#sAddyTo#" from="#sAddyFrom#" subject="#sSubject#">
<cfmailpart type="multipart/mixed; boundary=#chr(34)##sBoundary##chr(34)#">
--#sBoundary#
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<html>
<head>
   <title>HTML E-mail</title>
</head>
<body>
 	Attached is a Closing Order Form from:<br /><br />
	test test test test
	<br /><br />
</body>
</html>



</cfmailpart>
<cfmailpart type="application/x-unsupported">
This should not be rendered by a mail user agent because it does not support the MIME-type.
</cfmailpart>
</cfmail>  

<cfcatch type="any">
	<cfdump var="#cfcatch#">
	There was an error sending you form.  Please <a href="#" onclick="history.go(-1)">return to the previous page</a> and try again or "Print PDF for Fax".
</cfcatch>
</cftry>
<img src="kytitle.jpg" id="logo" /><br /><br />
You closing order was submitted.<br />
<a href="http://www.kentuckianatitle.com/order.htm">Submit another order</a> or click the back button twice to return to your previous order.
