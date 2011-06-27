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

<cfset evnt = CreateObject("component", "OpenHorizon.Storage.ObjectEvent").OpenByPK(URL.event_id)>
<cfset cmnt = CreateObject("component", "OpenHorizon.Storage.ObjectEventComment").Create(evnt, session.user, URL.comment)>
<cfset cmnt.Save()>

<cfset event_comments = evnt.Comments(1, 500)>

<cfoutput>


<cfloop array="#event_comments#" index="ec">
    <div id="event_comment_#ec.r_pk#" class="EventComment">
        <strong>#ec.user.display_name#</strong> - #ec.body_copy#
    </div>
</cfloop>
</cfoutput>

