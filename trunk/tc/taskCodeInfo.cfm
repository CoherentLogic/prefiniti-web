<link href="../css/gecko.css" rel="stylesheet" type="text/css">

<cfquery name="taskcodeInfo" datasource="webwarecl">
	SELECT * FROM task_codes WHERE id=#url.id#
</cfquery>

<table cellspacing="0" cellpadding="5" width="100%">
	<cfoutput query="taskcodeInfo">
	<tr>
		<td>Task Code:</td>
		<td>#task_id#</td>
	</tr>
	<tr>
		<td>Item:</td>
		<td>#item#</td>
	</tr>
	<tr>
		<td>Description:</td>
		<td>#description#</td>
	</tr>
	<tr>
		<td>Rate:</td>
		<td>$#rate#/#charge_type#</td>
	</tr>
	</cfoutput>
</table>