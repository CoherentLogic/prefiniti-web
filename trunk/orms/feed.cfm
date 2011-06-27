
<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.uuid)>


<cfset events = o.Events(1, 20)>

<cfloop array="#events#" index="e">
	<cfmodule template="/OpenHorizon/Storage/EventViews/Feed.cfm" r_pk="#e.r_pk#">
	<hr style="width:100%; border:0; height:1px; background-color:#c0c0c0; color:#c0c0c0;" />
</cfloop>