<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="editLISub" datasource="webwarecl">
	UPDATE time_entries
	SET hours=#url.hours#,
		description='#url.description#',
		taskCodeID=#url.taskCodeID#,
		odStart=#url.odStart#,
		odEnd=#url.odEnd#,
		mileage=#url.mileage#,
        project_number='#url.project_number#'
	WHERE
		id=#url.id#
</cfquery>
<cfmodule template="/tc/orms_do.cfm" id="#url.timecard_id#">
<cfoutput>
<table width="100%">
	<tr>
		<td align="center">
			<h1>Line Item Saved</h1>
			<p class="VPLink"><a href="javascript:openTS(#url.timecard_id#, 'tcTarget');">Return to Timesheet View</a></p>
		</td>
	</tr>
</table>
</cfoutput>

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_EDITED", url.current_site_id, "A timesheet line item was edited by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	