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

<cfset event = CreateObject("component", "OpenHorizon.Storage.ObjectEvent").OpenByPK(url.event_id)>

<cfset oid = event.object_record.r_id>


<cfquery name="subs" datasource="webwarecl">
	SELECT * FROM orms_subscriptions WHERE target_uuid='#oid#'
</cfquery>

<cfoutput query="subs">
	<cfset user = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(user_id)>
    <cfset user.SendEventNotificationEmail(event)>
    
    <cfset notify_string = event.event_user.display_name & " " & LCase(event.event_name) & " to " & LCase(event.object_record.r_type) & " " & event.object_record.r_name>    
    <cfset user.SendNotification(notify_string, event)>       
</cfoutput>