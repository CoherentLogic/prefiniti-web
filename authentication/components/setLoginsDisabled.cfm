<cfquery name="setLoginsDisabled" datasource="webwarecl">
	UPDATE config SET logins_disabled=#url.logins_disabled#
</cfquery>