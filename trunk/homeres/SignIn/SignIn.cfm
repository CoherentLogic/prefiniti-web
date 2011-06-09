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

<cfif IsDefined("url.PDKey")>
	<cfset turl = "/desktop_login.cfm?PDKey=#URL.PDKey#&PDVersion=#URL.PDVersion#">
	<cflocation url="#turl#">
	
</cfif>

<center>
<div align="center" style="width:450px; height:310px; padding:20px; background-color:white; color:black; border:1px solid black; margin-top:60px;">
<h1><img src="/graphics/prenew-medium.png" /></h1>
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