<cfquery name="getSiteName" datasource="sites">
	SELECT siteName FROM sites WHERE SiteID=#attributes.id#
</cfquery>

<cfoutput>#getSiteName.siteName#</cfoutput>