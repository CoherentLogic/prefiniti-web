<!---
	$Id$
--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="description" content="Prefiniti is a social networking, business management, project management, and e-commerce service." /> 
<head>
    <!-- Configure the Prefiniti Cold Fusion application -->
    <cfapplication name="Prefiniti_1" sessionmanagement="yes">
    
    <!-- Declare session variables -->

    <cfparam name="session.username" default="">
    <cfparam name="session.userid" default="">
    <cfparam name="session.longname" default="0">
    <cfparam name="session.loggedin" default="no">
    <cfparam name="session.datasource" default="webwarecl">
    <cfparam name="session.site_maintainer" default="0">
    <cfparam name="session.email" default="">
    <cfparam name="session.browserType" default="">
    <cfparam name="session.current_site_id" default="0">
    <cfparam name="session.current_association" default="0">
    <cfparam name="session.webware_admin" default="0">
    <cfparam name="session.authentication_key" default="">
  
    

    <div id="soundmanager-debug" style="display:none;"></div>
    
    <cfinclude template="/console.cfm">
          
     
    <!-- Include the WebWare API files -->
    <cfinclude template="scriptIncludes.cfm">
    <cfinclude template="/screenFader.cfm">
	  
    <!-- Detect the browser type -->
    <cfinclude template="browserDetection.cfm">
    
    <!-- Load the appropriate stylesheet -->
    <cfinclude template="styleConfig.cfm">

    <!-- Configure the shortcut icon and site RSS feed -->
	<cfinclude template="configRSS.cfm">
</head>
<body id="PGlobalScreen" onresize="handleAppResize();">
 	<!-- Load the SoundManager div -->
    <cfinclude template="soundManagerDiv.cfm">

    <!-- Load the title bar -->
    <cfinclude template="headBar.cfm">

    <!-- Configure this Prefiniti session -->
    <cfif #session.loggedin# EQ "yes">
        <cfinclude template="webwareConfigLoad.cfm">
    </cfif>
    
    <!-- 	This script must be loaded seperately from 
    		scriptIncludes.cfm because it depends on 
            configuration being complete in webwareConfigLoad.cfm		-->
    
    <!-- Check for maintenance condition -->	
    <cfinclude template="maintCheck.cfm">
    
    <script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>
    <!-- Load the session message as appropriate -->
    <cfinclude template="sessionMessage.cfm">
    
    <!-- Load the generic message template -->
    <cfinclude template="genericMessage.cfm">
    
    <!-- Load the help window resources -->
    <cfinclude template="/help/components/helpWrapper.cfm">
    
    <!-- Load the SmartDesk Info Manager resources -->
    <cfinclude template="/contentManager/components/fileBrowserWrapper.cfm">
    
    <!-- Load the upload wrapper -->
    <cfinclude template="/uploadWrapper.cfm">
    
    <!-- Load the file association wrapper -->
    <cfinclude template="/cms_add_file_assoc_wrapper.cfm">
    
    <!-- Load the CMS minibrowser wrapper -->
    <cfinclude template="/cms_minibrowser_wrapper.cfm">
    
    <!-- Load the generic window wrapper -->
    <cfinclude template="/windowWrapper.cfm">
    
    <cfinclude template="/gis/components/gis_controls.cfm">
    <cfinclude template="/gis/components/gis_map.cfm">
    
    <!-- Open the div element for the main client area -->    
    <cfif session.loggedIn EQ "yes">
    	<div class="bodyWrapper" id="appArea" style="height:auto; min-height:800px; width:100%; padding:0px; margin:0px; background-image:none;">
    <cfelse>
    	<div class="bodyWrapper" id="appArea" style="height:auto;  width:100%; padding:0px; margin:0px; background-image:none;">
	</cfif>

    <div id="dev-null" style="display:none;">
    </div>
	<cfoutput><input id="PMF_CurrentDate" type="hidden" value="#DateFormat(Now(), 'mm/dd/yyyy')#" /></cfoutput>
