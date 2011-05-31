<cfif #attributes.loggedIn# NEQ "yes">
	<cfset session.message="You must be logged in to view this page.">
	<cflocation url="default.cfm?redir=#attributes.redirPage#" addtoken="no">
</cfif>