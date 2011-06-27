<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="/homeres/home.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>The Prefiniti Network</title>
</head>

<body>
	<div id="header_bar">
    	<div id="header_container">
			<cfinclude template="/homeres/SignIn/SignIn.cfm">
        </div>
    </div>
    <div id="home_container">
    	<div id="home_sidebar">
			
        </div>
        <div id="home_content">        	            
  			<cfquery name="get_account" datasource="webwarecl">
            	SELECT id FROM users WHERE confirm_id='#url.om_uuid#'
            </cfquery>
            
            <cfif get_account.RecordCount GT 0>
	            <cfset u = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(get_account.id)>
                <cfset u.ConfirmAccount()>
                
                <h1>Account Confirmed!</h1>
                
                <p>You may now sign into The Prefiniti Network.</p>
            <cfelse>
            	<h1>Invalid Account</h1>
                
                <p>The account you have attempted to confirm does not exist.</p>
            </cfif>				
    	</div>
    </div>
    <div id="home_footer">
    	<div id="home_footer_content">
        	<div class="LandingHeaderText">
            	Copyright &copy; 2011 Prefiniti Inc.<br />
                All Rights Reserved.
            </div>
        </div>
    </div>
</body>
</html>
