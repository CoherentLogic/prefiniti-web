<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="gusr" datasource="webwarecl">
	SELECT * FROM users WHERE id=#attributes.id#
</cfquery>

<cfset rt = CreateObject("component", "Res")>
<cfoutput query="gusr">
		<cfset rtype = "User Account">
		<cfset rowner = id>
		<cfset rsite = 5>
		<cfset rname = username>
		<cfset redit = 'javascript:editUser(#id#,"basic_information.cfm")'>
		<cfset rview = 'javascript:viewProfile(#id#)'>
		<cfset rdel = "javascript:ORMSNoAction();">
		<cfset rthumb = "#getPicture(id)#">
		<cfset rpk = id>
		
		<cfswitch expression="#account_enabled#">
			<cfcase value="0">
				<cfset rstat = "Disabled">
			</cfcase>
			<cfcase value="1">
				<cfset rstat = "Active">
			</cfcase>
			<cfdefaultcase>
				<cfset rstat = "Corrupted">
			</cfdefaultcase>
		</cfswitch>
		
		<cfset rpar = "NONE">												
		
		<cfset rt.Crup(rtype, rowner, rsite, rname, redit, rview, rdel, rthumb, rpk, rstat, rpar)>	
		<cfset rt.AddPair("Person/Name/First", firstName)>
		<cfset rt.AddPair("Person/Name/Last", lastName)>
		<cfset rt.AddPair("Person/Name/Middle", middleInitial)>
		<cfset rt.AddPair("Person/Name/Preferred", longName)>
		<cfset rt.AddPair("Person/Location/ZipCode", zip_code)>
		<cfset rt.AddPair("Person/Account/EMail", email)>
		<cfset rt.AddPair("Person/Location/SMSNumber", smsNumber)>
		<cfset rt.AddPair("Person/Gender", gender)>
		<cfset rt.AddPair("Person/Location/Phone", phone)>
		
</cfoutput>