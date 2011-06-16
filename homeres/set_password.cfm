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
			<cfif form.new_password EQ form.new_password_confirm>
                <cfquery name="rsp" datasource="webwarecl">
                    UPDATE users SET password='#Hash(form.new_password)#' WHERE id=#url.my_id#
                </cfquery>            
                <h1>Password Reset Successful</h1>
            
                <blockquote><a href="/homeres/default.cfm">Go to the Sign In page</a></blockquote>
            <cfelse>
                <h1>Passwords Do Not Match</h1>
                <p>Please try again.</p>
                <cfoutput>
                <form name="rsp" action="/homeres/set_password.cfm?my_id=#url.my_id#" method="post">
                <table>
                    <tr>
                        <td>Please enter your new password:</td>
                        <td><input type="password" name="new_password" id="new_password" /></td>
                    </tr>
                    <tr>
                        <td>Enter your new password again for confirmation:</td>
                        <td><input type="password" name="new_password_confirm" id="new_password_confirm" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" name="submit" value="Reset Password" />
                        </td>
                    </tr>                   
                </table>                            
                </form>
                </cfoutput>
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



  		