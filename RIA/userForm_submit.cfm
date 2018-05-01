<cfsetting enablecfoutputonly="true" />
<cfset errors = StructNew() />

<cfif form.firstName EQ "">
	<cfset errors["firstName"] = "You must enter a first name." />
</cfif>

<cfif form.lastName EQ "">
	<cfset errors["lastName"] = "You must enter a last name." />
</cfif>

<cfif NOT isValid("email", form.emailAddress)>
	<cfset errors["emailAddress"]= "You must enter a valid email address" />
</cfif>

<cfif NOT isValid("telephone",form.phone)>
	<cfset errors["phone"] = "You must enter a valid phone number" />
</cfif>

<cfif structIsEmpty(errors)>
	<cfset createObject("component","com.user.UserService").saveUser(argumentCollection = form) />
<cfelse>
	<cfoutput><cfoutput>#serializeJSON(errors)#</cfoutput></cfoutput>
</cfif>
<cfsetting enablecfoutputonly="false" />