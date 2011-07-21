<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>dsvalidate</title>
</head>

<body>
	<cfset session.total_errors = 0>
    <cfset session.reverse_index_errors = 0>
    <cfset session.forward_index_errors = 0>
    <cfset session.total_errors_fixed = 0>
    <cfset session.reverse_index_errors_fixed = 0>
    <cfset session.forward_index_errors_fixed = 0>
	Checking OTPK reverse indexing...<br />
    <blockquote>
	<cfinclude template="get-tables.cfm">
	</blockquote>
    
    <cfoutput>
    <strong>Reverse index errors:</strong> #session.reverse_index_errors#<br />
    <strong>Forward index errors:</strong> #session.forward_index_errors#<br />
    <strong>Total errors:</strong> #session.total_errors#<br />
    <strong>Reverse index errors fixed:</strong> #session.reverse_index_errors_fixed#<br />
    <strong>Forward index errors fixed:</strong> #session.forward_index_errors_fixed#<br />
    <strong>Total errors fixed:</strong> #session.total_errors_fixed#<br />
    </cfoutput>
    
</body>
</html>
