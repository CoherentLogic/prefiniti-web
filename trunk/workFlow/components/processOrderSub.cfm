<cfinclude template="/contentmanager/cm_udf.cfm">



<cfquery name="updateP" datasource="webwarecl">
	UPDATE projects 
	SET		stage=#url.stage#,
			clsJobNumber='#url.clsJobNumber#',
			charge_type='#url.charge_type#',
            total_quoted_price=#url.total_quoted_price#
	WHERE id=#url.id#
</cfquery>

<cfif #url.stage# EQ 1>
	<cfquery name="setStatus" datasource="webwarecl">
		UPDATE projects 
		SET		SubStatus='Awarded'
		WHERE	id=#url.id#
	</cfquery>
<cfelse>
	<cfquery name="setReverseExplanation" datasource="webwarecl">
		UPDATE projects
		SET		reverse_explanation='#url.reverse_explanation#'
		WHERE	id=#url.id#
	</cfquery>
</cfif>


<cfif #url.publish# EQ "true">
	<cfquery name="as" datasource="webwarecl">
		INSERT INTO news_items (date, headline, body, site_id)
		VALUES		(#CreateODBCDateTime(Now())#,
					'New order placed',
					'#url.articleText#',
                    #url.current_site_id#)
	</cfquery>
</cfif>


<cfquery name="p" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.id#
</cfquery>
<cfmodule template="/workFlow/orms_do.cfm" id="#url.id#">

<cfmodule template="/workFlow/components/orderProcessNotify.cfm" id="#url.id#" clientID="#url.clientID#" clientJobNumber="#p.clientJobNumber#" status="#p.status#" subStatus="#p.subStatus#">

<cfoutput>
<table width="100%">
	<tr>
		<td align="center">
			<h2>Order Processed</h2>
			
			<p class="VPLink">
            	<a href="javascript:loadProjectViewer(#url.id#);">View project</a>
            </p>
            <cftry>
            <p><strong>Output from CMS:</strong> <cfoutput>#cmsCreateStagingArea(url.current_site_id, url.clsJobNumber)#</cfoutput></p>
            <cfcatch type="any">
            
            </cfcatch>
            </cftry>
		</td>
	</tr>
</table>
</cfoutput>


