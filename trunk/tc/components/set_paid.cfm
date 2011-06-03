<cfset pVal = 0>
<cfif url.value EQ "true">
	<cfset pVal = 1>
</cfif>
	
<cfquery name="sbilled" datasource="webwarecl">
	UPDATE 	time_card 
	SET 	paid=#pVal#,
			paid_date=#CreateODBCDate(url.paid_date)#,
			check_number='#url.check_number#' 
	WHERE 	id=#url.id#
</cfquery>    

<cfmodule template="/tc/orms_do.cfm" id="#url.id#">