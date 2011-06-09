<cfset usr = CreateObject("component","Res").GetByTypeAndPK("User Account", attributes.r_pk)>

<cfinclude template="/authentication/authentication_udf.cfm">

<strong class="OH_HEADER">Basic Information</strong>

<cfif usr.CanWrite(URL.CalledByUser)>
	<cfparam name="u" default="">
	<cfset u = getUserInformation(attributes.r_pk)>
	
	<cfoutput query="u">
	
	<form name="updateBasic" id="updateBasic">
	<input type="hidden" name="user_id" id="user_id" value="#attributes.r_pk#" />
		<table width="100%">
	    	<tr>
	        	<td>First Name:</td>
	    		<td>
	            	<input type="text" name="firstName" id="firstName" maxlength="255"  value="#firstName#"/>
	                <label>Middle Initial: <input name="middleInitial" type="text" id="middleInitial" size="2" maxlength="1" value="#middleInitial#"/></label>
	                <label>Last: <input type="text" name="lastName" id="lastName" maxlength="255" value="#lastName#"/></label>
	            </td>
			</tr>            
	    	<tr>
	        	<td>Gender:</td>
	            <td>
	            	<p>
				    <label>
				      <input type="radio" name="gender" value="M" <cfif gender EQ "M">checked</cfif>>
				      Male</label>
				    <br>
				    <label>
				      <input type="radio" name="gender" value="F"  <cfif gender EQ "F">checked</cfif>>
				      Female</label>
				    <br>
				    </p>
	            </td>
			</tr>            
	        <tr>
				<td>Birthday:</td>
				<td><cfmodule template="/controls/date_picker.cfm" ctlname="birthday" startdate="#birthday#"></td>
			</tr>
	        <tr>
	        	<td>ZIP Code:</td>
	            <td><strong style="color:red">This field will not be shown in your profile, however, if your privacy settings allow other users to search for you, it will be used to provide distance information between your location and the searching user's location.</strong><br /> <input type="text" name="zip_code" id="zip_code" value="#zip_code#" /></td>
			</tr> 
	        <tr>
	        	<td>Time Zone:</td>
	            <td>
	            	<cfparam name="tOffset" default="">
	                <cfset tOffset = wwReadConfig(URL.CalledByUser, "PF:TIMEZONE")>
	                <cfif tOffset EQ "WW_NOT_CONFIGURED">
	                	<cfset tOffset = 0>
					</cfif>
	                                    
	            	<select name="TimeZoneL" id="TimeZoneL" onchange="SetValue('tzOffset', GetValue('TimeZoneL'));">
	                	<option value="-1" <cfif tOffset EQ -1>selected</cfif>>(GMT -08:00) Pacific Time (US &amp; Canada)</option>
	                    <option value="0" <cfif tOffset EQ 0>selected</cfif>>(GMT -07:00) Mountain Time (US &amp; Canada)</option>
	                    <option value="1" <cfif tOffset EQ 1>selected</cfif>>(GMT -06:00) Central Time (US &amp; Canada)</option>
	                    <option value="2" <cfif tOffset EQ 2>selected</cfif>>(GMT -05:00) Eastern Time (US &amp; Canada)</option>
	                    <option value="3" <cfif tOffset EQ 3>selected</cfif>>(GMT -04:00) Atlantic Time (Canada)</option>
					</select>
	                
	                <input type="hidden" name="tzOffset" id="tzOffset" value="#tOffset#" />
				</td>
			</tr>                                                             
	        <tr>
	        	<td colspan="2" align="left">
	            	<input type="button" class="normalButton" name="submit" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('updateBasic'), '/socialnet/components/profile_manager/basic_information_sub.cfm', 'userActionTarget');" />
	            </td>
			</tr>
	   
	    </table>
	</form>
	</cfoutput>
	<div id="userActionTarget"></div>
<cfelse>	<!--- read only --->

</cfif>

