<!---

var url = '/workFlow/sections/milestones/mtc_update.cfm?milestone_id=' + escape(milestone_id);
	url += '&taskcode_id=' + escape(taskcode_id);
	url += '&billing_type=' + escape(billing_type);
	url += '&written=' + escape(written);
	url += '&rate=' + escape(rate);
	url += '&charge_type=' + escape(charge_type);
	
--->

<cfquery name="get_written" datasource="webwarecl">
	SELECT * FROM project_milestone_task_codes WHERE task_code_id=#url.taskcode_id# AND milestone_id='#url.milestone_id#'
</cfquery>


<cfif get_written.RecordCount GT 0 AND URL.written EQ "false">
	<cfquery name="delete_ass" datasource="webwarecl">
		DELETE FROM project_milestone_task_codes WHERE task_code_id=#url.taskcode_id# AND milestone_id='#url.milestone_id#'
	</cfquery>
	Record deleted.
<cfelseif get_written.RecordCount EQ 0 AND URL.written EQ "true">
	<cfquery name="mtc_insert" datasource="webwarecl">
		INSERT INTO project_milestone_task_codes
			(id,
			milestone_id,
			task_code_id,
			billing_type,
			rate,
			charge_type)
		VALUES
			('#CreateUUID()#',
			'#url.milestone_id#',
			#url.taskcode_id#,
			'#url.billing_type#',
			#url.rate#,
			'#url.charge_type#')
	</cfquery>	
	Record inserted.
<cfelseif get_written.RecordCount GT 0 AND URL.written EQ "true">
	<cfquery name="mtc_update" datasource="webwarecl">
		UPDATE 	project_milestone_task_codes
		SET		billing_type='#url.billing_type#',
				rate=#url.rate#,
				charge_type='#url.charge_type#'
		WHERE	task_code_id=#url.taskcode_id#
		AND		milestone_id='#url.milestone_id#'
	</cfquery>
	Record updated.
<cfelse>
			
</cfif>	