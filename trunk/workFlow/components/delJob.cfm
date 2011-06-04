<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<cfquery name="deljob" datasource="webwarecl">
	DELETE FROM projects WHERE id=#url.jobid#
</cfquery>

<table width="100%">
<tr>
<td align="center">
<h1 align="center">Project Deleted</h1>

<p class="VPLink" align="center"><a href="javascript:loadHome();">Home</a></p>
</td>
</tr>
</table>
</body>
</html>
