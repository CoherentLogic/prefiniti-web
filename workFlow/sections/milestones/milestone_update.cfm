<cfset comp = 0>
<cfif URL.completed EQ true>
	<cfset comp = 1>
</cfif>

<cfset ds = 0>
<cfif URL.date_sensitive EQ true>
	<cfset ds = 1>
</cfif>

<cfquery name="milestone_update" datasource="webwarecl">
	UPDATE 	project_milestones
	SET		milestone='#url.milestone#',
			date_sensitive=#ds#,
			due_date=#CreateODBCDate(URL.due_date)#,
			completed=#comp#,
			budget=#URL.budget#
	WHERE	id='#URL.milestone_id#'
</cfquery>
<div style="font-size:14px; padding:10px;">
Milestone Updated.
</div>
			