<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="CreateTimesheet" datasource="webwarecl">
	INSERT INTO time_card 
		(emp_id,
		date,
		JobDescription,
		startTime,
		submitID,
        site_id)
	VALUES (#url.emp_id#,
			#CreateODBCDateTime(url.date)#,
			'#url.JobDescription#',
			#CreateODBCDateTime(url.startTime)#,
			'#url.submitID#',
            #url.current_site_id#)		
</cfquery>

<cfquery name="gTSid" datasource="webwarecl">
	SELECT id FROM time_card WHERE submitID='#url.submitID#'
</cfquery>

<cfmodule template="/tc/orms_do.cfm" id="#gTSid.id#">


<!---
<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="string" required="yes">
    <cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	
	--->


<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_CREATED", url.current_site_id, "A new timesheet was opened by #getLongname(url.emp_id)#.", "")#
</cfoutput>	

<cfoutput>
#pfCreateItem(URL.JobDescription, 0, 2, gTSid.id, "SYSOBJ", URL.emp_id)#
<div id="pageScriptContent" style="display:none;">
	openTS(#gTSid.id#, 'tcTarget');
</div>
</cfoutput>
