<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="wwd" default="">
<cfset wwd=wwGetDepartments(url.current_site_id)>

<cfoutput query="wwd">
	<label><cfmodule template="/authentication/components/site_manager/be_checkbox.cfm" event_id="#attributes.event_id#"  department_id="#id#" site_id="#url.current_site_id#">#department_name#</label><br />
</cfoutput>