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
<cfset f = CreateObject("component", "OpenHorizon.Storage.File").Open(url.file_uuid)>
<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(url.orms_id)>

<cfoutput>
<a class="button" href="#f.URL()#" target="_blank"><span>View</span></a>
<a class="button" href="/cms/download.cfm?filename=#f.new_filename#" target="download_target"><span>Download</span></a>
<cfif o.IsOwner(session.user.r_pk)>
	<a class="button" onclick="ORMSDeleteFile('#url.orms_id#', '#url.file_uuid#');" href="####"><span>Delete</span></a>
</cfif>
<cfif f.mime_type EQ "image" AND o.IsOwner(session.user.r_pk)>
	<a class="button" href="####" onclick="ORMSSetThumbnail('#url.orms_id#', '#url.file_uuid#')"><span>Set as Default</span></a>
</cfif>
</cfoutput>

<iframe id="download_target" style="display:none; visibility:hidden;">

</iframe>