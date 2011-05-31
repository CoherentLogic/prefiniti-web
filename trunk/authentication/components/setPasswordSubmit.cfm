<cfquery name="setInitialPW" datasource="webwarecl">
	UPDATE Users
	SET		password='#Hash(url.password)#',
    		last_pwchange=#CreateODBCDateTime(Now())#
	WHERE	id=#url.id#
</cfquery>

<cfset session.pwdiff=0>

<p style="color:red">Password set.</p>
<div id="pageScriptContent">
	location.replace("http://www.prefiniti.com/clear_pwdiff.cfm");
</div>