<cfquery name="get_mail" datasource="webwarecl">
	SELECT id FROM messageinbox
</cfquery>

<cfoutput query="get_mail">
	<cfmodule template="/mail/orms_do.cfm" id="#id#">
</cfoutput>	