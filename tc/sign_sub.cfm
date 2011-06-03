<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="sign" datasource="webwarecl">
	UPDATE time_card SET
		closed=1,
		initials='#url.initials#'
	WHERE id=#url.id#
</cfquery>

<cfmodule template="/tc/orms_do.cfm" id="#url.id#">

<cfoutput>
	<table width="100%">
		<tr>
			<td align="center">
				<h2>Timesheet Signed.</h2>
				<p class="VPLink"><a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', 'no', '')">My Open Timesheets</a></p>
			</td>
		</tr>
	</table>
</cfoutput>

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_SIGNED", url.current_site_id, "A timesheet was signed by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	