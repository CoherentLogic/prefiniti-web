<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="ap" datasource="webwarecl">
	UPDATE time_card SET closed=2 WHERE id=#url.id#
</cfquery>

<cfquery name="gtc" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#url.id#
</cfquery>    

<cfmodule template="/tc/orms_do.cfm" id="#url.id#">

<cfmodule template="/tc/components/tcStatus.cfm" id="#url.id#">

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_APPROVED", url.current_site_id, "A timesheet was approved for #getLongname(gtc.emp_id)# by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	

<cfoutput>
#ntNotify(gtc.emp_id, "TC_TIMESHEET_APPROVED", "One of your signed timesheets was approved by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	