
<cfif #session.browserType# NEQ "Microsoft Internet Explorer">
	<link href="css/gecko.css" rel="stylesheet" type="text/css" />
<cfelse>
	<link href="css/msie.css" rel="stylesheet" type="text/css" />
</cfif>
