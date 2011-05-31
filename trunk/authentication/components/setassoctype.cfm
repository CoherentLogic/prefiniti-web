<cfquery name="setassoctype" datasource="sites">
	UPDATE 	site_associations
    SET		assoc_type=#URL.assoc_type#
    WHERE	id=#URL.id#
</cfquery>    