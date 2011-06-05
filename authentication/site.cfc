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

<cfcomponent displayname="site" hint="Represents a Prefiniti site" output="no">
	<cfset this.r_pk = 0>    
    <cfset this.site_name = "">
    <cfset this.admin_id = 724>
    <cfset this.enabled = true>
    <cfset this.summary = "">
    <cfset this.about = "">
    <cfset this.industry = 0>
    <cfset this.logo = "">
    <cfset this.mission_statement = "">
    <cfset this.vision_statement = "">
    <cfset this.slogan = "">
    <cfset this.om_uuid = ""> 					<!--- conf_id --->
    <cfset this.salestax_rate = 0>
    <cfset this.logo_invoice = "">
    
    <cfset this.written = false>

	<cffunction name="Open" access="public" returntype="authentication.site">
		<cfargument name="id" type="numeric" required="yes">

		<cfquery name="s" datasource="sites">
        	SELECT * FROM sites WHERE SiteID = id
        </cfquery>
        
        <cfset this.r_pk = s.id>
        <cfset this.site_name = s.SiteName>
        <cfset this.admin_id = s.admin_id>
        <cfset this.enabled = s.enabled>
        <cfset this.summary = s.summary>
        <cfset this.about = s.about>
        <cfset this.industry = s.industry>
        <cfset this.logo = s.logo>
        <cfset this.mission_statement = s.mission_statement>
        <cfset this.vision_statement = s.vision_statement>
        <cfset this.slogan = s.slogan>
        <cfset this.om_uuid = s.conf_id>
        <cfset this.salestax_rate = s.salestax_rate>
        <cfset this.logo_invoice = s.logo_invoice>
        
        <cfset this.written = true>
        
        <cfreturn #this#>
	</cffunction>
    
    <cffunction name="Save" access="public" output="no" returntype="void">
    	<cfif this.written>
      		<cfset this.UpdateExistingRecord()>
    	<cfelse>
      		<cfset this.WriteAsNewRecord()>
    	</cfif>
    	<cfmodule template="/authentication/Sites/orms_do.cfm" id="#this.r_pk#">
        <cfset this.written = true>
  	</cffunction>
    
    <cffunction name="UpdateExistingRecord" access="public" output="no" returntype="void">
    	<cfquery name="uer" datasource="sites">
			UPDATE	sites
            SET		SiteName='#this.site_name#',
            		enabled=#this.enabled#,
                    summary='#this.summary#',
                    about='#this.about#',
                    industry=#this.industry#,
                    logo='#this.logo#',
                    mission_statement='#this.mission_statement#',
                    vision_statement='#this.vision_statement#',
                    slogan='#this.slogan#',
                    salestax_rate=#this.salestax_rate#,
                    logo_invoice='#this.logo_invoice#',
                    admin_id=#this.admin_id#
			WHERE	id=#this.r_pk#                    
		</cfquery>        
	</cffunction>        
    
    <cffunction name="WriteAsNewRecord" access="public" output="no" returntype="void">
    	<cfset this.om_uuid = CreateUUID()>
    
    	<cfquery name="wanr" datasource="sites">
        	INSERT INTO	sites
            			(SiteName,
                        enabled,
                        summary,
                        about,
                        industry,
                        logo,
                        mission_statement,
                        vision_statement,
                        slogan,
                        salestax_rate,
                        logo_invoice,
                        admin_id,
                        conf_id)
			VALUES		('#this.site_name#',
            			#this.enabled#,
                        '#this.summary#',
                        '#this.about#',
                        #this.industry#,
                        '#this.logo#',
                        '#this.mission_statement#',
                        '#this.vision_statement#',
                        '#this.slogan#',
                        #this.salestax_rate#,
                        '#this.logo_invoice#',
                        #this.admin_id#,
                        '#this.om_uuid#')                        
        </cfquery>    
        
        <cfquery name="gwanr" datasource="sites">
        	SELECT SiteID FROM sites WHERE conf_id='#this.om_uuid#'
        </cfquery>
        
        <cfset this.r_pk = gwanr.SiteID>               
	</cffunction>
    
    <cffunction name="AddMembership" access="public" returntype="void" output="no">
    	<cfargument name="user" type="authentication.user" required="yes">
        
    </cffunction>
    
    <cffunction name="DeleteMembership" access="public" returntype="void" output="no">
    	<cfargument name="user" type="authentication.user" required="yes">
    
    </cffunction>

    <cffunction name="Memberships" access="public" returntype="array" output="no">
    	<cfargument name="user" type="authentication.user" required="yes">
    
    </cffunction>
            
</cfcomponent>