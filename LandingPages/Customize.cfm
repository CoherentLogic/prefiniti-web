<!---
	$Id$
--->
<cfinclude template="/authentication/authentication_udf.cfm">

<cfmodule template="/LandingPages/LandingHeader.cfm">

<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<h3>My Profile</h3>
			
			<p style="margin-left:5px;">
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Basic information" url="EditProfile" help="Change my basic profile information" profile_section="basic_information.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Contact information" url="EditProfile" help="Change my contact information" profile_section="contact_info.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Background &amp; Interests" url="EditProfile" help="Change my background, interests, music, relationship status" profile_section="background.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="My locations" url="EditProfile" help="Change my locations and points of interest" profile_section="locations.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Site memberships" url="EditProfile" help="Manage my site memberships" profile_section="memberships.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Notification settings" url="EditProfile" help="Change my notification settings" profile_section="notifications.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Privacy settings" url="EditProfile" help="Change my privacy settings" profile_section="privacy.cfm">
			</p>
			
			<h3>Automatic Notifications</h3>
			
			<p style="margin-left:5px;">
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Notification settings" url="EditProfile" help="Change my notification settings" profile_section="notifications.cfm"><br />
				<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Contact information" url="EditProfile" help="Change my contact information" profile_section="contact_info.cfm">
			</p>
		</td>
		<td>
			
			<h3>My Business</h3>
			
			<p style="margin-left:5px;">
			<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Change business information" url="/authentication/components/maintenancePanel.cfm?section=site_information.cfm" help="Change my business information"><br />
			<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Create and edit departments" url="/authentication/components/maintenancePanel.cfm?section=departments.cfm" help="Create and edit departments"><br />
			<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Prefiniti billing" url="/authentication/components/maintenancePanel.cfm?section=billing.cfm" help="View billing information"><br />
			<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Business events" url="/authentication/components/maintenancePanel.cfm?section=order_settings.cfm" help="View billing information"><br />
			<cfmodule template="/framework/link.cfm" perm="AS_VIEW" linkname="Manage employees and customers" url="/authentication/components/associationManager.cfm" help="Manage employees and customers"><br />	
			<cfmodule template="/framework/link.cfm" perm="WW_MANAGECATALOG" linkname="Add a product to my company's catalog" url="/product_ordering/AddProduct.cfm" help="Add Product"><br />
			</p>				
			
			<cfif pfIsPrefinitiAdmin(url.calledByUser)>
				<h3>Prefiniti Network Administration</h3>
				
				<p style="margin-left:5px;">
				<a href="/webware_admin/manageSites.cfm">Manage Prefiniti sites</a><br />
				<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/postWebgram.cfm');">Post WebGram</a><br />
				<a href="/prefiniti_framework_base.cfm">Reload</a><br />
				<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/dump_url.cfm');">Dump URL</a><br />
				<label style="color:black;"><input type="text" id="pageTest" /></label><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('tcTarget', GetValue('pageTest'));" value="CB"/><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('sbTarget', GetValue('pageTest'));" value="SB"/><br />
				<a href="http://www.prefiniti.com/docs/create_document.cfm">Create new help document</a><br />
				<a href="javascript:showConsole();">Show Prefiniti debugging and command console</a><br />
				<a href="javascript:PWelcomeScreen();">Welcome Screen</a><br />
				
				<cfquery name="gaun" datasource="webwarecl">
					SELECT longName, id, username FROM Users ORDER BY longName
				</cfquery>    
				<a href="javascript:showDiv('impersonatorNew');">Impersonate</a>
				<br />
				<div id="impersonatorNew" style="display:none;">
				<form name="impersonateNew" id="impersonateNew" action="/impersonate_user.cfm" method="post">
					<select name="i_uid" id="i_uid">
						<cfoutput query="gaun">
							<option value="#id#">#longName# (#username#)</option>
						</cfoutput>
					</select>
					<input type="submit" name="submit" value="Login As" class="normalButton" />
				</form>                        
				</div>
				
				<br /><a href="javascript:AjaxLoadPageToWindow('/authentication/components/invite_user.cfm', 'Invite User');">Invite User</a>
				<!---<cfoutput>#getPermissionByKey("AS_LOGIN", session.current_association)#</cfoutput>--->
				</p>
			</cfif>
		</td>
	</tr>
</table>						
							