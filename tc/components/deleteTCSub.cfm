<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="dtc" datasource="webwarecl">
	DELETE FROM time_card WHERE id='#url.id#'
</cfquery>

<table width="100%">
	<tr>
		<th>Timesheet Deleted</th>
	</tr>
	<tr>
		<td align="center"><p class="VPLink">Timesheet deleted</p></td>
	</tr>
</table>

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_DELETED", url.current_site_id, "A timesheet was deleted by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	