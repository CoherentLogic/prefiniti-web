
<cfquery name="qrySubs" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE site_id=#url.current_site_id# AND name LIKE '%#url.name#%' AND approved=1 ORDER BY name
</cfquery>



<cfif qrySubs.RecordCount EQ 0>
    <cfoutput><strong style="color:red;">No subdivisions found containing &quot;#url.name#&quot;.</strong></cfoutput>
    <br />Submitting this form will create a new subdivision with the name typed in the above text field.
<cfelse>    
<select name="subSelect" size="5" onclick="SetValue('new_sub', 0);" id="subSelect">
	<cfoutput query="qrySubs">
		<option value="#id#">#name#</option>
	</cfoutput>
    
</select>
</cfif>