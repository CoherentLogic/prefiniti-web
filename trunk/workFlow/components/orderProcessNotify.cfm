<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="c" datasource="webwarecl">
	SELECT * FROM Users WHERE id='#attributes.clientID#'
</cfquery>

<cfquery name="gProj" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#attributes.id#
</cfquery>



<cfoutput>
	#ntBusinessEventNotify("WF_ORDER_PROCESSED", url.current_site_id, 
    						"Order #gProj.clsJobNumber# has been processed.",
                            "")#
	#ntNotify(attributes.clientID, "WF_ORDER_PROCESSED", "Order #gProj.clsJobNumber# [#gProj.description#] has been processed.", "")#
    
    <cfif gProj.stage EQ 0>
    	#ntNotify(attributes.clientID, "WF_ORDER_REVERSED", "Order #gProj.clsJobNumber# [#gProj.description#] has been reversed. Explanation: #gProj.reverse_explanation#", "")#
        #ntBusinessEventNotify("WF_ORDER_REVERSED", url.current_site_id, "Order #gProj.clsJobNumber# has been reversed. Explanation: #gProj.reverse_explanation#", "")#
	</cfif>         
</cfoutput>
<!---<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">--->