<!--
<wwafcomponent>Edit Subdivision</wwafcomponent>
-->

<cfquery name="qryEditSub" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE id=#url.id#
</cfquery>    

<h3 class="stdHeader">Edit Subdivision</h3>

<cfoutput query="qryEditSub">
<form name="editSubdivision" id="editSubdivision">
<input type="hidden" name="subdivisionID" id="subdivisionID" value="#id#">
	<table width="100%">
    	<tr>
        	<td>Subdivision Name:</td>
            <td><input type="text" name="subdivisionName" id="subdivisionName" value="#name#" /></td>
        </tr>
        <tr>
        	<td>Subdivision Location:</td>
            <td>
            	<table>
                	<tr>
                    	<td>Latitude:</td>
                        <td><input type="text" name="subdiv_lat" id="subdiv_lat" value="#latitude#"/></td>
                    </tr>
                    <tr>
                    	<td>Longitude:</td>
                        <td><input type="text" name="subdiv_lon" id="subdiv_lon" value="#longitude#"/></td>
                    </tr>
                </table>
                <br />
                <a href="javascript:mapSelectLocation('subdiv_lat', 'subdiv_lon', GetValue('subdiv_lat'), GetValue('subdiv_lon'));">Select from map...</a>
              </td>
        </tr>
        <tr>
        	<td colspan="2" align="left">
            	<input type="button" class="normalButton" name="submit" value="Save Subdivision" onclick="AjaxSubmitForm(AjaxGetElementReference('editSubdivision'), '/workflow/components/subdivisionEditSubmit.cfm', 'tcTarget');" />
			</td>
		</tr>                            
    </table>
</form>
</cfoutput>