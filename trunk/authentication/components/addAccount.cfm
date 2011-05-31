<!--
<wwafcomponent>Add a User Account</wwafcomponent>
-->
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Add a User Account</h3>
<table width="100%" cellspacing="0">
	<tr>
		<td>User's Full Name:</td>
		<td><input type="text" name="longName" id="longName" /></td>
	</tr>
	<tr>
		<td>Login Name:</td>
		<td>
			<input type="text" name="username" id="username" />
			<input type="button" name="checkAvailabilityx" id="checkAvailabilityx" class="normalButton" onClick="checkAvailability(GetValue('username'));" value="Check Availability" />
			<span id="availability"></span>					
		</td>
	</tr>
	<tr>
		<td>E-Mail Address:</td>
		<td><input type="text" name="email" id="email" /></td>
	</tr>

	<tr>
		<td colspan="2" align="right">
			<input type="button" class="normalButton" name="createAccount" value="Create Account" onclick="createAccount(GetValue('username'), GetValue('longName'), GetValue('email'));" />
		</td>
	</tr>
		
</table>