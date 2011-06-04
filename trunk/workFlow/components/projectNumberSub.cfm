<cfquery name="pnUpdate" datasource="webwarecl">
	UPDATE projects
	SET		clsJobNumber='#url.clsJobNumber#'
	WHERE	id=#url.id#
</cfquery>

<cfmodule template="/workFlow/orms_do.cfm" id="#url.id#">