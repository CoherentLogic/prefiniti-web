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
            <cfquery name="UserInfo" datasource="webwarecl">
                SELECT id, password_question, password_answer FROM Users WHERE id=#form.my_id#
            </cfquery>
                        
			<cfif LCase(UserInfo.password_answer) EQ LCase(form.my_answer)>
                <h1>Reset Password</h1>
                <cfoutput>
                <form name="rsp" action="/homeres/set_password.cfm?my_id=#form.my_id#" method="post">
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
            <cfelse>
                <h1>Invalid Answer</h1>
                
                <blockquote>
                    <a href="/homeres/default.cfm">Return to Sign In page</a>
                </blockquote>            
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
<!-- my_id, my_question, my_answer-->

