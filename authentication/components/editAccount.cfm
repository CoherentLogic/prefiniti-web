<cfquery name="accountInfo" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#URL.id#
</cfquery>

<cfquery name="getCompanies" datasource="webwarecl">
	SELECT * FROM companies ORDER BY name
</cfquery>

<cfquery name="getCompanyName" datasource="webwarecl">
	SELECT * FROM companies WHERE id=#accountInfo.company#
</cfquery>

<center>
<form name="editAccount" action="editAcct_post.cfm" method="post">
<cfoutput><input type="hidden" name="id" id="id" value="#URL.id#"/></cfoutput>
	<table width="100%">
		
		<tr>
			<td>Company:</td>
			<td>
				<select name="company" id="company"  <cfif #url.isAdmin# EQ "false">disabled</cfif>>
					<cfoutput>
						<option value="#accountInfo.company#" selected>#getCompanyName.name#</option>
					</cfoutput>
					<cfoutput query="getCompanies">
						<option value="#id#">#name#</option>
					</cfoutput>	
				</select>			</td>
		</tr>
		<tr>
			<td>Name:</td>
			<td><cfoutput><input type="text" name="longName" id="longName" value="#accountInfo.longName#"  /></cfoutput></td>
		</tr>
		<tr>
		  <td>Job Title: </td>
		  <td><cfoutput><input type="text" name="title" id="title" value="#accountInfo.title#" /></cfoutput></td>
	  </tr>
		<tr>
		  <td>Gender:</td>
		  <td>
				<p>
				<label>
				  <input type="radio" name="gender" value="F" <cfif #accountInfo.gender# EQ 'F'>checked</cfif>/>
				  Female</label>
				<br />
				<label>
				  <input type="radio" name="gender" value="M" <cfif #accountInfo.gender# EQ 'M'>checked</cfif>/>
				  Male</label>
				<br />
				</p>			</td>
	  </tr>
		

		<tr>
			<td>E-Mail Address:</td>
			<td>
				<cfoutput>
				<input type="text" name="email" id="email" value="#accountinfo.email#" />
				</cfoutput>			</td>
		</tr>
		<tr>
			<td>Phone Number:</td>
			<td><cfoutput><input type="text" name="phone" id="phone" value="#accountinfo.phone#"></cfoutput></td>
		</tr>
		<tr>
			<td>Fax Number:</td>
			<td><cfoutput><input type="text" name="fax" id="fax" value="#accountinfo.fax#"></cfoutput></td>
		</tr>
		<tr>
			<td>Mobile Phone  Number:</td>
			<td><cfoutput><input type="text" name="smsNumber" id="smsNumber" value="#accountinfo.smsNumber#"><input type="button" class="normalButton" value="Configure my account for Text Messaging" onclick="confirmSMS(GetValue('id'), GetValue('smsNumber'));" /></cfoutput></td>
		</tr>
		<tr>
		  <td>Biography:</td>
		  <td><cfoutput><textarea name="bio" cols="50" rows="8" id="bio">#accountinfo.bio#</textarea></cfoutput></td>
		</tr>
		<tr>
		  <td>Login Options:</td>
		  <td><input type="checkbox" name="remember_page" id="remember_page" <cfif #accountinfo.remember_page# EQ 1>checked</cfif> />
		    Return to last viewed application on login</td>
	  </tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right">
				<cfoutput><input type="button" class="normalButton" name="Submit" value="Update #accountinfo.longName#'s User Account" onclick="javascript:updateAccountInfo(GetValue('id'), GetValue('company'), GetValue('longName'), GetValue('email'), GetValue('smsNumber'), AjaxGetCheckedValue('gender'), GetValue('bio'), GetValue('title'), GetValue('phone'), GetValue('fax'), IsChecked('remember_page'))"  /></cfoutput>			</td>
			</td>
		</tr>
	</table>
</form>
