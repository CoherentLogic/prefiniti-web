<cfquery name="delsub" datasource="webwarecl">
	DELETE FROM subdivisions WHERE id=#url.id#
</cfquery>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Subdivision Deleted.</h1>
            
            <p class="VPLink">
            	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionList.cfm');">Return to subdivision list</a>
            </p>
		</td>
	</tr>
</table>                            