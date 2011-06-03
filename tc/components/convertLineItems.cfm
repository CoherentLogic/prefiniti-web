<cfquery name="GetTimeCards" datasource="webwarecl">
	SELECT id, clsJobNumber FROM time_card
</cfquery>


<cfoutput query="getTimeCards">
	<p><strong>Converting line items for timecard #id#...</strong></p>
    
    <blockquote>
    <cfmodule template="/tc/components/convertLineItems_li.cfm" id="#id#" project_number="#clsJobNumber#">
    </blockquote>
    
</cfoutput>    