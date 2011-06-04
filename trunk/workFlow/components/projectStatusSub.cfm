<cfquery name="setProjectStatus" datasource="webwarecl">
	UPDATE projects
	SET		status=#url.status#,
			SubStatus='#url.SubStatus#'
	WHERE	id=#url.id#
</cfquery>
<cfmodule template="/workFlow/orms_do.cfm" id="#url.id#">

<cfquery name="p" datasource="webwarecl">
	SELECT clientID, clientJobNumber, status, subStatus, clsJobNumber, description FROM projects WHERE id=#url.id#
</cfquery>

<cfmodule template="/workFlow/components/projectStatusNotify.cfm" id="#url.id#" clientID="#p.clientID#" clientJobNumber="#p.clientJobNumber#" status="#p.status#" subStatus="#p.subStatus#" clsJobNumber="#p.clsJobNumber#" description="#p.description#">

