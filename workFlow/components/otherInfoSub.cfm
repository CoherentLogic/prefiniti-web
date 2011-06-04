<!--function updateFilingInfo(statusDiv, project_id, SubdivisionOrDeed, FilingType, PlatCabinetBook,
						  PageOrSlide, PageSlide, ReceptionNumber, FilingDate, CertifiedTo)-->
<cfquery name="oiUpdate" datasource="webwarecl">
	UPDATE projects
	SET		specialinstructions='#url.specialinstructions#'
	WHERE	id=#url.id#
</cfquery>
Changes saved.

<cfmodule template="/workFlow/orms_do.cfm" id="#url.id#">