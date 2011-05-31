<cfif url.value EQ true>
	<cfquery name="setTrue" datasource="sites">
    	INSERT INTO event_entries
        	(department_id,
            event_id,
            site_id)
		VALUES
        	(#url.department_id#,
            #url.event_id#,
            #url.site_id#)
	</cfquery>
    Event enabled.                        
<cfelse>
	<cfquery name="setFalse" datasource="sites">
    	DELETE FROM event_entries
        WHERE	department_id=#url.department_id#
        AND		event_id=#url.event_id#
        AND		site_id=#url.site_id#
	</cfquery>
    Event disabled.        

</cfif>