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
<style type="text/css">
	.obj_table td {
		font-size:14px;
		font-weight:lighter;
		font-family:"Segoe UI",Tahoma, Arial, Helvetica, sans-serif;
		border-bottom:1px solid #efefef;
		padding:10px;
 	}
</style>

<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.target_uuid)>
<cfset attached_files = orms_rec.Files()>

<div style="height:100%;position:relative;">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/files.png"  caption="#orms_rec.r_type# Files"> 


    
	<div style="height:270px; width:65%; overflow:auto; float:left; text-align:left;" align="left">
       	<cfloop array="#attached_files#" index="cf">
    	    <cfoutput>
        		<cfmodule template="/cms/file_tile.cfm" file_uuid="#cf.file_uuid#" target_uuid="#URL.target_uuid#">    
	        </cfoutput>            
        </cfloop>   
    </div>
    
    <div style="height:270px; width:34%; float:left; border-left:1px solid #efefef;" id="file_preview">
    	<div style="padding:20px;" class="LandingHeaderText">Click one of the files on the left.</div>
    </div>
    
    <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="create_timesheet_buttons" >
			<span id="file_actions"></span>
            <cfif orms_rec.CanRead(session.user.r_pk)>
               	<cfoutput>
					<a href="##" class="button" onclick="ORMSDialog('/cms/create_file.cfm?target_uuid=#orms_rec.r_id#');"><span>Upload File</span></a>
                </cfoutput>
			</cfif>
            <a class="button" href="##" onclick="CloseORMSDialog();"><span>Close</span></a>
			<!--- <a class="button" href="##" onclick="EditFile();"><span><strong>Edit</strong></span></a> --->
			
		</div>
	</div>    
       
</div>
    