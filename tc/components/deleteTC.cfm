<cfoutput>
<table width="100%">
	<tr>
		<th>Delete Timesheet</th>
	</tr>
	<tr>
		<td align="center">
			Are you sure you wish to delete this timesheet?
			<p class="VPLink"><img src="/graphics/time_delete.png"> <a href="javascript:deleteTimesheetSub('#url.id#', '#url.PWindowClientArea#');">Yes, delete this timesheet</a></p>
			<p class="VPLink"><img src="/graphics/time_go.png"> <a href="javascript:openTS('#url.id#', '#url.PWindowClientArea#');">No, return to timesheet</a></p>
		</td>
	</tr>
</table>
</cfoutput>