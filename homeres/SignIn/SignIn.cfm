<!---
	$Id$
--->

<center>
<div align="center" style="width:450px; height:310px; padding:20px; background-color:white; color:black; border:1px solid black; margin-top:60px;">
<h1><img src="/graphics/prefiniti.png" /></h1>
<p><strong>Prefiniti</strong><br />Version 1.6</p>


<cfset view = "">
<cfset section = "">

<cfif IsDefined("URL.View")>
    <cfset view = URL.View>
</cfif>
<cfif IsDefined("URL.Section")>
    <cfset section = URL.Section>
</cfif>

<cfmodule template="/authentication/components/NewLogin.cfm" siteid="1" width="100%" BrowserType="#session.browserType#" View="#view#" Section="#section#">
</div>
</center>	