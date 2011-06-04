<cfquery name="get_project_id" datasource="webwarecl">
	SELECT * FROM project_milestones WHERE id='#url.milestone_id#'
</cfquery>

<cfquery name="get_site_id" datasource="webwarecl">
	SELECT site_id FROM projects WHERE id=#get_project_id.project_id#
</cfquery>	

<cfquery name="get_task_codes" datasource="webwarecl">
	SELECT * FROM task_codes WHERE site_id=#get_site_id.site_id#
</cfquery>

<strong>Assign task codes to Milestone:</strong> <cfoutput>#get_project_id.milestone#</cfoutput>

<div style="width:570px; border:1px solid #c0c0c0; height:160px; overflow:auto; margin-top:5px;">
	<table width="100%">
	<cfoutput query="get_task_codes">	
		<cfmodule template="/workFlow/sections/milestones/task_asgn_row.cfm" milestone_id="#url.milestone_id#" taskcode_id="#id#">
	</cfoutput>
	</table>	
</div>

<div id="MTC_Update" style="width:570px; border:1px solid #c0c0c0; height:40px; overflow:auto; padding:5px; font-size:10px; color:#c0c0c0">
		
</div>