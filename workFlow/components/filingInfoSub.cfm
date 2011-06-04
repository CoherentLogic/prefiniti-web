<!--function updateFilingInfo(statusDiv, project_id, SubdivisionOrDeed, FilingType, PlatCabinetBook,
						  PageOrSlide, PageSlide, ReceptionNumber, FilingDate, CertifiedTo)-->
<cfquery name="fiUpdate" datasource="webwarecl">
	UPDATE projects
	SET		SubdivisionOrDeed='#url.SubdivisionOrDeed#',
			FilingType='#url.FilingType#',
			PlatCabinetBook='#url.PlatCabinetBook#',
			PageOrSlide='#url.PageOrSlide#',
			PageSlide='#url.PageSlide#',
			ReceptionNumber='#url.ReceptionNumber#',
			FilingDate=#CreateODBCDateTime(url.FilingDate)#,
			CertifiedTo='#url.CertifiedTo#'
	WHERE	id=#url.id#
</cfquery>
Changes saved.

<cfmodule template="/workFlow/orms_do.cfm" id="#url.id#">