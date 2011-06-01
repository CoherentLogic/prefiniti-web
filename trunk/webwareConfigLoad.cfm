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

<cfoutput>
	<script language="javascript">
		glob_userid='#session.userid#';
		glob_site_maintainer = '#session.site_maintainer#';
		glob_userName = '#session.userName#';
		glob_longName = '#session.longname#';
		glob_current_association = #session.current_association#;
		glob_current_site_id = #session.current_site_id#;
		glob_browser = '#session.browserType#';
		glob_FrameworkRevision = 1.5;
	</script>
</cfoutput>	

