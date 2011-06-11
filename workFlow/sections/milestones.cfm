<cfquery name="get_milestones" datasource="webwarecl">
	SELECT * FROM project_milestones WHERE project_id=#attributes.r_pk# ORDER BY completed DESC, milestone ASC
</cfquery>

<cfquery name="pc" datasource="webwarecl">
	SELECT id FROM project_milestones WHERE project_id=#attributes.r_pk# AND completed=1
</cfquery>

<cfif pc.RecordCount GT 0>
	<cfset percent_complete = Int((pc.RecordCount * 100) / get_milestones.RecordCount)>
<cfelse>
	<cfset percent_complete = 0>
</cfif>

<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset o.GetByTypeAndPK("Project", attributes.r_pk)>


<div style="width:100%; background-color:##c0c0c0; height:80px;">

<div style="width:100%;height:auto; overflow:hidden; border:1px solid ##c0c0c0;">
<div style="width:505px; height:50px; border:1px solid black;">
<cfloop from="0" to="100" index="cp">
	<cfif cp LE percent_complete>
		<cfoutput><div style="height:50px; width:5px; float:left; background-color:##999999;">&nbsp;</div></cfoutput>
	<cfelse>
		<cfoutput><div style="height:50px; width:5px; float:left; background-color:##efefef;">&nbsp;</div></cfoutput>
	</cfif>
	
</cfloop>
</div>
</div>

<cfoutput><strong class="OH_HEADER" style="font-size:12px;">Project is #percent_complete#% Complete</strong></cfoutput>

</div>
<cfif get_milestones.RecordCount GT 0>
	<cfoutput query="get_milestones">
	<div id="milestone_#id#" style="font-size:14px; width:100%;">
		<table width="100%">
		<tr>
		<td width="250">
			<span style="width:250px; overflow:hidden; font-size:14px;">
			<cfif completed eq 1>
				<span style="color:green;">#milestone#</span>
			<cfelse>
				<span style="color:red; font-weight:bold;">#milestone#</span>
			</cfif>	
		</td>
		<td width="20">
			<cfif completed NEQ 1>
				<cfif date_sensitive EQ 1>
					<cfif CreateODBCDate(due_date) EQ CreateODBCDate(Now())>
						<img src="/graphics/flag_yellow.png" onmouseover="Tip('Milestone is due today');" onmouseout="UnTip();" align="absmiddle">
					<cfelseif CreateODBCDate(due_date) LT CreateODBCDate(Now())>
						<img src="/graphics/flag_green.png" onmouseover="Tip('Milestone is due #DateFormat(due_date, 'long')#');" onmouseout="UnTip();" align="absmiddle">
					<cfelseif CreateODBCDate(due_date) GT CreateODBCDate(Now())>
						<img src="/graphics/flag_red.png" onmouseover="Tip('Milestone is past due');" onmouseout="UnTip();" align="absmiddle">
					</cfif>
				<cfelse>
					<img src="/graphics/flag_green.png" onmouseover="Tip('Milestone is not date-sensitive');" onmouseout="UnTip();" align="absmiddle">
				</cfif>
			<cfelse>
				<img src="/graphics/tick.png" onmouseover="Tip('Milestone has been completed');" onmouseout="UnTip();" align="absmiddle">
			</cfif>
		</td>
		<td>
		<a href="####" class="button" style="font-size:14px;" onclick="showDivBlock('milestone_extended_#id#');"><span>Edit</span></a>
		</td>
		</tr>
		</table>
		
			
		
	
		<div id="milestone_extended_#id#" style="display:none;">
			<form name="edit_milestone_#id#" id="edit_milestone_#id#">
			<input type="hidden" name="milestone_id" id="milestone_id" value="#id#">
			<table width="100%">
			<tr>
			<td>Milestone:</td>
			<td>
			<input 	type="text" 
					name="milestone" 
					id="milestone"	
					value="#milestone#">
			</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td>
			<label>
			<input 	type="checkbox" 
					name="date_sensitive" 
					id="date_sensitive" 
					<cfif date_sensitive EQ 1>
						checked
					</cfif>>
			Date Sensitive</label>
			</td>
			</tr>
			<tr>
			<td>Ideal Completion:</td>
			<td>
			<cfmodule template="/controls/date_picker.cfm" ctlname="due_date" startdate="#DateFormat(due_date, 'mm/dd/yyyy')#">
			</td>
			</tr>
			<tr>
			<td>Projected Cost:</td>
			<td>$
			<input  type="text" 
					size="4"
					name="budget"
					id="budget"
					value="#budget#">
			</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td>
			<label>
			<input 	type="checkbox" 
					name="completed" 
					id="completed" 
					<cfif completed EQ 1>
						checked
					</cfif>>
			Completed</label>
			</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td>
			<cfif o.CanWrite(URL.CalledByUser)>
				<a class="button" href="####" onclick="ProjUpdateMilestone('#id#');"><span>Update</span></a>
			</cfif>
			</td>
			</tr>
			</table>
			</form>
		</div>	<!-- milestone_extended_id -->
		<hr style="border:1px solid ##c0c0c0; height:1px;">
	</div> <!-- milestone_id -->
	</cfoutput>
<cfelse>
	<div style="width:100%; font-size:14px; padding:10px;">
	No milestones have been created for this project.
	</div>
</cfif>

<cfoutput>
<div style="width:100%; height:40px;">
    <div style="padding:10px;">	
		<a class="button" href="####" onclick="ProjAddMilestone(#attributes.r_pk#)"><span>Add Milestone</span></a>
	</div>
</div>
</cfoutput>