<cfquery name="gH" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#attributes.id#
</cfquery>

<table width="100%" cellspacing="0">
	<tr>
		<td>
			<strong>Status:</strong><br>
			<cfmodule template="/tc/components/tcStatus.cfm" id="#gH.id#">
		</td>
		<cfif #gH.closed# GT 0>
			<td>
				<strong>Initials:</strong><br />
				<cfoutput>#gH.initials#</cfoutput>
			</td>
		</cfif>
		<td>
			<strong>Start Time:</strong><br>
			<cfoutput>#TimeFormat(gH.startTime, "h:mm tt")#</cfoutput>
		</td>
		<td>
			<strong>Total Mileage:</strong><br>
			<cfmodule template="/tc/components/mileageByTS.cfm" timecard_id="#gH.id#">
		</td>
		<td>
			<strong>Total Hours:</strong><br>
			<cfmodule template="/tc/components/hoursByTS.cfm" timecard_id="#gH.id#">
		</td>
	</tr>
</table>