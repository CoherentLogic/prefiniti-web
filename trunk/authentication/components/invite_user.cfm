<div id="iut" style="width:100%; height:300px; background-color:white;">		
<form name="invite_user" id="invite_user">
	<table width="100%" cellspacing="0">
    	<tr>
        	<td>First Name:</td>
            <td><input type="text" name="firstName" id="firstName" /></td>
        </tr>
        <tr>
        	<td>Last Name:</td>
            <td><input type="text" name="lastName" id="lastName" /></td>
        </tr>
        
		<tr>
            <td>Login Name:</td>
            <td>
                <input type="text" name="Tusername" id="Tusername" maxlength="45" onKeyPress="SetInnerHTML('availability', '');"/><strong style="color:red;">*</strong>
                <input type="button" name="checkAvailabilityx" id="checkAvailabilityx" class="normalButton" onClick="checkAvailability(GetValue('Tusername'));" value="Check Availability" /><br />
                <span id="availability"></span>					
            </td>
		</tr>
        <tr>
        	<td>Account Type:</td>
            <td>
            <p>
              <label>
                <input type="radio" name="assoc_type" value="0" id="assoc_type_0" checked/>
                Customer</label>
              <br />
              <label>
                <input type="radio" name="assoc_type" value="1" id="assoc_type_1" />
                Employee</label>
              <br />
            </p>            </td>
        <tr>
        	<td>E-Mail Address:</td>
            <td><input type="text" name="email" id="email" /></td>
        </tr>
        <tr>
        	<td>Gender:</td>
            <td>
           	  <p>
            	  <label>
            	    <input type="radio" name="gender" value="M" id="gender_0" checked>
            	    Male</label>
            	  <br>
            	  <label>
            	    <input type="radio" name="gender" value="F" id="gender_1">
            	    Female</label>
            	  <br>
          	  </p>            
        	</td>
		</tr>
        <tr>
        	<td>ZIP Code:</td>
            <td><input type="text" name="ZIP" id="ZIP" maxlength="11" /></td>
        </tr>
       	<tr>
        	<td colspan="2" align="right">
            <!---function AjaxSubmitForm(formRef, postTarget, targetDiv)--->
            	<input type="button" onClick="AjaxSubmitForm(AjaxGetElementReference('invite_user'), '/authentication/components/invite_user_submit.cfm', 'iut');" name="submit" value="Send Invitation" class="normalButton" />
			</td>
       	</tr>
	</table>                                         
</form>
</div>