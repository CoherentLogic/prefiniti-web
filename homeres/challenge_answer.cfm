<!-- my_id, my_question, my_answer-->

<cfquery name="UserInfo" datasource="webwarecl">
	SELECT id, password_question, password_answer FROM Users WHERE id=#form.my_id#
</cfquery>

<div class="mainArea">
	<cfif LCase(UserInfo.password_answer) EQ LCase(form.my_answer)>
    	<h1>Reset Password</h1>
        <cfoutput>
        <form name="rsp" action="/homeres/set_password.cfm?my_id=#form.my_id#" method="post">
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
	<cfelse>
    	<h1>Invalid Answer</h1>
        
        <blockquote>
        	<a href="/homeres/SignIn.cfm">Return to Sign In page</a>
		</blockquote>            
	</cfif>                

</div>    