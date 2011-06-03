<cfquery name="chk" datasource="webwarecl">
	SELECT * FROM time_card WHERE emp_id=#attributes.userid# AND date=NOW()
</cfquery>

<cfquery name="u" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#attributes.userid#
</cfquery>

<cfoutput>#u.longName# #u.smsNumber#<br></cfoutput>

<cfparam name="cWeekday" default="0">
<cfset cWeekday="#DatePart("w", Now())#">

<cfif #cWeekday# EQ 1 or #cWeekday# EQ 7>
	<cfabort>
</cfif>

<cfif #chk.RecordCount# EQ 0>
	<cfif #u.smsNumber# NEQ "">
	<cfmail from="noreply@centerlineservices.biz" to="#u.smsNumber#" subject="Timesheet">
		You have not entered any timesheets for #DateFormat(Now(), "mm/dd/yyyy")#. Please visit the Center Line Services web site and enter a timesheet.
	</cfmail>
	</cfif>
</cfif>