<link href="../css/gecko.css" rel="stylesheet" type="text/css">

<script language="javascript">
	var startDateCal = new calendar2(document.forms['dateSel'].elements['startDate']);
	var endDateCal = new calendar2(document.forms['dateSel'].elements['endDate']);
</script>

<cfquery name="getUserName" datasource="webwarecl">
	SELECT longName FROM Users WHERE id=#url.emp_id#
</cfquery>

<form name="dateSel">
<table width="100%" cellpadding="8" cellspacing="0">
	<tr>
		<th colspan="2"><cfoutput>Select Date Range for #getUserName.longName#</cfoutput></th>
	</tr>
	<tr>
		<td align="right" width="50%">Start</td>
		<td align="left" width="50%"><input type="text" name="startDate"> <a href="javascript:startDateCal.popup();"><img src="img/cal.gif" border="0" width="16" height="16"></a></td>
	</tr>
	<tr>
		<td align="right" width="50%">End</td>
		<td align="left" width="50%"><input type="text" name="endDate"> <a href="javascript:endDateCal.popup();"><img src="img/cal.gif" border="0" width="16" height="16"></a></td>
	</tr>
</table>
</form>
