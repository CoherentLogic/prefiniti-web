
<cfquery name="ore" datasource="webwarecl">
	SELECT * FROM orms WHERE id='#url.orms_id#'
</cfquery>

<cfoutput>
<!--
<wwafcomponent>#ore.r_type# #ore.r_name#</wwafcomponent>
-->
</cfoutput>

<cfset po = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK(ore.r_type, ore.r_pk)>
<cfif po.CanRead(URL.CalledByUser)>
	<cfset po.DoAccess("View", url.calledByUser)>
	<cfmodule template="/orms/view_header.cfm" r_type="#ore.r_type#" r_pk="#ore.r_pk#" section="#url.section#">
<cfelse>
	<strong class="OH_HEADER">Permission Denied</strong>
</cfif>

