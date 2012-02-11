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
	<cfif session.loggedin NEQ true>
		<cfif IsDefined("URL.View")>
			<cfif IsDefined("URL.Section")>
				<cfset sec = URL.Section>
			<cfelse>
				<cfset sec = "">
			</cfif>
			<cflocation url="/homeres/default.cfm?view=#URL.View#&section=#sec#" addtoken="no">
		</cfif>
	<cfelse>        
		<cfif NOT session.active_membership.Examine('AS_LOGIN')>
        	<cfset session.framework.Err("SEC002")>
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
		<cfif GetFirst.RecordCount GT 0>
        	<cfset CurrentObject = GetFirst.r_id>
		<cfelse>	
			<cfset CurrentObject = session.user.ObjectRecord().r_id>
		</cfif>
		<cfset CurrentSection = "">                       
    </cfif>

	<cfset session.current_object = CurrentObject>
	
	

	<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(CurrentObject)>
	<cfoutput>
		<title>#o.r_type# #o.r_name# - The Prefiniti Network</title>
	</cfoutput>

<cfoutput>
<body onLoad="ObjectInit('#CurrentObject#');">	
</cfoutput>



<script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>

<div class="notification_box" id="notify_wrapper" style="display:none;">
	<h2><img src="/graphics/wand.png" align="absmiddle"> Notifications</h2>           
    <div id="notify_target">
    
    </div>
    <hr>
    <a href="##" onClick="hideDiv('notify_wrapper');">Close</a> 
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

<cfif session.basket NEQ "">
	<cfset BasketObj = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(session.basket)>
	<cfset BrowseObj = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(CurrentObject)>
	<div style="font-size:12px;padding:5px;color:white;-moz-border-radius:5px;-webkit-border-radius:5px;position:absolute;bottom:8px;right:8px;width:500px;border:1px solid #c0c0c0;background-color:#333333;opacity:0.6;">
		<span style="font-size:14px;font-weight:bold;"><img src="/graphics/basket.png" align="absmiddle"> Basket</span><br>
		<hr>
		<p>You are carrying the <cfoutput><strong>#BasketObj.r_name# #BasketObj.r_type#</strong></cfoutput>. You can now browse to any other item to share or copy this <cfoutput>#LCase(BasketObj.r_type)#</cfoutput>.</p>
		<blockquote>
		<label><input type="checkbox">Remove from basket</label><br>
		<label><input type="checkbox">Add this <cfoutput>#LCase(BasketObj.r_type)#</cfoutput> to sharing group <select size="1"><option value="">Friends</option></select></label><br>
		</blockquote>
		<cfoutput>
		<input type="button" value="Copy to #BrowseObj.r_name#"><input type="button" value="Share with #BrowseObj.r_name#">
		</cfoutput>
	</div>
</cfif>

<div style="display:none;">
<form name="site_selection" action="/siteSelectSubmit2.cfm" method="post">
    <input type="hidden" name="siteAssociation2" id="assoc" >
</form>
</div>

<cfoutput>
<script>
	ORMSLoadHistory(1, #session.user.r_pk#);
	var session_key = '#session.authentication_key#';

	
	
	<cfif NOT IsDefined("URL.section")>
		ORMSPrepareFeed('#CurrentObject#', 0);
	<cfelse>
		<cfif URL.section EQ "">
			ORMSPrepareFeed('#CurrentObject#', 0);
		</cfif>			
	</cfif>
	
	try {
		ObjectInit('#CurrentObject#');
	} catch (e) {
		//alert('Could not initialize ORMS object #CurrentObject# ' + e);	
	}
</script>
</cfoutput>



