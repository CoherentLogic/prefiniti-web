<script type="text/javascript">
	hideSplash();
</script>
<cfquery name="getAssoc" datasource="sites">
	SELECT * FROM site_associations WHERE site_id=#url.site_id#
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">   
 
<div align="left" style="margin:30px; padding:30px; width:800px; border:1px solid #EFEFEF;">
	<h3 class="stdHeader">Manage Associations</h3>
    <h2><cfmodule template="/authentication/components/siteNameByID.cfm" id="#url.site_id#"></h2>    

	<cfoutput><img src="/graphics/link_add.png"> <a href="/webware_admin/addAssociation.cfm?site_id=#url.site_id#">Add Association</a></cfoutput>
	<table width="100%" cellspacing="0">
    	<tr>
        	<th>User</th>
            <th>Association</th>
        </tr>
        
        <cfoutput query="getAssoc">
        <cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
      	<tr>
        	<td style="background-color:#ColColor#"><cfmodule template="/jobviews/components/custNameByID.cfm" id="#user_id#"></td>
            <td style="background-color:#ColColor#">
            	<cfif #assoc_type# EQ 0>
                	Customer
				<cfelse>
					Employee
				</cfif>
			</td>
		</tr>
        </cfoutput>                                                                    
    </table>    

</div>    
