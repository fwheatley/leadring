<cfset searchAPI = createObject("component", "org.camden.yahoo.search")>

<cfinvoke component="#searchAPI#" method="spellingSuggestion" returnVariable="result">
	<cfinvokeargument name="query" value="categry">
</cfinvoke>

<cfdump var="#result#" label="Spelling suggestions for 'categry'">

<cfinvoke component="#searchAPI#" method="spellingSuggestion" returnVariable="result">
	<cfinvokeargument name="query" value="Camden">
</cfinvoke>

<cfdump var="#result#" label="Spelling suggestions for 'Camden'">
