<cfquery name="get_site_industry" datasource="sites">
	SELECT industry FROM sites WHERE SiteID=#url.site_id#
</cfquery>

<cfquery name="get_project_types" datasource="webwarecl">
	SELECT * FROM project_types WHERE industry=#get_site_industry.industry#
</cfquery>

<select name="project_type" id="project_type">
	<cfoutput query="get_project_types">
		<option value="#ppm_type_category#^#ppm_type_name#">#ppm_type_category# - #ppm_type_name#</option>
	</cfoutput>
</select>