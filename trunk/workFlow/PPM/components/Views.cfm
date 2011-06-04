<!---var url = "/workFlow/PPM/components/ppm_module.cfm?ppm_module_id=" + escape(ppm_module_id)
		url += "&ppm_project_type=" + escape(ppm_project_type);
		url += "&ppm_project_id=" + escape(ppm_project_id);
		
		var ppm_module_id = args[1];
		var ppm_project_type = args[2];
		var ppm_project_id = args[3];
		<strong></strong>
		--->
        
<cfquery name="ppm" datasource="webwarecl">
	SELECT * FROM ppm_modules WHERE project_type='#attributes.project_type#'
</cfquery>
    
<select name="section" id="project_section" onchange="show_project_section(GetValue('project_section'));">
   	<option value="builtin:location_information">Location Information</option>
    <cfif attributes.project_type EQ 0>
	    <option value="builtin:filing_information">Filing Information</option>
    </cfif>
    <option value="builtin:project_files" selected>Project Files</option>
    <option value="builtin:other_information">Other Information</option>
    <option value="builtin:time_information">Labor &amp; Invoicing</option>

	<cfoutput query="ppm">
    	<option value="ppm_module:#ppm_module_id#:#attributes.project_type#:#attributes.project_id#">#ppm_module_description#</option>
    </cfoutput>
</select>