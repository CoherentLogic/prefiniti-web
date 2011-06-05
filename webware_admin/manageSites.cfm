<cfquery name="getSiteList" datasource="sites">
	SELECT * FROM sites
</cfquery>
<div align="left" style="margin:30px; padding:30px; width:800px; border:1px solid #EFEFEF;">
	<h3 class="stdHeader">Manage Prefiniti Sites</h3>

	<cfparam name="RowNum" default="0">
    <cfparam name="ColOdd" default="">
	<cfparam name="ColColor" default="white">

	<img src="/graphics/group_add.png"> <a href="addSite.cfm">Add New Site</a>
	<table width="100%" cellspacing="0">
    	<tr>
        	<th>Site</th>
            <th>&nbsp;</th>
        </tr>
        
        <cfoutput query="getSiteList">
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
            	<td style="background-color:#ColColor#; padding-top:3px; padding-bottom:3px;">#SiteName#</td>
            	<td align="right" style="background-color:#ColColor#; padding-top:3px; padding-bottom:3px;">
                	<img src="/graphics/group_edit.png" align="absmiddle"> <a href="editSite.cfm?id=#siteid#">Edit Site</a><br>
                    <img src="/graphics/link_edit.png" align="absmiddle"> <a href="getAssociations.cfm?site_id=#siteid#">Manage Associations</a>
					
                </td>
        	</tr>
        </cfoutput>
	</table>        

</div>

<script>
hideSplash();
</script>