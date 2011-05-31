<cfquery name="uAT" datasource="webwarecl">
	UPDATE Users
	SET		type=#url.type#,
			role='#url.role#',
			tcadmin='#url.tcadmin#',
			account_enabled=#url.account_enabled#,
			order_processor=#url.order_processor#,
			site_maintainer=#url.site_maintainer#,
			receives_timesheet_reminders=#url.receives_timesheet_reminders#
	WHERE	id=#url.id#
</cfquery>

<p style="color:red">Profile updated.</p>
