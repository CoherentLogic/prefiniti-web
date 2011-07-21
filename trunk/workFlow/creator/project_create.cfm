<cfquery name="getSites" datasource="sites">
	SELECT * FROM site_associations WHERE assoc_type=1 AND user_id=#session.user.r_pk#
</cfquery>

<div style="height:100%;position:relative;">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/prefproject.png" caption="Create Project">
	
	<div style="padding-left:30px; margin-top:10px; font-size:14px;" id="project_creator_form">
	
	<form name="create_project" id="create_project">
	<cfoutput>
	<input type="hidden" name="om_uuid" id="om_uuid" value="#CreateUUID()#">
	<input type="hidden" name="client_id" id="client_id" value="#session.user.r_pk#">
	</cfoutput>
	<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">
	<tr>
		<td align="right" width="30%"><strong>Name of project</strong></td>
		<td align="left" width="70%">
			<input type="text" name="description" id="description" size="30">
		</td>
	</tr>
	<tr>
		<td align="right" width="30%"><strong>Create on which site</strong></td>
		<td align="left" width="70%">
		<select name="site_id" id="site_id" style="width:160px;" onchange="ProjLoadProjectTypes(GetValue('site_id'));">
    	<cfoutput query="getSites">
        	<option value="#site_id#">
            	<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#">				
            </option>
        </cfoutput>
		<option value="" selected>Select site...</option>
    	</select>
		</td>
	</tr>
	<tr>
		<td align="right" width="30%"><strong>Type of project to create</strong></td>
		<td align="left" width="70%">
			<div id="proj_types"> [you must first choose a site]</div>
		</td>	
	</tr>
	
	<tr>
		<td align="right" width="30%"><strong>Project is due by</strong></td>
		<td align="left" width="70%">
			<cfmodule template="/controls/date_picker.cfm" ctlname="duedate" startdate="#Now()#">
		</td>
	</tr>
	</table>
	</form>
	
	</div>
	
	<div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="create_project_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Cancel</span></a>
			<a class="button" href="##" onclick="ProjCreateProject();"><span><strong>Next</strong></span></a>
			
		</div>
	</div>
</div>
