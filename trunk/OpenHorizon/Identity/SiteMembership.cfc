<!--- Open Horizon SiteMembership.cfc $Revision: 1.2 $--->
<cfcomponent displayName="SiteMembership" hint="Encapsulates a membership to an Open Horizon site" extends="OpenHorizon.Framework">
	
    <cfset this.MembershipID = "">
    <cfset this.SiteID = "">
    <cfset this.MembershipType = "">
    <cfset this.SiteName = "">
    <cfset this.Site = "">
    
    <cfset this.DBKey = "">
    
    <cffunction name="Create" displayName="Create" hint="Create a new site membership" access="public" returnType="OpenHorizon.Identity.SiteMembership" output="false">
		<!--- Create body --->
		<cfreturn #this#>
	</cffunction>
    
    <cffunction name="Load" displayname="Load" hint="Load an existing site membership from the database" access="public" returntype="OpenHorizon.Identity.SiteMembership" output="false">
    	<cfargument name="SiteName" type="string" required="yes">
        <cfargument name="MembershipType" type="string" required="yes">
        
        
        <cfquery name="qryLoadByID" datasource="#this.SitesDatasource#">
			SELECT
            	site_associations.id AS MembershipID,                
                sites.SiteID AS SiteID,
                sites.SiteName AS SiteName,
                association_types.association_type_name AS MembershipType
             FROM site_associations 
             INNER JOIN sites 
             ON site_associations.site_id=sites.SiteID
             INNER JOIN association_types
             ON site_associations.assoc_type=association_types.association_type
             WHERE SiteName='#SiteName#' 
             AND   MembershipType='#MembershipType#'   	        
        </cfquery>
        
        <cfset this.MembershipID = qryLoadByID.MembershipID>
        <cfset this.SiteID = qryLoadByID.SiteID>
        <cfset this.MembershipType = qryLoadByID.MembershipType>
        <cfset this.SiteName = qryLoadByID.SiteName>      
        
        
        <cfset this.Site = createObject("component", "OpenHorizon.Identity.Site").Open(this.SiteName)>
        
        <cfreturn #this#>
    </cffunction>
    
    <cffunction name="LoadByID" displayname="LoadByID" hint="Load an existing site membership from the database by membership ID" access="public" returntype="OpenHorizon.Identity.SiteMembership" output="false">
    	<cfargument name="MembershipID" type="numeric" required="yes">
        
        <cfquery name="qryLoadByID" datasource="#this.SitesDatasource#">
			SELECT
            	site_associations.id AS MembershipID,                
                sites.SiteID AS SiteID,
                sites.SiteName AS SiteName,
                association_types.association_type_name AS MembershipType
             FROM site_associations 
             INNER JOIN sites 
             ON site_associations.site_id=sites.SiteID
             INNER JOIN association_types
             ON site_associations.assoc_type=association_types.association_type
             WHERE site_associations.id=#MembershipID#        	        
        </cfquery>
        
        <cfset this.MembershipID = qryLoadByID.MembershipID>
        <cfset this.SiteID = qryLoadByID.SiteID>
        <cfset this.MembershipType = qryLoadByID.MembershipType>
        <cfset this.SiteName = qryLoadByID.SiteName>      
        
		<cftry>
        <cfset this.Site = createObject("component", "OpenHorizon.Identity.Site").Open(this.SiteName)>
        <cfcatch>
        	<cflog file="OpenHorizon.Identity.SiteMembership" type="error" text="Message: #cfcatch.Message#">
        	<cflog file="OpenHorizon.Identity.SiteMembership" type="error" text="Detail: #cfcatch.Detail#">
        </cfcatch>
        </cftry>
        <cfreturn #this#>
    </cffunction>
    
    <cffunction name="InstalledApps" hint="Return an array of structures representing all installed apps." access="public" returntype="array" output="no">
    	
        <cfquery name="qryInstalledApps" datasource="#this.BaseDatasource#">
        	SELECT * FROM apps_installed WHERE MembershipID = #this.MembershipID#
		</cfquery>  
        
        <cfparam name="tmpArray" default="">
        <cfset tmpArray = ArrayNew(1)>
        
        
        <cfparam name="appObj" default="">
        
        <cfoutput query="qryInstalledApps">
        	<cfset appObj = createObject("component", "OpenHorizon.Apps.App").Open(AppID)>
            
          	#ArrayAppend(tmpArray, appObj)#
        </cfoutput>          
        
        <cfreturn #tmpArray#>
    </cffunction>
    
    <cffunction name="IsAppInstalled" hint="Is an application installed on this membership?" access="public" returntype="boolean" output="no">
    	<cfargument name="AppID" hint="The UUID-format ID of the application in question" type="string" required="yes">
        
        <cfquery name="qryIsAppInstalled" datasource="#this.BaseDatasource#">
        	SELECT * FROM apps_installed WHERE AppID='#AppID#' AND MembershipID=#this.MembershipID#
		</cfquery>
        
        <cfif qryIsAppInstalled.RecordCount GT 0>
        	<cfreturn true>
		<cfelse>
        	<cfreturn false>
		</cfif>                                    
        
    </cffunction>
    
    <cffunction name="Enumerate" displayname="Enumerate" hint="Enumerate site memberships for a user." access="public" returntype="query" output="false">
    	<cfargument name="User" type="OpenHorizon.Identity.User" required="yes">
        
        <cfquery name="qryEnumerateSM" datasource="#this.SitesDatasource#">
        	SELECT
            	site_associations.id AS MembershipID,                
                sites.SiteID AS SiteID,
                sites.SiteName AS SiteName,
                association_types.association_type_name AS MembershipType
             FROM site_associations 
             INNER JOIN sites 
             ON site_associations.site_id=sites.SiteID
             INNER JOIN association_types
             ON site_associations.assoc_type=association_types.association_type
             WHERE site_associations.user_id=#User.DBKey#             
        </cfquery>
        
        <cfreturn #qryEnumerateSM#>
    
    </cffunction>
    
    <cffunction name="EnumerateGrid" displayname="Enumerate" hint="Enumerate site memberships for a user in a grid format." access="public" returntype="query" output="false">
    	<cfargument name="User" type="OpenHorizon.Identity.User" required="yes">
        <cfargument name="Page" type="numeric" required="yes">
        <cfargument name="PageSize" type="numeric" required="yes">
        <cfargument name="SortColumn" type="string" required="yes">
        <cfargument name="SortDirection" type="string" required="yes">
        
        
        <cfquery name="qryEnumerateSMGrid" datasource="#this.SitesDatasource#">
        	SELECT
            	site_associations.id AS MembershipID,                
                sites.SiteID AS SiteID,
                sites.SiteName AS SiteName,
                association_types.association_type_name AS MembershipType
             FROM site_associations 
             INNER JOIN sites 
             ON site_associations.site_id=sites.SiteID
             INNER JOIN association_types
             ON site_associations.assoc_type=association_types.association_type
             WHERE site_associations.user_id=#User.DBKey#
             
        </cfquery>
        <!--- ORDER BY #SortColumn# #SortDirection#
            --->
        <cfreturn #qryEnumerateSMGrid#>
    
    </cffunction>
</cfcomponent>