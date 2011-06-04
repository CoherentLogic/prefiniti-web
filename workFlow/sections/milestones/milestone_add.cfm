<div style="height:100%;position:relative;">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/milestones.png" caption="Add Milestone">
	
	<div style="padding-left:30px; margin-top:10px; font-size:14px;" id="add_milestone_form">
	<form name="add_milestone" id="add_milestone">
	<cfset uid = CreateUUID()>
	<cfoutput>
	<input type="hidden" name="milestone_id" id="milestone_id" value="#uid#">
	<input type="hidden" name="project_id" id="project_id" value="#URL.project_id#">
	</cfoutput>
	<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">
	<tr>
		<td align="right" width="30%"><strong>Name of milestone</strong></td>
		<td align="left" width="70%">
			<input type="text" name="milestone" id="milestone" size="30">
		</td>
	</tr>
	<tr>
		<td align="right" valign="top" width="30%"><strong>Sensitivity</strong></td>
		<td align="left" valign="top" width="70%">
			<label><input type="checkbox" name="date_sensitive" id="date_sensitive">Milestone is time sensitive</label><br>
			
		</td>
	</tr>
	<tr>
		<td align="right" width="30%"><strong>Ideal completion date</strong></td>
		<td align="left" width="70%">
			<label> <cfmodule template="/controls/date_picker.cfm" ctlname="due_date" startdate="#Now()#"></label>
		</td>
	</tr>
	<tr>
		<td align="right" width="30%"><strong>Projected cost</strong></td>
		<td align="left" width="70%">
			<input type="text" size="10" name="budget" id="budget">
		</td>	
	</tr>
		
	</table>
	</form>
	</div>
	
	<div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="add_milestone_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog()"><span>Cancel</span></a>
			<cfoutput>
			<a class="button" href="####" onclick="ProjAssignTaskCodesToMilestone('#uid#');"><span><strong>Assign Task Codes</strong></span></a>
			</cfoutput>
		</div>
	</div>
</div>