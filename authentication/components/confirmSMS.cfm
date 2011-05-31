<cfparam name="sms_confid" default="">
<cfset sms_confid=Left(CreateUUID(), 6)>

<cfquery name="udsc" datasource="webwarecl">
	UPDATE Users SET sms_conf='#sms_confid#' WHERE id=#url.userid#
</cfquery>

<cfmail from="sms@prefiniti.com" to="#url.number#@teleflip.com" subject="Prefiniti SMS Confirmation">Reply with 'CONF #sms_confid#' to confirm.</cfmail>

<cfoutput>
<table width="100%">
	<tr>
		<td align="center"><p>Your SMS confirmation text message has been sent. Please reply to it with the text '<code>CONF #sms_confid#</code>' to complete SMS setup.</p></td>
	</tr>
</table>
</cfoutput>