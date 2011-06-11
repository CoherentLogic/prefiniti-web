<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.orms_id)>
<cfset f = CreateObject("component", "OpenHorizon.Storage.File").Open(URL.file_uuid)>

<cfset o.SetThumbnail(f.URL())>
