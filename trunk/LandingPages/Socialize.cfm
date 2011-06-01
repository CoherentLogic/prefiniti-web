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

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
    	<td>
        	<h3>My Profile</h3>
            <p style="margin-left:5px;">
            	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="View my profile" url="ViewProfile" help="View my profile"><br />
            	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Add photos to my profile" url="AddPhotos" help="Add photos to my profile"><br />
                <cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Change my profile info" url="EditProfile" help="Change my profile information" profile_section="basic_information.cfm"><br />
	
            </p>
            
            <h3>Blogs</h3>
            <p style="margin-left:5px;">
            	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Post a new blog entry" url="PostBlog" help="Post a new blog"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="View my blog" url="ViewBlog" help="ViewBlog"><br />
            </p>
        </td>
        <td>
        	<h3>Connect</h3>
            <p style="margin-left:5px;">
            	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Search for new friends" url="FindFriends" help="Find new friends"><br />
	     		<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Invite someone to Prefiniti" url="Invite" help="Invite"><br />
            </p>
            
            <h3>Communicate</h3>
            <p style="margin-left:5px;">
            	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="View comments I've received" url="ViewComments" help="View comments I've received"><br />
			</p>
        </td>
	</tr>
</table>            
