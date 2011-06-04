<!--function wfpProcessSubdivision(status_div, subdivision_option, new_subdivision, subdivision_select, project_id)-->

<cfif url.subdivision_option EQ "approve">
	<cfquery name="approve_sub" datasource="webwarecl">
    	UPDATE subdivisions SET name='#url.new_subdivision#', approved=1 WHERE id=#url.original_id#
    </cfquery>
<cfelse> <!--- choose --->
	<cfquery name="choose_sub" datasource="webwarecl">
    	UPDATE projects SET subdivision=#url.subdivision_select# WHERE id=#url.project_id#
	</cfquery>        
</cfif>

<strong style="color:red;">Subdivision processed.</strong>