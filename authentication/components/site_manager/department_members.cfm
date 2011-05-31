<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="dm" default="">
<cfset dm=wwGetDepartmentMembers(attributes.department_id)>
<table cellpadding="5" width="100%" cellspacing="0">
<cfoutput query="dm">

	<tr>
	    <td style="border-bottom:1px solid ##EFEFEF;" width="60%"><a href="javascript:viewProfile(#user_id#);">#getLongname(user_id)#</a></td>
    	<td style="border-bottom:1px solid ##EFEFEF;" align="left">
        	<img src="/graphics/arrow_up.png" align="absmiddle"> <a href="javascript:wwSetManager(#attributes.department_id#, #user_id#);">Make Manager</a><br>
        	<img src="/graphics/bin.png" align="absmiddle"> <a href="javascript:wwDeleteDepartmentMember(#id#);">Remove From Department</a>
        </td>
	</tr>
</cfoutput>                        
</table>                    

<div style="width:100%; background-color:#EFEFEF; padding-top:2px; padding-bottom:2px;">
<cfoutput><img src="/graphics/user_add.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToWindow('/authentication/components/site_manager/add_department_member.cfm?department_id=#attributes.department_id#&site_id=#attributes.site_id#', 'Add Department Member');">Add Member</a></cfoutput>
</div>