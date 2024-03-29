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

<form id="orms_post_comment" name="orms_post_comment" method="post" action="##">
<cfoutput>
<input type="hidden" name="r_id" id="r_id" value="#attributes.r_id#">
<input type="hidden" name="user_id" id="user_id" value="#attributes.user_id#">
<cfset oo = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset oo.Get(attributes.r_id)>
</cfoutput>
<label>Rate This <cfoutput>#oo.r_type#</cfoutput>: <select name="rating" id="rating">
	<option value="0" selected>No Rating</option>
	<option value="1">1 - Poor</option>
	<option value="2">2 - Below Average</option>
	<option value="3">3 - Average</option>
	<option value="4">4 - Above Average</option>
	<option value="5">5 - Excellent</option></select>
</label><br>
<textarea name="comment_body" id="comment_body" cols="50" rows="3"></textarea><br>
<div style="width:100%; height:40px;">
<cfoutput>
<a class="button" 
	href="##" 
	onclick="ORMSPostComment('#attributes.r_id#', #attributes.user_id#)"><span>Post Comment</span></a>
</div>
</cfoutput>
</form>