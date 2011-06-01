<!---
	$Id$
	
	Processes traditional logins not coming from the Prefiniti Desktop application.
	
--->
<cfset Authenticator = CreateObject("webservice", "http://orms.prefiniti.com/Authentication.cfc?wsdl")>
<cfset key = Authenticator.GetKey(form.username, form.password)>

<cfif key NEQ 0>
	<!--- username and password are good --->
	<cfset uid = Authenticator.UserIDFromKey(key)>

	<cfquery name="qryGetLogin" datasource="#session.datasource#">
		SELECT * FROM users WHERE id=#uid#
	</cfquery>		

	<cfif #qryGetLogin.account_enabled# EQ 1>	
    	<!--- the user's account is enabled --->				
		<cfset session.loggedin="yes">
		<cfset session.username="#qryGetLogin.username#">
		<cfset session.longname="#qryGetLogin.LongName#">            
		<cfset session.userid="#qryGetLogin.id#">
		<cfset session.email="#qryGetLogin.email#">
		<cfset session.current_association="#qryGetLogin.last_site_id#">                    
		<cfset session.authentication_key = key>
        
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
    	<!--- the user's account is disabled --->	
		<cflocation url="/homeres/account_disabled.cfm" addtoken="no">
	</cfif>

<cfelse>
	<!---login failure--->		                
	<cflocation url="/homeres/bad_password.cfm" addtoken="no">
</cfif>

