<script type="text/javascript">
	hideSplash();
</script>
<div align="left" style="margin:30px; padding:30px; width:800px; border:1px solid #EFEFEF;">
	<h3 class="stdHeader">Add Association</h3>
    <h2><cfmodule template="/authentication/components/siteNameByID.cfm" id="#url.site_id#"></h2>

	<form name="addAssoc" action="addAssociationSubmit.cfm" method="post">
	<table width="600">
    	<tr>
        	<td>User:</td>
            <td><span id="user_name">[None Selected]</span>
            	<cfoutput><input type="hidden" name="site_id" value="#url.site_id#"></cfoutput>
            	<input type="hidden" name="user_id" id="user_id">
				<div id="userPicker">
    				<cfmodule template="/authentication/components/userPicker.cfm" nameTgt="user_name" idTgt="user_id">
    			</div>
			</td>
		</tr>
        <tr>
        	<td>Association with <cfmodule template="/authentication/components/siteNameByID.cfm" id="#url.site_id#">:</td>
           	<td>
            	<label><input type="radio" name="assoc_type" value="0" checked>Customer</label><br>
                <label><input type="radio" name="assoc_type" value="1">Employee</label>
			</td>
		</tr>                            
        <tr>
        	<td colspan="2" align="right">
            	<input class="normalButton" type="submit" name="submit" value="Add Association">
			</td>
		</tr>                            
	</table>                
    </form>                    
</div>    
    
    