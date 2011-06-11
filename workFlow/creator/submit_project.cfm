<cfset ptA = ListToArray(url.project_type, "^")>
<cfset ServiceType = ptA[1]>
<cfset jobtype = ptA[2]>

<cfquery name="create_project" datasource="webwarecl">
	INSERT INTO projects
		(site_id,
		description,
		reqid,
		duedate,
		ServiceType,
		jobtype,
		status,
		SubStatus,
		viewed,
		stage,
		clientID,
		subdivision)
	VALUES
		(#url.site_id#,
		'#url.description#',
		'#url.om_uuid#',
		#CreateODBCDateTime(url.duedate)#,
		'#ServiceType#',
		'#jobtype#',
		0,
		"Pending",
		0,
		0,
		#URL.client_id#,
		14)
</cfquery>

<cfquery name="get_r_pk" datasource="webwarecl">
	SELECT id FROM projects WHERE reqid='#url.om_uuid#'
</cfquery>
<div style="display:none;">
<cfmodule template="/workFlow/orms_do.cfm" id="#get_r_pk.id#">
<cfset po = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK("Project", get_r_pk.id)>
<cfset po.DoAccess("View", url.client_id)>
</div>
<cfoutput>
<a class="button" href="##" onclick="CloseORMSDialog(); loadProjectViewer(#get_r_pk.id#);"><span><strong>Finish</strong></span></a>
</cfoutput>
			