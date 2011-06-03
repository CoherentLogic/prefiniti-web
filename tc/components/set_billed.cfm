<cfparam name="bVal" default="">
<cfif url.value EQ "true">
	<cfset bVal = 1>
<cfelse>
	<cfset bVal = 0>
</cfif>		
<cfquery name="sbilled" datasource="webwarecl">
	UPDATE 	time_card 
	SET 	billed=#bVal#, 
			billed_date=#CreateODBCDate(URL.billed_date)#
	WHERE 	id=#url.id#
</cfquery>    

<cfmodule template="/tc/orms_do.cfm" id="#url.id#">