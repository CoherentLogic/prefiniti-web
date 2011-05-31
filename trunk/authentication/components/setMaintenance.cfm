<cfquery name="setMaintenance" datasource="webwarecl">
	UPDATE config SET maintenance=#url.maintenance#
</cfquery>