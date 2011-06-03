<cfquery name="getLI" datasource="webwarecl">
	SELECT * FROM time_entries WHERE timecard_id=#attributes.id#
</cfquery>

<cfoutput query="getLI">
	Applying project number #attributes.project_number# to line item #getLI.id#<br />
</cfoutput>    

<cfquery name="uli" datasource="webwarecl">
	UPDATE time_entries SET project_number='#attributes.project_number#' WHERE timecard_id=#attributes.id#
</cfquery>    

