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
<table><tr><td>
<h3>Shop</h3>
<p style="margin-left:5px;">
<cfmodule template="/framework/link.cfm" perm="WF_CREATE" linkname="Place an order" url="/workflow/components/survey_order_form.cfm" help="Place an order"><br />
<cfmodule template="/framework/link.cfm" perm="WF_VIEW" linkname="View priority projects" url="/jobViews/priority.cfm" help="Priority Projects"><br />
<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Find companies" help="Find companies to do business with" url="/socialnet/components/find_companies.cfm">
</p></td></tr></table>