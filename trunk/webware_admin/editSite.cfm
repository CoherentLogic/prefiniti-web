<cfquery name="getSiteList" datasource="sites">
	SELECT * FROM sites WHERE siteid=#url.id#
</cfquery>

<div align="left" style="margin:30px; padding:30px; width:800px; border:1px solid #EFEFEF;">
	<h3 class="stdHeader">Edit Site</h3>
    
    
   	<cfoutput query="getSiteList">
      
      <form name="editSite" action="editSiteSubmit.cfm" method="post">
      
       		<input type="hidden" id="admin_id" value="#admin_id#" name="admin_id">
            <input type="hidden" id="SiteID" name="SiteID" value="#url.id#">
          <table width="600" cellspacing="0">
              <tr>
                  <td>Site Name:</td>
                  <td><input type="text" name="SiteName" value="#SiteName#"></td>
                    <td>&nbsp;</td>
              </tr>

              <tr>
       			  <td>Administrative Authority:</td>
                  <td><span id="admin_name" style="padding-right:10px;"><cfmodule template="/jobviews/components/custNameByID.cfm" id="#admin_id#"></span>                 </td>
                    <td>
                    	<img src="/graphics/user_go.png" align="absmiddle"> <a href="javascript:showDivBlock('userPicker');">Change</a>
                   	  <div id="userPicker" style="display:none; position:absolute; z-index:300; left:100px; top:100px; background-color:white;">
                       	  <cfmodule template="/authentication/components/userPicker.cfm" nameTgt="admin_name" idTgt="admin_id">
                      </div>  
                  </td>
              </tr>
              <tr>
              		<td>Options:</td>
                    <td>
                    	<label><input type="radio" name="enabled" value="1" <cfif enabled EQ 1>checked</cfif>>Enabled</label><br>
                        <label><input type="radio" name="enabled" value="0" <cfif enabled EQ 0>checked</cfif>>Disabled</label>
                    </td>
                    <td>&nbsp;</td>
              </tr>
              <tr>
               	  <td colspan="3" align="right">
                   	  <input type="submit" class="normalButton" name="submit" value="Save Changes">                  
                  </td>
              </tr>
          </table>
      </form>
    </cfoutput>
	<script>
	hideSplash();
	</script>