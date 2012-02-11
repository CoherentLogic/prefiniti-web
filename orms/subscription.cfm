
<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.om_uuid)>
<cfset user = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(URL.user_id)>

<cfswitch expression="#URL.action#">
	<cfcase value="subscribe">
		<cfset orms_rec.Subscribe(user)>
	</cfcase>
	<cfcase value="unsubscribe">
		<cfset orms_rec.Unsubscribe(user)>
	</cfcase>
</cfswitch>