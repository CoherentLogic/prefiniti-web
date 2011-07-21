<cfset usr = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK("User Account", attributes.r_pk)>

<strong class="OH_HEADER">Notifications</strong>


<cfif usr.CanWrite(session.user.r_pk)>
	<div style="padding-left:20px;">
	
		<cfmodule template="/notifications/components/notify_types.cfm" user_id="#attributes.r_pk#">
	
	</div>
<cfelse>	
</cfif>	