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

<cfquery name="get_comments" datasource="webwarecl">
	SELECT * FROM orms_comments WHERE r_id='#attributes.r_id#' ORDER BY post_date DESC
</cfquery>

<cfif IsDefined("attributes.limit_to")>
	<cfset theMaxRows = attributes.limit_to>
<cfelse>
	<cfset theMaxRows = 50000>
</cfif>

<cfif get_comments.RecordCount GT 0>
<table width="100%" cellpadding="5" cellspacing="0">
	<cfoutput query="get_comments" maxrows="#theMaxRows#">
    
    <cfset user_object = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(user_id)>
    
	<tr>
	<cfif NOT IsDefined("attributes.limit_to")>
	<td width="50" valign="top" align="center">
		<img src="#user_object.Picture(48, 48)#" width="48" height="48">
	</td>
	</cfif>
	<td valign="top">
		
		<p style="font-size:14px; margin-top:0px;"><strong style="color:##2957a2;">#user_object.display_name#</strong> - #comment_body#<br><br>
		<span style="font-size:xx-small; color:##c0c0c0;">#DateFormat(post_date, "long")# Rating:</span> 
		<cfif rating GT 0>
			<cfloop from="1" to="#rating#" index="x"><img src="/graphics/star.png" align="absmiddle"></cfloop><cfloop from="1" to="#5 - rating#" index="x"><img src="/graphics/star_gray.png" align="absmiddle"></cfloop>
		<cfelse>
			<span style="font-size:xx-small; color:##c0c0c0;">No rating.</span>
		</cfif>
		</p>
	</td>
	</tr>
	</cfoutput>
</table>
</cfif>