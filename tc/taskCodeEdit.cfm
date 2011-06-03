<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="TS_EDIT_TC">
<link href="../css/gecko.css" rel="stylesheet" type="text/css">
<cfquery name="getTaskCode" datasource="webwarecl">
	SELECT * FROM task_codes WHERE id=#url.id#
</cfquery>

<cfoutput query="getTaskCode">
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Make Changes to a Task Code</h3>
        </div>
    </div>
    <br />
    <br />
<form name="editTaskCode" id="editTaskCode" action="tc/editTask_sub.cfm?id=#url.id#" method="post">
	<input type="hidden" name="taskcode_id" id="taskcode_id" value="#url.id#" />
	<table width="100%" cellpadding="0" cellspacing="0">

		<tr>
			<td>Task Code</td>
			<td><input type="text" name="task_id" value="#task_id#"></td>
		</tr>
		<tr>
			<td>Item</td>
			<td><input type="text" name="item" value="#item#"></td>
		</tr>
		<tr>
			<td>Description</td>
			<td><input type="text" name="description" value="#description#"></td>
		</tr>
		<tr>
			<td>Rate</td>
			<td><input type="text" name="rate" value="#rate#"></td>
		</tr>
		<tr>
			<td>Charge Type</td>
			<td>
				<select name="charge_type">
					<option value="Hour" <cfif #charge_type# EQ 'Hour'>checked</cfif>>Hour</option>
					<option value="Layer" <cfif #charge_type# EQ 'Layer'>checked</cfif>>Layer</option>
					<option value="Day" <cfif #charge_type# EQ 'Day'>checked</cfif>>Day</option>
					<option value="Unit" <cfif #charge_type# EQ 'Unit'>checked</cfif>>Unit</option>
					<option value="Category" <cfif #charge_type# EQ 'Category'>checked</cfif>>Category</option>
					<option value="Sheet" <cfif #charge_type# EQ 'Sheet'>checked</cfif>>Sheet</option>
				</select>			
			</td>
		</tr>
		<tr>
		  <td colspan="2" align="right"><input type="button" class="normalButton" name="Submit" value="Submit" onclick="javascript:AjaxSubmitForm(AjaxGetElementReference('editTaskCode'), '/tc/editTask_sub.cfm', 'statTarget');"></td>
	  </tr>
	</table>
</form>
</cfoutput>
