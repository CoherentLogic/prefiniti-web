<!---
	$Id$
--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

	<cfquery name="qryGetLogin" datasource="#session.datasource#">
		SELECT * FROM users WHERE username='#form.username#' AND password='#Hash(form.password)#'
	</cfquery>
    

	
	<cfquery name="siteStatus" datasource="#session.datasource#">
		SELECT * FROM config
	</cfquery>
	
	<cfquery name="eventUsers" datasource="#session.datasource#">
		SELECT id FROM Users
	</cfquery>
	
	<cfif #qryGetLogin.RecordCount# GT 0>

		<cfif #qryGetLogin.account_enabled# EQ 1>
			

			
			<cfset session.loggedin="yes">
			<cfset session.username="#qryGetLogin.username#">
			<cfset session.longname="#qryGetLogin.LongName#">
            
			<cfset session.userid="#qryGetLogin.id#">
			<cfset session.email="#qryGetLogin.email#">
            <cfset session.current_association="#qryGetLogin.last_site_id#">

            
           
            
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
			<cfset session.message="Your account has been disabled.">
			<cflocation url="default.cfm" addtoken="no">
		</cfif>

	<cfelse>
		<!---login failure--->
		
        
        
		<cflocation url="/homeres/bad_password.cfm" addtoken="no">
	</cfif>
</body>
</html>
