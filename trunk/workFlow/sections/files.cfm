<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workflow/workflow_udf.cfm">

	<cfquery name="projectInfo" datasource="webwarecl">
	    SELECT * FROM projects WHERE id=#attributes.r_pk#
	</cfquery>
	

	<cfset orec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
	<cfset orec.GetByTypeAndPK("Project", attributes.r_pk)>
	
	<cfif orec.CanWrite(session.user.r_pk)>
		<cfset canEdit = 1>
	<cfelse>
		<cfset canEdit = 0>
	</cfif>
	<cfoutput><a href="javascript:viewPrintable('#attributes.r_pk#')">Printable View</a></cfoutput>
	<strong class="OH_HEADER">Project Files</strong>
	<cfmodule template="/workflow/components/project_files.cfm" project_id="#attributes.r_pk#"><br />
    <div style="height:40px; overflow:hidden;">
	<div style="padding:8px;">
	<cfoutput>
	<a class="button" href="##" onclick="cmsBrowseFolder(#session.user.r_pk#, 'project_files', '#projectInfo.clsJobNumber#', 'site', '');"><span>Staging Area</span></a>
	</cfoutput>
	</div>
	</div>