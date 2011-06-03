<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="writeItem" datasource="webwarecl">
	INSERT INTO time_entries
		(hours,
		description,
		taskCodeID,
		timecard_id,
		odStart,
		odEnd,
		mileage,
        project_number)
	VALUES
		(#url.hours#,
		'#url.description#',
		#url.taskCodeID#,
		#url.timecard_id#,
		#url.odStart#,
		#url.odEnd#,
		#url.mileage#,
        '#url.project_number#')
</cfquery>

<cfoutput>
<table width="100%">
	<tr>
		<td align="center">
			<h1>Line Item Saved</h1>
			<p class="VPLink"><a href="javascript:openTS(#url.timecard_id#, 'tcTarget');">Return to Timesheet View</a></p>
		</td>
	</tr>
</table>

<div id="pageScriptContent" style="display:none;">
	openTS(#url.timecard_id#, 'tcTarget');
</div>

</cfoutput>

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_EDITED", url.current_site_id, "A timesheet line item was added by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	