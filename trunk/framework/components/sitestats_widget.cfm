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
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/framework/components/sitestats_udf.cfm">

<style type="text/css">
	#notification_content {
		position:fixed;
		bottom:22px;
		height:auto;
		left:30px;
		background-color:#efefef;
		padding:3px;
		border:1px solid #cccccc;
		display:none;	
		
	}
	
	#notification_content img {
		margin:3px;
	}
	
	#notification_content a {
		color:#2957a2;
		font-size:12px;
	}
	
	#notification_dock a {
		color:red;
		font-weight:bold;
		text-decoration:none;	
	}
	
	#notification_dock a:hover {
		font-weight:bold;
	}
	
	
	#notification_dock {
		position:fixed;
		bottom:0px;
		left:30px;
		height:16px;
		width:auto;
		background-color:#efefef;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		padding:3px;
	}
	
</style>

<cfparam name="s" default="">

<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<div id="notification_content">
<cfoutput>
	<cfset tn = 0>
	<cfif s.unreadMail GT 0>
       	<img src="/graphics/email.png" align="absmiddle"/> <a href="javascript:viewMailFolder('inbox', 1);">#s.unreadMail# new messages</a>
		<cfset tn = tn + s.unreadMail>
	</cfif>
    <cfif getPermissionByKey("TS_APPROVE", url.current_association)>
		<cfif s.tsNeedApproval GT 0>
                <img src="/graphics/AppIconResources/crystal_project/16x16/actions/player_time.png" align="absmiddle" width="16" height="16" /> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '', '')"  >#s.tsNeedApproval# timesheets need approval</a><br>
				<cfset tn = tn + s.tsNeedApproval>
        </cfif>
    </cfif>
    <cfif s.tsNeedSign GT 0>        
        	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/player_time.png"  width="16" height="16"  align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '', '')"  >#s.tsNeedSign# timesheets need signing</a><br>
			<cfset tn = tn + s.tsNeedSign>
	</cfif>
    <cfif getPermissionByKey("WF_PROCESSORDER", url.current_association)>
    <cfif s.newOrders GT 0>        
       		<img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/jobViews/newJobs.cfm');"  >#s.newOrders# new survey orders</a><br>
			<cfset tn = tn + s.newOrders>
    </cfif>
    </cfif>
    
	<cfif getPermissionByKey("WF_VIEWRFP", url.current_association)>
		<cfif s.newRFP GT 0>        
                <img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16"  align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/jobViews/newRFP.cfm');"  >#s.newRFP# proposals awaiting review</a><br>
				<cfset tn = tn + s.newRFP>
        </cfif>
    </cfif>
	
	<cfif getPermissionByKey("CT_PROCESSPAYMENTS", url.current_association)>
		<cfif s.orders0 GT 0>
			<img src="/graphics/AppIconResources/crystal_project/16x16/actions/project_open.png"  width="16" height="16"  align="absmiddle" /> <a href="https://www.prefiniti.com/framework/OrderProcess/Master.cfm?VendorID=#URL.Current_Site_ID#&UserID=#URL.CalledByUser#" target="_blank"  >#s.orders0# unacknowledged orders</a><br>
			<cfset tn = tn + s.orders0>
		</cfif>
	</cfif>
	
    <!---<cfif getPermissionByKey("WF_MANAGE_DELINQUENT", url.current_association)>
		<cfif s.delinquentJobs GT 0>
            <div style"padding-top:5px;">
                <img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/checkDelinquent.cfm');"   ><strong>#s.delinquentJobs# delinquent orders</strong></a>
            </div>
        </cfif>
    </cfif>--->
    <cfif s.newFriendRequests GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/actions/add_user.png"  width="16" height="16"  align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');"  >#s.newFriendRequests# friend requests</a><br>
			<cfset tn = tn + s.newFriendRequests>
	</cfif>
    <cfif s.newComments GT 0>
        	<img src="/graphics/AppIconResources/crystal_project/16x16/apps/xchat.png" width="16" height="16"  align="absmiddle" /> <a href="javascript:viewProfile(#url.calledByUser#);"   >#s.newComments# new comments</a><br>
			<cfset tn = tn + s.newComments>
	</cfif>

    
</cfoutput>
</div>

<cfif tn GT 0>
	<div id="notification_dock" style="color:red; font-weight:bold;" onclick="ShowNotifications();">
		<cfoutput>
			<img src="/graphics/comment.png" align="absmiddle"> #tn#
		</cfoutput>	
	</div>
</cfif>

<span style="font-weight:lighter; color:#999999">
