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
<cfcomponent displayname="site_membership" output="no">
	<cfset this.site = "">
    <cfset this.user = "">
    <cfset this.membership_type = "">
    <cfset this.r_pk = 0>
    
    <cfset this.written = false>
    
    <cffunction name="Create" access="public" returntype="authentication.site_membership" output="no">
		<cfargument name="site" type="authentication.site" required="yes">
    	<cfargument name="user" type="authentication.user" required="yes">
        <cfargument name="membership_type" type="string" required="yes">
        
        <cfset this.site = site>
        <cfset this.user = user>
        <cfset this.membership_type = membership_type>
                                        
		<cfreturn #this#>                                        
    </cffunction>
    
    <cffunction name="Open" access="public" returntype="authentication.site_membership" output="no">
    	<cfargument name="site" type="authentication.site" required="yes">
    	<cfargument name="user" type="authentication.user" required="yes">
        <cfargument name="membership_type" type="string" required="yes">
        
        <cfquery name="oid" datasource="sites">
        	SELECT association_type FROM association_types WHERE association_type_name='#membership_type#'
        </cfquery>
        
        <cfquery name="open" datasource="sites">
        	SELECT 	* 
            FROM 	site_associations 
            WHERE 	site_id=#site.r_pk# 
            AND		user_id=#user.r_pk#
            AND		assoc_type=#oid.association_type#
        </cfquery>
        
        <cfset this.site = site>
        <cfset this.user = user>
        <cfset this.membership_type = membership_type>
        <cfset this.r_pk = open.id>
        
        <cfset this.written = true>
        
        <cfreturn #this#>
    </cffunction>
    
    
    <cffunction name="Delete" access="public" returntype="void" output="no">
    	<cfargument name="site" type="authentication.site" required="yes">
    	<cfargument name="user" type="authentication.user" required="yes">
    	<cfargument name="membership_type" type="string" required="yes">
        
        <cfquery name="mt_id" datasource="sites">
        	SELECT association_type FROM association_types WHERE association_type_name='#membership_type#'
        </cfquery>
        
        <cfquery name="delete_member" datasource="sites">
        	DELETE FROM site_associations
            WHERE		user_id=#user.r_pk#
            AND			assoc_type=#mt_id.association_type#
        </cfquery>        
    </cffunction>
    
    <cffunction name="Save" access="public" output="no" returntype="void">
    	<cfif NOT this.written>      	
      		<cfset this.WriteAsNewRecord()>
    	</cfif>
    	<cfmodule template="/authentication/Sites/orms_do.cfm" id="#this.r_pk#">
        <cfset this.written = true>
  	</cffunction>
    
    <cffunction name="WriteAsNewRecord" access="public" output="no" returntype="void">
    	<cfset this.om_uuid = CreateUUID()>       
        
        <cfquery name="mt" datasource="sites">
        	SELECT association_type FROM association_types WHERE association_type_name='#this.membership_type#'
        </cfquery>
        
        <cfquery name="wanr" datasource="sites">
        	INSERT INTO site_associations
            			(user_id,
                        site_id,
                        assoc_type,
                        conf_id)
			VALUES		(#this.user.r_pk#,
            			#this.site.r_pk#,
                        #mt.association_type#,
                        '#this.om_uuid#')                                                
        </cfquery>
        
        <cfquery name="wanr_id" datasource="sites">
        	SELECT id FROM site_associations WHERE conf_id='#this.om_uuid#'
        </cfquery>
        
        <cfset this.r_pk = wanr_id.id>
    </cffunction>
    
    <cffunction name="Grant" access="public" output="no" returntype="void">
    	<cfargument name="permission_key" type="string" required="yes">
                  
        <cfparam name="tperm_id" default="">
        
        <cfquery name="get_perm_id" datasource="sites">
            SELECT * FROM permissions WHERE perm_key='#permission_key#'
        </cfquery>
        
        <cfset tperm_id = get_perm_id.id>
    
        <cfquery name="set_perm" datasource="sites">
            INSERT INTO permission_entries
                (assoc_id,
                perm_id)
            VALUES
                (#this.r_pk#,
                #tperm_id#)
        </cfquery>                        
    </cffunction>
    
    <cffunction name="Revoke" access="public" output="no" returntype="void">
    	<cfargument name="permission_key" type="string" required="yes">
        
        <cfparam name="tperm_id" default="">
        
        <cfquery name="get_perm_id" datasource="sites">
            SELECT * FROM permissions WHERE perm_key='#permission_key#'
        </cfquery>
        
        <cfset tperm_id = get_perm_id.id>  
        
        <cfquery name="rev_perm" datasource="site">
        	DELETE FROM	permission_entries
            WHERE		assoc_id=#this.r_pk#
            AND			perm_id=#tperm_id#
        </cfquery>              
    </cffunction>


    <cffunction name="Examine" access="public" output="no" returntype="boolean">
    	<cfargument name="permission_key" type="string" required="yes">
		
        <cfparam name="tperm_id" default="">
    
        <cfquery name="get_perm_id" datasource="sites">
            SELECT * FROM permissions WHERE perm_key='#permission_key#'
        </cfquery>
        
        <cfset tperm_id = get_perm_id.id>
        
        <cfquery name="get_entry" datasource="sites">
            SELECT * FROM permission_entries WHERE perm_id=#tperm_id# AND assoc_id=#this.r_pk#
        </cfquery>
        
        <cfif get_entry.RecordCount EQ 0>
            <cfreturn "false">
        <cfelse>
            <cfreturn "true" > 
        </cfif>                           
    </cffunction>
	
</cfcomponent> 