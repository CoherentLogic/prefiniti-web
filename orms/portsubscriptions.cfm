<cfquery name="get_objects" datasource="webwarecl">
	SELECT id, r_owner FROM orms
</cfquery>

<cfoutput query="get_objects">
	Creating subscription for UID #r_owner# to OID #id#...<br />
	<cfquery name="create_sub" datasource="webwarecl">
    	INSERT INTO orms_subscriptions (target_uuid, user_id)
        VALUES ('#id#', #r_owner#)
    </cfquery>
</cfoutput>
    