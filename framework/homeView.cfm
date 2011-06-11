<!--
<wwafcomponent>Welcome to Prefiniti</wwafcomponent>
-->

<style type="text/css">
	#wv_sidebar {
		float:left;
		width:250px;
		line-height:20px;
		
		font-size:12px;
	}
	
	#wv_sidebar a {
		font-size:12px;
		text-decoration:none;
	}
	
	#wv_sidebar a:hover {
		font-size:12px;
		color:#2957a2;
	}
	
	#wv_content {
		margin:0 0 0 250px;
		border-left:1px solid #efefef;
	}
	
	#wv_sidebar h2 {
		font-weight:lighter; 
		font-size:16px; 
		color:#2957A2; 
		font-family:"Segoe UI", Verdana, Arial, Helvetica, sans-serif;
	}
</style>

<div id="wv_sidebar">
<cfoutput>
	<table cellpadding="3">
    <tr>
    	<td>        	
			<img src="#session.user.Picture(64, 64)#" width="64" height="64" align="texttop"  onclick="ORMSLoad('#session.user.ObjectRecord().r_id#', '')"/>
        </td>
    	<td>
		    <a href="##" onclick="ORMSLoad('#session.user.ObjectRecord().r_id#', '')"><span class="LandingHeaderText" style="font-weight:bold;">#session.user.display_name#</span></a><br /> 
            #session.active_membership.membership_type# of #session.active_membership.site.site_name#      
		</td>
	</tr>
    </table>  
    <!--<a href="##">Create Site...</a>  <br />-->   
</cfoutput>

<h2>Friends</h2>
<cfset g_friends = session.user.Friends()>


<cfloop array="#g_friends#" index="fr">

	<cfif fr.Online()>
		<cfoutput>
            <img src="#fr.Picture(16, 16)#"  align="absmiddle" style="margin-left:3px;" /> <a href="##" onclick="ORMSLoad('#fr.ObjectRecord().r_id#', '')">#fr.display_name#</a><br />
        </cfoutput>
    </cfif>
</cfloop>

<cfif session.active_membership.membership_type EQ "Employee">
    <h2>Coworkers</h2>
    <cfset g_friends = session.active_membership.site.Employees()>
    
    
    <cfloop array="#g_friends#" index="fr">
    
        <cfif fr.Online()>
            <cfoutput>
                <img src="#fr.Picture(16, 16)#"  align="absmiddle" style="margin-left:3px;" /> <a href="##" onclick="ORMSLoad('#fr.ObjectRecord().r_id#', '')">#fr.display_name#</a><br />
            </cfoutput>
        </cfif>
    </cfloop>
    
    
    <h2>Customers</h2>
    <cfset g_friends = session.active_membership.site.Customers()>
    
    
    <cfloop array="#g_friends#" index="fr">
    
        <cfif fr.Online()>
            <cfoutput>
                <img src="#fr.Picture(16, 16)#" align="absmiddle" style="margin-left:3px;" /> <a href="##" onclick="ORMSLoad('#fr.ObjectRecord().r_id#', '')">#fr.display_name#</a><br />
            </cfoutput>
        </cfif>
    </cfloop>
</cfif>
</div>

<div id="wv_content">
	<cfmodule template="/orms/recent_objects.cfm" user_id="#url.calledByUser#">
</div>