<cfinclude template="/notifications/notification_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfquery name="c" datasource="webwarecl">
	SELECT * FROM Users WHERE id='#attributes.clientID#'
</cfquery>

<cfparam name="pstatval" default="">
<cfif #attributes.Status# EQ 0>
	<cfset pstatval="Incomplete">
<cfelse>
	<cfset pstatval="Complete">
</cfif>

<cfoutput>
	#ntBusinessEventNotify("WF_PROJECT_STATUS_CHANGED", url.current_site_id, 
    						"New project status (project #attributes.clsJobNumber#): #pstatval#/#attributes.SubStatus#.",
                            "loadProjectViewer(#attributes.id#)")#
	<!--- below lines disabled per request of anchomex 6/2/2008 --->
    <!--- ...and put back in, on the same night --->
	#ntNotify(attributes.clientID, "WF_PROJECT_STATUS_CHANGED", "New project status (your project #attributes.clientJobNumber#, #attributes.description#): #pstatval#/#attributes.SubStatus#.", "")#
    
    
</cfoutput>

<!---<cfmail to="#c.email#" from="donotreply@centerlineservices.biz" subject="Center Line Services - Job Status Changed" type="html">
	<h1>Job Status Changed</h1>
	
	<table>
		<tr>
			<td>Your Job Number:</td>
			<td>#attributes.clientJobNumber#</td>
		</tr>
		<tr>
			<td><strong>New Job Status:</strong></td>
			<td><cfif #attributes.Status# EQ 0>Incomplete<cfelse>Complete</cfif>/#attributes.SubStatus#</td>
		</tr>
	</table>
	<p><a href="http://www.webwarecl.com/projectView.cfm?id=#attributes.id#">View Project</a></p>
</cfmail>--->

