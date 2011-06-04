<!--
<wwafcomponent>Delinquent Orders</wwafcomponent>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
<cfquery name="od" datasource="webwarecl">
	SELECT * FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 30 DAY) > duedate AND SubStatus <> "Closed";
</cfquery>
<form name="reminders" id="reminders" action="sendReminders.cfm" method="post">
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Delinquent Orders</h3>
<table width="100%" cellpadding="10">

	<tr>
		<th><img align="absmiddle" src="graphics/email.png"/> </th>
		<th>Job Number</th>
		<th>Job Title</th>
		<th>Due Date</th>
		<th>Days Past Due</th>
	</tr>
	<cfoutput query="od">
		
		<tr>
			<td><input type="checkbox" name="#clsJobNumber#" value="#clsJobNumber#" checked/></td>
			<td><a href="javascript:loadProjectViewer(#id#);">#clsJobNumber#</a></td>
			<td>#description#</td>
			<td>#DateFormat(duedate, "mm/dd/yyyy")#</td>
			<td><font color="red">#DateDiff("d", duedate, Now())# days past due</font> </td>
		</tr>
	</cfoutput>
	<tr>
		<td colspan="5" align="right"><input type="button" class="normalButton" name="submit" value="Send Reminders" onclick="AjaxSubmitForm(AjaxGetElementReference('reminders'), '/workflow/components/sendReminders.cfm', 'tcTarget');" /></td>
	</tr>
</table>
</form>
