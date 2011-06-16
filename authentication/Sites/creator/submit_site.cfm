<cfset new_site = CreateObject("component", "OpenHorizon.Identity.Site")>
<cfset new_site.Create(URL.site_name, URL.industry, URL.salestax_rate)>
<cfset new_site.Save()>

<cfset first_member = CreateObject("component", "OpenHorizon.Identity.SiteMembership")>
<cfset first_member.Create(new_site, session.user, "Employee")>
<cfset first_member.Save()>
<cfset first_member.GrantSet(session.framework.PermissionSet("Site Administrator"))>

<a href="##" onclick="CloseORMSDialog(); AjaxRefreshTarget();" class="button"><span>Finish</span></a>