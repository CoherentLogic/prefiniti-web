<cfquery name="getAllUsers" datasource="webwarecl">
	SELECT id FROM users
</cfquery>

<cfoutput query="getAllUsers">
	<cfmodule template="/authentication/Users/orms_do.cfm" id="#id#">
</cfoutput>		