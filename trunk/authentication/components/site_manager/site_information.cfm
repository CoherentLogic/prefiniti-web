<cfquery name="gsi" datasource="sites">
	SELECT * FROM sites WHERE SiteID=#url.current_site_id#
</cfquery>

<cfquery name="industries" datasource="sites">
	SELECT * FROM industries
</cfquery>
    
<div class="homeHeader"><img src="/graphics/page.png" align="absmiddle" /> Site Information</div>

<div style="padding-left:20px;">
	<form name="siteInfo" id="siteInfo">
    <cfoutput><input type="hidden" name="SiteID" id="SiteID" value="#url.current_site_id#" /></cfoutput>
    <table width="500">
    	<cfoutput>
        <tr>
        	<td>Slogan:</td>
            <td><input type="text" name="slogan" id="slogan" value="#gsi.slogan#" /></td>
		</tr>
        <tr>
        	<td>Summary:</td>
            <td><textarea name="summary" id="summary">#gsi.summary#</textarea></td>
		</tr>
        <tr>
        	<td>About This Company:</td>
            <td><textarea name="about" id="about">#gsi.about#</textarea></td>
		</tr>
        <tr>
        	<td>Mission Statement:</td>
            <td><textarea name="mission_statement" id="mission_statement">#gsi.mission_statement#</textarea></td>
		</tr>
        <tr>
        	<td>Vision Statement:</td>
            <td><textarea name="vision_statement" id="vision_statement">#gsi.vision_statement#</textarea></td>
		</tr>
        </cfoutput>
        <tr>
        	<td>Industry:</td>
            <td>
            	<select name="industry" id="industry" size="1">
                	<cfoutput query="industries">
                    	<option value="#id#" <cfif gsi.industry EQ id>selected</cfif>>#industry_name#</option>
                    </cfoutput>
                </select>
			</td>
		</tr>
		<tr>
			<td>Tax Rate:</td>
			<td><cfoutput>
					<input type="text" name="salestax_rate" id="salestax_rate" value="#gsi.salestax_rate#" />
				</cfoutput>	
			</td>
        <tr>
        	<td colspan="2">
            	<input type="button" class="normalButton" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('siteInfo'), '/authentication/components/site_manager/site_information_sub.cfm', 'userActionTarget');" />
			</td>
		</tr>                            
                                    
                                                
                        
	</table> 
    </form>             
     
</div>    