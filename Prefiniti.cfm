<!---

$Id$

Copyright (C) 2011 John Willis
 
This file is part of Prefiniti.

Prefiniti is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Prefiniti is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.

--->

<cfajaximport tags="cfmenu,cfwindow">

<!-- Open the div element for the main client area -->    
    <cfif session.loggedIn EQ "yes">
    	<div class="bodyWrapper" id="appArea" style="height:auto; min-height:800px; width:100%; padding:0px; margin:0px; background-image:none;">
    <cfelse>
    	<div class="bodyWrapper" id="appArea" style="height:auto;  width:100%; padding:0px; margin:0px; background-image:none;">
	</cfif>

    <div id="dev-null" style="display:none;">
    </div>
	<cfoutput><input id="PMF_CurrentDate" type="hidden" value="#DateFormat(Now(), 'mm/dd/yyyy')#" /></cfoutput>

<head>
	<!--- jump back to login page with redirect clues if the session is not logged in --->
	<cfif session.loggedin NEQ "yes">
		<cfif IsDefined("URL.View")>
			<cfif IsDefined("URL.Section")>
				<cfset sec = URL.Section>
			<cfelse>
				<cfset sec = "">
			</cfif>
			<cflocation url="/homeres/default.cfm?view=#URL.View#&section=#sec#" addtoken="no">
		</cfif>
        <cfif NOT session.active_membership.Examine('AS_LOGIN')>
        	<cflocation url="/bad_site_permissions.cfm" addtoken="no">
        </cfif>        	
	</cfif>
    
    <!--- set up the current ORMS object and section --->
    <cfif IsDefined("URL.view")>
		<cfset CurrentObject = URL.View>
        <cfif IsDefined("URL.section")>
            <cfset CurrentSection = URL.section>
        <cfelse>
            <cfset CurrentSection = "">
        </cfif>       
    <cfelse>
        <cfquery name="GetFirst" datasource="#session.framework.BaseDatasource#" maxrows="1">
            SELECT r_id FROM orms_access_log WHERE a_user_id=#session.user.r_pk# ORDER BY a_date DESC
        </cfquery>
        <cfset CurrentObject = GetFirst.r_id>
		<cfset CurrentSection = "">                       
    </cfif>

	<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(CurrentObject)>
	<cfoutput>
		<title>#o.r_type# #o.r_name# - The Prefiniti Network</title>
	</cfoutput>
	




<script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>

<div class="notification_box" id="notify_wrapper" style="display:none;">
	<h2><img src="/graphics/wand.png" align="absmiddle"> Notifications</h2>           
    <div id="notify_target">
    
    </div>
    <hr>
    <a href="##" onclick="hideDiv('notify_wrapper');">Close</a> 
</div>



<div style="width:100%; background-color:#efefef; border-bottom:1px solid #c0c0c0; margin-bottom:0px;">
<div id="tb" class="iPrefinitiToolbar" align="right">
	
    
	<div style="padding:10px;width:960px;margin-bottom:20px;">
    <table width="100%" cellpadding="0" cellspacing="0">
    <tr>
    <td style="background-color:transparent;">
	<div style="width:auto; float:left; padding-top:8px;"><cfoutput><img src="/graphics/prenew-small.png" height="30"></cfoutput></div>
    </td>
    <td  style="background-color:transparent;" align="right">
	<input 	type="text" 
			id="searchBox" 
			name="searchBox" 
			class="search_inactive" 
			value="Type your search terms and press Enter"
			onkeypress="ORMSSearchKeyPress(event);"
			onclick="ORMSSearchClick();">		
	</td>	
	</tr>
	</table>
	</div>
    <cfmodule template="/orms/object_menu.cfm" orms_id="#CurrentObject#" section="#CurrentSection#">
</div>
</div>

	

<!--- END TOOLBAR --->

<div class="ContentBar" style="background-color:white;margin-top:0px;">	
    <div id="tcTarget" style="margin-top:0px;">    			
        <cfmodule template="/orms/loader_noajax.cfm" orms_id="#CurrentObject#" section="#CurrentSection#"> 		
    </div>	
</div>

<div style="display:none;">
<form name="site_selection" action="/siteSelectSubmit2.cfm" method="post">
    <input type="hidden" name="siteAssociation2" id="assoc" >
</form>
</div>

<cfoutput>
<script>
	ORMSLoadHistory(1, #session.user.r_pk#);
	


	
	<cfif NOT IsDefined("URL.section")>
		ORMSLoadFeed('#CurrentObject#');
	<cfelse>
		<cfif URL.section EQ "">
			ORMSLoadFeed('#CurrentObject#');
		</cfif>			
	</cfif>
</script>
</cfoutput>


