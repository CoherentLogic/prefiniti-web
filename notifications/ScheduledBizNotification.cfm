<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">


<!---
<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="string" required="yes">
    <cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	
	--->
	
    
<cfquery name="gsn" datasource="webwarecl">
	SELECT * FROM scheduled_business_notifications WHERE scheduler_task='#URL.event_guid#'
</cfquery>

<cfif gsn.RecordCount GT 0>
	<cfif gsn.event_key EQ "TC_MISSING_TS"> <!--- check to see if the timesheet is actually missing --->
    	<cfparam name="tDate" default="">
        <cfparam name="todayDate" default="">
        
        <cfset tDate = DateFormat(Now(), "mm/dd/yyyy")>
        <cfset todayDate = CreateODBCDate(tDate)>
        
        <cfquery name="getTCC" datasource="webwarecl">
        	SELECT 	COUNT(id) AS tcc 
            FROM 	time_card 
            WHERE 	emp_id=#gsn.concerning_user#
            AND		date=#todayDate#
        </cfquery>
        
        <cfif getTCC.tcc EQ 0>
        	<cfoutput query="gsn">#ntBusinessEventNotify(event_key, site_id, body_text, "")#</cfoutput>
		</cfif>
                    
    <cfelse>
		<cfoutput query="gsn">#ntBusinessEventNotify(event_key, site_id, body_text, "")#</cfoutput>        
	</cfif>        
</cfif>