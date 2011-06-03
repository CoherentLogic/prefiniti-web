<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="TS_VIEW">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>View Time Cards</title>
<link href="/tc/components/ts.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfquery name="tcByUser" datasource="webwarecl">
	SELECT * FROM time_card WHERE
	<cfif #url.emp_id# NEQ "noUserFilter">
		emp_id=#url.emp_id# 
		AND
	</cfif>
	date>='#DateFormat(url.startDate, "yyyy/mm/dd")#' 
	AND date<='#DateFormat(url.endDate, "yyyy/mm/dd")#'
	<cfif #url.filter# NEQ "None">
		<cfswitch expression="#url.filter#">
			<cfcase value="Open">
				AND closed=0
			</cfcase>
			<cfcase value="Signed">
				AND closed=1
			</cfcase>
			<cfcase value="Approved">
				AND closed=2
			</cfcase>
		</cfswitch>
	</cfif>
	<cfif #url.jobNum# NEQ "">
		AND clsJobNumber='#url.jobNum#'
	</cfif>
    AND site_id=#url.current_site_id#
	ORDER BY date
</cfquery>

<cfoutput query="tcByUser">
<table width="600" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<cfmodule template="/tc/components/tcHeader.cfm" id="#id#">
	</td>
</tr>
<tr>
	<td>
		<cfmodule template="/tc/components/lineItemsByTC.cfm" timecard_id="#id#">
	</td>
</tr>
<tr>
	<td>
		<cfmodule template="/tc/components/tcFooter.cfm" id="#id#">
	</td>
</tr>
</table>

<br />
<br />
</cfoutput>
</body>
</html>

