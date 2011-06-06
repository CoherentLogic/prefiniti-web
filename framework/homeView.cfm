<!--
<wwafcomponent>Prefiniti Home</wwafcomponent>
<wwafsidebar>sb_Home.cfm</wwafsidebar>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>pi-16x16.png</wwaficon>
-->


<table width="100%" cellpadding="4" cellspacing="0" border="0">
	<tr>
		<td width="30%">
			<div class="OH_BOX" style="height:auto; overflow:hidden;">
        		<strong class="OH_HEADER">Today at a Glance</strong>
                <div style="padding-left:10px; padding-top:2px;">
                	<cfmodule template="/socialnet/components/day_at_glance.cfm" user_id="#url.calledByUser#">
                </div>
                <br />
                <strong class="OH_HEADER">Friends Online</strong>
                <div style="height:auto; padding-left:10px; padding-top:2px; overflow:hidden;" id="vof">
	                <cfmodule template="/socialnet/components/view_online_friends.cfm" user_id="#url.calledByUser#">
    			</div>            
        	
				<strong class="OH_HEADER">Featured Profiles</strong>
				<div style="padding-left:10px; padding-top:2px; clear:left;">
					<cfmodule template="/socialnet/components/cool_people.cfm">
				</div>
				<!---<cfmodule template="/socialnet/components/view_webgrams.cfm" maxrows="1">--->
			</div>
			
		</td>
		<td width="70%">
			<cfmodule template="/orms/recent_objects.cfm" user_id="#url.calledByUser#">
			<!--- <div style="margin-top:20px; padding:10px; width:650px; height:270px; -moz-border-radius:5px; margin-bottom:10px; background-color:#2957A2;">
				<h1 style="margin-top:0px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:36px; letter-spacing:-3px; font-weight:bold; color:white;">Welcome to Prefiniti 1.5</h1>
				
				<p style="margin-left:40px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:14px; width:350px; color:white;">This version of Prefiniti is specially tailored for Land Survey and Medical small businesses. If you would like to order products on Prefiniti, like fast food, please create a new account on Prefiniti 2.0</p>
				<p style="margin-left:40px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:14px; width:350px; color:white;">We hope you find Prefiniti 1.5 easy to use!</p>	
				<p style="margin-left:40px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:14px; width:350px; color:white;"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/help.png" align="absmiddle"> <a style="font-size:14px; color:white;" href="javascript:dispatch(); PHelpBrowser(0);">Get help using Prefiniti 1.5</a></p>
			</div> --->
			
		</td>
	</tr>
</table>			
			
	


<!---<cfquery name="profile" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#url.calledByUser#
</cfquery>

<cfoutput query="profile">
	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> The Prefiniti Network</h3>
        </div>
    </div>
    <br />
    <br />
    
    <cfparam name="bdayMonth" default="">
    <cfparam name="bdayDay" default="">
    <cfparam name="nowMonth" default="">
    <cfparam name="nowDay" default="">
    
    <cfset bdayMonth=DatePart("m", birthday)>
    <cfset bdayDay=DatePart("d", birthday)>
    <cfset nowMonth=DatePart("m", Now())>
    <cfset nowDay=DatePart("d", Now())>
    
    <table>
    <tr>
    	<td width="220">
        	<div style="width:215px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
        		<strong>Today at a Glance</strong><br />
                <div style="padding-left:10px; padding-top:2px;">
                	<cfmodule template="/socialnet/components/day_at_glance.cfm" user_id="#url.calledByUser#">
                </div>
                <br />
                <strong>Friends Online</strong><br />
                <div style="padding-left:10px; padding-top:2px;" id="vof">
	                <cfmodule template="/socialnet/components/view_online_friends.cfm" user_id="#url.calledByUser#">
    			</div>            
        	</div>
        </td>
		<td width="500">        
			<cfif bdayMonth EQ nowMonth and bdayDay EQ nowDay>
                <div style="clear:both;" class="homeHeader"><img src="/graphics/cake.png" align="absmiddle"/> Happy Birthday, #firstName#!
                </div>
                <div style="margin-left:30px;">Birthday wishes from the Prefiniti Team to you. We hope it's a happy one!</div>
            </cfif>        
            <div class="homeHeader" style="clear:both;"><img src="/graphics/sound.png" align="absmiddle"/> WebGrams</div>
            <div style="margin-left:30px; background-color:##EFEFEF; padding:5px; -moz-border-radius:5px; width:375px;">
            <cfmodule template="/socialnet/components/view_webgrams.cfm" maxrows="1">
            <div style="width:100%; text-align:right;">
                <img src="/graphics/zoom.png" align="absmiddle" />&nbsp;
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/view_all_webgrams.cfm');">View All WebGrams</a>
            </div>
            </div>
            <!---<div class="homeHeader"><img src="graphics/calendar_view_day.png" align="absmiddle" /> My Schedule</div>
            <div style="padding-left:30px;">
                <cfmodule template="/scheduling/components/getSchedule.cfm" userid="#url.calledByUser#">
            </div>--->
            
            <div class="homeHeader"><a href="/news/rss.cfm?current_site_id=#url.current_site_id#" target="_blank"><img src="graphics/feed.png" align="absmiddle" border="0"/></a> Site News</div>
            <div style="padding-left:30px;">
            <cfmodule template="/news/components/newsView.cfm"  site_id="#url.current_site_id#">
            </div>
            <div class="homeHeader"><img src="/graphics/newspaper.png" align="absmiddle" /> My Friends' News</div>		<div id="fre">
            <cfmodule template="/socialnet/components/view_friend_events.cfm" user_id="#url.calledByUser#" start_row="1" records_per_page="5" load_to="fre"></div>
            <div class="homeHeader"><img src="/graphics/user.png" align="absmiddle" /> Friends</div>
            <div id="frl"> 
            <cfmodule template="/socialnet/components/friends_list.cfm"  user_id="#url.calledByUser#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="30" load_to="frl" >
            </div>  
		</td>
	</tr>
</table>                           	
</cfoutput>--->