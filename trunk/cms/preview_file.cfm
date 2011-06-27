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

<cfset Datatype = f.Datatype()>

<cfoutput>
    <div style="width:100%; text-align:center; margin-top:20px;" class="LandingHeaderText">        
    	<div align="center" style="width:130px; height:130px; margin:auto; overflow:hidden;">
        <cfif Datatype EQ "">
        	<span style="color:black; font-size:12px;">No Preview Available<br />(#f.MIMEType()#)</span>
        <cfelse>    
         	<cfset data_type = CreateObject("component", Datatype).Render(f.URL(), f.FullPath(), 130, 130)>
        </cfif>
        </div>
        <br />
        Uploaded by #f.poster.display_name#<br />
        #DateFormat(f.post_date, "long")#<br /><br />
        
        <cfset util = CreateObject("component", "OpenHorizon.Apps.Utility")>
        #util.FriendlySize(f.file_size)#
        
        
        
    </div>
</cfoutput>