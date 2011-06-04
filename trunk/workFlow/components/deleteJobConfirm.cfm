
<table width="100%" align="center">
	<tr>
		<th>Delete Project</th>
	</tr>
	<tr>
		<td align="center"><strong>Are you sure you wish to delete this project?<br /><font color="red">This cannot be undone!</font></strong></td>
	</tr>
	<tr>
		<td align="center"><cfoutput><p class="VPLink"><a href="javascript:deleteProjectReal(#url.id#);">Yes, delete this project</a></p>
		<p class="VPLink"><a href="javascript:loadProjectViewer(#url.id#);">No, return to project view</a></cfoutput></td>
	</tr>
	
	
</table>
