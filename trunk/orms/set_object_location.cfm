<cfdump var="#form#">

<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(form.orms_id)>
<cfset orms_rec.r_latitude = form.latitude>
<cfset orms_rec.r_longitude = form.longitude>
<cfif IsDefined("form.dontask")>
<cfset orms_rec.r_ask_location = 0>
</cfif>
<cfset orms_rec.r_has_location = 1>
<cfset orms_rec.Save()>

<script>
	parent.CloseORMSDialog();
</script>