<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<style type="text/css">
	.orms_table th {
		background-color:#efefef;
		font-weight:bold;
		background-image:none;
		color:black;
		text-align:left;
	}
	
	.orms_table td {
		padding:2px;
		border-bottom:1px solid #c0c0c0;
	}
	
	.otab td:hover {
		background-color:#efefef;
	}
	
</style>

<cfquery name="gro" datasource="webwarecl">
	SELECT DISTINCT(r_id) FROM orms_access_log WHERE a_user_id=#attributes.user_id# ORDER BY a_date DESC
</cfquery>




<cfparam name="oAr" default="">
<cfset oAr = ArrayNew(1)>

<cfset apvar = "">
<cfset ind = 1>
<cfloop query="gro">
	<cfset orms = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
	<cfset apvar = orms.Get(r_id)>
	
	<cfset ArrayAppend(oAr, apvar)>
</cfloop>	

<cfif ArrayLen(oAr) GT 0>
<table width="100%" cellpadding="5" cellspacing="0" class="otab">
	
	<cfloop array="#oAr#" index="x">
		<cfoutput>
        <cfset thumb = CreateObject("component", "OpenHorizon.Graphics.Image").Create(x.r_thumb, 48, 48)>
		<tr>
			<td width="50" valign="top" align="center" onclick="ORMSLoad('#x.r_id#', '');"><img src="#thumb#" align="absmiddle" width="48" height="48"></td>
			<td valign="top" onclick="ORMSLoad('#x.r_id#', '');">
				<p style="font-size:14px; margin-top:0px;"><strong style="color:##2957a2;">#x.r_type# #x.r_name#</strong> (#x.r_status#)<br><br>
				<cftry>
				<span style="font-size:xx-small; color:##c0c0c0;">Last modified #DateFormat(x.r_created, "long")# Rating:</span> 
				<cfif x.GetRating() GT 0>
					<cfloop from="1" to="#x.GetRating()#" index="xx"><img src="/graphics/star.png" align="absmiddle"></cfloop><cfloop from="1" to="#5 - x.GetRating#()" index="xx"><img src="/graphics/star_gray.png" align="absmiddle"></cfloop>
				</cfif>
				<cfcatch>
					
				</cfcatch>
				</cftry>
				<span style="font-size:xx-small; color:##c0c0c0;">Owner: #getLongname(x.r_owner)#</span><br>
				<!---<a class="button" href="#Replace(x.r_view, '"', "'", "all")#"><span>Open</span></a>--->
				</p>
				
				
				<cfmodule template="/orms/comment_view_page.cfm" r_id="#x.r_id#" limit_to="2">
				
			</td>						
		</tr>	
		</cfoutput>		
	</cfloop>	
</table>
<cfelse>
	<div style="margin-top:20px; padding:10px; width:650px; height:270px; -moz-border-radius:5px; margin-bottom:10px; background-color:#2957A2; color:white; font-size:14px;">
	<p>
	<img src="/graphics/bricks.png" align="absmiddle"> <strong>Welcome to Prefiniti ORMS!</strong>
	</p>
	
	<p>The Prefiniti ORMS is a new metadata management system that will allow much more flexible data management, 
		searching, sorting, and sharing on the Prefiniti Network. It will ultimately allow you to relate objects 
		from any Prefiniti application to any other, rate any object, comment on any object, and much more.</p>
	<p><strong>You have not opened any ORMS-managed objects yet!</strong> As you browse through time cards and projects,
	they will be added to your <em>Recent Objects</em> list, which will appear in place of this welcome message.</p>
	<p><strong>Enjoy!</strong></p>
	</div>
	
	
</cfif>	