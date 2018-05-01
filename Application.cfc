<cfcomponent> 
<cfset This.name = "leadring"> 
<cfset This.Sessionmanagement="True"> 
<cfset This.loginstorage="session"> 
<cfset This.datasource = "webserver">
 
<cfset objFactory = CreateObject( "java",  "coldfusion.server.ServiceFactory"  ) />

<cffunction name="OnRequestStart"> 
	<cfargument name = "request" required="true"/> 

	<!---<cfset request.sCityName = "St. Regis Park">--->
	<!---<cflog file="myAppLog" text="from onrequeststart." type="information" >--->

</cffunction> 

<cffunction name="onRequest" returnType="void">
  <cfargument name="targetPage" type="String" required=true/>

  <cfinclude template="#Arguments.targetPage#">

</cffunction>

<cffunction name="onRequestEnd" returnType="void">

  	
	<cfset objDebugging = objFactory.GetDebuggingService() />
	<cfset qEvents = objDebugging.GetDebugger().GetData() />
	<cfquery name="qTemplates" dbtype="query">
	    SELECT line, parent, template, endtime, starttime
	    FROM qEvents
	    WHERE type = 'Template' AND line > 0
	    ORDER BY template ASC
	</cfquery>
	<cfloop query="qTemplates">
		<cflog file="Usedpage" text="#parent#, #line#, #template#">
	</cfloop>
	
</cffunction>

</cfcomponent>
