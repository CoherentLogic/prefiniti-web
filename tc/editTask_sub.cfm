<link href="../css/gecko.css" rel="stylesheet" type="text/css">

<cfquery name="writeTaskChanges" datasource="webwarecl">
	UPDATE task_codes 
	SET	task_id=#url.task_id#,
		item='#url.item#',
		description='#url.description#',
		rate=#url.rate#,
		charge_type='#url.charge_type#'
	WHERE id=#url.taskcode_id#
		
</cfquery>

<p style="color:red">Task code saved.</p>

<div id="pageScriptContent" style="display:none;">
	AjaxLoadPageToDiv('tcTarget', '/tc/taskCodes.cfm');
</div>    
