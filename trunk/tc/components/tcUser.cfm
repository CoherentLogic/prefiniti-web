<cfquery name="u" datasource="webwarecl">
	SELECT longName FROM Users WHERE id=#attributes.id#
</cfquery>

<cfoutput query="u">#longName#</cfoutput>
