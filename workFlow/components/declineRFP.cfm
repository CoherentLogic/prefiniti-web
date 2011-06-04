<cfinclude template="/notifications/notification_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="projectInfo" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.id#
</cfquery>

<cfparam name="et" default="">
<cfset et="The proposal for #projectInfo.description# has been declined.">

<cfquery name="udRFP" datasource="webwarecl">
	DELETE FROM projects WHERE id=#url.id#
</cfquery>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Proposal Declined.</h1>
                    
			<cfoutput>
				#ntBusinessEventNotify("WF_RFP_DECLINED", url.current_site_id, et, "")#	
			</cfoutput>
            
            <cfoutput><p class="VPLink"><a href="javascript:loadHomeView();">Home</a></p></cfoutput>
        </td>
	</tr>
</table>            
