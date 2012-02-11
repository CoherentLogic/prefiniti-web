<cfset ob = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.target_uuid)>
<cfset ob.Relate(URL.mobile_device, "LocationProvider")>

<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">
	<tr>
		<td align="center" valign="top"><img src="/graphics/sunrise.png" width="100"></td>
		<td align="left" valign="top" style="font-size:14px;">
			<h2 style="color:#2957a2; letter-spacing:6px; text-transform:uppercase;">Mobile Device Linked</h2>
			<p>Congratulations! Your mobile device has been linked to this object. Click on the <strong>Finish</strong> button to proceed.</p>
						
		</td>
	</tr>
</table>