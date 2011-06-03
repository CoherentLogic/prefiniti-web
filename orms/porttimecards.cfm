<cfquery name="ptc" datasource="webwarecl">
	SELECT id FROM time_card
</cfquery>

<cfoutput query="ptc">
	<cfmodule template="/tc/orms_do.cfm" id="#id#">
</cfoutput>		