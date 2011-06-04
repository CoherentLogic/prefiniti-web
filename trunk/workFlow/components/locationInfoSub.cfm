<cfquery name="liUpdate" datasource="webwarecl">
	UPDATE projects
	SET		address='#url.address#',
			city='#url.city#',
			state='#url.state#',
			zip='#url.zip#',
			latitude=#url.latitude#,
			longitude=#url.longitude#,
			subdivision='#url.subdivision#',
			lot='#url.lot#',
			block='#url.block#',
			section='#url.section#',
			township='#url.township#',
			range='#url.range#'
	WHERE	id=#url.id#
</cfquery>
<span style="clear:none;">Changes saved.</span>
<cfmodule template="/workFlow/orms_do.cfm" id="#url.id#">