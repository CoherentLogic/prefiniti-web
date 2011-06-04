<cfquery name="p_inf" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#attributes.project_id#
</cfquery>

<div style="width:450px; border:1px solid gray; text-align:left;">
Project Status
<table width="100%">
<cfoutput query="p_inf">
	<tr>
    	<td <cfif SubStatus EQ "Pending">style="color:black; font-weight:bold; background-color:##EFEFEF; border-top:1px solid gray;"<cfelse>style="color:##999999; font-weight:normal; border-top:1px solid silver;"</cfif>>Pending
        </td>
        <td <cfif SubStatus EQ "Awarded">style="color:black; font-weight:bold; background-color:##EFEFEF; border-top:1px solid gray;"<cfelse>style="color:##999999; font-weight:normal; border-top:1px solid silver;"</cfif>>Awarded
        </td>
		<td <cfif SubStatus EQ "In Progress">style="color:black; font-weight:bold; background-color:##EFEFEF; border-top:1px solid gray;"<cfelse>style="color:##999999; font-weight:normal; border-top:1px solid silver;"</cfif>>In Progress
        </td>
        <td <cfif SubStatus EQ "Paid">style="color:black; font-weight:bold; background-color:##EFEFEF; border-top:1px solid gray;"<cfelse>style="color:##999999; font-weight:normal; border-top:1px solid silver;"</cfif>>Paid
        </td>
        <td <cfif SubStatus EQ "Closed">style="color:black; font-weight:bold; background-color:##EFEFEF; border-top:1px solid gray;"<cfelse>style="color:##999999; font-weight:normal; border-top:1px solid silver;"</cfif>>Closed
        </td>
    </tr>
</cfoutput>
</table>
</div>     