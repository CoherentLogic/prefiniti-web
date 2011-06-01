<!---
	$Id$
--->
<cfapplication name="PrefinitiHomeV2" sessionmanagement="yes">
<cfparam name="session.browserType" default="">

<cfset session.DB_Core = "webwarecl">
<cfset session.DB_Sites = "sites">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<LINK REL="SHORTCUT ICON" href="http://www.prefiniti.com/graphics/webware-16x16.ico">

<cfif FindNoCase("MSIE", cgi.HTTP_USER_AGENT) NEQ 0>
	<cfset session.browserType="Microsoft Internet Explorer">
<cfelseif FindNoCase("Firefox", cgi.HTTP_USER_AGENT) NEQ 0>
	<cfset session.browserType="Mozilla Firefox">
<cfelse>
	<cfset session.browserType="an unknown browser">
</cfif>

<script type="text/javascript" src="/Framework/CoreSystem/Math.js"></script>
<script type="text/javascript" src="/homeres/home.js"></script>

<cfparam name="bg" default="">
<cfset bg = RandRange(1, 5)>

<style type="text/css">
	body {
		background-color:#2957A2;
		margin:10px;
		font-family:Tahoma, Verdana, Arial, Helvetica, sans-serif;
		color:white;
	}
	
	#navBar {
		width:830px;
		height:30px;
	}
	
	.navButton {
		float:left;
		display:block;
		background-image:url(/homeres/button_back.png);
		background-repeat:no-repeat;
		margin-right:8px;
		width:106px;
		height:25px;
		font-size:small;
		text-align:center;
		padding-top:3px;
		font-weight:bold;
	}
	
	a {
		/*background-image:url(/homeres/button_back.png);*/
		background-repeat:no-repeat;
		margin-right:8px;
		width:106px;
		height:25px;
		font-size:small;
		text-align:center;
		padding-top:3px;
		font-weight:bold;
	}
	
	#mainArea {
		width:792px;
		height:289px;
		<cfoutput>background-image:url(/homeres/back_0#bg#.jpg);</cfoutput>
		background-repeat:no-repeat;
		margin-top:20px;
	}
	
	.mainArea {
		width:792px;
		height:289px;
		background-image:url(/homeres/back.jpg);
		background-repeat:no-repeat;
		margin-top:20px;
		overflow:auto;
	}
	
	.mainAreaFAQ {
		width:792px;
		height:289px;
		background-image:url(/homeres/back.jpg);
		
		background-repeat:no-repeat;
		margin-top:20px;
		overflow:auto;
		color:black;
	}
	
	.mainAreaFAQ p {
		color:black;
	}
	
	
	
	.sideBox {
		width:224px;
		text-align:center;
		margin-top:10px;
		margin-bottom:10px;
	}
	
	h1 {
		font-size:24px;
	}
	
	h2 {
		font-size:18px;
		margin-top:0px;
		
	}
	
	p {
		font-size:11px;
	}
	
	td {
		font-size:11px;
	}
	
	a {
		text-decoration:none;
		color:white;
	}
	
	a:hover {
		text-decoration:underline;
	}
	
	.bottomPiece {
		width:259px;
		height:136px;
		background-image:url(/homeres/button_large.png);
		float:left;
		margin-top:20px;
		margin-right:4px;
		padding:5px;
		background-repeat:no-repeat;
	}
	
	.iconTable td {
		color:#13284A;
	}
		

</style>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Prefiniti</title>
</head>

<body onload="window.setTimeout('HScrollBackground();', 10000);">

<script type="text/javascript" src="/framework/UI/wz_tooltip.js"></script>
	<div id="navBar">
    	<a href="Home.cfm"><img src="/homeres/Prefiniti-Logo-white.png" style="float:left;" border="0" alt="Prefiniti Logo"/></a>
        <span class="navButton" style="margin-left:20px;"><a href="AboutUs.cfm">About Us</a></span>
        <span class="navButton"><a href="Services.cfm">Services</a></span>
        <span class="navButton"><a href="FAQs.cfm">FAQs</a></span>
        <span class="navButton"><a href="ContactUs.cfm">Contact Us</a></span>
        <cfif IsDefined("url.PDKey")>
        	<cfset desktop_url = "/desktop_login.cfm?PDKey=#URL.PDKey#&PDVersion=#URL.PDVersion#">    	    
            <cflocation url="#desktop_url#">
		<cfelse>
	        <span class="navButton" style="background-image:none;"><a href="SignIn/SignIn.cfm" style="background-image:none;">Sign In</a></span>
		</cfif>
    </div>
    <img src="/homeres/header_line.png" alt="Header Line" />