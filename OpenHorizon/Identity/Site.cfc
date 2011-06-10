<!--- Open Horizon site.cfc $Revision: 1.3 $ --->
<cfcomponent displayname="Site" hint="Represents a site on Open Horizon." extends="OpenHorizon.Framework">
	
    <cfset this.SiteName = "">
    <cfset this.Administrator = "">
    <cfset this.BillingPlan = "">
    <cfset this.SalesTaxRate = 0>
    <cfset this.Enabled = "">
    <cfset this.Industry = "">
    
    <cfset this.Logo = "">
    <cfset this.Slogan = "">
	<cfset this.About = "">
    <cfset this.Summary = "">
    <cfset this.MissionStatement = "">
	<cfset this.VisionStatement = "">
    
    <cfset this.Written = false>
	<cfset this.DBKey = "">
    
    
    <cffunction name="Open" displayname="Open" hint="Open an Open Horizon site" access="public" returntype="OpenHorizon.Identity.Site">
		<cfargument name="SiteName" type="string" required="yes">
		
        <cfquery name="qryOpenSite" datasource="#this.SitesDatasource#">
        	SELECT * FROM sites WHERE SiteName='#SiteName#'
		</cfquery>
        
        <cfscript>
			this.SiteName = qryOpenSite.SiteName;
			this.Administrator = createObject("component", "OpenHorizon.Identity.User").OpenByDBKey(qryOpenSite.admin_id).Object;
			// this.BillingPlan		TODO: implement OpenHorizon.Identity.BillingPlan
			this.SalesTaxRate = qryOpenSite.salestax_rate;
			this.Enabled = qryOpenSite.enabled;
			// this.Industry		TODO: implement OpenHorizon.Identity.Industry
			// this.Logo			TODO: call OpenHorizon.Graphics.Image() to use this
			this.Slogan = qryOpenSite.slogan;
			this.About = qryOpenSite.about;
			this.Summary = qryOpenSite.Summary;
			this.MissionStatement = qryOpenSite.mission_statement;
			this.VisionStatement = qryOpenSite.vision_statement;			
			
			this.DBKey = qryOpenSite.SiteID;
			this.Written = true;
		</cfscript>			
			
		<cfreturn #this#>
	</cffunction>
    
     <cffunction name="OpenByDBKey" displayname="OpenByDBKey" hint="Open an Open Horizon site by its database PK." access="public" returntype="OpenHorizon.Identity.Site">
		<cfargument name="DBKey" type="numeric" required="yes" hint="The Primary Key of the Site object in the database.">
		
        <cfquery name="qryOpenSite" datasource="#this.SitesDatasource#">
        	SELECT * FROM sites WHERE SiteID='#DBKey#'
		</cfquery>
        
        <cfscript>
			this.SiteName = qryOpenSite.SiteName;
			this.Administrator = createObject("component", "OpenHorizon.Identity.User").OpenByDBKey(qryOpenSite.admin_id).Object;
			// this.BillingPlan		TODO: implement OpenHorizon.Identity.BillingPlan
			this.SalesTaxRate = qryOpenSite.salestax_rate;
			this.Enabled = qryOpenSite.enabled;
			// this.Industry		TODO: implement OpenHorizon.Identity.Industry
			// this.Logo			TODO: call OpenHorizon.Graphics.Image() to use this
			this.Slogan = qryOpenSite.slogan;
			this.About = qryOpenSite.about;
			this.Summary = qryOpenSite.Summary;
			this.MissionStatement = qryOpenSite.mission_statement;
			this.VisionStatement = qryOpenSite.vision_statement;			
			
			this.DBKey = qryOpenSite.SiteID;
			this.Written = true;
		</cfscript>			
			
		<cfreturn #this#>
	</cffunction>
    
    <cffunction name="Departments" displayname="Departments" hint="Array of departments in an Open Horizon site." access="public" returntype="array" output="no">
    	
        <cfparam name="tmpArray" default="">
        <cfset tmpArray = ArrayNew(1)>
        
        <cfquery name="qryDepartments" datasource="#this.SitesDatasource#">
        	SELECT id FROM departments WHERE site_id=#this.DBKey#
        </cfquery>
        
        <cfparam name="tDept" default="">      
        <cfoutput query="qryDepartments">
        	<cfset tDept = createObject("component", "OpenHorizon.Identity.Department").LoadByDBKey(id)>
            #ArrayAppend(tmpArray, tDept)#
        </cfoutput>
        
        <cfreturn #tmpArray#>
    </cffunction>
</cfcomponent>