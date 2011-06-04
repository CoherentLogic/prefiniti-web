<cfinclude template="/notifications/notification_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="udRFP" datasource="webwarecl">
	UPDATE projects
    SET		rfp=0,
    		rfp_accepted=1
    WHERE	id=#url.id#
</cfquery>

<cfquery name="projectInfo" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.id#
</cfquery>

<cfparam name="et" default="">
<cfset et="The proposal for #projectInfo.description# has been accepted.">
    

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Proposal Accepted.</h1>
            
            <p>This proposal has now been submitted as a project order.</p>
            
            
            
            <cfoutput>
				#ntBusinessEventNotify("WF_RFP_APPROVED", url.current_site_id, et, "")#															
			</cfoutput>
            
            <cfoutput><p class="VPLink"><a href="javascript:loadProjectViewer(#url.id#);">View project</a></p></cfoutput>
        </td>
	</tr>
</table>            
