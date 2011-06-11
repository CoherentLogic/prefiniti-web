<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfoutput>
<!--
	<wwafcomponent>Search Results - #url.search_value#</wwafcomponent>
-->
</cfoutput>

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
	
	<cfif r.CanRead(URL.CalledByUser)>
		<table>
		<tr>
		<td valign="top" width="48">
		<img src="#r.r_thumb#" width="48" style="border:none;" align="top"> 
		</td>
		<td valign="top">
		<a style="font-size:18px; font-weight:bold; color:##2957a2; margin-left:15px;" href="####" onclick="ORMSLoad('#r_id#', '')"> #getLongname(r.r_owner)# - #getSiteNameByID(r.r_site)# #r.r_type# #r.r_name# (#r.r_status#)</a>
		<p style="margin-left:30px; margin-bottom:10px; font-size:14px;">
			<strong>Found in:</strong> #res_string_key#: #res_string_value#<br>
			<span style="color:##999999; font-size:10px;">Last modified on #DateFormat(r.r_created, "mm/dd/yyyy")# at #TimeFormat(r.r_created, "h:mm tt")#</span>
			
		</p>
		</td>
		</tr>
		</table>
	
		<!--- <tr>
			<td></td>
			<td></td>
			<td>#r.r_name#</td>
			<td>#getLongname(r.r_owner)#</td>
			<td></td>
			<td><a href="#Replace(r.r_view, '"', "'", "all")#"><span>Open</span></a></td>
		</tr> --->
	</cfif>
</cfoutput>	
</div>
	
		