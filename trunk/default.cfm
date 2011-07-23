<cfif session.framework.InstanceMode EQ "Unconfigured">
	<cflocation URL="setup/setup.cfm" addtoken="no">
<cfelse>
	<cflocation url="homeres/default.cfm" addtoken="no">
</cfif>