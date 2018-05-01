<!---
Backs up a database to a zip file.

@param dbsource      DNS. (Required)
@return Returns a string.
@author Darwan Leonardo Sitepu (dlns2001@yahoo.com)
@version 1, February 21, 2011
--->
<cffunction name="backupDatabase" returnType="string" output="true">
<cfargument name="dbsource" type="string" required="true">
<cftry>
<cfdbinfo datasource="#arguments.dbsource#" name="tables" type="tables" />


<cfset data = StructNew() />

<cfloop query="tables"> <!--- grab all data from table --->

<cftry>
<cfset data[Table_Name] = StructNew() />

<cfdbinfo datasource="#arguments.dbsource#" table="#Table_Name#" name="qryTableFields" type="columns" />
<cfset data[Table_Name].schema = qryTableFields />

<cfquery name="getData" datasource="#arguments.dbsource#" debug="no" cachedwithin=#CreateTimeSpan(0,0,0,10)# >SELECT * FROM [#Table_Name#]</cfquery>

<cfset data[Table_Name].data = getData />
<cfcatch></cfcatch>
</cftry>
</cfloop><!--- Now serialize into one ginormous string --->
<cfdump var="#data#">
<cfwddx action="cfml2wddx" input="#data#" output="packet" /><!--- file to store zip --->
<cfset zfile = expandPath("./data.zip") /><!--- Now zip this baby up --->
<cfzip action="zip" file="#zfile#" overwrite="true"><cfzipparam content="#packet#" entrypath="data.packet.xml" /></cfzip>
<cfreturn "I retrieved #tables.recordCount# tables from datasource #arguments.dbsource# and saved it to #zfile#.">
<cfcatch><cfoutput>#cfcatch.Message#</cfoutput>
    <cfreturn "Backup Database Is Failed..">
</cfcatch>
</cftry>
</cffunction>



<cfoutput>
<cfsetting showdebugoutput="no">
#BackupDatabase("kytitle")#
</cfoutput>