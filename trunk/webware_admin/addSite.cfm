
<cfquery name="Industries" datasource="sites">
	SELECT * FROM industries
</cfquery>

<div align="left" style="margin:30px; padding:30px; width:800px; border:1px solid #EFEFEF;">
	<h3 class="stdHeader">Add Site</h3>
    
    
      <form name="editSite" action="addSiteSubmit.cfm" method="post">
      
       		<input type="hidden" id="admin_id" value="#admin_id#" name="admin_id">
            
          <table width="600" cellspacing="0">
              <tr>
                  <td>Site Name:</td>
                  <td><input type="text" name="SiteName"></td>
                    <td>&nbsp;</td>
              </tr>
              <tr>
              	<td>Industry:</td>
                <td>
                	<select name="industry" id="industry">
                    	<cfoutput query="industries">
                        	<option value="#id#">#industry_name#</option>
						</cfoutput>                            
                    </select>
				</td>
              </tr>                    
              <tr>
       			  <td>Administrative Authority:</td>
                  <td>
                  	<span id="admin_name" style="padding-right:10px;">[None Selected]</span>                 
                  </td>
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
                    	<label><input type="radio" name="enabled" value="1" checked>Enabled</label><br>
                        <label><input type="radio" name="enabled" value="0">Disabled</label>
                    </td>
                    <td>&nbsp;</td>
              </tr>
              <tr>
               	  <td colspan="3" align="right">
                   	  <input type="submit" class="normalButton" name="submit" value="Add Site">                  
                  </td>
              </tr>
          </table>
      </form>
<script>
hideSplash();
</script>