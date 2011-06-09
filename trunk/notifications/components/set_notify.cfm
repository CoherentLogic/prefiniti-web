<!---function ntSetNotify(user_id, event_id, method, value)--->

<!---<cfquery name="getNotify" datasource="webwarecl">
	SELECT * FROM notification_entries 
    WHERE 	user_id=#url.user_id# 
    AND 	notification_id=#url.event_id# 
    AND 	method=#url.method#
</cfquery>--->

<cfif url.value EQ "false">
	<cfquery name="dn" datasource="webwarecl">
    	DELETE FROM notification_entries
        WHERE	user_id=#url.user_id#
        AND		notification_id=#url.event_id#
        AND		method=#url.method#
	</cfquery>
<cfelse>
	<cfquery name="cn" datasource="webwarecl">
    	INSERT INTO notification_entries
        	(user_id,
            notification_id,
            method)
		VALUES
        	(#url.user_id#,
            #url.event_id#,
            #url.method#)
	</cfquery>
</cfif>                                           