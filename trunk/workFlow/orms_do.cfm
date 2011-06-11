<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workFlow/workflow_udf.cfm">

<cfquery name="gpr" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#attributes.id#
</cfquery>

<cfset rt = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfoutput query="gpr">
		<cfset rtype = "Project">
		<cfset rowner = clientID>
		<cfset rsite = site_id>
		<cfset rname = clsJobNumber>
		<cfset redit = 'javascript:loadProjectViewer(#id#);'>
		<cfset rview = redit>
		<cfset rdel = "javascript:ORMSNoAction();">
		<cfset rthumb = "/graphics/prefproject.png">
		<cfset rpk = id>
		<cfif status EQ 0>
			<cfset rstatus = "Incomplete">
		<cfelse>
			<cfset rstatus = "Complete">	
		</cfif>		
		<cfset rstatus = rstatus & "/" & SubStatus>
		
		<cfset rpar = "NONE">												
		
		<cfset rt.Crup(rtype, rowner, rsite, rname, redit, rview, rdel, rthumb, rpk, rstatus, rpar)>	
		<cftry>
		<cfscript>
			rt.AddPair("Project/Information/ProjectNumber", clsJobNumber);
			rt.AddPair("Project/Information/Description", description);
			rt.AddPair("Project/Client/Address", billing_address);						
			rt.AddPair("Project/Client/Name", getLongname(clientID));
			rt.AddPair("Project/Client/ProjectNumber", clientJobNumber);
			rt.AddPair("Project/Client/Company", billing_company);
			rt.AddPair("Project/Client/Location/Address", billing_address);
			rt.AddPair("Project/Client/Location/City", billing_city);
			rt.AddPair("Project/Client/Location/State", billing_state);
			rt.AddPair("Project/Client/Location/Zip", billing_zip);
			rt.AddPair("Project/Client/Location/Phone", billing_phone);
			rt.AddPair("Project/Client/Location/Fax", billing_fax);
			rt.AddPair("Project/Client/Location/EMail", billing_email);														
			rt.AddPair("Project/Location/Address", address);
			rt.AddPair("Project/Location/Section", section);
			rt.AddPair("Project/Location/Township", township);
			rt.AddPair("Project/Location/Range", range);
			rt.AddPair("Project/Location/Subdivision", SubdivisionNameByID(subdivision));
			rt.AddPair("Project/Location/Lot", lot);
			rt.AddPair("Project/Location/Block", block);
			rt.AddPair("Project/Location/Address", address);
			rt.AddPair("Project/Location/City", city);
			rt.AddPair("Project/Location/State", state);
			rt.AddPair("Project/Location/Zip", zip);
			rt.AddPair("Project/Location/Latitude", latitude);
			rt.AddPair("Project/Location/Longitude", longitude);
		</cfscript>
		<cfcatch>
		</cfcatch>
		</cftry>
</cfoutput>