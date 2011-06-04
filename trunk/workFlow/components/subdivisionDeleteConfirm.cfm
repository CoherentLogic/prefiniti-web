<h3 class="stdHeader">Delete Subdivision</h3>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Are you sure?</h1>
            
            <p class="VPLink">
				<cfoutput>
            		<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionDeleteSubmit.cfm?id=#url.id#');">Yes, delete this subdivision.</a><br />
                    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionList.cfm');">No, return to subdivision list.</a>
            	</cfoutput>
            </p>
        
        </td>
    </tr>
</table>