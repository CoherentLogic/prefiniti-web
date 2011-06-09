<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Prefiniti Notification</title>
</head>
<style type="text/css">
	td {
		background-color:white;
	}
	table {
		border-left:1px solid #3399CC;
		border-right:1px solid #3399CC;
		border-top:1px solid #3399CC;
		}
	h1 {
		font-family:"Times New Roman", Times, serif;
		color:#3399CC;
		font-weight:lighter;
		}
	body {
		font-family:"Segoe UI", "Lucida Grande", Tahoma, Verdana, Arial, Helvetica, sans-serif;
		font-size:x-small;
		color:#999999;
	}		
	strong {
		color:black;
		}		
	a {
		color:#999999;
		text-decoration:none;
	}
	a:hover {
		color:#3399CC;
	}		
</style>

<body style="background-color:#EFEFEF;">
	
	<table width="600" cellpadding="0" cellspacing="0" align="center">
    	<tr>
        	<td style="padding:10px; height:80px; background-image:url(http://www.prefiniti.com/graphics/binary-bg.jpg); background-repeat:no-repeat;"><img src="http://www.prefiniti.com/graphics/prefiniti-small.png" /></td>
            <td align="right" valign="top" style="padding:10px;"><h1>Prefiniti Notification</h1></td>
        </tr>
        <tr>
        	<td colspan="2" style="padding:10px; border-top:1px solid #EFEFEF;">
            	<cfoutput><p style="font-size:large;"><strong>#attributes.event_name#</strong></p>
            	
                
                <p style="padding-left:10px; color:black; font-size:medium;">#attributes.body_text#</p> 
				<a style="padding-left:10px;" href="http://www.prefiniti.com">Click here to log into Prefiniti</a>
				</cfoutput> 
                <p style="color:red;">This is an automatically generated notification. Please do not reply.</p>  
            </td>
	  </tr>   
        
        <tr>
        	<td colspan="2" style="border-top:1px solid #EFEFEF; padding:10px; border-bottom:1px solid #3399CC;">
            	<p style="font-size:xx-small;">Copyright &copy; 2009 AJL Intel-Properties, LLC<br />All rights reserved.</p>            </td>                         
	</table>
    </body>
</html>
