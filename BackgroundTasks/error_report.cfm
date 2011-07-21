<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
	<cfquery name="err" datasource="webwarecl">
    	SELECT * FROM site_errors
    </cfquery>
    
    <cfquery name="derr" datasource="webwarecl">
    	DELETE FROM site_errors
    </cfquery>


	<cfif err.RecordCount GT 0>
    	<cfmail from="errors@prefiniti.com" to="prefiniti-bugs@googlegroups.com" subject="Prefiniti Error Report" type="html">        
        	<html>
            <head>
            <style type="text/css">
				h1 {
					font-family:"Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
					color:##2957a2;
					font-size:16px;
					font-weight:lighter;
				}
				th {
					background-color:##2957a2;
					color:white;
					font-family:"Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
					font-size:12px;
				}
				td {
					font-family:"Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
					font-size:12px;
				}					
				
			</style>
            </head>
            <body>
            <h1>Prefiniti Error Report</h1>
            <table border="1" cellpadding="3" cellspacing="0">
            	<tr>
                	<th>Code</th>
                    <th>Summary</th>                    
                    <th>Description</th>
                    <th>Timestamp</th>
                    <th>Template:Line No.</th>
                    <th>Session Key</th>                    
                    <th>ORMS Record</th>
                    <th>Extended Information</th>
				</tr>
                <cfloop query="err">                
                    <tr>
                        <td>#error_code#</td>
                        <td>#error_summary#</td>
                        <td>#error_description#</td>
                        <td>#DateFormat(error_timestamp, "mm/dd/yyyy")# #TimeFormat(error_timestamp, "h:mm tt")#</td>
                        <td>#error_template#</td>
                        <td><a href="http://www.prefiniti.com/webware_admin/session.cfm?id=#session_key#">#session_key#</a></td>
                        <td><a href="http://www.prefiniti.com/Prefiniti.cfm?View=#current_object#">#current_object#</a></td>
                        <td>#extended_info#</td>
                    </tr>                
                </cfloop>                    
			</table>
            </body>
            </html>                            
        </cfmail>
    </cfif>
</body>
</html>
