<!---
	ATTRIBUTES:
	
	r_type		object type
	r_pk		object pri key
	user_id		user_id to check perms for
--->
<style type="text/css">
	#orms_sidebar {
		float:left;
		width:220px;
		line-height:20x;
		margin-top:0px;
		font-family:"Segoe UI", Verdana, Arial, Helvetica, sans-serif;
		font-size:14px;		
	}

	#orms_content {
		margin-left:220px;
		font-size:12px;
		border-left:1px solid #c0c0c0;
		margin-top:0px;
		padding-left:30px;
		font-family:"Segoe UI", Verdana, Arial, Helvetica, sans-serif;
		font-size:14px;
	}	


</style>
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset o.GetByTypeAndPK(attributes.r_type, attributes.r_pk)>

<div id="orms_sidebar">
	<cfoutput>
        <table>
        <tr>
        <td>
            <img src="#o.r_thumb#" width="48">
        </td>
        <td>
            <span class="LandingHeaderText">#o.r_name#</span><br /> <br />       
            <cfif o.GetRating() GT 0>
                <cfloop from="1" to="#o.GetRating()#" index="x"><img src="/graphics/star.png" align="absmiddle"></cfloop>
                <br><br>
            </cfif>
        </td>
        </tr>
        </table>
       
        <cfif o.sidebar_path NEQ "">
        	<cfmodule template="#o.sidebar_path#" orms_id="#o.r_id#">
        </cfif>
        
    </cfoutput>
</div>
<div id="orms_content">	
	<cfset sections = o.GetSections()>

	<div id="orms_active_section" style="width:100%; height:auto; overflow:hidden; margin-top:20px;">
		<cfif IsDefined("attributes.section")>
			<cfif attributes.section NEQ "">
				<cfquery name="get_section_data" datasource="webwarecl">
					SELECT section_file FROM orms_app_sections WHERE r_type='#o.r_type#' AND section_name='#attributes.section#'
				</cfquery>
				<cfmodule template="#get_section_data.section_file#" r_pk="#o.r_pk#">
			<cfelse>
                <cfmodule template="/orms/object_events.cfm" user_id="#attributes.user_id#" orms_id="#o.r_id#">
			</cfif>            
		<cfelse>
			<cfoutput query="sections" maxrows="1">
				<cfmodule template="#section_file#" r_pk="#o.r_pk#">
			</cfoutput>
		</cfif>
	</div>
</div>    
	
	

