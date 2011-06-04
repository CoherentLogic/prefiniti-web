    <style>
		.mo
		{
		}
		
		.mo h2
		{
			font-size:large;
			font-family:Arial, Helvetica, sans-serif;
			color:#3399CC;
			padding-top:0px;
			margin-top:0px;
			text-transform:capitalize;
		}
	
	</style>
    <cfquery name="pp" datasource="webwarecl">
        SELECT * FROM projects WHERE clientID=#url.calledByUser# ORDER BY dueDate ASC
    </cfquery>
    
    <table width="100%" cellspacing="0" class="mo">
    	<cfoutput query="pp">
			<tr>
            	<td rowspan="2" valign="top" style="border-bottom:1px solid gray;"><h2>
                	<cfif #description# NEQ "">
						#LCase(description)#
                    <cfelse>
						No Description
                    </cfif>
					</h2>
                    <ul>
                    	<li>This order was placed on <strong>#DateFormat(ordered_date, "dd mmmm yyyy")#</strong></li>
                    	<cfif #clsJobNumber# NEQ "">
                        	<li>Your order number is <strong>#clsJobNumber#</strong></li>
                        </cfif>
       				</ul>
                    
                    <ul>
                    	<img src="/graphics/arrow_right.png" align="absmiddle"> <a href="javascript:loadProjectViewer(#id#);">Go to this project's workspace</a><br>
                   </ul>
                </td>
             
                <td align="right" valign="top"><cfif status EQ 0>
                    	<img src="/graphics/time.png"> Incomplete
                    <cfelse>
                    	<img src="/graphics/accept.png"> Complete
                    </cfif>                </td>
			</tr>
			<tr>
			  <td align="right" valign="bottom" style="border-bottom:1px solid gray; padding:0px; margin:0px;"><cfmodule template="/workflow/components/project_timeline.cfm" project_id="#id#"></td>
		  </tr>
		</cfoutput>
	</table>                                              
                   