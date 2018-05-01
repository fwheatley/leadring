<cfcomponent extends="targetprocess" >

<cffunction access="public" name="addUsers" output="true" returntype="void" roles="user" displayname="add user to timekeeper from targetprocess">
			
	<cfset var strLocal = structNew()>
	
	<!--- get active users from target process --->
	<cfset strLocal.qTPusers = getUsers()>
	
	<cfloop query="strLocal.qTPusers" >
		<cfquery name="strLocal.qUser" datasource="timetracking" >
		SELECT userID, fname, lname, email, ADname, isAdmin, roleID
  		FROM [timetracking].[dbo].[User]
  		WHERE userid = #strLocal.qTPusers.userid#
		</cfquery>	
		
		<cfif strLocal.qUser.recordcount>
			<!--- update [timetracking].[dbo].[User] --->
			<cfquery name="strLocal.updateUser" datasource="timetracking" >
			UPDATE [timetracking].[dbo].[User]
			SET fname = '#strLocal.qTPusers.firstname#', 
			    lname = '#strLocal.qTPusers.lastname#', 
			    email = '#strLocal.qTPusers.email#', 
			    ADname = '#strLocal.qTPusers.activedirectoryname#', 
			    isAdmin = #strLocal.qTPusers.isadministrator#, 
			    roleID = #strLocal.qTPusers.roleid#
	  		WHERE userid = #strLocal.qTPusers.userid#
			</cfquery>

		<cfelse>
			<!--- insert [timetracking].[dbo].[User] --->
			<cfquery name="strLocal.insertUser" datasource="timetracking" >
			INSERT INTO [timetracking].[dbo].[User] (userID, fname, lname, email, ADname, isAdmin, roleID)
	  		VALUES (#strLocal.qTPusers.userid#, '#strLocal.qTPusers.firstname#', '#strLocal.qTPusers.lastname#', '#strLocal.qTPusers.email#', 
			    '#strLocal.qTPusers.activedirectoryname#', #strLocal.qTPusers.isadministrator#, #strLocal.qTPusers.roleid#)
			</cfquery>
			
			<cfquery name="strLocal.insertUser" datasource="timetracking" >
			INSERT INTO [timetracking].[dbo].[UserProdPref] (userID, projectID, selected)
			SELECT #strLocal.qTPusers.userid# as userID, ProjectID, 1 as selected
			FROM [timetracking].[dbo].[Project]
			WHERE projectID in (7,8,9,10,11,12,13);
			</cfquery>
			
		</cfif>
	</cfloop>
	
</cffunction>

<cffunction access="public" name="getUser" output="false" returntype="query" displayname="get user info from login">
	<cfargument name="loginname" type="string" required="true" >
	
	<cfset var strLocal = structNew()>
	
	<cfquery name="strLocal.qUser" datasource="timetracking" >
	SELECT userID, fname, lname, email, ADname, isAdmin, roleID
	FROM [timetracking].[dbo].[User]
	WHERE ADname = 'wwig\'+'#arguments.loginname#'
	</cfquery>	

	<cfreturn strLocal.qUser />

</cffunction>

<cffunction access="public" name="getUserProdPref" output="false" returntype="query" displayname="get user prod support preferences">
	<cfargument name="userid" type="numeric" required="true" >
	
	<cfset var strLocal = structNew()>
	
	<cfquery name="strLocal.qUserProdPref" datasource="timetracking" >
	SELECT projectID, selected
	FROM [timetracking].[dbo].[UserProdPref]
	WHERE userID = #arguments.userID#;
	</cfquery>	

	<cfreturn strLocal.qUserProdPref />

</cffunction>

<cffunction access="remote" name="updateUserProdPref" output="false" returntype="void" displayname="update user prod support preferences">
	<cfargument name="userID" type="numeric" required="true" >
	<cfargument name="projectID" type="numeric" required="true" >	
	<cfargument name="selected" type="boolean" required="true" >
	
	<cfset var strLocal = structNew()>
	
	<cfquery name="strLocal.updateUserProdPref" datasource="timetracking" >
	UPDATE [timetracking].[dbo].[UserProdPref]
	SET selected = '#arguments.selected#'
	WHERE userID = #arguments.userID#
	  AND projectID = #arguments.projectID#;
	</cfquery>	

</cffunction>

<cffunction access="public" name="addProjects" output="true" returntype="void" roles="user" displayname="add projects to timekeeper from targetprocess">
			
	<cfset var strLocal = structNew()>

	<cfquery name="strLocal.qTPproject">
	select a.GeneralID, a.Name, a.CreateDate, a.DeleteDate, a.EndDate, a.IsActive
	from ProjectHistory a, (SELECT max(ID) as ID, GeneralID FROM ProjectHistory group by GeneralID) b
	where a.ID = b.ID
	order by a.Date desc;
	</cfquery>

	<cfloop query="strLocal.qTPproject">
		<cfif len(strLocal.qTPproject.CreateDate)><cfset strLocal.bNullCreateDate = false><cfelse><cfset strLocal.bNullCreateDate = true></cfif>
		<cfif len(strLocal.qTPproject.DeleteDate)><cfset strLocal.bNullDeleteDate = false><cfelse><cfset strLocal.bNullDeleteDate = true></cfif>
		<cfif len(strLocal.qTPproject.EndDate)><cfset strLocal.bNullEndDate = false><cfelse><cfset strLocal.bNullEndDate = true></cfif>
			
		<!--- populate projects table --->
		<cfquery name="strLocal.qProject" datasource="timetracking" >
		SELECT projectID, name, CreateDate, DeleteDate, EndDate, IsActive 
		FROM [timetracking].[dbo].[Project]
		WHERE projectID = #strLocal.qTPproject.GeneralID#
		</cfquery>
			
		<cfif strLocal.qProject.recordCount>
			<!--- update [timetracking].[dbo].[Project] --->
			<cfquery name="strLocal.updateProject" datasource="timetracking" >
			UPDATE [timetracking].[dbo].[Project]
			SET name = <cfqueryparam value="#strLocal.qTPproject.name#" cfsqltype="cf_sql_varchar" >,
			    createDate = <cfqueryparam value="#strLocal.qTPproject.CreateDate#" cfsqltype="cf_sql_timestamp" null="#strLocal.bNullCreateDate#">,
			    deleteDate = <cfqueryparam value="#strLocal.qTPproject.DeleteDate#" cfsqltype="cf_sql_timestamp" null="#strLocal.bNullDeleteDate#">,
			    endDate = <cfqueryparam value="#strLocal.qTPproject.EndDate#" cfsqltype="cf_sql_timestamp" null="#strLocal.bNullEndDate#">,
			    isActive = <cfqueryparam value="#strLocal.qTPproject.IsActive#" cfsqltype="cf_sql_bit" > 
  			WHERE projectId = #strLocal.qTPproject.GeneralID#
			</cfquery>			
		<cfelse>

			<cfquery name="strLocal.insertProject" datasource="timetracking" >
			INSERT INTO [timetracking].[dbo].[Project] (projectID, name, DeleteDate, EndDate, IsActive, CreateDate )
	  		VALUES (<cfqueryparam value="#strLocal.qTPproject.GeneralID#" cfsqltype="cf_sql_int" >,
	  				<cfqueryparam value="#strLocal.qTPproject.name#" cfsqltype="cf_sql_varchar" >,
	  		        <cfqueryparam value="#strLocal.qTPproject.DeleteDate#" cfsqltype="cf_sql_timestamp" null="true">,
	  		        <cfqueryparam value="#strLocal.qTPproject.EndDate#" cfsqltype="cf_sql_timestamp" null="true">,
	  		        <cfqueryparam value="#strLocal.qTPproject.IsActive#" cfsqltype="cf_sql_bit" >,
	  		        <cfqueryparam value="#strLocal.qTPproject.CreateDate#" cfsqltype="cf_sql_timestamp" null="true" >)
			</cfquery>
		</cfif>	

		<!--- populate entities with sprint 2 --->
		<!--- confirm entity(project) is in timetracking.Entity table --->
		<cfquery name="strLocal.qEntity" datasource="timetracking" >
		SELECT entityID, typeID, name, sprintID, projectID, storyID 
		FROM [timetracking].[dbo].[Entity]
		WHERE entityID = #strLocal.qTPproject.GeneralID#
		  and sprintid = 2
		</cfquery>
		
		<cfif strLocal.qEntity.recordCount>
			<!--- update [timetracking].[dbo].[Entity] --->
			<cfquery name="strLocal.updateEntity" datasource="timetracking" >
			UPDATE [timetracking].[dbo].[Entity]
			SET typeID = 0,
			    name = '#strLocal.qProject.name#',
			    projectID = #strLocal.qTPproject.generalID#,
			    storyID = #strLocal.qTPproject.generalID#
  			WHERE entityId = #strLocal.qTPproject.generalID#
  			  and sprintid = 2
			</cfquery>
			
		<cfelse>
			<!--- insert [timetracking].[dbo].[Entity] --->
			<cfquery name="strLocal.insertEntity" datasource="timetracking" >
			INSERT INTO [timetracking].[dbo].[Entity] (entityID, typeID, name, sprintID, projectID, storyID)
  			VALUES (#strLocal.qTPproject.generalID#, 0, '#strLocal.qTPproject.name#', 2, #strLocal.qTPproject.generalID#, #strLocal.qTPproject.generalID#)
			</cfquery>
		</cfif>

	</cfloop>
	
</cffunction>

<cffunction access="public" name="addEntities" output="true" returntype="void" roles="user" displayname="add entities (stories, tasks and bugs) to timekeeper from targetprocess">
			
	<cfset var strLocal = structNew()>
	
	<!--- get active users from target process --->
	<cfset strLocal.qTPsprints = getSprints()>
	<!--- loop through last 4 sprints --->
	<cfoutput query="strLocal.qTPsprints" maxrows="13" >
		
		<!--- confirm sprint is in timetracking.Sprint table --->
		<cfquery name="strLocal.qSprint" datasource="timetracking" >
		SELECT sprintID, name, startdate, enddate 
		FROM [timetracking].[dbo].[Sprint]
		WHERE sprintID = #strLocal.qTPsprints.GeneralID#
		</cfquery>
			
		<cfif strLocal.qSprint.recordcount>
			<!--- update [timetracking].[dbo].[Sprint] --->
			<cfquery name="strLocal.updateSprint" datasource="timetracking" >
			UPDATE [timetracking].[dbo].[Sprint]
			SET name = '#strLocal.qTPsprints.name#',
			    startdate = '#strLocal.qTPsprints.startdate#',
			    enddate = '#strLocal.qTPsprints.enddate#'
	  		WHERE sprintId = #strLocal.qTPsprints.GeneralID#
			</cfquery>
		
		<cfelse>
			<!--- insert [timetracking].[dbo].[Sprint] --->
			<cfquery name="strLocal.insertSprint" datasource="timetracking" >
			INSERT INTO [timetracking].[dbo].[Sprint] (sprintID, name, startdate, enddate)
	  		VALUES (#strLocal.qTPsprints.GeneralID#, '#strLocal.qTPsprints.name#', '#strLocal.qTPsprints.startdate#', '#strLocal.qTPsprints.enddate#')
			</cfquery>

		</cfif>

		<!--- populate entity table by sprint --->
		<!---start with stories --->
		<cfset strLocal.qTPstories = getStoriesSprint(strLocal.qTPsprints.GeneralID)>
		<cfloop query="strLocal.qTPstories">

			<!--- populate projects table --->
			<cfquery name="strLocal.qProject" datasource="timetracking" >
			SELECT projectID, name, DeleteDate, EndDate, IsActive 
			FROM [timetracking].[dbo].[Project]
			WHERE projectID = #strLocal.qTPstories.ProjectID#
			</cfquery>
			
			<!--- confirm entity(project) is in timetracking.Entity table --->
			<cfquery name="strLocal.qEntity" datasource="timetracking" >
			SELECT entityID, typeID, name, sprintID, projectID, storyID 
			FROM [timetracking].[dbo].[Entity]
			WHERE entityID = #strLocal.qTPstories.ProjectID#
			  and sprintid = #strLocal.qTPstories.squaditerationID#
			</cfquery>
		
			<cfif strLocal.qEntity.recordCount>
				<!--- update [timetracking].[dbo].[Entity] --->
				<cfquery name="strLocal.updateEntity" datasource="timetracking" >
				UPDATE [timetracking].[dbo].[Entity]
				SET typeID = 0,
				    name = '#strLocal.qProject.name#',
				    projectID = #strLocal.qTPstories.projectID#,
				    storyID = #strLocal.qTPstories.projectID#
	  			WHERE entityId = #strLocal.qTPstories.ProjectID#
	  			  and sprintid = #strLocal.qTPstories.squaditerationID#
				</cfquery>
				
			<cfelse>
				<!--- insert [timetracking].[dbo].[Entity] --->
				<cfquery name="strLocal.insertEntity" datasource="timetracking" >
				INSERT INTO [timetracking].[dbo].[Entity] (entityID, typeID, name, sprintID, projectID, storyID)
	  			VALUES (#strLocal.qTPstories.projectID#, 0, '#strLocal.qProject.name#', #strLocal.qTPstories.squaditerationID#, #strLocal.qTPstories.projectID#, #strLocal.qTPstories.projectID#)
				</cfquery>
			</cfif>

			<!--- confirm entity(story) is in timetracking.Entity table --->
			<cfquery name="strLocal.qEntity" datasource="timetracking" >
			SELECT entityID, typeID, name, sprintID, projectID, storyID 
			FROM [timetracking].[dbo].[Entity]
			WHERE entityID = #strLocal.qTPstories.GeneralID#
			  and sprintid = #strLocal.qTPstories.squaditerationID#
			</cfquery>
			
			<cfif strLocal.qEntity.recordCount>
				<!--- update [timetracking].[dbo].[Entity] --->
				<cfquery name="strLocal.updateEntity" datasource="timetracking" >
				UPDATE [timetracking].[dbo].[Entity]
				SET typeID = 1,
				    name = '#strLocal.qTPstories.name#',
				    projectID = #strLocal.qTPstories.projectID#,
				    storyID = #strLocal.qTPstories.userstoryID#
	  			WHERE entityId = #strLocal.qTPstories.GeneralID#
	  			  and sprintid = #strLocal.qTPstories.squaditerationID#
				</cfquery>
				
			<cfelse>
				<!--- insert [timetracking].[dbo].[Entity] --->
				<cfquery name="strLocal.insertEntity" datasource="timetracking" >
				INSERT INTO [timetracking].[dbo].[Entity] (entityID, typeID, name, sprintID, projectID, storyID)
	  			VALUES (#strLocal.qTPstories.generalID#, 1, '#strLocal.qTPstories.name#', #strLocal.qTPstories.squaditerationID#, #strLocal.qTPstories.projectID#, #strLocal.qTPstories.userstoryID#)
				</cfquery>
			</cfif>

			<!--- get tasks in story --->
			<cfset strLocal.qTPtasks = getTasksStory(strLocal.qTPstories.userstoryID)>
			<cfloop query="strLocal.qTPtasks" >
				<!--- confirm entity(task) is in timetracking.Entity table --->
				<cfquery name="strLocal.qEntity" datasource="timetracking" >
				SELECT entityID, typeID, name, sprintID, projectID, storyID 
				FROM [timetracking].[dbo].[Entity]
				WHERE entityID = #strLocal.qTPtasks.taskID#
				  and sprintid = #strLocal.qTPstories.squaditerationID#
				</cfquery>

				<cfif strLocal.qEntity.recordCount>
					<!--- update [timetracking].[dbo].[Entity] --->
					<cfquery name="strLocal.updateEntity" datasource="timetracking" >
					UPDATE [timetracking].[dbo].[Entity]
					SET typeID = 2,
					    name = '#strLocal.qTPtasks.name#',
					    projectID = #strLocal.qTPtasks.parentprojectID#,
					    storyID = #strLocal.qTPtasks.userstoryID#
		  			WHERE entityId = #strLocal.qTPtasks.taskID#
		  			  and sprintid = #strLocal.qTPstories.squaditerationID#
					</cfquery>
					
				<cfelse>
					<!--- insert [timetracking].[dbo].[Entity] --->
					<cfquery name="strLocal.insertEntity" datasource="timetracking" >
					INSERT INTO [timetracking].[dbo].[Entity] (entityID, typeID, name, sprintID, projectID, storyID)
		  			VALUES (#strLocal.qTPtasks.taskID#, 2, '#strLocal.qTPtasks.name#', #strLocal.qTPstories.squaditerationID#, #strLocal.qTPtasks.parentprojectID#, #strLocal.qTPtasks.userstoryID#)
					</cfquery>
				</cfif>
			</cfloop>

			<!--- get bugs in story --->
			<cfset strLocal.qTPbugs = getBugsStory(strLocal.qTPstories.userstoryID)>
			<cfloop query="strLocal.qTPbugs" >			
				<!--- confirm entity(bug) is in timetracking.Entity table --->
				<cfquery name="strLocal.qEntity" datasource="timetracking" >
				SELECT entityID, typeID, name, sprintID, projectID, storyID 
				FROM [timetracking].[dbo].[Entity]
				WHERE entityID = #strLocal.qTPbugs.bugID#
				  and sprintid = #strLocal.qTPstories.squaditerationID#
				</cfquery>

				<cfif strLocal.qEntity.recordCount>
					<!--- update [timetracking].[dbo].[Entity] --->
					<cfquery name="strLocal.updateEntity" datasource="timetracking" >
					UPDATE [timetracking].[dbo].[Entity]
					SET typeID = 3,
					    name = '#strLocal.qTPbugs.name#',
					    projectID = #strLocal.qTPbugs.parentprojectID#,
					    storyID = #strLocal.qTPbugs.userstoryID#
		  			WHERE entityId = #strLocal.qTPbugs.bugID#
		  			  and sprintid = #strLocal.qTPstories.squaditerationID#
					</cfquery>
					
				<cfelse>
					<!--- insert [timetracking].[dbo].[Entity] --->
					<cfquery name="strLocal.insertEntity" datasource="timetracking" >
					INSERT INTO [timetracking].[dbo].[Entity] (entityID, typeID, name, sprintID, projectID, storyID)
		  			VALUES (#strLocal.qTPbugs.bugID#, 3, '#strLocal.qTPbugs.name#', #strLocal.qTPstories.squaditerationID#, #strLocal.qTPbugs.parentprojectID#, #strLocal.qTPbugs.userstoryID#)
					</cfquery>
				</cfif>
			</cfloop>

		</cfloop>

		<!--- insert records into [dbo].[UserEntity] ( userID, entityID) --->
		<!--- the first insert add a record for new user stories if you are assigned to a task or bug but not the user story --->
		<cfquery name="strLocal.insertUserEntity" datasource="timetracking" >
		INSERT INTO [timetracking].[dbo].[UserEntity] ( userID, entityID)
		SELECT aa.userID, aa.storyID
		FROM ( SELECT min(a.typeid) as typeid, b.userID, a.sprintID, a.storyID
			   FROM [timetracking].[dbo].[Entity] a, (select userID, assignableID from [targetprocess].[dbo].[Team] where userID in (select userid FROM [timetracking].[dbo].[User])) b
			   WHERE a.sprintID = #strLocal.qTPsprints.GeneralID#
			     AND a.entityID = b.assignableID
			   GROUP BY b.userID, a.sprintID, a.storyID ) aa
		WHERE typeid > 1
		EXCEPT
		SELECT userID, entityID
		FROM [timetracking].[dbo].[UserEntity]
		</cfquery>
		
		<!--- this insert all new assignable items --->
		<cfquery name="strLocal.insertUserEntity" datasource="timetracking" >
		INSERT INTO [timetracking].[dbo].[UserEntity] ( userID, entityID)
		SELECT b.userID, a.entityID
		FROM [timetracking].[dbo].[Entity] a, (select userID, assignableID from [targetprocess].[dbo].[Team] where userID in (select userid FROM [timetracking].[dbo].[User])) b
		WHERE a.sprintID = #strLocal.qTPsprints.GeneralID#
		  and a.entityID = b.assignableID
		EXCEPT
		SELECT userID, entityID
		FROM [timetracking].[dbo].[UserEntity]
		</cfquery>

		<!--- this insert all new project items --->
		<cfquery name="strLocal.insertUserEntity" datasource="timetracking" >
		INSERT INTO [timetracking].[dbo].[UserEntity] ( userID, entityID)
		SELECT distinct b.userid, a.projectid--, b.entityID, a.entityid, a.sprintid, a.typeid, a.name, a.storyid 
		FROM [timetracking].[dbo].[Entity] a, [timetracking].[dbo].[UserEntity] b
		WHERE a.entityID = b.entityID
		  and a.sprintid = #strLocal.qTPsprints.GeneralID#
		EXCEPT
		SELECT userID, entityID
		FROM [timetracking].[dbo].[UserEntity]
		</cfquery>

	</cfoutput>

</cffunction>


<cffunction access="public" name="getEntitiesSprintUser" output="false" returntype="query" roles="user" displayname="Get query of stories in sprint for user" hint="Get query of stories in sprint by user">
	<cfargument name="sprint" type="numeric" required="true" >
	<cfargument name="userid" type="numeric" required="true" >

	<cfquery name="qStoriesSprintUser" datasource="timetracking">
	SELECT a.userID, a.entityID, b.typeID, b.name, b.sprintID, b.storyID, b.projectID
	FROM [timetracking].[dbo].[UserEntity] a, [timetracking].[dbo].[Entity] b
	WHERE a.entityID = b.entityID
	  AND b.sprintID = #arguments.sprint#
	  AND a.userID = #arguments.userid#
	ORDER BY storyID, entityID, typeID
	</cfquery>

	<cfreturn qStoriesSprintUser />
</cffunction>


<cffunction access="remote" name="addUserEntityTime" output="true" returntype="query" roles="user" displayname="add/update record in UserEntityTime" hint="add/update record in UserEntityTime">
	<cfargument name="userid" type="numeric" required="true" >
	<cfargument name="timedata" type="string" required="true" >
	<cfargument name="entityEffort" type="numeric" required="true" >

	<cfset var strLocal = structNew()>
	
	<!--- convert timedata to EntityID and date --->
	<cfset strLocal.xxx = arguments.timedata>
	<!---20150202-6786--->

	<cfset strLocal.logdatetime = CREATEODBCDATETIME( Now() ) />
	<cfset strLocal.entityID = mid(arguments.timedata, find("-", arguments.timedata)+1, len(arguments.timedata))>
	<cfset strLocal.entityDate = mid(arguments.timedata,1,4)&'-'&mid(arguments.timedata,5,2)&'-'&mid(arguments.timedata,7,2)>
	
	<cfquery name="qUserEntityTime" datasource="timetracking">
	SELECT *
	FROM [timetracking].[dbo].[UserEntityTime]
	WHERE userID = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" >
	  AND timeData =<cfqueryparam value="#arguments.timedata#" cfsqltype="cf_sql_varchar" >;
	</cfquery>

	<cfif qUserEntityTime.recordCount>
		<cfquery name="updateUserEntityTime" datasource="timetracking">
		UPDATE [timetracking].[dbo].[UserEntityTime]
		SET entityEffort = <cfqueryparam value="#arguments.entityEffort#" cfsqltype="cf_sql_double" >,
		   logDate = <cfqueryparam value="#strLocal.logdatetime#" cfsqltype="cf_sql_timestamp">
		WHERE userID = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" >
		  AND timeData = <cfqueryparam value="#arguments.timedata#" cfsqltype="cf_sql_varchar" >;
		</cfquery>
	<cfelse>
		<cfquery name="insertUserEntityTime" datasource="timetracking">
		INSERT INTO [timetracking].[dbo].[UserEntityTime] (userID, timedata, entityID, entityDate, entityEffort, logDate, billable)
		VALUES (<cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" >,
				<cfqueryparam value="#arguments.timedata#" cfsqltype="cf_sql_varchar" >,
				<cfqueryparam value="#strLocal.entityID#" cfsqltype="cf_sql_integer" >,
				<cfqueryparam value="#strLocal.entityDate#" cfsqltype="cf_sql_date" >,  
			    <cfqueryparam value="#arguments.entityEffort#" cfsqltype="cf_sql_double" >,
			    <cfqueryparam value="#strLocal.logdatetime#" cfsqltype="cf_sql_timestamp">, 
			   null); 
		</cfquery>
	</cfif>
	
	<cfset strLocal.qUserDailyTime = getUserEntityEffortDate(arguments.userid, strLocal.entityDate)>

	<cfreturn strLocal.qUserDailyTime />

</cffunction>

<cffunction access="public" name="getUserEntityEffortDate" output="false" returntype="query" roles="user" displayname="get daily sum UserEntityTime" hint="get daily sum UserEntityTime">
	<cfargument name="userid" type="numeric" required="true" >
	<cfargument name="entityDate" type="date" required="true" >
	
	<cfset var strLocal = structNew()>

	<cfset strLocal.DOW = ucase(dateformat(arguments.entityDate, "DDD"))>

	<cfquery name="strLocal.qUserDailyTime" datasource="timetracking">
	SELECT sum(entityEffort) as dailyEffort, '#strLocal.DOW#' as DOW
	FROM [timetracking].[dbo].[UserEntityTime]
	WHERE userID = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" >
	  AND entityDate = <cfqueryparam value="#arguments.entityDate#" cfsqltype="cf_sql_date" >
	</cfquery>

	<cfreturn strLocal.qUserDailyTime />
</cffunction>

<cffunction access="remote" name="getUserEntityEffortWeek" output="true" returntype="query" roles="user" displayname="get weekly sum UserEntityTime" hint="get weekly sum UserEntityTime">
	<cfargument name="userid" type="numeric" required="true" >
	<cfargument name="entityDate" type="date" required="true" >

	<cfset var strLocal = structNew()>
	
	<cfset strLocal.dtFirstDate = getFirstDateOfWeek(arguments.entityDate)>
	<cfset strLocal.dtEndDate = dateAdd('d', 6, strLocal.dtFirstDate)>
	
	<cfquery name="strLocal.qUserWeeklyTime" datasource="timetracking">
	SELECT sum(entityEffort) as weeklyEffort
	FROM [timetracking].[dbo].[UserEntityTime]
	WHERE userID = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" >
	  AND entityDate >= <cfqueryparam value="#strLocal.dtFirstDate#" cfsqltype="cf_sql_date" >
	  AND entityDate <= <cfqueryparam value="#strLocal.dtEndDate#" cfsqltype="cf_sql_date" >
	</cfquery>

	<cfreturn strLocal.qUserWeeklyTime />
</cffunction>

<cffunction access="public" name="getFirstDateOfWeek" output="false" returntype="date" displayname="input date and return ">
	<cfargument name="entityDate" type="date" required="true" >
		
	<cfset var strLocal = structNew()>
	
	<cfset strLocal.nDay = dayOfWeek(arguments.entityDate)>

	<cfswitch expression="#strLocal.nDay#">
		<!--- our week is Monday - Sunday --->
		<cfcase value="1">
			<cfset strLocal.dtFirstDate = dateAdd('d', -6, arguments.entityDate)>
		</cfcase>
		<cfcase value="2">
			<cfset strLocal.dtFirstDate = dateAdd('d', 0, arguments.entityDate)>
		</cfcase>
		<cfcase value="3">
			<cfset strLocal.dtFirstDate = dateAdd('d', -1, arguments.entityDate)>
		</cfcase>
		<cfcase value="4">
			<cfset strLocal.dtFirstDate = dateAdd('d', -2, arguments.entityDate)>
		</cfcase>
		<cfcase value="5">
			<cfset strLocal.dtFirstDate = dateAdd('d', -3, arguments.entityDate)>
		</cfcase>
		<cfcase value="6">
			<cfset strLocal.dtFirstDate = dateAdd('d', -4, arguments.entityDate)>
		</cfcase>
		<cfcase value="7">
			<cfset strLocal.dtFirstDate = dateAdd('d', -5, arguments.entityDate)>
		</cfcase>
	</cfswitch>
	
	<cfreturn strLocal.dtFirstDate />
	
</cffunction>

<cffunction access="public" name="getAllOutOfOfficeStartDate" output="false" returntype="query" roles="user" displayname="Get query of all users out of office from a date on" hint="Get query of all users out of office from a date on">
	<cfargument name="startDate" type="date" required="true" >

	<cfquery name="qAllOutOfOffice" datasource="timetracking">
	SELECT a.userID, a.timeData, a.entityID, a.entityDate, a.entityEffort, a.logDate, b.name, c.fname, c.lname
	FROM [timetracking].[dbo].[UserEntityTime] a, 
		 (SELECT distinct entityID, typeID, name FROM [timetracking].[dbo].[Entity] ) b,
		 [timetracking].[dbo].[User] c 
	where a.entityID = b.entityID
	  and a.userID = c.userID
	  and b.typeID = 6
	  and entityDate >= '#dateformat(arguments.startDate, "yyyy/mm/dd")#'
	order by a.userID, a.entityDate
	</cfquery>

	<cfreturn qAllOutOfOffice />
</cffunction>


</cfcomponent>