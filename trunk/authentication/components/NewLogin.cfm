<!---
	$Id$
--->

<style type="text/css">
	.loginTable {
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: x-small;
	
	margin:0px;
	padding:0px;
	}
	
	.loginTable td {
	padding-left: 5px;	
	padding-right: 5px;
	padding-bottom: 5px;
	padding-top:5px;
	}
	
</style>

<!---<cfquery name="ll" datasource="webwarecl">
	SELECT id FROM Users WHERE online=1
</cfquery>--->

<cfquery name="uc" datasource="webwarecl">
	SELECT count(id) AS ct FROM Users WHERE confirmed=1
</cfquery>

<cfquery name="SiteInfo" datasource="sites">
	SELECT * FROM Sites WHERE SiteID='#attributes.siteid#'
</cfquery>

<cfquery name="getStatus" datasource="webwarecl">
	SELECT * FROM config
</cfquery>

<cfif not IsDefined("cookie.wwcl_rememberMe")>
	<cfcookie name="wwcl_rememberMe" value="false">
</cfif>

<cfoutput>
	<cfform name="login" action="/login-submit.cfm">
		<cfif attributes.View NEQ "">
			<input type="hidden" name="view" value="#attributes.View#">
		</cfif>
		<cfif attributes.Section NEQ "">
			<input type="hidden" name="section" value="#attributes.Section#">
		</cfif>
		<cfif IsDefined("url.redir")>
			<input type="hidden" name="doRedirect" value="true" />
			<input type="hidden" name="redir" value="#url.redir#" />
			
		<cfelse>
		  	<input type="hidden" name="doRedirect" value="false" />
		</cfif>
		<input type="hidden" name="siteid" value="#attributes.siteid#">
        <div style="width:auto; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin-top:20px;">
	    <table class="loginTable" width="400" cellpadding="0" cellspacing="0" border="0" style=""> 		 
          <tr>
            <td>Username:</td>
            <td colspan="2" align="right"><input type="text" name="UserName" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_username#"</cfif>></td>
          </tr>
          <tr>
            <td>Password:</td>
            <td colspan="2" align="right"><input type="password" name="Password" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_password#"</cfif>><br /><input type="checkbox" name="rememberMe" <cfif #cookie.wwcl_rememberMe# EQ "true">checked</cfif>/>Remember me</td>
          </tr>
          <tr>
	        <td align="right" colspan="3" style="padding:0px;">
            	<!---<input type="button" onclick="javascript:location.replace('/appBase.cfm?contentBar=/authentication/components/register.cfm');" value="Sign Up for Prefiniti" class="normalButton" />--->
                <input type="submit" class="normalButton" name="Submit" value="Log In" style="font-weight:bold;" /></td>
          </tr>
        </table>
        </div>
	</cfform>
</cfoutput>