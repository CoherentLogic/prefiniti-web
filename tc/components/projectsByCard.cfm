<cfquery name="getPBC" datasource="webwarecl">
	SELECT DISTINCT project_number FROM time_entries WHERE timecard_id=#attributes.id#
</cfquery>

<cfoutput query="getPBC">
	#project_number#<br />
</cfoutput>        