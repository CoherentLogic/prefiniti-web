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

<cfcomponent displayname="Prefiniti" output="no">

	<cffunction name="Config" access="public" returntype="string">
		<cfargument name="section" type="string" required="yes">
        <cfargument name="key" type="string" required="yes">
        
        <cfset IniFile = ExpandPath("/prefiniti.ini")>
        
        
		<cfset myResult = GetProfileString(IniFile, section, key)>
		<cfreturn myResult>
	</cffunction>
    
</cfcomponent>