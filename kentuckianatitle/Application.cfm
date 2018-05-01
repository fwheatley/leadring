<cfapplication name="kentianatitle"
   	           clientmanagement="Yes"
			   clientstorage="registry"
           	   sessionmanagement="Yes"
   	           applicationtimeout="#CreateTimeSpan(7,0,0,0)#">
   	           
<cfparam name="client.bLoggedIn" default="0">

<!---<cfset request.sOfficeEmail = "kta@insightbb.com">--->
<cfset request.sOfficeEmail = "frank@wheatley.net">
<cfset request.sTechEmail = "frank@wheatley.net">

<!---<cfset request.sUrlLeadring = "http://www.leadring.com/">--->
<cfset request.sUrlLeadring = "http://wd111/leadring/">

<!---<cfset request.sUrlKentuckiana = "http://www.kentuckianatitle.com/">--->
<cfset request.sUrlKentuckiana = "http://wd111/kentuckianatitle/">
			   