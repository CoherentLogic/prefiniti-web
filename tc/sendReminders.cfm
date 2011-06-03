<cfquery name="smsUsers" datasource="webwarecl">
	SELECT * FROM Users WHERE type=1 AND receives_timesheet_reminders=1
</cfquery>


<cfoutput query="smsUsers">
	<cfmodule template="/tc/components/checkRem.cfm" userid="#smsUsers.id#">
</cfoutput>