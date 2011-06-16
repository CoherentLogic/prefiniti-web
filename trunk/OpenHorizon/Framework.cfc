<!--- Open Horizon Framework.cfc $Revision: 1.2 $ --->

<cfcomponent displayName="Framework" hint="Open Horizon Base">
	
    <cfset this.BaseDatasource = "webwarecl">
    <cfset this.SitesDatasource = "sites">
    <cfset this.CMSDatasource = "webware_cms">
	
	
	<cfset this.URLBase = CreateObject("component", "Prefiniti").Config("Instance", "rooturl")>
	<cfset this.ServerPort = CreateObject("component", "Prefiniti").Config("Instance", "serverport")>
    <cfset this.OHRootDir = CreateObject("component", "Prefiniti").Config("Instance", "ohrootdir")>
	<cfset this.StorageRoot =  CreateObject("component", "Prefiniti").Config("ORMS", "filestorage")>
	<cfset this.ServerPlatform =  CreateObject("component", "Prefiniti").Config("Instance", "platform")>
	<cfset this.PathDelimiter =  CreateObject("component", "Prefiniti").Config("Instance", "pathdelimiter")>
	<cfset this.PrefinitiRoot =  CreateObject("component", "Prefiniti").Config("Instance", "rootpath")>
	<cfset this.Staging = CreateObject("component", "Prefiniti").Config("Instance", "staging")>
	<cfset this.ThumbnailCache = CreateObject("component", "Prefiniti").Config("Instance", "thumbnailcache")>
   	<cfset this.CMSURL = CreateObject("component", "Prefiniti").Config("ORMS", "cmsurl")>
    
    <cfset this.main_site_id = CreateObject("component", "Prefiniti").Config("Instance", "mainsite")>
   
    <cfset this.notification_sender_id = CreateObject("component", "Prefiniti").Config("Instance", "notification_sender")>
    
    
    
    <cffunction name="PermissionSet" access="public" returntype="string" output="no">
    	<cfargument name="set_key" type="string" required="yes">
        
        <cfquery name="ps" datasource="#this.SitesDatasource#">
        	SELECT permission_list FROM permission_sets WHERE id='#set_key#'
        </cfquery>
        
        <cfreturn #ps.permission_list#>
    </cffunction>
    
    <cffunction name="MainSite" access="public" returntype="OpenHorizon.Identity.Site" output="no">
    	 <cfset ret_val = CreateObject("component", "OpenHorizon.Identity.Site").Open(this.main_site_id)>
         
         <cfreturn #ret_val#>
    </cffunction>
    
    <cffunction name="NotificationSender" access="public" returntype="OpenHorizon.Identity.User" output="no">
    	<cfset ret_val = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(this.notification_sender_id)>
        
        <cfreturn #ret_val#>
    </cffunction>
    
</cfcomponent>
