<cfcomponent>

<cffunction access="public" name="getUsers" output="false" returntype="query" roles="user" displayname="Get query of active users" hint="Get query of active users">
			
	<cfquery name="qUsers" >
	select UserId, FirstName, Lastname, Email, IsActive, IsAdministrator, RoleId, ActiveDirectoryName 
	from TpUser
	where IsActive = 1
	  and ActiveDirectoryName is not null;
	</cfquery>

	<cfreturn qUsers />
</cffunction>

<cffunction access="public" name="getSprints" output="false" returntype="query" roles="user" displayname="Get query of Sprints" hint="Get query of Sprints">
			
	<cfquery name="qSprints" >
	select a.ID, a.Date, a.ModifierID, a.GeneralID, a.Name, a.StartDate, a.EndDate, a.CreateDate, a.Modifydate, a.NumericPriority, 
		a.ParentProjectID, a.OwnerID, a.LastEditorID, a.EntityTypeID, a.SquadIterationID, a.Velocity, a.SquadID
	from SquadIterationHistory a, (SELECT max(ID) as ID, GeneralID FROM SquadIterationHistory group by GeneralID) b, SquadIteration c
	where a.SquadIterationID = c.SquadIterationID 
	  and a.ID = b.ID
	order by Startdate Desc;
	</cfquery>

	<cfreturn qSprints />
</cffunction>

<cffunction access="public" name="getTPProjects" output="false" returntype="query" roles="user" displayname="Get query of TP Projects" hint="Get query of TP Projects">
			
	<cfquery name="qTPProjects" >
	select a.ID, a.Date, a.ModifierID, a.GeneralID, a.Name, a.Description, a.StartDate, a.EndDate, a.CreateDate, a.ModifyDate, a.Ownerid, a.IsActive, a.Abbreviation
	from ProjectHistory a, (select max(ID) as ID, GeneralID FROM ProjectHistory group by GeneralID) b
	where a.ID = b.ID
	  and a.DeleteDate is null
	  and a.IsActive = 1
	order by a.generalID desc
	</cfquery>

	<cfreturn qTPProjects />
</cffunction>

<cffunction access="public" name="getSprintsDates" output="true" returntype="query" roles="user" displayname="Get query of Sprints in date range" hint="Get query of Sprints in date range">
	<cfargument name="startdate" type="date" required="true" >
	<cfargument name="enddate" type="date" required="true" >

	<cfset var strLocal = structNew()>

	<cfset strLocal.dtStartDate = dateformat(arguments.startdate, "yyyy/mm/dd")> 
	<cfset strLocal.dtEndDate = dateformat(arguments.enddate, "yyyy/mm/dd")>

	<cfquery name="strLocal.qSprints" >
	select a.ID, a.Date, a.ModifierID, a.GeneralID, a.Name, a.Description, a.StartDate, a.EndDate, a.CreateDate
	from SquadIterationHistory a, (SELECT max(ID) as ID, GeneralID FROM SquadIterationHistory group by GeneralID) b
	where a.ID = b.ID
	  and (('#strLocal.dtStartDate#' BETWEEN a.StartDate AND a.Enddate) OR ('#strLocal.dtEndDate#' BETWEEN a.StartDate AND a.Enddate))
	order by a.Startdate Desc;
	</cfquery>

	<cfreturn strLocal.qSprints />
</cffunction>

<cffunction access="public" name="getStoriesSprint" output="false" returntype="query" roles="user" displayname="Get query of stories in sprint" hint="Get query of stories in sprint">
	<cfargument name="sprint" type="numeric" required="true" >

	<cfquery name="qStoriesSprint">
	select a.ID, a.Date, a.Modification, a.ModifierID, a.GeneralID, a.Name, a.Description, a.StartDate, a.EndDate, a.CreateDate, a.ModifyDate, 
		a.ParentProjectID, a.ProjectID, a.OwnerID, a.LastEditorID, a.EntityTypeID, a.AssignableID, a.Effort, a.EffortCompleted, a.EffortToDo, a.TimeSpent, 
		a.TimeRemain, a.EntityStateID, a.PriorityID, a.UserStoryID, a.SquadIterationID, a.SquadID
	 from UserStoryHistory a, (SELECT max(ID) as ID, GeneralID FROM UserStoryHistory group by GeneralID) b
	 where a.ID = b.ID
	   and a.SquadIterationID = #arguments.sprint#
	 order by a.Date desc;
	</cfquery>
		
	<cfreturn qStoriesSprint />
</cffunction>

<cffunction access="public" name="getTasksStory" output="false" returntype="query" roles="user" displayname="Get query of tasks in story for user" hint="Get query of tasks in story by user">
	<cfargument name="story" type="numeric" required="true" >

	<cfquery name="qTasksStory">
	select a.ID, a.GeneralID, a.Name, a.ParentProjectID, a.OwnerID, a.EntityTypeID, a.ProjectID, a.TaskID, a.UserStoryID, a.SquadIterationID
	from TaskHistory a, (SELECT max(ID) as ID, GeneralID FROM TaskHistory Group by GeneralID) b
	where a.ID = b.ID
	  and a.UserStoryID = #arguments.story#
	order by a.ID;
	</cfquery>

	<cfreturn qTasksStory />
