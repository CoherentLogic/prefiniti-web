<cfquery name="subdivisionEdit" datasource="webwarecl">
	UPDATE 	subdivisions
    SET		name='#url.subdivisionName#',
    		latitude=#url.subdiv_lat#,
            longitude=#url.subdiv_lon#
    WHERE	id='#url.subdivisionID#'
</cfquery>    

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Subdivision Saved.</h1>
            
            <p class="VPLink"><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionList.cfm');">Return to Subdivisions</a></p>
		</td>
	</tr>
</table>                        