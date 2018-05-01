<cfset searchAPI = createObject("component", "org.camden.yahoo.search")>

<cfinvoke component="#searchAPI#" method="relatedSuggestion" returnVariable="result">
	<cfinvokeargument name="query" value="coldfusion">
</cfinvoke>

<cfdump var="#result#" label="Related suggestions for 'coldfusion'">

<cfinvoke component="#searchAPI#" method="relatedSuggestion" returnVariable="result">
	<cfinvokeargument name="query" value="Camden">
</cfinvoke>

<cfdump var="#result#" label="Related suggestions for 'Camden'">
