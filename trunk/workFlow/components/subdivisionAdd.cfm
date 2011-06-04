<!--
<wwafcomponent>Add Subdivision</wwafcomponent>
-->

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Add New Subdivision</h3>
        </div>
    </div>
<br />
<br />

<cfoutput>
<form name="addSubdivision" id="addSubdivision" action="post">
	<table width="100%">
    	<tr>
        	<td>Subdivision Name:</td>
            <td><input type="text" name="subdivisionName" id="subdivisionName" /></td>
        </tr>
        <tr>
        	<td>Subdivision Location:</td>
            <td>
            	<table>
                	<tr>
                    	<td>Latitude:</td>
                        <td><input type="text" name="subdiv_lat" id="subdiv_lat" value="32.310349"/></td>
                    </tr>
                    <tr>
                    	<td>Longitude:</td>
                        <td><input type="text" name="subdiv_lon" id="subdiv_lon" value="-106.776810"/></td>
                    </tr>
                </table>
                <br />
                <a href="javascript:mapSelectLocation('subdiv_lat', 'subdiv_lon', GetValue('subdiv_lat'), GetValue('subdiv_lon'));">Select from map...</a>
              </td>
        </tr>
        <tr>
        	<td colspan="2" align="left">
            	<input type="button" class="normalButton" name="submit" value="Add Subdivision" onclick="AjaxSubmitForm(AjaxGetElementReference('addSubdivision'), '/workflow/components/subdivisionAddSubmit.cfm', 'tcTarget');">
            </td>
		</tr>            
    </table>
</form>
</cfoutput>