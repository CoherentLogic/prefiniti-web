<cfquery name="gSubMap" datasource="webwarecl">
	SELECT * FROM files WHERE fileType='MAP' AND subdivisionID=#attributes.id#
</cfquery>

<cfif gSubMap.RecordCount EQ 0>
	<cfoutput>
    	<img src="/graphics/map_go.png"> <a href="javascript:uploadSurveyMap(#attributes.id#);">Upload Survey Map</a>
	</cfoutput>
<cfelse>
	<cfoutput>
		<img src="/graphics/map.png"> <a href="javascript:viewFile('/datastore/projectfiles/#gSubMap.filePath#');">View Survey Map</a>
    </cfoutput>
</cfif>    
