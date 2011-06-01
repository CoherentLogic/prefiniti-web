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
<cfmodule template="/LandingPages/LandingHeader.cfm">

<cfquery name="gFavs" datasource="webwarecl">
	SELECT id, url AS linkurl, title, docked FROM favorites WHERE user_id=#url.calledByUser#
</cfquery>    

<h1 style="font-size:large;"><img src="/graphics/AppIconResources/crystal_project/32x32/filesystems/favorites.png" align="absmiddle" /> My Favorites</h1>

<div style="width:100%; height:180px; border:1px solid #EFEFEF; overflow:auto;">
<table width="100%" cellspacing="0" cellpadding="0" class="PList">
<tr>
	<th>Link</th>
	<th>Docked</th>
	<th>Tools</th>
</tr>
<cfoutput query="gFavs">
	<tr>
	<td><cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="#title#" url="#linkurl#" help="#title#"></td>
	<td><input type="checkbox" id="favorite_#id#" onclick="SetDockedFavorite(#id#, IsChecked('favorite_#id#'));" <cfif docked EQ 1>checked</cfif>></td>
	<td><img src="/graphics/AppIconResources/crystal_project/16x16/actions/delete.png" onclick="DeleteFavorite(#id#);" onmouseover="Tip('Delete this link from my favorites');" onmouseout="UnTip();" /></td>
	</tr>
</cfoutput>
</table>
</div>

<img src="/graphics/AppIconResources/crystal_project/16x16/actions/bookmark_add.png" onclick="AddTargetToFavorites(); dispatch(); OpenLanding('Favorites.cfm');" border="0" align="absmiddle"/> <a href="##" onclick="AddTargetToFavorites(); dispatch();">Add current page to favorites</a>
