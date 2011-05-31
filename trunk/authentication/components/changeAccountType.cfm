<cfquery name="accountInfo" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#URL.id#
</cfquery>

<cfquery name="getCompanies" datasource="webwarecl">
	SELECT * FROM companies
</cfquery>

<cfquery name="getCompanyName" datasource="webwarecl">
	SELECT * FROM companies WHERE id=#accountInfo.company#
</cfquery>

<table width="100%">
<tr>
	<td>&nbsp;</td>
	<td><cfoutput><label><input type="checkbox" name="account_enabled" id="account_enabled" <cfif #accountInfo.account_enabled# EQ 1>checked</cfif>/>User can log in</label></cfoutput></td>
<tr>
			<td>Account Type:</td>
			<td><p>
			  <label>
			    <input type="radio" name="type" value="0" <cfif #accountinfo.type# EQ 0>checked</cfif>/>
			    Customer</label>
			  <br />
			  <blockquote><input name="orderRep" id="orderRep" type="checkbox" value="ORDER REP" <cfif #accountinfo.role# EQ 'ORDER REP'>checked</cfif>/> <cfoutput>#accountInfo.longName# </cfoutput>is an ordering representative for <cfif #accountinfo.gender# EQ 'M'>his<cfelse>her</cfif> company</blockquote>
			  <label>
			    <input type="radio" name="type" value="1" <cfif #accountinfo.type# EQ 1>checked</cfif> />
			    Employee</label>
				<blockquote><input name="admin" type="checkbox" id="admin" value="ADMIN" <cfif #accountinfo.role# EQ 'ADMIN'>checked</cfif> /> <cfoutput>#accountInfo.longName# </cfoutput>can add/remove accounts<br />
				<input name="admin" type="checkbox" id="order_processor" <cfif #accountinfo.order_processor# EQ 1>checked</cfif> /> <cfoutput>#accountInfo.longName# </cfoutput>can process new orders<br />
				<label><input name="tcAdmin" type="checkbox" id="tcAdmin" value="yes" <cfif #accountinfo.tcadmin# EQ 'yes'>checked</cfif>><cfoutput>#accountInfo.longName# </cfoutput> is a timesheet administrator</label><br />
				<label><input name="site_maintainer" type="checkbox" id="site_maintainer" value="yes" <cfif #accountinfo.site_maintainer# EQ 'yes'>checked</cfif>><cfoutput>#accountInfo.longName# </cfoutput> is a site maintainer</label><br />
				<label><input name="receives_timesheet_reminders" type="checkbox" id="receives_timesheet_reminders" value="yes" <cfif #accountinfo.receives_timesheet_reminders# EQ 1>checked</cfif>><cfoutput>#accountInfo.longName# </cfoutput> receives timesheet reminders</label>
				</blockquote>
			  <br />
		    </p>
			
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<cfoutput>
				<input type="button" class="normalButton" name="udAccountType" value="Update Account Type" onclick="updateAccountType(#url.id#, AjaxGetCheckedValue('type'), IsChecked('orderRep'), IsChecked('admin'), IsChecked('tcAdmin'), IsChecked('account_enabled'), IsChecked('order_processor'), IsChecked('site_maintainer'), IsChecked('receives_timesheet_reminders'));" />
				</cfoutput>
			</td>
		</tr>
		

</table>