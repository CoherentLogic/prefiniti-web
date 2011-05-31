<div class="mainArea">
	<cfif form.new_password EQ form.new_password_confirm>
    	<cfquery name="rsp" datasource="webwarecl">
        	UPDATE users SET password='#Hash(form.new_password)#' WHERE id=#url.my_id#
		</cfquery>            
        <h1>Password Reset Successful</h1>
    
    	<blockquote><a href="/homeres/SignIn.cfm">Go to the Sign In page</a></blockquote>
    <cfelse>
        <h1>Passwords Do Not Match</h1>
        <p>Please try again.</p>
		<cfoutput>
        <form name="rsp" action="/homeres/set_password.cfm?my_id=#url.my_id#" method="post">
        <table>
        	<tr>
            	<td>Please enter your new password:</td>
                <td><input type="password" name="new_password" id="new_password" /></td>
            </tr>
			<tr>
           		<td>Enter your new password again for confirmation:</td>
            	<td><input type="password" name="new_password_confirm" id="new_password_confirm" /></td>
			</tr>
            <tr>
            	<td colspan="2">
					<input type="submit" name="submit" value="Reset Password" />
                </td>
			</tr>                   
		</table>                            
		</form>
        </cfoutput>
	</cfif>
</div>    		