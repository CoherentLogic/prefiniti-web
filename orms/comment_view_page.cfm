<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="get_comments" datasource="webwarecl">
	SELECT * FROM orms_comments WHERE r_id='#attributes.r_id#' ORDER BY post_date DESC
</cfquery>

<cfif IsDefined("attributes.limit_to")>
	<cfset theMaxRows = attributes.limit_to>
<cfelse>
	<cfset theMaxRows = 50000>
</cfif>

<cfif get_comments.RecordCount GT 0>
<table width="100%" cellpadding="5" cellspacing="0">
	<cfoutput query="get_comments" maxrows="#theMaxRows#">
	<tr>
	<cfif NOT IsDefined("attributes.limit_to")>
	<td width="50" valign="top" align="center">
		<img src="#getPicture(user_id)#" width="48" height="48">
	</td>
	</cfif>
	<td valign="top">
		
		<p style="font-size:14px; margin-top:0px;"><strong style="color:##2957a2;">#getLongname(user_id)#</strong> - #comment_body#<br><br>
		<span style="font-size:xx-small; color:##c0c0c0;">#DateFormat(post_date, "long")# Rating:</span> 
		<cfif rating GT 0>
			<cfloop from="1" to="#rating#" index="x"><img src="/graphics/star.png" align="absmiddle"></cfloop><cfloop from="1" to="#5 - rating#" index="x"><img src="/graphics/star_gray.png" align="absmiddle"></cfloop>
		<cfelse>
			<span style="font-size:xx-small; color:##c0c0c0;">No rating.</span>
		</cfif>
		</p>
	</td>
	</tr>
	</cfoutput>
</table>
</cfif>