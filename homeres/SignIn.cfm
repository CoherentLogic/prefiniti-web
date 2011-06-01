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
	<center>
	<div align="center" style="width:450px; height:310px; padding:20px; background-color:white; color:black; border:1px solid black; margin-top:60px;">
    <h1><img src="/graphics/prefiniti.png" /></h1>
    <p><strong>Prefiniti</strong><br />Version 1.6</p>
    
    <!--- <div style="border:1px solid red; padding:20px; margin-top:20px; font-size:10px; font-weight:normal;">
    <p style="color:red;">Please note that Prefiniti 1.5 is supported only for the Land Survey and Medical industries. If you are looking for Prefiniti's social networking and online shopping service, you will need to use <a href="http://www.prefiniti.com/FindServer.cfm" style="color:blue; font-size:10px; font-weight:normal;">Prefiniti 2.0</a></p><p>No new accounts are being created on Prefiniti 1.5 at this time.</p>
    
    </div> --->
    
    <cfmodule template="/authentication/components/NewLogin.cfm" siteid="1" width="100%" BrowserType="#session.browserType#">
	</div>
    </center>
	
	<cflocation url="SignIn/SignIn.cfm" addtoken="no">