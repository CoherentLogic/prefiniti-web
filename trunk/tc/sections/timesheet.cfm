<cfparam name="totalHours" default="0">
<cfset tco = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK("Time Card", attributes.r_pk)>

<cfquery name="getHeader" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#attributes.r_pk#
</cfquery>

<cfquery name="getEntries" datasource="webwarecl">
	SELECT * FROM time_entries WHERE timecard_id=#attributes.r_pk#
</cfquery>

<cfquery name="getTaskCodes" datasource="webwarecl">
	SELECT * FROM task_codes WHERE site_id=#tco.r_site# ORDER BY task_id
</cfquery>


<cfquery name="qJobNumbers" datasource="webwarecl">
	SELECT clsJobNumber, description FROM projects WHERE site_id=#tco.r_site# ORDER BY clsJobNumber DESC
</cfquery>


<cfset CanEdit = false>

<cfif tco.CanWrite(session.user.r_pk)>
	<cfset CanEdit = true>
</cfif>



		<strong class="OH_HEADER">Edit Line Items</strong>
	
		<table width="100%" cellpadding="0" cellspacing="0" class="pretty-table">
		<tr>
			<th scope="col" nowrap>Task</th>
        	<th scope="col">Project Number</th>
			<th scope="col">Description</th>
			<th scope="col">Hours</th>
		</tr>
		<cfif #getEntries.RecordCount# GT 0>
			<cfoutput query="getEntries">
				<cfset totalHours=#totalHours#+#Hours#>
				<tr>
				<td>									
				<a href="##"><img src="/graphics/zoom.png" border="0" onclick="javascript:AjaxLoadPageToDiv('taskInfo', '/tc/taskCodeInfo.cfm?id=#taskCodeID#'); moveDiv('taskInfoWrapper', mouseX(event), mouseY(event)); showDiv('taskInfoWrapper');"/></a>
				<cfif CanEdit>&nbsp;<a href="javascript:AjaxLoadPageToDiv('userActionTarget', '/tc/editLineItem.cfm?id=#id#'); showDiv('userActionTarget')"><img src="/graphics/page_edit.png" border="0" /></a>&nbsp;</cfif>
				<a href="javascript:deleteLineItem(#attributes.r_pk#, #id#)"><img src="/graphics/bin.png" border="0" /></a>
				</td>
				<td>#project_number#</td>
	            <td>#description#</td>				
				<td>#Hours#</td>
				</tr>	
			</cfoutput>
			<tr>
				<td colspan="3" align="right">Total: <cfoutput><strong>#totalHours#</strong></cfoutput></td>
				<td><img src="/graphics/time_add.png" align="absmiddle" onclick="showDiv('userActionTarget')" onmouseover="Tip('Add a line item...');" onmouseout="UnTip();"></td>
			</tr>
		<cfelse>
			<tr>
				<td colspan="3">You have not entered any line items for this time card.</td>
				<td><cfif CanEdit><img src="/graphics/time_add.png" align="absmiddle" onclick="showDiv('userActionTarget')" onmouseover="Tip('Add a line item...');" onmouseout="UnTip();"></cfif></td>
			</tr>
	  	</cfif>	
		</table>
		
		<div id="userActionTarget" style="display:none;">
		<form name="addEntry" action="/tc/addEntry_sub.cfm" method="post" onsubmit="return minLength('description', 'descErr', 15, true);">
		<cfoutput><input type="hidden" name="timecard_id" id="timecard_id" value="#attributes.r_pk#"></cfoutput>		
		<table width="100%" cellpadding="4">
		<tr>
			<td>Project Number:</td>
			<td colspan="2">
				<select name="JobNumSel" id="JobNumSel">
					<option value="WEB DEVEL">Web Development</option>
					<option value="SCAN DOCS">Document Scanning</option>
					<option value="ADMIN">Administration</option>
					<cfoutput query="qJobNumbers">
						<option value="#clsJobNumber#">#clsJobNumber#   #description#</option>
					</cfoutput>
				</select>	
			</td>
		</tr>
		<tr>
			<td>Task Code</td>
			<td colspan="2">
				<select name="taskCodeID" id="taskCodeID">
				<cfoutput query="getTaskCodes">
					<option value="#id#" selected>#task_id#:  #item#</option>
				</cfoutput>
				</select>
			</td>
		</tr>
		<tr>
			<td>Description</td>
			<td colspan="2"><input type="text" name="description" id="description" onkeyup="return minLength('description', 'descErr', 15, false);">
			<span class="style1" id="descErr">Must be at least 15 characters</span></td>
		</tr>
		<tr>
			<td>Hours</td>
			<td colspan="2"><input type="text" name="hours" id="hours"></td>
		</tr>
		<tr>
			<td rowspan="3">Mileage</td>
			<td>Odometer Start: </td>
		    <td><input name="odStart" type="text" id="odStart" onkeyup="return AddMileage();" value="0"></td>
		</tr>
		<tr>
			<td>Odometer End: </td>
			<td>
				<input name="odEnd" type="text" id="odEnd" onkeyup="subtractTwoFields('odStart', 'odEnd', 'mileage');" value="0">  
			</td>
		</tr>
		<tr>
			<td>Total Mileage: </td>
			<td><input name="mileage" type="text" id="mileage" value="0"></td>
		</tr>
		<tr>
			<td colspan="3" align="right"><input type="button" class="normalButton" name="Submit" value="Add Item" onclick="addLineItem(GetValue('timecard_id'), GetValue('taskCodeID'), GetValue('JobNumSel'), GetValue('description'), GetValue('hours'), GetValue('odStart'), GetValue('odEnd'), GetValue('mileage'));"></td>
		</tr>
	</table>
	</form>
	</div>
	



<div id="taskInfoWrapper" style="z-index:2; border:solid 1px black; display:none;">
 	<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align="left" class="popupWin">Task Code Information</td>
			<td align="right" class="popupWin">
				<div align="right"><a href="javascript:hideDiv('taskInfoWrapper')"><img src="/graphics/delete.png" border="0" align="absmiddle"/></a></div>			</td>
		</tr>
	</table>
	<div id="taskInfo">	</div>
</div>

<br><br>

