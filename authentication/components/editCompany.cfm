

<cfquery name="cI" datasource="webwarecl">
	SELECT * FROM companies WHERE id=#url.id#
</cfquery>

<cfoutput>
<!--
<wwafcomponent>Edit Company (#cI.name#)</wwafcomponent>
-->
</cfoutput>
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Make changes to a Company</h3>
<cfoutput query="cI">
	<table width="100%" cellspacing="0">
		<tr>
			<td>Company Name:</td>
			<td><input name="name" type="text" id="name" value="#name#" size="60"></td>
		</tr>
		<tr>
			<td>Mailing Address:</td>
			<td>
				<table>
					<tr>
						<td>Street:</td>
						<td><input type="text" name="mailing_address" id="mailing_address" value="#mailing_address#"></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="mailing_city" id="mailing_city" value="#mailing_city#"></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="mailing_state" id="mailing_state" value="#mailing_state#"></td>
					</tr>
					<tr>
						<td>ZIP Code:</td>
						<td><input type="text" name="mailing_zip" id="mailing_zip" value="#mailing_zip#"></td>
					</tr>
				</table>
			</td>
		</tr>
				<tr>
			<td>Billing Address:</td>
			<td>
				<table>
					<tr>
						<td>Street:</td>
						<td><input type="text" name="billing_address" id="billing_address" value="#billing_address#"></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="billing_city" id="billing_city" value="#billing_city#"></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="billing_state" id="billing_state" value="#billing_state#"></td>
					</tr>
					<tr>
						<td>ZIP Code:</td>
						<td><input type="text" name="billing_zip" id="billing_zip" value="#billing_zip#"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>Website:</td>
			<td><input type="text" name="website" id="website" value="#website#"></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" class="normalButton" value="Update #name#" onClick="updateCompany(#url.id#, GetValue('name'), GetValue('mailing_address'), GetValue('mailing_city'), GetValue('mailing_state'), GetValue('mailing_zip'), GetValue('billing_address'), GetValue('billing_city'), GetValue('billing_state'), GetValue('billing_zip'), GetValue('website'));">
			</td>
		</tr>
	</table>
</cfoutput>
<div id="userActionTarget" style="width:100%; clear:both; margin-top:30px;">
</div>