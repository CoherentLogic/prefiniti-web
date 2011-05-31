<cffile action="upload"
		destination="D:\Inetpub\WebWareCL\UserContent\#form.userName#\profile_images"
		nameConflict="makeunique"
		fileField="Form.FiletoUpload">

<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfparam name="et" default="">
<cfset et="#getLongname(form.userid)# has uploaded a new photo">
<cfoutput>#writeUserEvent(form.userid, "photos.png", et)#</cfoutput>
<link href="../../css/gecko.css" rel="stylesheet" type="text/css">


<table width="100%">
	<tr>
		<td align="center">
			<h3>Picture Uploaded</h3>
			
			<p class="VPLink"><img src="/graphics/delete.png" border="0" align="absmiddle"> <a href="javascript:window.close();">Close</a>
			</p>
		</td>
	</tr>
</table>

<script language="javascript">
	window.close();
</script>