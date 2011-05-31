<!---
	$Id$
--->
<cfmodule template="/LandingPages/LandingHeader.cfm">

<cfquery name="MyDepts" datasource="sites">
	SELECT * FROM department_entries WHERE user_id=#url.calledByUser#
</cfquery>	

<cfset createProjectLink = CreateObject("component","res").GetByTypeAndPK("User Account", url.calledByUser).GetCreator("Project")>


<table width="100%" cellpadding="0" cellspacing="0">
<tr><td>
<h3>Orders &amp; Projects</h3>
<p style="margin-left:5px;">
	<!---<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Create New Project" url="ORMSDialog('#createProjectLink#');" help="Create New Project"><br />--->
	<cfmodule template="/framework/link.cfm" perm="WF_VIEW" linkname="View priority projects" url="/jobViews/priority.cfm" help="Priority Projects"><br />
	<cfmodule template="/framework/link.cfm" perm="WF_PROCESSORDER" linkname="Process new orders" url="/jobViews/newJobs.cfm" help="Process New Orders"><br />
    <cfmodule template="/framework/link.cfm" perm="WF_VIEW" linkname="" url="/jobViews/priority.cfm" help="Priority Projects"><br />
	
</p>

<h3>Project Manager 2.0 <span style="color:red;">(BETA)</span>
<p style="margin-left:5px;">
	<cfmodule template="/framework/link.cfm" perm="WF_VIEW" linkname="Projects at a glance" url="/pm/ProjectLists/AtAGlance.cfm" help="Projects at a glance"><br />
	
</p>

<h3>Time Entry</h3>
<p style="margin-left:5px;">
	<cfmodule template="/framework/link.cfm" perm="TS_CREATE" linkname="Start a new timesheet" url="NewTimesheet" help="Start a new timesheet"><br />
	<cfmodule template="/framework/link.cfm" perm="TS_VIEW" linkname="My open timesheets" url="MyOpenTimesheets" help="My open timesheets"><br />
	<cfmodule template="/framework/link.cfm" perm="TS_VIEW" linkname="This week's timesheets" url="/tc/components/timesheetsByWeek.cfm" help="This week's timesheets">
<br />
	<cfmodule template="/framework/link.cfm" perm="TS_VIEW_TC" linkname="Manage task codes" url="/tc/taskCodes.cfm" help="Manage task codes"><br />
</p>	
</td><td>
<h3>My Departments</h3>
<p style="margin-left:5px;">
	<cfoutput query="MyDepts">
		<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="" url="DepartmentLink" department_id="#department_id#" help="View department"><br />
	</cfoutput>
	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="View all my departments" url="MyDepartments" help="My departments"><br />
</p>
</td></tr></table>
			