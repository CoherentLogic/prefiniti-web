<!---
	<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="string" required="yes">
    <cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">
	
	
	<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">
--->
<cfinclude template="/notifications/notification_udf.cfm">
<cfquery name="writeRFP" datasource="webwarecl">
	UPDATE projects
    SET	ScopeOfServices='#url.ScopeOfServices#',
    	RateSchedule='#url.RateSchedule#',
        Timeline='#url.Timeline#',
        Contract='#url.Contract#',
        TotalCost=#url.TotalCost#,
        rfp_processed=1
	WHERE id=#url.projectID#
</cfquery>   

<cfquery name="projectInfo" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.projectID#
</cfquery>    

<cfparam name="et" default="">
<cfset et="Your proposal is ready for review for #projectInfo.description#.">

<cfoutput>
	#ntBusinessEventNotify("WF_RFP_POSTED", url.current_site_id, "An RFP was posted.", "")#
    #ntNotify(projectInfo.clientID, "WF_RFP_POSTED", et, "")#
</cfoutput>

<cfoutput>
<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Proposal submitted.</h1>
            
            <p class="VPLink"><a href="javascript:loadProjectViewer(#url.projectID#);">View project</a></p>
        </td>
    </tr>
</table>    

</cfoutput>