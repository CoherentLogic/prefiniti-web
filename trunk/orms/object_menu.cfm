
<cfset orms = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset orms_rec = orms.Get(attributes.orms_id)>
<cfset img = createObject("component", "OpenHorizon.Graphics.Image")>
<cfset sections = orms_rec.GetSections()>
<cfset createObjectLink = orms_rec.GetCreator(orms_rec.r_type)>
<cfset g_friends = session.user.Friends()>
<cfset subscriptionLink = "/orms/subscription.cfm?target_uuid=" & orms_rec.r_id>
<cfset liveLocLink = "/orms/live_location.cfm?target_uuid=" & orms_rec.r_id>
<cfset linkToMobile = "/orms/link_to_mobile.cfm?target_uuid=" & orms_rec.r_id>
<cfset staticLocLink = "/orms/locate_object.cfm?orms_id=" & orms_rec.r_id>

<cfif session.active_membership.membership_type EQ 'Employee'>
	<cfset g_employees = session.active_membership.site.Employees()>
	<cfset g_customers = session.active_membership.site.Customers()>		
</cfif>    

<cfquery name="ObjectTypes" datasource="#session.framework.BaseDatasource#">
	SELECT r_type FROM orms_creators WHERE r_creatable=1 ORDER BY r_type
</cfquery>

<cfquery name="getSites" datasource="#session.framework.basedatasource#">
	SELECT * FROM site_associations WHERE user_id=#session.user.r_pk#
</cfquery>


