<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="e" default="">
<cfset e=wwGetEmployeesBySite(url.site_id)>

<cfoutput query="e">
	<div style="width:100%; border-bottom:1px solid ##C0C0C0; padding-top:10px; padding-bottom:10px;">
    	<img src="#getPicture(user_id)#" width="50" /> <input type="button" value="Choose" onclick="wwAddMember(#url.department_id#, #user_id#);" /> #getLongname(user_id)#
    </div>
</cfoutput>    
    