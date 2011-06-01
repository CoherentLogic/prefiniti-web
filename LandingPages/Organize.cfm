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

<cfparam name="UserColl" default="">
<cfset UserColl=ArrayNew(1)>
<cfset UserColl[1]=#url.calledByUser#>

<p style="margin-left:5px;">
	<div id="schedArea" style="width:100%; height:350px; overflow:auto;">
		<cfmodule template="/controls/day_view.cfm" users="#UserColl#" date="#DateFormat(Now(), 'mm/dd/yyyy')#">
	</div>
</p>
    
<h3>Other Scheduling Tools</h3>
<p style="margin-left:5px;">
	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="View full schedule" url="MySchedule" help="View full schedule"><br />
</p>
