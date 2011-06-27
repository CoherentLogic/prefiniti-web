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

<cfif Find(":", url.search_value)> <!-- we are searching on both keyword and value -->
	<cfset search_mode = "key_and_value">
	<cfset la = ArrayNew(1)>
	<cfset la = ListToArray(url.search_value, ":")>
	<cfset search_key = la[1]>
	<cfset search_value = la[2]>

	<cfquery name="doSearch" datasource="webwarecl">
		SELECT 	* 
		FROM 	orms_keywords 
		WHERE 	k_word LIKE '%#search_key#%'
		AND		k_value LIKE '%#search_value#%'
	</cfquery>		
<cfelse>
	<cfset search_mode = "value_only">
	<cfset search_value = url.search_value>
	<cfquery name="doSearch" datasource="webwarecl">
		SELECT * FROM orms_keywords WHERE k_value LIKE '%#search_value#%'
	</cfquery>
</cfif>	
		

<cfif search_mode EQ "value_only">
	<div style="font-size:18px; font-weight:bold; margin:8px;">Search Results - <cfoutput>#search_value#</cfoutput></div>
<cfelse>
	<div style="font-size:18px; font-weight:bold; margin:8px;">Search Results - Keyword <cfoutput>#search_key#, Value #search_value#</cfoutput></div>
</cfif>
<div style="padding-left:30px; padding-top:10px;">
<cfoutput query="doSearch">
	<cfset orms_obj =  CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
	<cfset r = orms_obj.Get(r_id)>
	
	<cfif search_mode EQ "key_and_value">
		<cfset res_string_value = Replace(k_value, search_value, "<strong>" & search_value  & "</strong>", "all")>
		<cfset res_string_key = Replace(k_word, search_key, "<strong>" & search_key  & "</strong>", "all")>
	<cfelse>
		<cfset res_string_value = Replace(k_value, search_value, "<strong>" & search_value  & "</strong>", "all")>	
		<cfset res_string_key = k_word>	
	</cfif>
	
	<cfif r.CanRead(session.user.r_pk)>
		<cfset owner = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(r.r_owner)>
        <cfset site = CreateObject("component", "OpenHorizon.Identity.Site").Open(r.r_site)>
    	<table>
		<tr>
		<td valign="top" width="48">
		<img src="#r.r_thumb#" width="48" style="border:none;" align="top"> 
		</td>
		<td valign="top">
		<a style="font-size:18px; font-weight:bold; color:##2957a2; margin-left:15px;" href="####" onclick="ORMSLoad('#r_id#', '')"> #owner.display_name# - #site.site_name# #r.r_type# #r.r_name# (#r.r_status#)</a>
		<p style="margin-left:30px; margin-bottom:10px; font-size:14px;">
			<strong>Found in:</strong> #res_string_key#: #res_string_value#<br>
			<span style="color:##999999; font-size:10px;">Last modified on #DateFormat(r.r_created, "mm/dd/yyyy")# at #TimeFormat(r.r_created, "h:mm tt")#</span>
			
		</p>
		</td>
		</tr>
		</table>
	

	</cfif>
</cfoutput>	
</div>
	
		