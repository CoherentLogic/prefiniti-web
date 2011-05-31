<cfquery name="udSiteInfo" datasource="sites">
	UPDATE 		sites
    SET			slogan = '#URL.slogan#',
    			summary = '#URL.summary#',
                about = '#URL.about#',
                mission_statement = '#URL.mission_statement#',
                vision_statement = '#URL.vision_statement#',
                industry = #URL.industry#,
				salestax_rate = #URL.salestax_rate#
	WHERE		SiteID = #URL.SiteID#
</cfquery>
<font color="red">Site information updated.</font>    