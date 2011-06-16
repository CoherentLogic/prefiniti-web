
        
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
            <h1>Invalid Login Credentials</h1>
            
            <p style="margin-left:50px;">You have attempted to log in with an invalid username and/or password.</p>
		            	                
                <form name="rlp" id="rlp" action="/homeres/retrieve_password.cfm" method="post">
                
                <label>Enter the e-mail address you used to sign up your Prefiniti account: <input type="text" name="email" id="email"></label><br><br>
                <a class="button" href="##" onclick="document.forms['rlp'].submit();"><span>Begin Password Reset</span></a>
                </form>
			               
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
