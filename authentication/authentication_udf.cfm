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

<cffunction name="getPermissionByKey" returntype="boolean">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="numeric" required="yes">
   
   	<cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="sites">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfset tperm_id=#get_perm_id.id#>
    
    <cfquery name="get_entry" datasource="sites">
    	SELECT * FROM permission_entries WHERE perm_id=#tperm_id# AND assoc_id=#n_assoc_id#
	</cfquery>
    
    <cfif get_entry.RecordCount EQ 0>
    	<cfreturn "false">
    <cfelse>
    	<cfreturn "true" >
	</cfif>                
</cffunction>

<cffunction name="grantPermission" returntype="void">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="string" required="yes">
    
    <cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="sites">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfset tperm_id=#get_perm_id.id#>

	<cfquery name="set_perm" datasource="sites">
    	INSERT INTO permission_entries
        	(assoc_id,
            perm_id)
		VALUES
        	(#n_assoc_id#,
            #tperm_id#)
	</cfquery>
</cffunction>

<cffunction name="getAssociationsByUser" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gabu" datasource="sites">
		SELECT * FROM site_associations WHERE user_id=#user_id#
	</cfquery>

	<cfreturn #gabu#>
</cffunction>    
                            
<cffunction name="getPermissionNameByKey" returntype="string">
	<cfargument name="sz_key" type="string" required="yes">
    
    <cfquery name="gPermName" datasource="sites">
    	SELECT name FROM permissions WHERE perm_key='#sz_key#'
	</cfquery>
    
    <cfreturn #gPermName.name#>
</cffunction>

<cffunction name="getSiteNameByID" returntype="string">
	<cfargument name="site_id" required="yes">
    
    <cfquery name="gSiteName" datasource="sites">
    	SELECT SiteName FROM sites WHERE SiteID=#site_id#
    </cfquery>
    
    <cfreturn #gSiteName.SiteName#>
</cffunction>

<cffunction name="getSiteNameByAssociation" returntype="string">

</cffunction>

<cffunction name="getUserInformation" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfquery name="gbi" datasource="webwarecl">
    	SELECT * FROM Users WHERE id=#user_id#
    </cfquery>    
    
    <cfreturn #gbi#>
</cffunction>    

<cffunction name="getUserLocations" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gul" datasource="webwarecl">
    	SELECT * FROM locations WHERE user_id=#user_id#
    </cfquery>
    
    <cfreturn #gul#>
</cffunction>

<cffunction name="getPublicUserLocations" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gul" datasource="webwarecl">
    	SELECT * FROM locations WHERE user_id=#user_id# AND public_location=1
    </cfquery>
    
    <cfreturn #gul#>
</cffunction>
                           


<cffunction name="getSiteInformation" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">

	<cfquery name="gsi" datasource="sites">
    	SELECT * FROM sites WHERE SiteID=#site_id#
	</cfquery>
    
    <cfreturn #gsi#>
</cffunction>

<cffunction name="getIndustryByID" returntype="string">
	<cfargument name="industry_id" type="numeric" required="yes">
    
    <cfquery name="gibi" datasource="sites">
    	SELECT industry_name FROM industries WHERE id=#industry_id#
	</cfquery>
    
    <cfreturn #gibi.industry_name#>
</cffunction>   

<cffunction name="wwGetDepartments" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgd" datasource="sites">
    	SELECT * FROM departments WHERE site_id=#site_id#
	</cfquery>
    
    <cfreturn #wwgd#>
</cffunction>

<cffunction name="wwDeleteDepartment" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="delete_event_entries" datasource="sites">
    	DELETE FROM event_entries WHERE department_id=#department_id#
    </cfquery>
    
    <cfquery name="delete_department_entries" datasource="sites">
    	DELETE FROM department_entries WHERE department_id=#department_id#
    </cfquery>
    
    <cfquery name="delete_department" datasource="sites">
    	DELETE FROM departments WHERE id=#department_id#
    </cfquery>

</cffunction>

<cffunction name="wwGetDepartmentMembers" returntype="query">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwgdm" datasource="sites">
    	SELECT * FROM department_entries WHERE department_id=#department_id#
	</cfquery>
    
    <cfreturn #wwgdm#>
</cffunction>

<cffunction name="wwCreateDepartment" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="department_name" type="string" required="yes">
    
    <cfquery name="wwcd" datasource="sites">
    	INSERT INTO departments
        	(site_id,
            department_name)
		VALUES 
        	(#site_id#,
            '#department_name#')
	</cfquery>
</cffunction> 

<cffunction name="wwCreateDepartmentMember" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="checkDMExists" datasource="sites">
    	SELECT * FROM department_entries WHERE department_id=#department_id# AND user_id=#user_id#
	</cfquery>
    
    <cfif checkDMExists.RecordCount GT 0>
    	<cfreturn>
	</cfif>                
    
    <cfquery name="wwcdm" datasource="sites">
    	INSERT INTO department_entries
        	(department_id,
            user_id)
		VALUES
        	(#department_id#,
            #user_id#)
	</cfquery>
</cffunction>

<cffunction name="wwSetDepartmentManager" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="wwsdm" datasource="sites">
    	UPDATE departments
        SET		manager_id=#user_id#
        WHERE	id=#department_id#
	</cfquery>
</cffunction>            

<cffunction name="wwDeleteDepartmentMember" returntype="void">
	<cfargument name="id" type="numeric" required="yes">
    
    <cfquery name="wwddm" datasource="sites">
    	DELETE FROM department_entries WHERE id=#id#
	</cfquery>
</cffunction>            

<cffunction name="wwGetEmployeesBySite" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgebs" datasource="sites">
    	SELECT * FROM site_associations WHERE site_id=#site_id# AND assoc_type=1
	</cfquery>
    
    <cfreturn #wwgebs#>
</cffunction>            

                            
<cffunction name="wwIsUserInDepartment" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwiuid" datasource="sites">
    	SELECT * FROM department_entries WHERE department_id=#department_id# and user_id=#user_id#
	</cfquery>
    
    <cfif wwiuid.RecordCount NEQ 0>
    	<cfreturn true>
    <cfelse>
    	<cfreturn false>
	</cfif>                
    
</cffunction>  

<cffunction name="wwIsUserDepartmentManager" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwiudm" datasource="sites">
    	SELECT * FROM departments WHERE id=#department_id# AND manager_id=#user_id#
	</cfquery>
    
    <cfif wwiudm.RecordCount NEQ 0>
    	<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>
    
</cffunction>                                                  

<cffunction name="wwDepartmentName" returntype="string">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwdn" datasource="sites">
    	SELECT department_name FROM departments WHERE id=#department_id#
    </cfquery>
    
    <cfreturn #wwdn.department_name#>
</cffunction>	    

<cffunction name="wwDepartmentManager" returntype="numeric">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwdm1" datasource="sites">
    	SELECT manager_id FROM departments WHERE id=#department_id#
	</cfquery>

	<cfreturn #wwdm1.manager_id#>
</cffunction> 

<cffunction name="wwCreateAssociation" returntype="string">
	<cfargument name="user_id" required="yes" type="numeric">
    <cfargument name="site_id" required="yes" type="numeric">
    <cfargument name="assoc_type" required="yes" type="numeric">
    
    <cfparam name="cid" type="string" default="">
    <cfset cid=CreateUUID()>
    
    <cfquery name="wwca" datasource="sites">
    	INSERT INTO site_associations
        	(user_id,
            site_id,
            assoc_type,
            conf_id)
		VALUES
        	(#user_id#,
            #site_id#,
            #assoc_type#,
            '#cid#')
	</cfquery>
    
    <cfreturn #cid#>
</cffunction>   

<cffunction name="wwReadConfig" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="conf_key" type="string" required="yes">
    
    <cfquery name="wwrc" datasource="webwarecl">
    	SELECT * FROM configuration WHERE user_id=#user_id# AND conf_key='#conf_key#'
	</cfquery>
    
    <cfif wwrc.RecordCount GT 0>
    	<cfreturn wwrc.conf_value>
	<cfelse>
    	<cfreturn "WW_NOT_CONFIGURED">
	</cfif>
</cffunction>                            

<cffunction name="wwWriteConfig" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="conf_key" type="string" required="yes">
    <cfargument name="conf_value" type="string" required="yes">
    
    <cfif wwReadConfig(user_id, conf_key) EQ "WW_NOT_CONFIGURED">
    	<cfquery name="wwwc_new" datasource="webwarecl">
        	INSERT INTO configuration
            	(user_id,
                conf_key,
                conf_value)
			VALUES
            	(#user_id#,
                '#conf_key#',
                '#conf_value#')
		</cfquery>                                
    <cfelse>
		<cfquery name="wwwc_old" datasource="webwarecl">
        	UPDATE configuration
            SET		conf_value='#conf_value#'
            WHERE	conf_key='#conf_key#'
            AND		user_id=#user_id#
		</cfquery>            
	</cfif>
</cffunction>                     

<cffunction name="pfLocalTime" returntype="date">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="ServerTime" type="date" required="yes">
    
    <cfparam name="tzOffset" default="">
    <cfset tzOffset = wwReadConfig(UserID, "PF:TIMEZONE")>
    
    <cfif tzOffset EQ "WW_NOT_CONFIGURED">
    	<cfset tzOffset = 0>
	</cfif>
    
   <cfparam name="outDate" default="">
   <cfset outDate = DateAdd("h", tzOffset, ServerTime)>
   
   <cfreturn #outDate#>
</cffunction>   


<cffunction name="pfScheduleLocalTime" returntype="date">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="ServerTime" type="date" required="yes">
    
    <cfparam name="tzOffset" default="">
    <cfset tzOffset = wwReadConfig(UserID, "PF:TIMEZONE")>
    
    <cfif tzOffset EQ "WW_NOT_CONFIGURED">
    	<cfset tzOffset = 0>
	</cfif>
    
    <cfif tzOffset GE 0>
    	<cfset tzOffset = -tzOffset>
	<cfelse>
    	<cfset tzOffset = Abs(tzOffset)>
	</cfif>                
    
   <cfparam name="outDate" default="">
   <cfset outDate = DateAdd("h", tzOffset, ServerTime)>
   
   <cfreturn #outDate#>
</cffunction>         

<cffunction name="clientByClsJobNumber" returntype="string">
	<cfargument name="clsJobNumber" type="string" required="yes">
    
    <cfquery name="gProj" datasource="webwarecl">
    	SELECT clientID FROM projects WHERE clsJobNumber='#clsJobNumber#'
	</cfquery>
    
    <cfif gProj.RecordCount GT 0>
        <cfquery name="gCli" datasource="webwarecl">
            SELECT longName FROM Users WHERE id=#gProj.clientID#
        </cfquery>
        
        <cfreturn #gCli.longName#>
	<cfelse>
    	<cfreturn "N/A">
	</cfif>
</cffunction>            		                    

<cffunction name="pfIsPrefinitiAdmin" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
	
	<cfquery name="pfipa" datasource="webwarecl">
		SELECT webware_admin FROM Users WHERE id=#user_id#
	</cfquery>
	
	<cfif pfipa.webware_admin EQ true>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>							

<cffunction name="pfGetSession" returntype="string">
	<cfargument name="username" type="string" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
	<cfargument name="HP_CGI_NetworkNode" type="string" required="yes">
	<cfargument name="HP_Browser" type="string" required="yes">
	<cfargument name="HP_PrefinitiHostKey" type="string" required="yes">
	<cfargument name="HP_OS" type="string" required="yes">

	<cfquery name="GetExistingSessions" datasource="webwarecl">
		SELECT * FROM auth_tokens WHERE user_id=#user_id# AND active=1
	</cfquery>
	
		<!--- CREATE A NEW SESSION --->
		<cfparam name="SessionKey" default="">
		<cfset SessionKey = CreateUUID()>
		
		<cfquery name="UpdateOldSessions" datasource="webwarecl">
			UPDATE auth_tokens
			SET		active=0,
					logout_date=#CreateODBCDateTime(Now())#
			WHERE	user_id=#user_id# AND active=1
		</cfquery>	
		
		<cfquery name="cns" datasource="webwarecl">
			INSERT INTO auth_tokens
				(username,
				token, 
				user_id,
				HP_CGI_NetworkNode,
				HP_CGI_Browser,
				HP_PrefinitiHostKey,
				HP_OS,
				login_date,
				active,
				session_key)
			VALUES 
				('#username#',
				'#CreateUUID()#',
				#user_id#,
				'#HP_CGI_NetworkNode#',
				'#HP_Browser#',
				'#HP_PrefinitiHostKey#',
				'#HP_OS#',
				#CreateODBCDateTime(Now())#,
				1,
				'#SessionKey#')

		</cfquery>
		

		
		<cfreturn #SessionKey#>

</cffunction>