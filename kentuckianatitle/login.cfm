<cfparam name="url.referrer" default="">
<cfparam name="url.action" default="">

<cfif url.action EQ "logout">
	<cfloop list="#GetClientVariablesList()#" index="var">
		<cfset DeleteClientVariable(var) />
	</cfloop>

	<cfset client.bLoggedIn = 0>
</cfif>

<cfset bErr = 0>
<cfset bErrUsr = 0>
<cfset bErrLog = 0>
<cfif structkeyexists(form,"submit")>
	<cfif form.login NEQ "kytitle" or form.pass NEQ "kytitle3419">
		<cfset client.bLoggedIn = 0>
		<cfset bErr = 1>
		<cfset bErrLog = 1>
		<cfset sErrLog = "Login/Password failed">
	</cfif>
	
	<cfif len(form.user) LT 3 or len(form.user) GT 15>
		<cfset client.bLoggedIn = 0>
		<cfset bErr = 1>
		<cfset bErrUsr = 1>
		<cfset sErrUsr = "User name must be between 4 and 15 characters">
	</cfif>

	<cfif bErr EQ 0>
		<cfset client.bLoggedIn = 1>
		<cfset client.user = form.user>
		<cfset client.timeLoggedIn = now()>
	</cfif>
</cfif>	

<cfinclude template="header.cfm">

<div id="page">
	<div id="login">
	<h2>Login</h2><br />

	<cfif client.bLoggedIn and DateDiff("h", client.timeLoggedIn, now()) LTE 12>
				
		<cfif len(url.referrer)>
			<cflocation url="#url.referrer#" addtoken="true">
		<cfelse>
			You are logged in.
		</cfif>
	<cfelse>
		<cfoutput>
		<form action="login.cfm?referrer=#url.referrer#" method="post">
		</cfoutput>
		<table cellpadding="0" cellspacing="0" class="form">
			<cfif structkeyexists(variables,"sResult")>
				<tr><td colspan="2"><cfoutput>#sResult#</cfoutput></tr>
				<tr><td colspan="2">&nbsp;</tr>
			</cfif>
			<tr>
				<td align="right">Login:</td>
				<td><input type="text" name="login"></td>
			</tr>
		    <tr><td colspan=2>&nbsp;</td></tr>
			<tr>
		        <td align="right">Password:</td>
				<td><input type="password" name="pass"></td>
		    </tr>
		    <tr>
		    	<td>&nbsp;</td>
				<td class="error">&nbsp;<cfif bErrLog><cfoutput>#sErrLog#</cfoutput></cfif></td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
		        <td align="right">User:</td>
				<td><input type="text" name="user"></td>
		    </tr>
			<tr>
				<td>&nbsp;</td>
				<td class="error">&nbsp;<cfif bErrUsr><cfoutput>#sErrUsr#</cfoutput></cfif></td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
		    <tr><td colspan="2" align="center"><input type="submit" name="submit" value="Log In"></tr>
		</table>
		</form>
	</cfif>
	</div>
</div>	

<cfinclude template="footer.cfm">
	
