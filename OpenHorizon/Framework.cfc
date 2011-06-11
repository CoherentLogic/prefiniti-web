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
    
    
</cfcomponent>
