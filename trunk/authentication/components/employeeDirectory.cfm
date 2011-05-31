<!--
<wwafcomponent>Employee Directory</wwafcomponent>
-->

<cfquery name="gDir" datasource="webwarecl">
	SELECT * FROM Users WHERE type=1 AND account_enabled=1 ORDER BY longName
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Employee Directory</h3>

<table width="100%" cellspacing="0">
	<cfoutput query="gDir">
		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#">
				<cfif #picture# EQ "">
					<img src="/graphics/no_pic.gif" width="65" height="65">
				<cfelse>
					<img src="/authentication/profile_images/#picture#" width="65" height="65">
				</cfif>
				<br />
				<cfswitch expression="#online#">
					<cfcase value="0"><font color="red">User is offline</font></cfcase>
					<cfcase value="1"><font color="green">User is online</font></cfcase>
				</cfswitch>
			</td>
			<td style="background-color:#ColColor#" valign="top" align="right">
				<h3 align="right"><a href="javascript:viewProfile(#id#);">#longName#</a></h3>
				<cfif #title# NEQ "">
					<p align="right">#title#</p>
				</cfif>
				<p align="right">
					<cfif #phone# NEQ "">
						Phone Number: #phone#<br>
					</cfif>
					<cfif #fax# NEQ "">
						Fax Number: #fax#<br>
					</cfif>
					E-Mail Address: <a href="mailto:#email#">#email#</a>
				</p>
				
				<cfif #smsnumber# NEQ "">
				<a href="javascript:showDiv('sendText_#id#');">Send Text Message</a>
				
				<div id="sendText_#id#" style="display:none;">
					<br>
					<label>Message Body: <input type="text" name="text_#id#" id="text_#id#" maxlength="160"></label><br>
					<input type="button" class="normalButton" name="sendMsg_#id#" id="sendMsg_#id#" value="Send Text Message" onclick="sendText('#id#', GetValue('text_#id#'));">
				</div>
				</cfif>
				
			</td>
		</tr>
	</cfoutput>
</table>