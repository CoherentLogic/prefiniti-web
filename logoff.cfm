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

<cfparam name="suid" default="">
<cfparam name="sln" default="">
	
	


<cfset suid = session.userid>
<cfset sln = session.longname>
<cfset session.loggedin = false>
<cfset session.username="">
<cfset session.longname="">
<cfset session.userid="">
<cfset session.loadcount="0">
<cflocation url="/homeres/default.cfm" addtoken="no">
	
