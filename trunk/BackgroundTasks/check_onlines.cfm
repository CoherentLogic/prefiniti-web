<cfquery name="co" datasource="webwarecl">
	SELECT user_id, last_event FROM auth_tokens
</cfquery>

<cfparam name="st" default="">

<cfoutput query="co">
	<cftry>
	<cfset st = DateDiff("h", co.last_event, Now())>
    #st#<br>
    <cfif st GE 2>
    	setting offline
    	<!--- <cfmodule template="/framework/components/set_offline.cfm" id="#id#"> --->
    </cfif>
    <cfcatch type="any">
    </cfcatch>
    </cftry>
</cfoutput>