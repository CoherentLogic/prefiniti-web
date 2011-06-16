<!---

$Id$

Copyright (C) 2011 John Willis
 
This file is part of Prefiniti.

Prefiniti is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Prefiniti is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.

--->

<cfquery name="get_industries" datasource="#session.framework.SitesDatasource#">
	SELECT industry_name FROM industries ORDER BY industry_name
</cfquery>    

<div style="height:100%;position:relative;">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/site_management.png" caption="Create Site">
	
	<div style="padding-left:30px; margin-top:10px; font-size:14px;" id="site_creator_form">
	
	<form name="create_site" id="create_site">
	
	<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">
	<tr>
		<td align="right" width="30%"><strong>Site Name</strong></td>
		<td align="left" width="70%"><input type="text" name="site_name" id="site_name" /></td>
	</tr>
    <tr>
		<td align="right" width="30%"><strong>Industry</strong></td>
		<td align="left" width="70%">
        	<select name="industry" id="industry" size="1">
            	<cfoutput query="get_industries">
                	<option value="#industry_name#">#industry_name#</option>                    
                </cfoutput>
			</select>                
        </td>
	</tr>
    <tr>
		<td align="right" width="30%"><strong>Default Tax Rate</strong></td>
		<td align="left" width="70%"><input type="text" id="salestax_rate" name="salestax_rate" /></td>
	</tr>
    
	</table>
	</form>
	
	</div>
	
	<div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="create_site_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Cancel</span></a>
			<a class="button" href="##" onclick="SCreateSite();"><span><strong>Create Site</strong></span></a>
			
		</div>
	</div>
</div>
