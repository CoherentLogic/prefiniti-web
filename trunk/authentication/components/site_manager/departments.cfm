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
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="d" default="">
<cfset d = wwGetDepartments(#attributes.site_id#)>
<div class="homeHeader"><img src="/graphics/group_edit.png" align="absmiddle" /> Departments</div>

<div style="padding-left:20px;">
<p><img src="/graphics/group_add.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToWindow('/authentication/components/site_manager/add_department.cfm', 'Add Department');">Add Department</a></p>
	<cfif d.RecordCount EQ 0>
    	<strong>You have not yet defined any departments for your company.</strong>
    <cfelse>
    	<div style="min-height:150px; max-height:400px; overflow:auto; width:400px; border:1px solid #EFEFEF;">
        
    	<cfoutput query="d">
        	
     		<div style="width:100%; border-bottom:1px solid ##EFEFEF;">
            	
                <table width="100%">
                	<tr>
                    	<td width="200">
                        	<strong><a href="javascript:showDiv('department_#id#');">#department_name#</a></strong>
                        </td>
                        <td>
                    		<cfif #manager_id# NEQ "">Manager: #getLongname(manager_id)#<cfelse>[No manager assigned]</cfif>
                		</td>
                        <td align="right">
                        	<a href="##" onclick="wwDeleteDepartment(#id#)" onmouseover="Tip('Click to delete this department');" onmouseout="UnTip();"><img src="/graphics/delete.png" align="absmiddle" style="border:none;" border="0" /></a>
                        </td>
					</tr>
				</table>                                            
                <div id="department_#id#" style="display:none;" >
                    <cfmodule template="/authentication/components/site_manager/department_members.cfm" department_id="#id#" site_id="#url.current_site_id#">
                </div>
            </div>
            
            
        </cfoutput>
        
        </div>
	</cfif>        
</div>