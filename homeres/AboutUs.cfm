<cfquery name="au" datasource="sites">
	SELECT about FROM sites WHERE SiteID=5
</cfquery>
    
<div class="mainArea" style="color:black;">
	<h1 style="color:#13284A;">About Us</h1>
	<p style="color:black; font-size:12px; padding:10px;"><cfoutput>#au.about#</cfoutput></p>
</div>