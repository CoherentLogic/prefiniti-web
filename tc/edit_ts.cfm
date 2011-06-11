<cfmodule template="/orms/view_header.cfm" r_type="Time Card" r_pk="#url.id#">
	<cfset tco = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK("Time Card", url.id)>
	<cfset tco.DoAccess("View", url.calledByUser)>

<cfoutput>
<!--
<wwafcomponent>Time Collection - #tco.r_name#</wwafcomponent>
<wwafpackage>Time Management</wwafpackage>
<wwaficon>time.png</wwaficon>
-->
</cfoutput>


