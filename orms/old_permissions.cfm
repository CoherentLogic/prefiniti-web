<!---
	ATTRIBUTES:
	
	r_type		object type
	r_pk		object pri key
	user_id		user_id to check perms for
--->
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset o.GetByTypeAndPK(attributes.r_type, attributes.r_pk)>

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td align="left"  style="display:inline; width:40%;" id="orms_sidebar">
	<div class="OH_BOX">
	<cfoutput>
	<div style="width:100%; text-align:center;">

	<cftry>
	<cfimage source="#o.r_thumb#" name="r_thumbnail">
	<cfif ImageGetWidth(r_thumbnail) GT 60>
		<cfset iWidth = "250">
	<cfelse>
		<cfset iWidth = "48">
	</cfif>
	<cfcatch>
		<cfset iWidth = "48">
	</cfcatch>
	</cftry>
	<img src="#o.r_thumb#" width="#iWidth#"><br><br>
	<strong class="OH_HEADER">#o.r_type# #o.r_name#</strong>
	
				
		
		<p style="font-size:14px; text-align:center;">
		#getSiteNameByID(o.r_site)#<br>
		#o.r_status#<br><br>
		
		<cfif o.GetRating() GT 0>
			<cfloop from="1" to="#o.GetRating()#" index="x"><img src="/graphics/star.png" align="absmiddle"></cfloop>
			<br><br>
		</cfif>
		
		<cfmodule template="/orms/keywords.cfm" r_type="#attributes.r_type#" r_pk="#attributes.r_pk#">
		
				
		<span style="font-size:10px;">Last modified on #DateFormat(o.r_created, "long")# at #TimeFormat(o.r_created, "h:mm tt")#</span>
	</p>
	</div>	
	</cfoutput>
	</div>
	<div class="OH_BOX">
	<cfoutput>
	<strong class="OH_HEADER">#o.r_type# Owner</strong>
	<blockquote>
		<p style="font-size:14px;"><img src="#getPicture(o.r_owner)#" width="48" height="48" align="top"> #getLongname(o.r_owner)#</p>
		
		<div style="height:40px;">
		<a href="##" class="button" onclick="viewProfile(#o.r_owner#)"><span>View Profile</span></a>
		<a href="##" class="button" onclick="mailTo(#o.r_owner#, '')"><span>Send Mail</span></a>
		</div>
	</blockquote>
	</cfoutput>
	
	<cfoutput>
	<strong class="OH_HEADER">My #o.r_type# Roles</strong>
	
	<blockquote>
	<label>
		<input 
		type="checkbox"
		name="orms_prefiniti_admin"
		<cfif o.IsPrefinitiAdmin(attributes.user_id)>
			checked
		</cfif>
		readonly disabled>
		Global administrator
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_owner"
		<cfif o.IsOwner(attributes.user_id)>
			checked
		</cfif>
		readonly disabled>
		Owner of this #LCase(o.r_type)#
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_site_admin"
		<cfif o.IsSiteAdmin(attributes.user_id)>
			checked
		</cfif>
		readonly disabled>
		Administrator of #getSiteNameByID(o.r_site)#
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_site_customer"
		<cfif o.IsPeer(attributes.user_id, "Customer")>
			checked
		</cfif>
		readonly disabled>
		Customer of #getSiteNameByID(o.r_site)#
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_site_employee"
		<cfif o.IsPeer(attributes.user_id, "Employee")>
			checked
		</cfif>
		readonly disabled>
		Employee of #getSiteNameByID(o.r_site)#
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_site_friend"
		<cfif o.IsPeer(attributes.user_id, "Friend")>
			checked
		</cfif>
		readonly disabled>
		Friend of #getSiteNameByID(o.r_site)#
	</label>
	
	<p><img src="/graphics/lightbulb.png" align="absmiddle"> Roles tell you how your Prefiniti account is related to this object.</p>
	
	</blockquote>
	</cfoutput>
	
	<cfoutput>
	<strong class="OH_HEADER">My #o.r_type# Permissions</strong>
	
	<blockquote>
	<label>
		<input 
		type="checkbox"
		name="orms_can_read"
		<cfif o.CanRead(attributes.user_id)>
			checked
		</cfif>
		readonly disabled>
		Look at this #LCase(o.r_type)#
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_can_write"
		<cfif o.CanWrite(attributes.user_id)>
			checked
		</cfif>
		readonly disabled>
		Make changes to this #LCase(o.r_type)#
	</label><br>
	
	<label>
		<input 
		type="checkbox"
		name="orms_can_delete"
		<cfif o.CanDelete(attributes.user_id)>
			checked
		</cfif>
		readonly disabled>
		Delete this #LCase(o.r_type)#
	</label>
	<p><img src="/graphics/lightbulb.png" align="absmiddle"> Permissions tell you what you are allowed to do with this object.</p>
	
	</blockquote>
	
	<strong class="OH_HEADER">Quick Access Code</strong>
	<blockquote>
	<img src="http://picasso.coherent-logic.com:8500/repos/#o.r_owner#/#o.r_type#/#o.r_id#/barcode.png"><br>
	</blockquote>
	</cfoutput>
	</div>
</td> <!-- END OF SIDEBAR -->
<td align="left" style="width:60%;" id="orms_content">
	<cfset sections = o.GetSections()>
	<div id="orms_active_section" style="width:100%; height:auto; overflow:hidden;">
		<cfif IsDefined("attributes.section")>
			<cfif attributes.section NEQ "">
				<cfquery name="get_section_data" datasource="webwarecl">
					SELECT section_file FROM orms_app_sections WHERE r_type='#o.r_type#' AND section_name='#attributes.section#'
				</cfquery>
				<cfmodule template="#get_section_data.section_file#" r_pk="#o.r_pk#">
			<cfelse>
				<cfoutput query="sections" maxrows="1">
					<cfmodule template="#section_file#" r_pk="#o.r_pk#">
				</cfoutput>
			</cfif>
		<cfelse>
			<cfoutput query="sections" maxrows="1">
				<cfmodule template="#section_file#" r_pk="#o.r_pk#">
			</cfoutput>
		</cfif>
	</div>
	<cfif o.CanRead(attributes.user_id)>
		<strong class="OH_HEADER">Comment on this <cfoutput>#o.r_type#</cfoutput></strong>
		<div id="orms_comment_form" style="width:100%;">
			<cfmodule template="/orms/comment_form.cfm" r_id="#o.r_id#" user_id="#attributes.user_id#">
		</div>
	</cfif>
	<div id="orms_comments">
		<cfmodule template="/orms/comment_view_page.cfm" r_id="#o.r_id#" page="1">
	</div>
</td>
</tr>
</table>
