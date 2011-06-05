<cfinclude template="/contentmanager/cm_udf.cfm">

<cfparam name="cid" default="">
<cfset cid = CreateUUID()>

<cfquery name="addSite" datasource="sites">
	INSERT INTO sites 
    	(SiteName,
        admin_id,
        enabled,
        conf_id,
        industry)
	VALUES
    	('#form.SiteName#',
        #form.admin_id#,
        #form.enabled#,
        '#cid#',
        #form.industry#)        
</cfquery>

<cfquery name="getSite" datasource="sites">
	SELECT * FROM sites WHERE conf_id='#cid#'
</cfquery>
    

<cfquery name="addAdminAssoc" datasource="sites">
	INSERT INTO site_associations
    	(user_id,
        site_id,
        assoc_type,
        conf_id)
    VALUES
    	(#form.admin_id#,
        #getSite.SiteID#,
        1,
        '#cid#')
</cfquery>      

<cfquery name="acid" datasource="sites">
	SELECT id FROM site_associations WHERE conf_id='#cid#'
</cfquery>



<cfoutput>

	#grantPermission("AS_LOGIN", acid.id)#
    #grantPermission("AS_CREATE", acid.id)#
    #grantPermission("AS_EDIT", acid.id)#
    #grantPermission("AS_DELETE", acid.id)#
    #grantPermission("SC_MANAGECREW", acid.id)#
    #grantPermission("AS_VIEW", acid.id)#
    #grantPermission("TS_EDIT_TC", acid.id)#
    #grantPermission("TS_DELETE_TC", acid.id)#
    #grantPermission("TS_VIEWALL", acid.id)#
    #grantPermission("MA_VIEW", acid.id)#
    #grantPermission("MA_WRITE", acid.id)#
    #grantPermission("SC_VIEW", acid.id)#
    #grantPermission("CM_STAGE", acid.id)#
    #grantPermission("TS_VIEW", acid.id)#
    #grantPermission("TS_CREATE", acid.id)#
    #grantPermission("TS_EDIT", acid.id)#
    #grantPermission("TS_DELETE", acid.id)#
    #grantPermission("TS_VIEW_TC", acid.id)#
    #grantPermission("GIS_VIEWSUBDIVISION", acid.id)#
    #grantPermission("CM_VIEW_STAGED", acid.id)#
    #grantPermission("WF_CREATE", acid.id)#
    #grantPermission("WF_VIEWRFP", acid.id)#
    #grantPermission("WF_SEARCH", acid.id)#
    #grantPermission("WF_VIEW", acid.id)#
    #grantPermission("WW_SITEMAINTAINER", acid.id)#
	
    #cmsCreateStagingArea(getSite.SiteID, '')#
</cfoutput>      

<cflocation url="/webware_admin/manageSites.cfm" addtoken="no">