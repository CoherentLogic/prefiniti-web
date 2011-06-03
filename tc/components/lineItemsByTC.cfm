

<cfquery name="liByTC" datasource="webwarecl">
	SELECT * FROM time_entries WHERE timecard_id=#attributes.timecard_id#
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<th width="10%" align="left">Project No.</th>
        <th  align="left">Task Code</th>
		<th align="left">Services Rendered</th>
		<th align="left" width="8%">OD Start</th>
		<th align="left" width="8%">OD End</th>
		<th align="left" width="8%">Total Mileage</th>
		<th align="left" width="8%">Hours</th>
	</tr>
    <cfif liByTC.RecordCount EQ 0>
    	<tr>
        	<td colspan="6"><strong>No line items have been entered.</strong></td>
		</tr>
	</cfif>
                        
	<cfoutput query="liByTC">
		<tr>
			<td>#project_number#</td>
            <td><cfmodule template="/tc/components/taskCode.cfm" id="#taskCodeID#"></td>
			
            <td>#description#</td>
			
			<td>#odStart#</td>
			<td>#odEnd#</td>
			<td>#mileage#</td>
			<td>#hours#</td>
		</tr>
	</cfoutput>
</table>