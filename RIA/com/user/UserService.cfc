<cfcomponent output="false">
	
	<cffunction name="getUser" output="false" access="remote">
		<cfargument name="userID" type="string" required="true" />
		
		<cfset var q = "" />
		
		<cfquery name="q" datasource="ria">
			SELECT userId, firstName, lastName, emailAddress, phone
			FROM users
			WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userId#">
		</cfquery>
		
		<cfreturn q />
	</cffunction>


	<cffunction name="saveUser" output="false" access="remote">
		<cfargument name="userId" type="string" required="true" />
		<cfargument name="firstName" type="string" required="true" />
		<cfargument name="lastName" type="string" required="true" />
		<cfargument name="emailAddress" type="string" required="true" />
		<cfargument name="phone" type="string" required="true" />
		
		<cfif arguments.userID EQ "">
			<cfset createUser(argumentCollection = arguments) />
		<cfelse>
			<cfset updateUser(argumentCollection = arguments) />
		</cfif>
	</cffunction>
	
	<cffunction name="createUser" output="false" access="private" returntype="any" hint="">
	   <cfargument name="userId" type="string" required="true" />
		<cfargument name="firstName" type="string" required="true" />
		<cfargument name="lastName" type="string" required="true" />
		<cfargument name="emailAddress" type="string" required="true" />
		<cfargument name="phone" type="string" required="true" />
		
		<cfquery datasource="ria">
		INSERT INTO users (userId,firstName, lastName, emailAddress, phone)
		VALUES (<cfqueryparam value="#createUUID()#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">)
	</cfquery>
	</cffunction>
	
	<cffunction name="updateUser" output="false" access="private" returntype="any" hint="">
	   <cfargument name="userId" type="string" required="true" />
		<cfargument name="firstName" type="string" required="true" />
		<cfargument name="lastName" type="string" required="true" />
		<cfargument name="emailAddress" type="string" required="true" />
		<cfargument name="phone" type="string" required="true" />
		
		<cfquery datasource="ria">
			UPDATE users
			SET 
			firstName = <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
			lastName = <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
			emailAddress = <cfqueryparam value="#arguments.emailAddress#" cfsqltype="cf_sql_varchar">,
			phone = <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
			WHERE userId = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
		</cfquery>
	</cffunction>


	<cffunction name="getAllUsers" output="false" access="remote" returntype="struct">
		<cfargument name="cfgridpage">
		<cfargument name="cfgridpageSize">
		<cfargument name="cfgridsortcolumn"  />
		<cfargument name="cfgridsortdirection"  />

		<cfset var qRead="">

		<cfquery name="qRead" datasource="ria">
			SELECT userId,firstName,lastName,emailAddress,phone
			FROM	users
			<cfif len(arguments.cfgridsortcolumn) and len(arguments.cfgridsortdirection)>
			ORDER BY #arguments.cfgridsortcolumn# #arguments.cfgridsortdirection#
			<cfelse>
			ORDER BY lastName ASC
			</cfif>
		</cfquery>

		<cfreturn queryConvertForGrid(qRead, cfgridpage, cfgridpageSize) />
	</cffunction>

</cfcomponent>