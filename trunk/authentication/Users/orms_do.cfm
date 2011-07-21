<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="gusr" datasource="webwarecl">
	SELECT * FROM users WHERE id=#attributes.id#
</cfquery>

<cfquery name="gfr" datasource="webwarecl">
	SELECT * FROM friends WHERE source_id=#attributes.id#
</cfquery>    

<cfquery name="gmemb" datasource="sites">
	SELECT * FROM site_associations WHERE user_id=#attributes.id#
</cfquery>

<cfset usr = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(attributes.id)>


<cfset rt = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfoutput query="gusr">
		Update user account #id# ORMS record...<br />
		<cfset rtype = "User Account">
		<cfset rowner = id>
		<cfset rsite = 5>
		<cfset rname = longName>
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

<cfoutput query="gfr">
	
	<cfset targ = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(target_id)>
    Add friend relationship #targ.display_name#...<br />
	<cfset rt.Relate(targ.ObjectRecord().r_id, "Friend")>
	

</cfoutput>

<cfoutput query="gmemb">
	
	<cfset targ = CreateObject("component", "OpenHorizon.Identity.Site").OpenByPK(site_id)>
    Add site membership #site_id#/#assoc_type#/#id#...<br />
    <cfswitch expression="#assoc_type#">
    	<cfcase value="0">
        	<cfset t = "Customer">
        </cfcase>
        <cfcase value="1">
        	<cfset t = "Employee">
        </cfcase>
        <cfcase value="2">
        	<cfset t = "Friend">
        </cfcase>
        <cfdefaultcase>
        	<cfset t = "Unknown">
        </cfdefaultcase>
	</cfswitch>   
    
    <cfset rt.Relate(targ.ObjectRecord().r_id, t)>     
    
</cfoutput>