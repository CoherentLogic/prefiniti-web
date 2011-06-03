<cfquery name="writeTaskCode" datasource="webwarecl">
	INSERT INTO task_codes
		(task_id,
		item,
		description,
		rate,
		charge_type,
        site_id,
		om_uuid)
	VALUES
		(#url.task_id#,
		'#url.item#',
		'#url.description#',
		#url.rate#,
		'#url.charge_type#',
        #url.current_site_id#,
		'#CreateUUID()#')
</cfquery>

<div align="center" style="width:100%;">
	<h1>Task code created</h1>
    
    <p class="VPLink"><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/taskCodes.cfm');">Return to Task Codes</a></p>
</div>
