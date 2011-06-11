<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="get_sites" datasource="sites">
	SELECT * FROM sites WHERE SiteID=#attributes.id#
</cfquery>

<cfset rt = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfoutput query="get_sites">
		<cfset rtype = "Site">
		<cfset rowner = admin_id>
		<cfset rsite = SiteID>
		<cfset rname = SiteName>
		<cfset redit = 'javascript:ORMSNoAction();'>
		<cfset rview = 'javascript:viewSiteProfile(#SiteID#)'>
		<cfset rdel = "javascript:ORMSNoAction();">
		<cfset rthumb = "/graphics/prefsite.png">
		<cfset rpk = SiteID>
		
		<cfswitch expression="#enabled#">
			<cfcase value="0">
				<cfset rstat = "Disabled">
			</cfcase>
			<cfcase value="1">
				<cfset rstat = "Active">
			</cfcase>
		</cfswitch>
		<cfset rpar = "NONE">												
		
		<cfset rt.Crup(rtype, rowner, rsite, rname, redit, rview, rdel, rthumb, rpk, rstat, rpar)>	
		<cfscript>
			rt.AddPair("Site/Name", SiteName);
			rt.AddPair("Site/Administrator", getLongname(admin_id));
			rt.AddPair("Site/Industry", getIndustryByID(industry));			
		</cfscript>
</cfoutput>