<cfquery name="m" datasource="webwarecl">
	SELECT mileage FROM time_entries WHERE timecard_id=#attributes.timecard_id#
</cfquery>

<cfparam name="ms" default="0">

<cfset ms="0">

<cfoutput query="m">
	<cfset ms=#ms#+#mileage#>
</cfoutput>

<cfoutput>#ms#</cfoutput>