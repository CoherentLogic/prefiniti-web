<cfquery name="qrySubdivisionAdd" datasource="webwarecl">
	INSERT INTO subdivisions 
    	(name,
        latitude,
        longitude)
    VALUES 
    	('#url.subdivisionName#',
        #url.subdiv_lat#,
        #url.subdiv_lon#)
</cfquery>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Subdivision Created.</h1>
            
            <p class="VPLink"><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionList.cfm');">Return to Subdivisions</a></p>
        </td>
	</tr>
</table>            