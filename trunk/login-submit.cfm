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

<!--- <cfif form.username NEQ "willisj-company">
	Prefiniti is now locked until the next major phase of development is complete.<br />
    Logins indefinitely disabled.
    <cfabort>
</cfif> --->

<cfset Authenticator = CreateObject("webservice", "http://orms.prefiniti.com/Authentication.cfc?wsdl")>
<cfset key = Authenticator.GetKey(form.login_username, form.login_password)>

<cfif key NEQ 0>
	<!--- username and password are good --->
	<cfset uid = Authenticator.UserIDFromKey(key)>

	<cfquery name="qryGetLogin" datasource="#session.datasource#">
		SELECT * FROM users WHERE id=#uid#
	</cfquery>		

	<cfif qryGetLogin.account_enabled EQ 1>
    	<cfif qryGetLogin.confirmed EQ 1>
			<!--- the user's account is enabled and confirmed --->				
            <cfset session.loggedin="yes">
            <cfset session.username="#qryGetLogin.username#">
            <cfset session.longname="#qryGetLogin.LongName#">            
            <cfset session.userid="#qryGetLogin.id#">
            <cfset session.email="#qryGetLogin.email#">
            <cfset session.current_association="#qryGetLogin.last_site_id#">                    
            <cfset session.authentication_key = key>
            
            <!--- bring in the new API --->
            <cfset session.user = CreateObject("component", "OpenHorizon.Identity.User").Open(session.username)>
            <cfset session.site = CreateObject("component", "OpenHorizon.Identity.Site").OpenByMembershipID(session.current_association)>
            <cfset session.active_membership = CreateObject("component", "OpenHorizon.Identity.SiteMembership").OpenByPK(session.current_association)>
            <cfset session.framework = CreateObject("component", "OpenHorizon.Framework")>
            
            <cfset urlstr = "">
            <cfif IsDefined("Form.View")>
                <cfset urlstr = "?View=#form.view#">
                <cfif IsDefined("Form.Section")>				
                    <cfset urlstr = urlstr & "&Section=#form.section#">
                <cfelse>
                    <cfset urlstr = urlstr & "&Section=">
                </cfif>
            </cfif>
                       
            <cflocation url="http://prefiniti15.prefiniti.com/Prefiniti.cfm#urlstr#" addtoken="no">	
		<cfelse>
        	<!--- the user's account is not yet confirmed --->
            <cflocation url="/homeres/account_not_confirmed.cfm?id=#qryGetLogin.id#" addtoken="no">
        </cfif>                        		
	<cfelse>
    	<!--- the user's account is disabled --->	
		<cflocation url="/homeres/account_disabled.cfm" addtoken="no">
	</cfif>

<cfelse>
	<!---login failure--->		                
	<cflocation url="/homeres/bad_password.cfm" addtoken="no">
</cfif>

