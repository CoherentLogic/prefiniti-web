<cfquery name="ps" datasource="webwarecl">
	SELECT address, city, state, zip, clsJobNumber, jobtype, subdivision, lot, block, section, township, range, SubdivisionOrDeed, FilingType, PlatCabinetBook, PageOrSlide, PageSlide, specialinstructions FROM projects WHERE id=#attributes.id#
</cfquery>

<table width="100%" cellspacing="0" cellpadding="4">
	<cfoutput query="ps">
		<tr>
			<td style="padding-left:10px;">Project Type:</td>
			<td>#jobtype#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Filing Information:</td>
			<td>#SubdivisionOrDeed# #FilingType# #PlatCabinetBook#, #PageOrSlide# #PageSlide#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Legal Description:</td>
			<td>Section #section# of township #township#, range #range#</td>
		</tr>
		<tr>
			<td style="padding-left:10px;">Special Instructions:</td>
			<td>#specialinstructions#<br /><br /><img src="/graphics/map_go.png" align="absmiddle"> <a href="javascript:popupMap('Map to Project #clsJobNumber#', '#address# #city#, #state# #zip#', '#clsJobNumber#');">View Map</a></td>
		</tr>
	</cfoutput>
</table>

