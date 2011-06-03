<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="ap" datasource="webwarecl">
	UPDATE time_card SET closed=0 WHERE id=#url.id#
</cfquery>

<cfquery name="gtc" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#url.id#
</cfquery>    

<cfmodule template="/tc/orms_do.cfm" id="#url.id#">

<cfmodule template="/tc/components/tcStatus.cfm" id="#url.id#">

<!---
<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">
--->

<cfoutput>
#ntNotify(gtc.emp_id, "TC_TIMESHEET_REVERSED", "One of your signed timesheets was returned to you for corrections.", "")#
</cfoutput>	

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_REVERSED", url.current_site_id, "A timesheet for #getLongname(gtc.emp_id)# was reversed by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	