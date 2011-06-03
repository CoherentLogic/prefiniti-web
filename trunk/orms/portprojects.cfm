<cfquery name="getAllProjects" datasource="webwarecl">
	SELECT id FROM projects
</cfquery>

<cfoutput query="getAllProjects">
	#id#,&nbsp;
	<cfmodule template="/workFlow/orms_do.cfm" id="#id#">
</cfoutput>		