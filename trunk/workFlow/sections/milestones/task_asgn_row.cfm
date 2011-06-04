<!---
	RECEIVES ATTRIBUTES:
		milestone_id
		taskcode_id
--->


<cfquery name="get_milestone" datasource="webwarecl">
	SELECT * FROM project_milestones WHERE id='#attributes.milestone_id#'
</cfquery>

<cfquery name="get_taskcode" datasource="webwarecl">
	SELECT * FROM task_codes WHERE id=#attributes.taskcode_id#
</cfquery>

<cfquery name="get_milestone_task_code" datasource="webwarecl">
	SELECT * FROM project_milestone_task_codes WHERE milestone_id='#attributes.milestone_id#' AND task_code_id=#attributes.taskcode_id#
</cfquery>

<cfif get_milestone_task_code.RecordCount GT 0>
	<cfset written = "true">
	<cfset billing_type = get_milestone_task_code.billing_type>
	<cfset rate = get_milestone_task_code.rate>
	<cfset charge_type = get_milestone_task_code.charge_type>
<cfelse>
	<cfset written = "false">
	<cfset billing_type = "Billable">
	<cfset rate = get_taskcode.rate>
	<cfset charge_type = get_taskcode.charge_type>
</cfif>
	<cfset ctlbase = attributes.taskcode_id & "_" & attributes.milestone_id & "_">
	<cfoutput>
	<tr>		
		<td>
			<span style="display:inline;">
			<input type="checkbox" onclick="ProjMTCUpdate('#attributes.milestone_id#', '#attributes.taskcode_id#');" name="#ctlbase#written" id="#ctlbase#written" <cfif written>checked</cfif>>
			</span>
			#get_taskcode.description#			
		</td>
		<td>
			<select onchange="ProjMTCUpdateCheck('#attributes.milestone_id#', '#attributes.taskcode_id#'); ProjMTCUpdate('#attributes.milestone_id#', '#attributes.taskcode_id#');" name="#ctlbase#billing_type" id="#ctlbase#billing_type">
				<option value="Billable" <cfif billing_type EQ "Billable">selected</cfif>>Billable</option>
				<option value="Unbillable" <cfif billing_type EQ "Unbillable">selected</cfif>>Unbillable</option>
			</select>
		</td>
		<td>
			<label>$<input onblur="ProjMTCUpdateCheck('#attributes.milestone_id#', '#attributes.taskcode_id#'); ProjMTCUpdate('#attributes.milestone_id#', '#attributes.taskcode_id#');" type="text" value="#rate#" name="#ctlbase#rate" id="#ctlbase#rate"></label>
		</td>
		<td>
			per			
			<select onchange="ProjMTCUpdateCheck('#attributes.milestone_id#', '#attributes.taskcode_id#'); ProjMTCUpdate('#attributes.milestone_id#', '#attributes.taskcode_id#');" name="#ctlbase#charge_type" id="#ctlbase#charge_type">
				<option value="Hour" <cfif #charge_type# EQ 'Hour'>checked</cfif>>Hour</option>
				<option value="Layer" <cfif #charge_type# EQ 'Layer'>checked</cfif>>Layer</option>
				<option value="Day" <cfif #charge_type# EQ 'Day'>checked</cfif>>Day</option>
				<option value="Unit" <cfif #charge_type# EQ 'Unit'>checked</cfif>>Unit</option>
				<option value="Category" <cfif #charge_type# EQ 'Category'>checked</cfif>>Category</option>
				<option value="Sheet" <cfif #charge_type# EQ 'Sheet'>checked</cfif>>Sheet</option>
			</select>
			
		</td>
	</tr>	
	</cfoutput>	
				
					

