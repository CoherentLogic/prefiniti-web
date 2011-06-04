<cfquery name="gSub" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE id=#attributes.id#
</cfquery>

<cfoutput>#gSub.name#</cfoutput>