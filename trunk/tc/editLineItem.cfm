
<cfquery name="gLineItem" datasource="webwarecl">
	SELECT * FROM time_entries WHERE id=#url.id#
</cfquery>

<cfquery name="getTaskCodes" datasource="webwarecl">
	SELECT * FROM task_codes WHERE site_id=#url.current_site_id# ORDER BY task_id
</cfquery>
<cfquery name="qJobNumbers" datasource="webwarecl">
	SELECT clsJobNumber, description FROM projects WHERE site_id=#url.current_site_id# ORDER BY clsJobNumber DESC
</cfquery>



<form name="editLI" action="/tc/editLineItemSub.cfm" method="post">
<cfoutput><input type="hidden" name="id" id="id" value="#gLineItem.id#" /></cfoutput>
<cfoutput><input type="hidden" name="timecard_id" id="timecard_id" value="#gLineItem.timecard_id#" /></cfoutput>
<table width="100%" cellpadding="5" cellspacing="0" border="0">
<tr>
					<td>Project Number:</td>
					<td colspan="2">
					 
								<select name="JobNumSel" id="JobNumSel">
										<option value="WEB DEVEL" <cfif gLineItem.project_number EQ "WEB DEVEL">selected</cfif>>Web Development</option>
										<option value="SCAN DOCS" <cfif gLineItem.project_number EQ "SCAN DOCS">selected</cfif>>Document Scanning</option>
										<option value="ADMIN" <cfif gLineItem.project_number EQ "ADMIN">selected</cfif>>Administration</option>
									<cfoutput query="qJobNumbers">
										<option value="#clsJobNumber#" <cfif gLineItem.project_number EQ clsJobNumber>selected</cfif>>#clsJobNumber#   #description#</option>
									</cfoutput>
								</select>	
						
						
						
						  </td>
				</tr>
	<tr>
					<td>Task Code</td>
					<td colspan="2">
						<select name="taskCodeID" id="taskCodeID">
							
							<cfoutput query="getTaskCodes">
								<option value="#id#" >#task_id#:  #item#</option>
						  </cfoutput>
						  <cfoutput><option value="#gLineItem.taskCodeID#" selected>
							<cfmodule template="/tc/components/taskCode.cfm" id="#gLineItem.taskCodeID#">:
							&nbsp;
							<cfmodule template="/tc/components/taskCodeDesc.cfm" id="#gLineItem.taskCodeID#">
							</option>
							</cfoutput>
					    </select>
					</td>
				</tr>
				<cfoutput query="gLineItem">
				<tr>
					<td>Description</td>
				  <td colspan="2"><input type="text" name="description" id="description" onkeyup="return minLength('description', 'descErr', 15, false);" value="#Replace(description, '""', '''', 'ALL')#">
					  <span class="style1" id="descErr">Must be at least 15 characters</span></td>
				</tr>
				
				
				<tr>
					<td>Hours</td>
					<td colspan="2"><input type="text" name="hours" id="hours" value="#hours#"></td>
				</tr>
                
				
				<tr>
					<td rowspan="3">Mileage</td>
					<td>Odometer Start: </td>
				    <td><input name="odStart" type="text" id="odStart" onkeyup="return AddMileage();" value="#odStart#"></td>
				</tr>
				<tr>
				  <td>Odometer End: </td>
				  <td>
				  	<input name="odEnd" type="text" id="odEnd" onkeyup="subtractTwoFields('odStart', 'odEnd', 'mileage');" value="#odEnd#">  </td>
			    </tr>
				<tr>
				  <td>Total Mileage: </td>
				  <td><input name="mileage" type="text" id="mileage" value="#mileage#"></td>
			    </tr>
				</cfoutput>
				
				<tr>
					<td colspan="3" align="right"><input type="button" class="normalButton" name="Submit" value="Save Line Item" onclick="editLineItem(GetValue('timecard_id'), GetValue('id'), GetValue('JobNumSel'), GetValue('taskCodeID'), GetValue('description'),  GetValue('hours'), GetValue('odStart'), GetValue('odEnd'), GetValue('mileage'));"></td>
				</tr>
		
</table>
</form>