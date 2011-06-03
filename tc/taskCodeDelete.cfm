<cfquery name="JohnIsADumbass" datasource="webwarecl">
	DELETE FROM task_codes WHERE id=#URL.id#
</cfquery>

<div id="pageScriptContent">
	AjaxLoadPageToDiv('tcTarget', '/tc/taskCodes.cfm');    
</div>    