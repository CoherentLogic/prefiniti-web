

<cfquery name="taskCode" datasource="webwarecl">
	SELECT task_id, item FROM task_codes WHERE id=#attributes.id#
</cfquery>

<cfoutput query="taskCode">
	#item#
</cfoutput>