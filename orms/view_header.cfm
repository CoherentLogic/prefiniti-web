<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfset orms = CreateObject("component", "Res")>

<cfset orms_rec = orms.GetByTypeAndPK(attributes.r_type, attributes.r_pk)>

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
	
</style>

<cfif IsDefined("attributes.section")>
	<cfset sec = attributes.section>
<cfelse>
	<cfset sec = "">
</cfif>

<cfset sections = orms_rec.GetSections()>
<div id="orms_info">
		<cfif orms_rec.r_id NEQ "NO ORMS ENTRY AVAILABLE">
			<div style="width:100%; height:45px; background-color:#efefef; border-bottom:1px solid #c0c0c0;">
				
				<div style="padding:8px; height:30px; float:left;">
					<select name="orms_app_sections" 
							id="orms_app_sections" 
							style="margin-left:5px; margin-right:30px; margin-top:1px; float:left;"
							<cfoutput>
								onchange="ORMSLoadSection(#orms_rec.r_pk#, GetValue('orms_app_sections'));"
							</cfoutput>>							
							<cfoutput query="sections">
								<option value="#section_loader#" <cfif section_name EQ sec>selected</cfif>>#section_name#</option>
							</cfoutput>
					</select>
					
					
					<cfset createObjectLink = orms_rec.GetCreator(orms_rec.r_type)>
					
					<cfif createObjectLink NEQ "">
						<cfoutput><a href="##" class="button" onclick="ORMSDialog('#createObjectLink#')"><span>New #orms_rec.r_type#</span></a></cfoutput>
					</cfif>
					<cfif orms_rec.CanDelete(URL.CalledByUser)>
						<a href="##" class="button" onclick=""><span>Delete</span></a>
					</cfif>
					
					<cfif orms_rec.CanRead(URL.CalledByUser)>
						<a href="##" class="button" onclick=""><span>Share</span></a>
					</cfif>
					
					<cfif orms_rec.CanRead(URL.CalledByUser)>
						<cfoutput><a class="button" href="http://prefiniti15.prefiniti.com/Prefiniti.cfm?view=#orms_rec.r_id#&section=" target="_blank"><span>New Window</span></a></cfoutput>
					</cfif>
					
					<a href="##" class="button" onclick="ORMSShowHideSidebar();"><span>Show/Hide Sidebar</span></a>
					
					
				</div>
			</div>
			<div id="orms_extended_info">
			<cfif IsDefined("URL.CalledByUser")>
				<cfif IsDefined("URL.section")>
					<cfset sec = URL.section>
				<cfelse>
					<cfset sec = "">
				</cfif>
				<cfmodule template="/orms/permissions.cfm" r_type="#orms_rec.r_type#" r_pk="#orms_rec.r_pk#" user_id="#URL.CalledByUser#" section="#sec#">
			</cfif>
			</div>
		<cfelse>
			<strong>No ORMS record is available for this object. This is most likely due to this object having been created before ORMS was implemented. However, the ORMS record will be created next time you modify this object.</strong>
		</cfif>
</div>
	