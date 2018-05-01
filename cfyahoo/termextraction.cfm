<cfset termAPI = createObject("component", "org.camden.yahoo.termextraction")>

<cfsavecontent variable="context">
This is the context I'm using for my test. ColdFusion makes it easy to 
get data from the database. It uses the cfquery tag which wraps SQL that
is passed to the database.

To work with the result, you can simply use the cfoutput tag, tell it to use
the query, and it will automatically loop over each query row.
</cfsavecontent>

<cfset results = termAPI.getTerms(context)>
<cfdump var="#results#" label="Just context">

<p>
<hr>
<p>

<cfset results = termAPI.getTerms(context,"ColdFusion")>
<cfdump var="#results#" label="Added ColdFusion as a query">

<p>
<hr>
<p>

<cfset results = termAPI.getTerms("dsflkdfkldfj","Carrots")>
<cfdump var="#results#" label="Added Carrots as a query">

<p>
<hr>
<p>
