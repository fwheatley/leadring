<cfset imageAPI = createObject("component", "org.camden.yahoo.image")>

<cfset term = "ColdFusion">
<cfinvoke component="#imageAPI#" method="search" returnVariable="result">
	<cfinvokeargument name="query" value="#term#">
</cfinvoke>

<cfoutput>
<h2>Image search for #term#</h2>
</cfoutput>

<p>
<cfoutput>Total results were: #result.recordcount#</cfoutput>
</p>

<cfoutput query="result">
<cfif len(thumbnail)>
<img src="#thumbnail#" width="#thumbnailwidth#" height="#thumbnailheight#" alt="#title#" align="left">
</cfif>
<h3>#title#</h3>
URL: <a href="#clickurl#">#result.url#</a><br />

#summary#

<br clear="left">

<p>
<hr>
</p>
</cfoutput>
