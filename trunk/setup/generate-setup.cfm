<cfdump var="#form#">

<cfset PAF = CreateObject("component", "Prefiniti")>

<cfset PAF.SetConfig("ORMS", "cmsurl", Form.cmsurl)>
<cfset PAF.SetConfig("Instance", "datasource", Form.datasource)>
<cfset PAF.SetConfig("ORMS", "filestorage", Form.filestorage)>
<cfset PAF.SetConfig("Instance", "mode", Form.mode)>
<cfset PAF.SetConfig("Instance", "name", Form.name)>
<cfset PAF.SetConfig("Instance", "ohrootdir", Form.ohrootdir)>
<cfset PAF.SetConfig("Instance", "pathdelimiter", Form.pathdelimiter)>
<cfset PAF.SetConfig("Instance", "platform", Form.platform)>
<cfset PAF.SetConfig("Instance", "rootpath", Form.rootpath)>
<cfset PAF.SetConfig("Instance", "rooturl", Form.rooturl)>
<cfset PAF.SetConfig("Instance", "staging", Form.staging)>
<cfset PAF.SetConfig("Instance", "thumbnailcache", Form.ohrootdir & form.pathdelimiter & "Resources" & form.pathdelimiter & "Graphics" & form.pathdelimiter & "ThumbnailCache")>
<cfset PAF.SetConfig("Instance", "serverport", CGI.SERVER_PORT)>
<cfset PAF.SetConfig("Instance", "notification_sender", "NOT CONFIGURED")>
<cfset PAF.SetConfig("Instance", "mainsite", "NOT CONFIGURED")>
<cfset PAF.SetConfig("Instance", "first_user", "NOT CONFIGURED")>

<cfset new_site = CreateObject("component", "OpenHorizon.Identity.Site")>
<cfset new_site.Create(Form.name, "Other/Not Selected", 0)>
<cfset new_site.Save()>

<cfset PAF.SetConfig("Instance", "mainsite", "#new_site.r_pk#")>


<cflocation url="/homeres/default.cfm" addtoken="no">

