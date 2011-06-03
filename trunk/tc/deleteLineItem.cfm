<cfquery name="dli" datasource="webwarecl">
	DELETE FROM time_entries WHERE id=#url.id#
</cfquery>

<table width="100%">
	<tr>
		<td><p class="VPLink">Line Item Deleted</p></td>
	</tr>
</table>
