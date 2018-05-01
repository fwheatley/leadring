<cfcomponent> 
<cfset This.name = "timekeeper"> 
<cfset This.Sessionmanagement="True"> 
<cfset This.loginstorage="session">
<cfset This.datasource = "targetprocess">
<cfset This.sessiontimeout = "#CreateTimeSpan(0, 0, 30, 0)#">

<cfset This.secureJson = false>

<cffunction name="onApplicationStart" output="false">
	<cfscript>

	</cfscript>
</cffunction>

<cffunction name="OnRequestStart"> 
	<cfargument name="thePage" type="string" required="true">
	
	<!---<cfset request.sCityName = "JNF Timekeeper">--->
	<cfif NOT isdefined("oTime")>
		<cfset oTime = createObject("component","com.timekeeper")>
	</cfif>	
	
	
	<cflogin idletimeout="3600" >
		<cfif NOT IsDefined("cflogin")>
			<cfinclude template="login.cfm"> 
			<cfabort>
		<cfelse>
 			<cfif cflogin.name IS "" OR cflogin.password IS ""> 
				<cfoutput> 
  				<h2>You must enter text in both the User Name and Password fields.</h2> 
				</cfoutput> 
				<cfinclude template="login.cfm"> 
				<cfabort> 
			<cfelse> 
				<cfset session.isAuthenticated=true>
			
				<cftry>		
				<cfldap action="query"
				           server="hqad06"
				           name="auth"
				           start="ou=exchange objects,ou=jefferson national,dc=jnf,dc=local"
				           username="wwig\#cflogin.name#"
				           password="#cflogin.password#"
				           attributes = "cn,mail,displayname">
				 	<cfcatch type="any">
						<cfset session.isAuthenticated=false>
						<cfset bLoginOK = false>		
					</cfcatch>

				</cftry>
				<cfif session.isAuthenticated>
					<cfset roles = "user,admin"> 
					<cfloginuser name="#cflogin.name#" password="#cflogin.password#" roles="#roles#">
					<cfset isLogged = 1>
					
					<cfset qUser = oTime.getUser(cflogin.name)>
					<cfset session.username = cflogin.name>
					<cfset session.userid = qUser.userid>
					<cfset session.userfname = qUser.fname>
					<cfset session.userlname = qUser.lname>
					<cfset session.useremail = qUser.email>
					
				<cfelse> 
					<cfoutput> 
					<H2>Your login information is not valid.<br>Please Try again</H2> 
					</cfoutput>     
					<cfinclude template="login.cfm"> 
					<cfabort> 
				</cfif> 
			</cfif>
		</cfif> 	
	</cflogin>
	
	<cfif isdefined("isLogged") AND isLogged>
		<cflocation url="index.cfm" addtoken="false">
	</cfif>
	
	 <cfset session.RequestStartTime = Now() />
	
</cffunction>

<cffunction name="onSessionStart" output="false">

    <cfif not IsDefined("Cookie.CFID")>
        <cflock scope="session" type="readonly" timeout="5">
            <cfcookie name="CFID" value="#session.CFID#">
            <cfcookie name="CFTOKEN" value="#session.CFTOKEN#">
             <cfset session.SessionStartTime = Now() />
        </cflock>
    </cfif>	
	
</cffunction>

<cffunction name="onRequestEnd" returnType="void" output="false">
	<cfargument name="thePage" type="string" required="true">
</cffunction>

<cffunction name="onSessionEnd" returnType="void" output="false">
	<cfargument name="SessionScope" type="struct" required="true">
	<cfargument name="ApplicationScope" type="struct" required="false">

	<cfscript>

	</cfscript>
</cffunction>

<cfset request.sSiteUrl = "http://127.0.0.1/leadring/timekeeper/">
<!---
<cfset request.sSiteUrl = "http://127.0.0.1/leadring/timekeeper/">
<cfset request.sSiteUrl = "http://moveformcf.jeffnat.com/timekeeper/">
 --->

</cfcomponent>