<p align="left" style="color:red">For best results, please choose a square picture.</p>

<form name="uploadPicture" action="/authentication/components/changePictureSub.cfm" target="uploadStatusWindow" method="post" enctype="multipart/form-data">
<cfoutput><input type="hidden" name="userid" value="#url.id#">
<input type="hidden" name="userName" value="#url.userName#" /></cfoutput>
	<table width="100%">
		<tr>
			<td>Choose Image:</td>
			<td><input type="file" name="FiletoUpload"></td>
		</tr>
		<tr>
			<cfoutput><td colspan="2" align="right"><input type="button" class="normalButton" onclick="doPictureUpload(#url.id#);" value="Upload This Picture"></td></cfoutput>
		</tr>
	</table>

</form>