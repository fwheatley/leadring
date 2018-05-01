<!--- Create ColdFusion service factory instance. --->
<cfset objFactory = CreateObject( "java",  "coldfusion.server.ServiceFactory"  ) />

<!--- Get the debugging service from the service factory. --->
<cfset objDebugging = objFactory.GetDebuggingService() />

<!--- Get the events table. This includes all events that have taken place, not just template executions. This is returned as a query. --->
<cfset qEvents = objDebugging.GetDebugger().GetData() />

<!--- Now that we have all the events in query format, do a query of queries to get only events that were template executions event. --->
<cfquery name="qTemplates" dbtype="query">
    SELECT line, parent, template, endtime, starttime
    FROM qEvents
    WHERE type = 'Template'
    ORDER BY template ASC
</cfquery>

<!--- Dump out the query of template. --->
<cfdump var="#qTemplates#" />