</cffunction>

<cffunction access="public" name="getBugsStory" output="false" returntype="query" roles="user" displayname="Get query of bugs in story for user" hint="Get query of bugs in story by user">
	<cfargument name="story" type="numeric" required="true" >

	<cfquery name="qBugsStory">
	select a.ID, a.Date, a.ModifierID, a.GeneralID, a.Name, a.Description, a.StartDate, a.EndDate, a.CreateDate, a.ModifyDate, a.ParentProjectID, a.OwnerID, a.AssignableID, 
		a.Effort, a.ProjectID, a.IterationID, a.ParentID, a.ReleaseID, a.BugID, a.SeverityID, a.BuildID, a.UserStoryID, a.SquadIterationID, a.SquadID, a.FeatureID
	from BugHistory a, (SELECT max(ID) as ID, GeneralID FROM BugHistory group by GeneralID) b
	where a.ID = b.ID
	  and a.UserStoryID = #arguments.story#
	order by a.GeneralID;
	</cfquery>

	<cfreturn qBugsStory />
</cffunction>



<cffunction access="public" name="getStoriesSprintUser" output="false" returntype="query" roles="user" displayname="Get query of stories in sprint for user" hint="Get query of stories in sprint by user">
	<cfargument name="sprint" type="numeric" required="true" >
	<cfargument name="userid" type="numeric" required="true" >

	<cfquery name="qStoriesSprintUser">
	select a.ID, a.Date, a.Modification, a.ModifierID, a.GeneralID, a.Name, a.Description, a.StartDate, a.EndDate, a.CreateDate, a.ModifyDate, 
		a.ParentProjectID, a.OwnerID, a.LastEditorID, a.EntityTypeID, a.AssignableID, a.Effort, a.EffortCompleted, a.EffortToDo, a.TimeSpent, 
		a.TimeRemain, a.EntityStateID, a.PriorityID, a.UserStoryID, a.SquadIterationID, a.SquadID
	 from UserStoryHistory a, (SELECT max(ID) as ID, GeneralID FROM UserStoryHistory group by GeneralID) b
	 where a.ID = b.ID
	   and a.SquadIterationID = #arguments.sprint#
	   and a.GeneralId in (select AssignableID from Team where UserID = #arguments.userid#)
	 order by a.ID;
	</cfquery>

	<cfreturn qStoriesSprintUser />
</cffunction>

<cffunction access="public" name="getTasksStoryUser" output="false" returntype="query" roles="user" displayname="Get query of tasks in story for user" hint="Get query of tasks in story by user">
	<cfargument name="story" type="numeric" required="true" >
	<cfargument name="userid" type="numeric" required="true" >

	<cfquery name="qTasksStoryUser">
	select a.ID, a.GeneralID, a.Name, a.ParentProjectID, a.OwnerID, a.EntityTypeID, a.ProjectID, a.TaskID, a.UserStoryID
	from TaskHistory a, (SELECT max(ID) as ID, GeneralID FROM TaskHistory Group by GeneralID) b
	where a.ID = b.ID
	  and a.GeneralId in (select AssignableID from Team where UserID = #arguments.userid#)
	  and a.UserStoryID = #arguments.story#
	order by a.ID;
	</cfquery>

	<cfreturn qTasksStoryUser />
</cffunction>

<cffunction access="public" name="getBugsStoryUser" output="false" returntype="query" roles="user" displayname="Get query of bugs in story for user" hint="Get query of bugs in story by user">
	<cfargument name="story" type="numeric" required="true" >
	<cfargument name="userid" type="numeric" required="true" >

	<cfquery name="qBugsStoryUser">
	select a.ID, a.Date, a.ModifierID, a.GeneralID, a.Name, a.Description, a.StartDate, a.EndDate, a.CreateDate, a.ModifyDate, a.ParentProjectID, a.OwnerID, a.AssignableID, 
		a.Effort, a.ProjectID, a.IterationID, a.ParentID, a.ReleaseID, a.BugID, a.SeverityID, a.BuildID, a.UserStoryID, a.SquadIterationID, a.SquadID, a.FeatureID
	from BugHistory a, (SELECT max(ID) as ID, GeneralID FROM BugHistory group by GeneralID) b
	where a.ID = b.ID
	  and a.GeneralId in (select AssignableID from Team where UserID = #arguments.userid#)
	  and a.UserStoryID = #arguments.story#
	order by a.GeneralID;
	</cfquery>

	<cfreturn qBugsStoryUser />
</cffunction>
	
</cfcomponent>