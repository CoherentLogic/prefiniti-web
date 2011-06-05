<cfquery name="aas" datasource="sites">
	INSERT INTO site_associations
    	(user_id,
        site_id,
        assoc_type)
	VALUES
    	(#form.user_id#,
        #form.site_id#,
        #form.assoc_type#)
</cfquery>

<cflocation url="/webware_admin/getAssociations.cfm?site_id=#form.site_id#" addtoken="no">