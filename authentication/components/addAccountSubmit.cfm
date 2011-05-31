<cfparam name="cid" default="#CreateUUID()#">

<cfquery name="cA" datasource="webwarecl">
	INSERT INTO Users (username, 
						email,
						password,
						longName, 
						account_enabled,
						confirm_id)
	VALUES ('#url.p_username#',
			'#url.email#',
			'',
			'#url.longName#',
			1,
			'#cid#');
</cfquery>

<cfquery name="gA" datasource="webwarecl">
	SELECT * FROM Users WHERE confirm_id='#cid#'
</cfquery>

<cfoutput>
<cfmail from="register@centerlineservices.biz" to="#url.email#" subject="Center Line Services Account Confirmation" type="html">
	<h1>Account Created</h1>
	
	<p>Your Center Line Services account has been created. Please visit the link below to confirm your new account.</p>
	
	<a href="http://www.prefiniti.com/appBase.cfm?sideBar=Register&contentBar=/authentication/components/setInitialPassword.cfm?cid=#cid#">Confirm My Account</a>
	
	<p>Otherwise, copy the following text to your browser's URL bar:</p>
	
	<pre>http://www.prefiniti.com/appBase.cfm?sideBar=Register&contentBar=/authentication/components/setInitialPassword.cfm?cid=#cid#</pre>
</cfmail>
</cfoutput>

<table width="100%">
	<tr>
		<td align="center" valign="middle">
			<h1>Account Created</h1>
			<cfoutput><a class="VPLink" href="javascript:editUser('#gA.id#');">Next Step</a></cfoutput>
		</td>
	</tr>
</table>