<cfmenu type="horizontal" name="overall" menustyle="background-color:##efefef;">
    <cfmenuitem display="#session.user.display_name#" image="/graphics/webware-16x16.png" name="menutest">
    	<cfmenuitem display="My Profile" href="/Prefiniti.cfm?View=#session.user.ObjectRecord().r_id#" />		
        <cfmenuitem display="Memberships">
			<cfoutput query="getSites">
        		<cfset sm = CreateObject("component", "OpenHorizon.Identity.SiteMembership").OpenByPK(id)>
            
            	<cfmenuitem display="#sm.site.site_name# - #sm.membership_type#" href="javascript:ORMSSwitchSites(#id#);" />
	        </cfoutput>
    	</cfmenuitem>
        <cfmenuitem divider />    	
       	<cfoutput query="ObjectTypes">
           	<cfset link = orms_rec.GetCreator(r_type)>
            <cfmenuitem display="New #r_type#" href="javascript:ORMSDialog('#link#');" />                
        </cfoutput>
        <cfmenuitem divider />
        <cfmenuitem display="Friends">
        	<cfloop array="#g_friends#" index="friend">
            	<cfif friend.Online()>
	                <cfmenuitem display="#friend.display_name#" image="#friend.Picture(16, 16)#" href="/Prefiniti.cfm?View=#friend.ObjectRecord().r_id#"/>                    
                </cfif>
            </cfloop>
        </cfmenuitem>
        <cfif session.active_membership.membership_type EQ 'Employee'>
            <cfmenuitem display="Coworkers">
                <cfloop array="#g_employees#" index="friend">
            	<cfif friend.Online()>
	                <cfmenuitem display="#friend.display_name#" image="#friend.Picture(16, 16)#" href="/Prefiniti.cfm?View=#friend.ObjectRecord().r_id#"/>                    
                </cfif>
            </cfloop>
            </cfmenuitem>
            <cfmenuitem display="Customers">
                <cfloop array="#g_customers#" index="friend">
            	<cfif friend.Online()>
	                <cfmenuitem display="#friend.display_name#" image="#friend.Picture(16, 16)#" href="/Prefiniti.cfm?View=#friend.ObjectRecord().r_id#"/>                    
                </cfif>
            	</cfloop>
            </cfmenuitem>
        </cfif>
        <cfmenuitem divider />
		<cfmenuitem display="Sign Out..." image="#img.Silk('door out', 16)#" href="/logoff.cfm" />        
    </cfmenuitem>
    <cfmenuitem display="#session.site.site_name#" image="#img.Silk('world', 15)#">
    	<cfset home_url = session.framework.URLBase & "Prefiniti.cfm?View=" & session.site.ObjectRecord().r_id>
    	<cfmenuitem display="#session.site.site_name# Home" image="/graphics/house.png" href="#home_url#" />
    </cfmenuitem>
    <cfmenuitem display="#orms_rec.r_type#" image="#img.Silk('bricks', 15)#">
    	<cfmenuitem display="Pick Up..." href="javascript:ORMSPickUp('#orms_rec.r_id#')" image="#img.Silk('basket add', 15)#" />
		<cfmenuitem display="Create Another..." image="#img.Silk('page white', 15)#" href="javascript:ORMSDialog('#createObjectLink#');"/>        
		<cfmenuitem divider />
        <cfmenuitem display="Display or Set Static Location..." image="#img.Silk('map', 15)#" href="javascript:ORMSDialog('#staticLocLink#');" />
		<cfmenuitem display="Display Live Location..."  href="javascript:ORMSDialog('#liveLocLink#');"/>
		<cfmenuitem display="Link to Mobile Device..." image="#img.Silk('phone', 15)#" href="javascript:ORMSDialog('#linkToMobile#');"/>
		<cfmenuitem divider />
    	<cfmenuitem display="Permissions..."/>
		<cfmenuitem display="Relationships..."/>
        <cfmenuitem divider />
    	<cfmenuitem display="#orms_rec.r_type# Events" image="#img.Silk('newspaper', 15)#" href="javascript:ORMSLoadFeedFull('#attributes.orms_id#');" />
    	
		<cfoutput query="sections">
        	<cfmenuitem display="#section_name#" href="javascript:ORMSLoadSection(#orms_rec.r_pk#, '#section_loader#');" />
        </cfoutput>
    	
    </cfmenuitem>
	
	<cfif session.user.IsSubscribed(orms_rec) EQ true>
		<cfmenuitem display="Subscribed" image="/graphics/newspaper.png">
			<cfmenuitem display="Unsubscribe" href="javascript:ORMSUnSubscribe('#orms_rec.r_id#', #session.user.r_pk#);"/>
		</cfmenuitem>
	<cfelse>
		<cfmenuitem display="Not Subscribed" image="/graphics/newspaper.png">
			<cfmenuitem display="Subscribe" href="javascript:ORMSSubscribe('#orms_rec.r_id#', #session.user.r_pk#);"/>
		</cfmenuitem>
	</cfif>
    <cfif orms_rec.CanRead(session.user.r_pk)>
        <cfmenuitem display="Files" image="/graphics/disk_multiple.png">
            <cfif orms_rec.CanWrite(session.user.r_pk)>
				<cfmenuitem display="Upload File..." image="#img.Silk('page white get', 15)#" href="javascript:ORMSDialog('/cms/create_file.cfm?target_uuid=#orms_rec.r_id#');"/>
    		</cfif>
	        <cfmenuitem display="Browse Files..." image="#img.Silk('folder magnify', 15)#" href="javascript:ORMSDialog('/cms/browse.cfm?target_uuid=#orms_rec.r_id#');"/>        
        </cfmenuitem>  
    </cfif>
	<cfif session.framework.InstanceMode EQ "Development">
		<cfmenuitem display="Debugging Tools" image="/graphics/bug.png">
			<cfmenuitem display="Session Dump" href="javascript:AjaxLoadPageToDiv('tcTarget', '/DebuggingTools/SessionDump.cfm');"/>
		</cfmenuitem>
    </cfif>
    <!--- <cfmenuitem display="View" image="/graphics/eye.png">
    	<cfmenuitem display=""/>
    </cfmenuitem>
    <cfmenuitem display="Tools" image="/graphics/wrench.png">
    	<cfmenuitem display=""/>
    </cfmenuitem>
    <cfmenuitem display="Help" image="/graphics/help.png">
    	<cfmenuitem display=""/>
    </cfmenuitem> --->    
</cfmenu>



<div class="OH_DIALOG_BG" id="oh_dialog_background" style="display:none;" align="left">
	<div id="orms_dialog_container" align="left"></div>
</div>