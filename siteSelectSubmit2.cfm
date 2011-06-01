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
<cfquery name="getSites" datasource="sites">
	SELECT * FROM site_associations WHERE id=#form.siteAssociation2#
</cfquery>

<cfquery name="updateLastSite" datasource="webwarecl">
	UPDATE users SET last_site_id=#form.siteAssociation2# WHERE id=#session.userid# 
</cfquery>    

<cfset session.usertype=#getSites.assoc_type#>
<cfset session.current_association=#getSites.id#>
<cfset session.current_site_id=#getSites.site_id#>

<cfif getPermissionByKey("AS_LOGIN", #session.current_association#) EQ false>
	<center>
    <div style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;" align="center">
        <img src="/graphics/webware.png" style="padding-bottom:20px;">
        <h3 class="stdHeader">Permission Denied</h3>
        
        <p>You do not have the <strong>AS_LOGIN</strong> permission on this site.</p>
    </div>
    </center>
    <cfabort>
</cfif>
    
<cfquery name="getASite" datasource="sites">
	SELECT * FROM sites WHERE SiteID=#session.current_site_id# 
</cfquery>    



<cfif #getASite.enabled# EQ 1>
	<cflocation url="/Prefiniti.cfm" addtoken="no">
<cfelse>
	<center>
    <div align="center" style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;">
		<img src="/graphics/webware.png" style="padding-bottom:20px;"/>
		<h3 class="stdHeader">Site Disabled</h3>
        
        <p>Logins to this site have been disabled by the Prefiniti administration team.</p><p>Please try again later.</p>
	</div>
	</center>
</cfif>