<cfcomponent>

	<cffunction access="public" name="clear" output="false" returntype="boolean" roles="Administrator" displayname="Clear a users linkage" hint="This method clears a users roles.">
		<cfargument required="true" name="dsn" type="string"/>
		<cfargument name="securityID" type="numeric" required="true"/>
			<cfquery datasource="#arguments.dsn#" name="deleteRole">
				DELETE
				FROM securityLink
				WHERE securityID = <cfqueryparam value="#arguments.securityID#" cfsqltype="CF_SQL_INTEGER"/>				
			</cfquery>
		<cfreturn 1/>
	</cffunction>	

	<cffunction access="public" name="getRoles" output="false" returntype="query" roles="Administrator" displayname="Get all Roles" hint="This method returns all security roles.">
		
		<cfquery name="getRoles">
		SELECT roleid, role FROM role ORDER BY ROLE
		</cfquery>
		<cfreturn getRoles/>
	</cffunction>

	<cffunction access="public" name="isDuplicate" output="false" returntype="boolean" displayname="Determines if a username or email exists in the system. Returns a boolean.">
		<cfargument required="true" name="dsn" type="string"/>
		<cfargument required="true" name="role" type="string"/>
		 <cfquery name="isDuplicate" datasource="#arguments.dsn#">
				SELECT ID
				FROM ROLE
				WHERE
					ROLE = <cfqueryparam value="#arguments.role#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"/>
		</cfquery>
		<cfif isDuplicate.recordcount NEQ 0>
			<cfreturn 1/>
		<cfelse>
			<cfreturn 0/>
		</cfif>
	</cffunction>	

	<cffunction access="public" name="add" output="false" returntype="boolean" roles="Administrator" displayname="Add a Role" hint="This method adds a role.">
		<cfargument required="true" name="dsn" type="string"/>
		<cfargument required="true" name="role" type="string"/>
			<cfquery datasource="#arguments.dsn#" name="add">
				INSERT INTO ROLE(role)
				VALUES(<cfqueryparam value="#arguments.role#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"/>)				
			</cfquery>
		<cfreturn 1/>
	</cffunction>	

	<cffunction access="public" name="delete" output="false" returntype="boolean" roles="Administrator" displayname="Delete a Role" hint="This method deletes a role.">
		<cfargument required="true" name="dsn" type="string"/>
		<cfargument required="true" name="role" type="string"/>
			<cfquery datasource="#arguments.dsn#" name="deleteRole">
				DELETE
					FROM ROLE
				WHERE
					ROLE = <cfqueryparam value="#arguments.role#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"/>				
			</cfquery>
			<cfquery datasource="#arguments.dsn#" name="deleteLink">
				DELETE
					FROM SECURITYLINK
				WHERE
					ROLE = <cfqueryparam value="#arguments.role#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"/>				
			</cfquery>
		<cfreturn 1/>
	</cffunction>	

	<cffunction access="public" name="update" output="false" returntype="boolean" roles="Administrator" displayname="Update a Role" hint="This method updates a role.">
		<cfargument required="true" name="dsn" type="string"/>
		<cfargument name="ID" type="numeric" required="true"/>
		<cfargument name="role" type="string" required="true"/>
			<cfquery datasource="#arguments.dsn#" name="deleteRole">
				UPDATE ROLE
				SET ROLE = <cfqueryparam value="#arguments.role#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"/>
				WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="CF_SQL_INTEGER"/>				
			</cfquery>
		<cfreturn 1/>
	</cffunction>	
	
	<cffunction access="public" name="join" output="false" returntype="boolean" displayname="Insert Security Data" hint="This method inserts a username and a hashed password into the security table. It returns the securityID.">
		<cfargument required="true" name="dsn" type="string"/>
		<cfargument required="true" name="role" type="string"/>
		<cfargument required="true" name="securityID" type="numeric"/>
		<cfquery datasource="#arguments.dsn#">
		  INSERT INTO securityLink(
			role,
			securityID)
		 VALUES (
			<cfqueryparam value="#arguments.role#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"/>,
			<cfqueryparam value="#arguments.securityID#" cfsqltype="CF_SQL_INTEGER"/>)
		  </cfquery>
		<cfreturn 1/>
	</cffunction>
	
</cfcomponent>