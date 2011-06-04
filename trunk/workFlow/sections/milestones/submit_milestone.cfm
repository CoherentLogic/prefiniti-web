<cfset date_sens = 0>
<cfif url.date_sensitive EQ true>
	<cfset date_sens = 1>
</cfif>

<cfquery name="CreateMilestone" datasource="webwarecl">
	INSERT INTO project_milestones
		(id,
		project_id,
		milestone,
		date_sensitive,
		due_date,
		completed
		<cfif URL.budget NEQ "">
		,budget
		</cfif>
		)
	VALUES
		('#url.milestone_id#',
		#url.project_id#,
		'#url.milestone#',
		#date_sens#,
		#CreateODBCDateTime(URL.due_date)#,
		0
		<cfif URL.budget NEQ "">
		,#url.budget#
		</cfif>
		)
</cfquery>

<cfoutput>
<a class="button" href="####" onclick="ProjAddMilestone(#url.project_id#);"><span>Add Another Milestone</span></a>
<a class="button" href="####" onclick="CloseORMSDialog(); AjaxRefreshTarget();"><span><strong>Finish</strong></span></a>

</cfoutput>		