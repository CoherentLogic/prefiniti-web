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
            <cfquery name="GetQuestion" datasource="webwarecl">
                SELECT password_question FROM users WHERE email='#form.email#'
            </cfquery>    
            
            
            <cfif GetQuestion.RecordCount EQ 0>
                <h1>No Such Account</h1>
                
                <p>There is no account on Prefiniti with the e-mail address you specified.</p>
                
                <p>Please call 1-8-PREFINITI or write our <a href="mailto:support@prefiniti.com">support staff</a> for assistance with this problem.</p>
                
                <p>We sincerely apologize for the inconvenience.</p>
            <cfelseif GetQuestion.RecordCount GT 1>
                <h1>Cannot Retrieve Password</h1>
                
                <p>There appears to be a problem with your account.</p>
                
                <p>Please call 1-8-PREFINITI or write our <a href="mailto:support@prefiniti.com">support staff</a> for assistance with this problem.</p>
                
                <p>We sincerely apologize for the inconvenience.</p>                
            <cfelse>
                <h1>Account Retrieved</h1>
                
                <p><strong>Instructions:</strong> Please answer the question shown below and click "Reset Password"</p>
                
                
                <div style="background-color:#EFEFEF; -moz-border-radius:5px; padding:5px; color:black; width:440px;">
                    <cfquery name="GetQuestion" datasource="webwarecl">
                        SELECT password_question, id FROM users WHERE email='#form.email#'
                    </cfquery>
                    
                    <p><strong><cfoutput>#GetQuestion.password_question#</cfoutput></strong> (your answer is not case-sensitive)</p>            <form name="pwa" id="pwa" action="/homeres/challenge_answer.cfm" method="post">
                        <cfoutput>
                        <input type="hidden" name="my_question" id="my_question" value="#GetQuestion.password_question#">
                        <input type="hidden" name="my_id" id="my_id" value="#GetQuestion.id#">
                        </cfoutput>
                        <input type="text" name="my_answer" id="my_answer" width="50" style="width:240px;">
                        <input type="submit" name="submit" value="Reset Password">
                    </form>
                </div>
                
                <blockquote>
            
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

