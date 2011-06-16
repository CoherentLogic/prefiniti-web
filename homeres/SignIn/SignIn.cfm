<!---

$Id$

Copyright (C) 2011 John Willis
 
This file is part of Prefiniti.

Prefiniti is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Prefiniti is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.

--->

<table width="100%" cellpadding="0">
<tr>
<td align="left">
	<a href="/homeres/default.cfm">
    <img src="/graphics/prenew-small.png" style="padding-top:20px; border:none;" border="0" />
    </a>
</td>
<td align="right">
    <form name="login" id="login" method="post" action="/login-submit.cfm">
        <cfif IsDefined("URL.View") AND IsDefined("URL.Section")>
            <cfif url.View NEQ "">
                <input type="hidden" name="view" value="#url.View#">
            </cfif>
            <cfif url.Section NEQ "">
                <input type="hidden" name="section" value="#url.Section#">
            </cfif>
        </cfif>
        <table>
        <tr>
        <td>
        <label>Username<br /> <input type="text" name="login_username" /></label>
        </td>
        <td>
        <label>Password<br /> <input type="password" name="login_password"  /></label>
        </td>
        <td>
            <!--- <input type="submit" name="submit" id="submit" value="submit" style="visibility:hidden;display:none;" /> --->
            <a class="button" href="##" onclick="document.forms['login'].submit()"><span>Login</span></a>
        </tr>
        </table>
    </form>
    <cfif IsDefined("url.BadLogin")>
        <span class="form_error">Invalid username or password.</span>
    </cfif>
</td>
</tr>
</table>