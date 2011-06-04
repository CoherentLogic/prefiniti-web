<!---
	ATTRIBUTES:
	
	Context			PPM Context
	Selector		Context Selector
	Field			Target Field
	Label			Field Label
--->

<cfquery name="ctx" datasource="webwarecl">
	SELECT * FROM ppm_contexts WHERE ctx_name='#Attributes.Context#'
</cfquery>    

<cfquery name="GetThisField" datasource="#attributes.Datasource">
	<cfif ctx.pkstring EQ 1>
		SELECT #attributes.Field# FROM #ctx.ctx_table# WHERE #ctx.ctx_pkfield#='#attributes.Selector#'
    <cfelse>
		SELECT #attributes.Field# FROM #ctx.ctx_table# WHERE #ctx.ctx_pkfield#=#attributes.Selector#
    </cfif>
</cfquery>

<cfoutput>
<label>#attributes.Label#: <input type="text" id="_PAFFIELD_#Attributes.Datasource#.#Attributes.Schema#.#Attributes.Table#.#Attributes.TargetField#" alt="#attributes.Label#" /></label>
</cfoutput>    