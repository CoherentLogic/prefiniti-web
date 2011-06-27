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
<cfset evnt = CreateObject("component", "OpenHorizon.Storage.ObjectEvent")>
<cfset obj = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(url.orms_id)>

<cfset evnt.Create(obj, session.user, "Posted a comment", url.comment)>
<cfset evnt.Save()>

<cfset events = obj.Events(1, 20)>

<cfloop array="#events#" index="e">
	<cfmodule template="/OpenHorizon/Storage/EventViews/Feed.cfm" r_pk="#e.r_pk#">
	<hr style="width:100%; border:0; height:1px; background-color:#c0c0c0; color:#c0c0c0;" />
</cfloop>