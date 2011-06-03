<cfquery name="h" datasource="webwarecl">
	SELECT hours FROM time_entries WHERE timecard_id=#attributes.timecard_id#
</cfquery>

<cfparam name="hs" default="0">

<cfset hs="0">

<cfoutput query="h">
	<cfset hs=#hs#+#hours#>
</cfoutput>

<cfoutput>#hs#</cfoutput>