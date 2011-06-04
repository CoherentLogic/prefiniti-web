<cfoutput>
<cfloop index="x" list="#StructKeyList(url)#">

	<cfquery name="q" datasource="webwarecl">
		SELECT Users.longName, Users.customerNumber, Users.email, projects.description, projects.status, projects.SubStatus,projects.clsJobNumber, projects.id AS jobid, Users.id AS custid, projects.duedate FROM projects INNER JOIN Users ON Users.id=projects.clientid WHERE clsJobNumber='#x#'
	</cfquery>
    
   
	<cfif #q.email# NEQ "">
	<cfmail from="surveyoffice@centerlineservices.biz" to="#q.email#" subject="Delinquent Reminder" type="html">
		Your Center Line Services project no. #q.clsJobNumber# is 30 days or more delinquent.
	</cfmail>
	</cfif>
</cfloop>
</cfoutput>
<cfoutput>
	<center>
	<h1>Reminders sent.</h1>
    <p class="VPLink"><a href="javascript:loadHomeView();">Home</a></p>
    </center>
</cfoutput>

