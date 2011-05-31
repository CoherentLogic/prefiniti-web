
	<center>
	<div align="center" style="width:450px; height:310px; padding:20px; background-color:white; color:black; border:1px solid black; margin-top:60px;">
    <h1><img src="/graphics/prefiniti.png" /></h1>
    <p><strong>Prefiniti</strong><br />Version 1.6</p>
    
    <!--- <div style="border:1px solid red; padding:20px; margin-top:20px; font-size:10px; font-weight:normal;">
    <p style="color:red;">Please note that Prefiniti 1.5 is supported only for the Land Survey and Medical industries. If you are looking for Prefiniti's social networking and online shopping service, you will need to use <a href="http://www.prefiniti.com/FindServer.cfm" style="color:blue; font-size:10px; font-weight:normal;">Prefiniti 2.0</a></p><p>No new accounts are being created on Prefiniti 1.5 at this time.</p>
    
    </div> --->
    
	<cfset view = "">
	<cfset section = "">
	
	<cfif IsDefined("URL.View")>
		<cfset view = URL.View>
	</cfif>
	<cfif IsDefined("URL.Section")>
		<cfset section = URL.Section>
	</cfif>
	
    <cfmodule template="/authentication/components/NewLogin.cfm" siteid="1" width="100%" BrowserType="#session.browserType#" View="#view#" Section="#section#">
	</div>
    </center>
	
</body>
</html>