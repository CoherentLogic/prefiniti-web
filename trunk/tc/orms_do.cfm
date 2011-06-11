<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="gtc" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#attributes.id#
</cfquery>

<cfset rt = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfoutput query="gtc">
		<cfset rtype = "Time Card">
		<cfset rowner = emp_id>
		<cfset rsite = site_id>
		<cfset rname = DateFormat(date, "mm/dd/yyyy") & " - " & JobDescription>
		<cfset redit = 'javascript:AjaxLoadPageToDiv("tcTarget","/tc/edit_ts.cfm?id=#id#")'>
		<cfset rview = redit>
		<cfset rdel = "javascript:ORMSNoAction();">
		<cfset rthumb = "/graphics/timesheet.png">
		<cfset rpk = id>
		
		<cfswitch expression="#closed#">
			<cfcase value="0">
				<cfset rstat = "Open">
			</cfcase>
			<cfcase value="1">
				<cfset rstat = "Signed">
			</cfcase>
			<cfcase value="2">
				<cfset rstat = "Approved">
				
				<cfif billed EQ 1>
					<cfset rstat = rstat & "/Billed">
				</cfif>
				
				<cfif paid EQ 1>
					<cfset rstat = rstat & "/Paid">
				</cfif>
			</cfcase>
		</cfswitch>
		<cfset rpar = "NONE">												
		
		<cfset rt.Crup(rtype, rowner, rsite, rname, redit, rview, rdel, rthumb, rpk, rstat, rpar)>	
		
</cfoutput>