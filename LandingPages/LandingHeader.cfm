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
	SELECT * FROM site_associations WHERE user_id=#url.CalledByUser#
</cfquery>

<cfoutput>
<div style="width:100%; height:50px; background-color:##2957a2; font-size:24px;"><div style="padding:8px; text-transform:uppercase; font-weight:bold; color:##efefef; letter-spacing:6px;"><img src="/graphics/prefsite.png" align="absmiddle" style="margin-left:20px; margin-top:20px; margin-right:20px; font-family:Arial;">welcome to prefiniti</div>
</cfoutput>

<div style="margin-left:100px; margin-top:-38px;">
<form name="siteSelect2" action="/siteSelectSubmit2.cfm" method="post" style="display:inline;">
    <select name="siteAssociation2" style="width:160px;" onchange="document.siteSelect2.submit();">
    	<cfoutput query="getSites">
        	<option value="#id#" <cfif #id# EQ #url.current_association#>selected</cfif>>
            	<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#">
				<cfif #assoc_type# EQ 0>
                    &nbsp;- Customer
                <cfelse>
                    &nbsp;- Employee
                </cfif>
            </option>
        </cfoutput>
    </select>    
</form>


 <a href="/logoff.cfm"><img src="/graphics/AppIconResources/crystal_project/16x16/actions/shutdown.png" style="border:none;" align="absmiddle" onmouseover="Tip('Sign out of The Prefiniti Network');" onmouseout="UnTip();"></a> 
 <a href="javascript:dispatch(); PHelpBrowser(0);"><img onmouseover="Tip('View Help');" onmouseout="UnTip();" src="/graphics/AppIconResources/crystal_project/16x16/actions/help.png" align="absmiddle" style="border:0;"></a>
 <a href="##" onclick="dispatch();"><img src="/graphics/cross.png" style="border:0;" align="absmiddle" onmouseover="Tip('Close this menu');" onmouseout="UnTip();"></a>
</div>
	