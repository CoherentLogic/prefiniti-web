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
            <cfset username_error = false>
            <cfset password_error = false>
            <cfset email_error = false>
            <cfset firstname_error = false>
            <cfset lastname_error = false>
            <cfset age_error = false>
            <cfset password_answer_error = false>
            <cfset zipcode_error = false>
            
            <cfset username_error_text = "">
            <cfset password_error_text = "">
            <cfset email_error_text = "">
            <cfset firstname_error_text = "">
            <cfset lastname_error_text = "">
            <cfset age_error_text = "">
            <cfset password_answer_error_text = "">
            <cfset zipcode_error_text = "">
            
            <cfif IsDefined("form.marker")>            
            	<!--- validate submission --->
                <cfset ec = 0> <!--- error count --->
                
                <cfif Trim(form.username) EQ "">
                	<cfset username_error = true>
                    <cfset username_error_text = "You must choose a username.">
                    <cfset ec = ec + 1>
                </cfif>
                
                <cfquery name="chkDupUsers" datasource="webwarecl">
                	SELECT id FROM users WHERE username='#form.username#'
                </cfquery>
                
                <cfif chkDupUsers.RecordCount GT 0>
               	 	<cfset username_error = true>
                    <cfset username_error_text = "That username is not available. You must choose another.">
                    <cfset ec = ec + 1>
				</cfif>                    
                
                <cfif Len(Trim(form.password)) LT 6>
                	<cfset password_error = true>
                    <cfset ec = ec + 1>
                    <cfset password_error_text = "Your password must contain six or more characters.">
                </cfif>
                
                <cfif Trim(form.email) EQ "">
                	<cfset email_error = true>
                    <cfset ec = ec + 1>
                    <cfset email_error_text = "You must enter an e-mail address.">                    
                </cfif>
                                
                <cfif Trim(form.first_name) EQ "">
                	<cfset firstname_error = true>
                    <cfset ec = ec + 1>
                    <cfset firstname_error_text = "You must enter your first name.">
                </cfif>
                
                <cfif Trim(form.last_name) EQ "">
                	<cfset lastname_error = true>
                    <cfset ec = ec + 1>
                    <cfset lastname_error_text = "You must enter your last name.">
                </cfif>
                
                <cfif Trim(form.password_answer) EQ "">
                	<cfset password_answer_error = true>
                    <cfset ec = ec + 1>
                    <cfset password_answer_error_text = "You must answer your password question.">
                </cfif>
                
                <cfif Trim(form.zip_code) EQ "">
                	<cfset zipcode_error = true>
                    <cfset ec = ec + 1>
                    <cfset zipcode_error_text = "You must enter your ZIP code.">
                </cfif>
            </cfif>  
            
            <cfif (NOT IsDefined("form.marker")) OR (ec GT 0)>
            	<h1 style="font-size:24px;">Sign Up</h1>
                <form name="SignUp" id="SignUp" method="post" action="/homeres/default.cfm">
                <input type="hidden" name="marker" id="marker" value="marker" />
                
                <table width="100%" cellpadding="5" cellspacing="0">
                    <tr>
                        <td align="right">Username</td>
                        <td align="left">
                        	<input type="text" name="username" />
                        	<cfif username_error EQ true>
                            	<cfoutput>
                            	<br /><span class="form_error">#username_error_text#</span>
                                </cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Password</td>
                        <td align="left">
                        	<input type="password" name="password" />
                        	<cfif password_error EQ true>
                            	<cfoutput>
                                <br /><span class="form_error">#password_error_text#</span>
                               	</cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Password Question</td>
                        <td align="left">
                            <select name="password_question" id="password_question">
                                <option value="What is your mother's maiden name?" selected>What is your mother's maiden name?</option>
                                <option value="What is the name of your favorite pet?">What is the name of your favorite pet?</option>
                                <option value="What street did you grow up on?">What street did you grow up on?</option>
                                <option value="What city were you born in?">What city were you born in?</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Password Answer</td>
                        <td align="left">
                        	<input type="text" name="password_answer" />
                        	<cfif password_answer_error EQ true>
                            	<cfoutput>
                                <br /><span class="form_error">#password_answer_error_text#</span>
                               	</cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">E-Mail Address</td>
                        <td align="left">
                            <input type="text" name="email" />
                        	<cfif email_error EQ true>
                            	<cfoutput>
                                <br /><span class="form_error">#email_error_text#</span>
                                </cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">First Name</td>
                        <td align="left">
                        	<input type="text" name="first_name" />
                        	<cfif firstname_error EQ true>
                            	<cfoutput>
                                <br /><span class="form_error">#firstname_error_text#</span>
                               	</cfoutput>
                            </cfif>                            
                        </td>
                    </tr>
    
                    <tr>
                        <td align="right">Last Name</td>
                        <td align="left">
                        	<input type="text" name="last_name" />
                        	<cfif lastname_error EQ true>
                            	<cfoutput>
                                <br /><span class="form_error">#lastname_error_text#</span>
                               	</cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Gender</td>
                        <td align="left">
                            <select name="gender" id="gender" size="1">
                                <option value="F" selected>Female</option>
                                <option value="M">Male</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Birthday</td>
                        <td align="left"><cfmodule template="/controls/date_picker.cfm" startdate="#DateAdd('yyyy', -13, Now())#" ctlname="birthday"></td>
                    </tr>
                    <tr>
                        <td align="right">ZIP Code</td>
                        <td align="left">
                        	<input type="text" name="zip_code" />
                        	<cfif zipcode_error EQ true>
                            	<cfoutput>
                                <br /><span class="form_error">#zipcode_error_text#</span>
                               	</cfoutput>
                            </cfif>
                        </td>
                    </tr>
                    
                  
                </table>   
               
                <a class="button" href="##" onclick="document.forms['SignUp'].submit();"><span>Create Account</span></a>
                </form> 
			<cfelse>
            	<cfset u = CreateObject("component", "OpenHorizon.Identity.User")>
                <cfset u.Create(form.username,
								form.password,
								form.password_question,
								form.password_answer,
								form.email,
								form.first_name,
								'',
								form.last_name,
								form.gender,
								form.birthday,
								true,
								form.zip_code)>
				<cfset u.Save()>
                <cfset u.SendConfirmationEmail()>
                                                               
            	<h1 style="font-size:24px;">Signup complete!</h1>
                
                <cfoutput>
                	<p>A confirmation e-mail has been sent to #form.email#. You must click the link contained in this message in order to complete your Prefiniti Network registration.</p>
                    <p>Thank you for registering on The Prefiniti Network!</p>
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
