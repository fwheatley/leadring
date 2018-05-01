http://fmqb.com/charts.asp?format=10

http://www.thetop22.com/wp-content/uploads/2011/12/Public-Radio-Songs-12-25-11.xls<br />
http://67.20.65.166/thetop22/wp-content/uploads/2011/12/



<cfhttp url="http://www.fmqb.com/charts.asp" method="get" result="http_response">
<cfhttpparam type="url" name="format" value="10" >
</cfhttp>
	
<cfdump var="#http_response#" >
<cfoutput>#http_response.filecontent#</cfoutput>
<!---<cfoutput>#HTMLEditFormat(http_response.filecontent)#</cfoutput>--->
<cfabort>

<!---<cfdirectory 
	action="list" 
	directory="67.20.65.166/thetop22/wp-content/uploads/2011/12/" 
	name="qTop22" >
<cfdump var="#qTop22#" >	--->


http://www.ivyishere.org/









<!--- read the spreadsheet data into a query object --->
<cfspreadsheet action="read" src="http://www.thetop22.com/wp-content/uploads/2011/12/Public-Radio-Songs-12-25-11.xls" query="importdata" headerrow="1" />
<cfdump var="#importdata#" ><cfabort>
<!--- create a variable to store the codes of products that could not be imported --->
<cfset failedimports = "" />
 
<!--- loop through the query starting with the first row containing data (row 2) --->
<cfloop query="importdata" startrow="2">
  <!--- check row contains valid data (all fields must contain a value and price must be numeric) --->
  <cfif !Len( product_title ) || !Len( product_code ) || !IsNumeric( product_price )>
    <!--- the row data is not valid so add it to our list of failed imports --->
    <cfset failedimports = ListAppend( failedimports, product_code ) />
  <cfelse>
    <cftry>
      <!--- insert the product into the database using REPLACE INTO to ensure existing products with the same code (which must be a unique key) are not duplicated --->
      <cfquery datasource="mydatasource" result="foobar">
        REPLACE INTO Products
        (
          product_title
          , product_code
          , product_price
        )
        VALUES
        (
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_title#" />
          , <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_code#" />
          , <cfqueryparam cfsqltype="cf_sql_double" value="#Val( product_price )#" />
        )
      </cfquery>
 
      <cfcatch type="any">
        <!--- catch any products that could not be imported and add them to our list of failed imports --->
        <cfset failedimports = ListAppend( failedimports, product_code) />
      </cfcatch>
    </cftry>
  </cfif>
</cfloop>
 
<cfoutput>
  <!--- display the products that could not be imported --->
  <h1>Failed Imports</h1>
 
  <cfif ListLen( failedimports )>
    <p>Oops! #ListLen( failedimports )# products could not be imported.</p>
 
    <cfloop list="#failedimports#" index="index">
      #index#<br />
    </cfloop>
  <cfelse>
    <p>No products failed to be imported.</p>
  </cfif>
</cfoutput>