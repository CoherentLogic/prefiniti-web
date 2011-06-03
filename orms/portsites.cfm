<cfquery name="get_sites" datasource="sites">
	SELECT SiteID FROM sites
</cfquery>

<cfoutput query="get_sites">
	<cfmodule template="/authentication/Sites/orms_do.cfm" id="#SiteID#">
</cfoutput>	