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

<cfquery name="getSites" datasource="sites">
	SELECT * FROM site_associations WHERE assoc_type=1 AND user_id=#url.CalledByUser#
</cfquery>
<cfquery name="userinfo" datasource="webwarecl">
	SELECT longname FROM Users WHERE id=#URL.calledByUser#
</cfquery>

<div style="height:100%;position:relative;">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/timesheet.png" caption="Create Timesheet">
	
	<div style="padding-left:30px; margin-top:10px; font-size:14px;" id="timesheet_creator_form">
	
	<form name="create_timesheet" id="create_timesheet">
	<cfoutput>
	<input type="hidden" name="om_uuid" id="om_uuid" value="#CreateUUID()#">
	<input type="hidden" name="client_id" id="client_id" value="#URL.CalledByUser#">
	</cfoutput>
	<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">
	<tr>
		<td align="right" width="30%"><strong>Name</strong></td>
		<td align="left" width="70%"><cfoutput>#userinfo.longname#</cfoutput></td>
	</tr>
    <tr>
		<td align="right" width="30%"><strong>Description</strong></td>
		<td align="left" width="70%">
			<input type="text" name="jobDescription" id="jobDescription" style="width:160px;">
		</td>
	</tr>
	<tr>
		<td align="right" width="30%"><strong>Create on which site</strong></td>
		<td align="left" width="70%">
		<select name="site_id" id="site_id" style="width:160px;">
    	<cfoutput query="getSites">
        	<option value="#site_id#">
            	<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#">				
            </option>
        </cfoutput>
		<option value="" selected>Select site...</option>
    	</select>
		</td>
	</tr>	
	
	<tr>
		<td align="right" width="30%"><strong>Timesheet date</strong></td>
		<td align="left" width="70%">
			<cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#Now()#">
		</td>
	</tr>
	</table>
	</form>
	
	</div>
	
	<div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="create_timesheet_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Cancel</span></a>
			<a class="button" href="##" onclick="TCCreateTimesheet();"><span><strong>Next</strong></span></a>
			
		</div>
	</div>
</div>
