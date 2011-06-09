<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">


<!---
<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
	--->
	
    
<cfquery name="gsn" datasource="webwarecl">
	SELECT * FROM scheduled_notifications WHERE scheduler_task='#URL.event_guid#'
</cfquery>

<cfif gsn.RecordCount GT 0>
<cfoutput query="gsn">#ntNotify(user_id, event_key, body_text, "")#</cfoutput>        
</cfif>