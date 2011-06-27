<cfif FindNoCase("MSIE", cgi.HTTP_USER_AGENT) NEQ 0>
	<cfset session.browserType="Microsoft Internet Explorer">
<cfelseif FindNoCase("Firefox", cgi.HTTP_USER_AGENT) NEQ 0>
	<cfset session.browserType="Mozilla Firefox">
<cfelse>
	<cfset session.browserType="an unknown browser">
</cfif>