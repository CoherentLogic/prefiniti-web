<table width="100%" cellspacing="0">
	<tr>
    	<td>Department Name:</td>
        <td><input type="text" name="department_name" id="department_name" /></td>
	</tr>
    <tr>
    	<td colspan="2" align="right">
        	<cfoutput><input type="button" class="normalButton" value="Add Department" onclick="wwCreateDepartment(#url.current_site_id#, GetValue('department_name'));" /></cfoutput>
		</td>
	</tr>                            
</table>
