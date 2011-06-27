
<cfquery name="ore" datasource="webwarecl">
	SELECT * FROM orms WHERE id='#attributes.orms_id#'
</cfquery>

<cfoutput>
<!--
<wwafcomponent>#ore.r_type# #ore.r_name#</wwafcomponent>
-->
</cfoutput>

<cfset po = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK(ore.r_type, ore.r_pk)>
<cfif po.CanRead(session.user.r_pk)>
	<cfset po.DoAccess("View", session.user.r_pk)>
	<cfmodule template="/orms/view_header.cfm" r_type="#ore.r_type#" r_pk="#ore.r_pk#" section="#attributes.section#">
<cfelse>
	<strong class="OH_HEADER">Permission Denied</strong>
</cfif>

