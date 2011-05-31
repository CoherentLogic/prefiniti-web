<cfquery name="cA" datasource="webwarecl">
	SELECT * FROM Users WHERE LCASE(username)='#LCase(Trim(url.suggested_username))#'
</cfquery>

<cfif #cA.RecordCount# EQ 0><span style="color:green">This login name is available for use!</span><cfelse><span style="color:red">This login name is already in use. Please choose another.</span></cfif>