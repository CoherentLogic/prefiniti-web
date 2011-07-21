
<cfset orms = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset orms_rec = orms.Get(attributes.orms_id)>
<cfset img = createObject("component", "OpenHorizon.Graphics.Image")>
<cfset sections = orms_rec.GetSections()>
<cfset createObjectLink = orms_rec.GetCreator(orms_rec.r_type)>
<cfset g_friends = session.user.Friends()>

<cfif session.active_membership.membership_type EQ 'Employee'>
	<cfset g_employees = session.active_membership.site.Employees()>
	<cfset g_customers = session.active_membership.site.Customers()>		
</cfif>    

<cfquery name="ObjectTypes" datasource="#session.framework.BaseDatasource#">
	SELECT r_type FROM orms_creators ORDER BY r_type
</cfquery>

<cfquery name="getSites" datasource="sites">
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
    <cfmenuitem display="#session.site.site_name#" image="/graphics/world.png">
    	<cfset home_url = session.framework.URLBase & "?View=" & session.site.ObjectRecord().r_id>
    	<cfmenuitem display="#session.site.site_name# Home" image="/graphics/house.png" href="#home_url#" />
    </cfmenuitem>
    <cfmenuitem display="#orms_rec.r_type#" image="/graphics/bricks.png">
    	<cfmenuitem display="Create Another..." image="#img.Silk('page white', 16)#" href="javascript:ORMSDialog('#createObjectLink#');"/>
        <cfmenuitem display="Subscription..." image="#img.Silk('rss', 16)#" href="javascript:ORMSDialog();" />
		
        <cfmenuitem display="Location..." image="#img.Silk('map', 16)#" href="javascript:current_object.ShowLocation();" />
    	
        <cfmenuitem divider />
    	<cfmenuitem display="#orms_rec.r_type# Events" image="#img.Silk('newspaper', 16)#" href="javascript:ORMSLoadFeedFull('#attributes.orms_id#');" />
    	
		<cfoutput query="sections">
        	<cfmenuitem display="#section_name#" href="javascript:ORMSLoadSection(#orms_rec.r_pk#, '#section_loader#');" />
        </cfoutput>
    	
    </cfmenuitem>
    <cfif orms_rec.CanRead(session.user.r_pk)>
        <cfmenuitem display="Files" image="/graphics/disk_multiple.png">
            <cfmenuitem display="Upload File..." image="#img.Silk('page white get', 16)#" href="javascript:ORMSDialog('/cms/create_file.cfm?target_uuid=#orms_rec.r_id#');"/>
            <cfmenuitem display="Browse Files..." image="#img.Silk('folder magnify', 16)#" href="javascript:ORMSDialog('/cms/browse.cfm?target_uuid=#orms_rec.r_id#');"/>        
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