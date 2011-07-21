<cfquery name="so" datasource="webwarecl">
	UPDATE Users SET online=0 WHERE id=#attributes.id#
</cfquery>