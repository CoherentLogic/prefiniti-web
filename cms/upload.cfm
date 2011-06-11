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


<cfset root = CreateObject("component", "Prefiniti").Config("ORMS", "filestorage")>

<cffile action="upload" destination="#root#" filefield="FileContents" nameconflict="makeunique">



<cfset new_file = CreateObject("component", "OpenHorizon.Storage.File")>
<cfset new_file.Create(URL.target_uuid, cffile.clientfile, cffile.serverfile, cffile.clientfileext, cffile.contenttype, cffile.contentsubtype, cffile.filesize, session.user, form.keywords)>
<cfset new_file.Save()>

<script>
	window.top.window.ORMSUploadFinished();
</script>


