<cfinclude template="/notifications/notification_udf.cfm">

<cfquery name="wwm_n" datasource="webwarecl">
	SELECT * FROM notification_entries 
    WHERE 	user_id=#attributes.user_id# 
    AND 	notification_id=#attributes.event_id#
    AND		method=0
</cfquery>

<cfquery name="email_n" datasource="webwarecl">
	SELECT * FROM notification_entries 
    WHERE 	user_id=#attributes.user_id# 
    AND 	notification_id=#attributes.event_id#
    AND		method=1
</cfquery>

<cfquery name="sms_n" datasource="webwarecl">
	SELECT * FROM notification_entries 
    WHERE 	user_id=#attributes.user_id# 
    AND 	notification_id=#attributes.event_id#
    AND		method=2
</cfquery>    

<cfparam name="sms" default="">
<cfparam name="wwm" default="">
<cfparam name="email" default="">

<cfif wwm_n.RecordCount EQ 0>
	<cfset wwm=false>
<cfelse>
	<cfset wwm=true>
</cfif>  

<cfif email_n.RecordCount EQ 0>
	<cfset email=false>
<cfelse>
	<cfset email=true>
</cfif>  

<cfif sms_n.RecordCount EQ 0>
	<cfset sms=false>
<cfelse>
	<cfset sms=true>
</cfif>       
<!---function ntSetNotify(user_id, event_id, method, value)--->
<cfoutput>
	<label><input type="checkbox" name="wwm_#attributes.event_id#" id="wwm_#attributes.event_id#" <cfif wwm>checked</cfif>  onclick="ntSetNotify(#attributes.user_id#, #attributes.event_id#, 0, IsChecked('wwm_#attributes.event_id#'));"/>Prefiniti Mail</label><br />
    <label><input type="checkbox" name="email_#attributes.event_id#" id="email_#attributes.event_id#" <cfif email>checked</cfif> onclick="ntSetNotify(#attributes.user_id#, #attributes.event_id#, 1, IsChecked('email_#attributes.event_id#'));"/>E-Mail</label><br />
    <label><input type="checkbox" name="sms_#attributes.event_id#" id="sms_#attributes.event_id#" <cfif sms>checked</cfif> onclick="ntSetNotify(#attributes.user_id#, #attributes.event_id#, 2, IsChecked('sms_#attributes.event_id#'));"/>SMS Text Message</label>
</cfoutput>
