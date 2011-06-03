<cfquery name="tsByDay" datasource="webwarecl">
	SELECT * FROM time_card WHERE DATE(date)=#CreateODBCDate(attributes.targetDate)# AND emp_id=#attributes.userid#
</cfquery>


<cfif #tsByDay.RecordCount# GT 0>
<cfoutput query="tsByDay">
	<a href="javascript:AjaxLoadPageToDiv('tsInfo', '/tc/edit_ts.cfm?id=#id#');">#clsJobNumber#: <cfmodule template="/tc/components/hoursByTS.cfm" timecard_id="#id#"> hours</a><br />
</cfoutput>
<cfelse>
	<span style="color:red">No timesheets.</span>
</cfif>