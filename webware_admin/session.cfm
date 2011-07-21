<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Session Information</title>
<link rel="stylesheet" type="text/css" href="/css/gecko.css" />
</head>

<body>
	<cfif session.loggedin NEQ "yes">
    	<cfset session.framework.Err("SEC002")>
	</cfif>
	<cfquery name="gsess" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM auth_tokens WHERE token='#URL.id#'
    </cfquery>
    
    <cfset user = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(gsess.user_id)>
    
    <h1>Session Summary</h1>
    
    <cfoutput query="gsess">
    <table>
    	<tr>
        	<td>Session Token:</td>
            <td>#URL.id#</td>
		</tr>
    	<tr>
        	<td>Username:</td>
            <td>#username#</td>
		</tr>
        <tr>            
            <td>Display Name:</td>
            <td>#user.display_name#</td>            
        </tr>
        <tr>            
            <td>Login Date:</td>
            <td>#DateFormat(login_date, "mm/dd/yyyy")# #TimeFormat(login_date, "h:mm tt")#</td>            
        </tr>
        <cftry>
            <tr>            
                <td>Logout Date:</td>
                <td>#DateFormat(logout_date, "mm/dd/yyyy")# #TimeFormat(logout_date, "h:mm tt")#</td>            
            </tr>
            <cfcatch type="any">
            </cfcatch>
        </cftry>
        
        <tr>            
            <td>User OTPK:</td>
            <td>{User Account/#user_id#}</td>                        
        </tr>
        <tr>            
            <td>IP Address:</td>
            <td>#ip_address#</td>                        
        </tr>
        <tr>            
            <td>Active:</td>
            <td>
            	<cfif active EQ 0>
                	NO
                <cfelse>
                	YES
                </cfif>
            </td>                        
        </tr>
        <tr>            
            <td>Last Event:</td>
            <td>#DateFormat(last_event, "mm/dd/yyyy")# #TimeFormat(last_event, "h:mm tt")#</td>                        
        </tr>
        
	</table>
    </cfoutput>
	
</body>
</html>
