<!--
	<wwafcomponent>Change Password</wwafcomponent>
    <wwaficon>key.png</wwaficon>
-->
    
<form name="cp" action="cpsub.cfm" method="post">
	<cfif IsDefined("url.expired")>
    	<h1 style="color:red">Password Expired</h1>
        <h2>Please choose a new password</h2>
    </cfif>
    <table width="100%">

		<tr>
			<td>New Password:</td>
			<td><input type="password" name="password" id="password" /></td>
		</tr>
		<tr>
			<td>Re-Enter to Confirm:</td>
			<td><input type="password" name="passwordConfirm" id="passwordConfirm"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<cfoutput><td align="right"><input type="button" class="normalButton" name="changePW" value="Change Password" onclick="setPassword(#url.id#, GetValue('password'), GetValue('passwordConfirm'));" /></td></cfoutput>
		</tr>
	</table>
</form>
    
    
<div id="userActionTarget"></div>
	