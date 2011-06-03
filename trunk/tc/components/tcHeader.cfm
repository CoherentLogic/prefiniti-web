<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="gH" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#attributes.id#
</cfquery>

<table width="100%" cellspacing="0">
	<cfoutput>
    <tr>
		<th colspan="2" align="left" class="tsTitle">#getSiteNameByID(url.current_site_id)#</th>	
		<th colspan="2" align="right" class="tsTitle">Timesheet #gH.emp_id#-#gH.id#</th>
	</tr>
    </cfoutput>
	
	<cfoutput query="gH">
		<tr>
		  <td><strong>Name:</strong><br /> <cfmodule template="/tc/components/tcUser.cfm" id="#emp_id#"> </td>
			<td><strong>Date:</strong><br>
		  #DateFormat(date, "mm/dd/yyyy")#</td>
			
			<td><strong>Job Description:</strong><br>
		  #JobDescription#</td>
		</tr>
	</cfoutput>
</table>