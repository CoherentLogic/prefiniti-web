<!---
	$Id$
--->
<!---
<cffunction name="getSiteStats" returntype="struct">
	<cfargument name="site_id" type="numeric" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
	
	    <cfset siteStats.unreadMail=#unreadMail.RecordCount#>
    <cfset siteStats.delinquentJobs=#delinquentJobs.RecordCount#>
    <cfset siteStats.tsNeedApproval=#tsNeedApproval.RecordCount#>
    <cfset siteStats.tsNeedSign=#tsNeedSign.RecordCount#>
    <cfset siteStats.newOrders=#newJobs.RecordCount#>
--->	

<cfinclude template="/authentication/authentication_udf.cfm">

<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfparam name="s" default="">

<cfset s=#getSiteStats(url.current_site_id, url.calledByUser)#>

<!---
<cfif URL.Steel EQ false>
	<style>
		.PNotifyText {
			font-size:xx-small;
			color:red;
			font-weight:bold;
			font-family:Verdana, Arial, Helvetica, sans-serif;
		}
	</style>
</cfif>    		
--->
<cfoutput>
	<cfif s.unreadMail GT 0>
		<div style="padding-top:5px;">
        	<img src="/graphics/email.png" align="absmiddle"/> <a href="javascript:viewMailFolder('inbox', 1);" class="PNotifyText">#s.unreadMail# new messages</a>
    	</div>
	</cfif>
    <cfif getPermissionByKey("TS_APPROVE", url.current_association)>
		<cfif s.tsNeedApproval GT 0>
            <div style="padding-top:5px;">
                <img src="/graphics/time.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '1/1/2999', 'Signed', '', '')" class="PNotifyText">#s.tsNeedApproval# timesheets need approval</a>
            </div>            
        </cfif>
    </cfif>
    <cfif s.tsNeedSign GT 0>        
	    <div style="padding-top:5px;">
        	<img src="/graphics/time.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '', '')" class="PNotifyText">#s.tsNeedSign# timesheets need signing</a>
		</div>            
	</cfif>
    <cfif getPermissionByKey("WF_PROCESSORDER", url.current_association)>
    <cfif s.newOrders GT 0>        
	    <div style="padding-top:5px;">
       		<img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newJobs.cfm');" class="PNotifyText">#s.newOrders# new orders</a>
        </div>
    </cfif>
    </cfif>
    
	<cfif getPermissionByKey("WF_VIEWRFP", url.current_association)>
		<cfif s.newRFP GT 0>        
            <div style="padding-top:5px;">
                <img src="/graphics/package.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/newRFP.cfm');" class="PNotifyText">#s.newRFP# proposals awaiting review</a>
            </div>
        </cfif>
    </cfif>

    <cfif s.newFriendRequests GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/user_add.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');" class="PNotifyText">#s.newFriendRequests# friend requests</a>
        </div>
	</cfif>
    <cfif s.newComments GT 0>
	    <div style"padding-top:5px;">
        	<img src="/graphics/comments.png" align="absmiddle" /> <a href="javascript:viewProfile(#url.calledByUser#);"  class="PNotifyText">#s.newComments# new comments</a>
        </div>
	</cfif>

    
</cfoutput>