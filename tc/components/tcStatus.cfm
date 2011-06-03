<cfquery name="s" datasource="webwarecl">
	SELECT closed FROM time_card WHERE id=#attributes.id#
</cfquery>

<strong>
<cfswitch expression="#s.closed#">
	<cfcase value="0"><font color="red">Open</font></cfcase>
	<cfcase value="1"><font color="orange">Signed</font></cfcase>
	<cfcase value="2"><font color="green">Approved</font></cfcase>
	<cfdefaultcase><font color="red">Open</font></cfdefaultcase>
</cfswitch>
</strong>