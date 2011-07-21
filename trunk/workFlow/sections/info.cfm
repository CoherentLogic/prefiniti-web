<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workflow/workflow_udf.cfm">

	<cfquery name="projectInfo" datasource="webwarecl">
	    SELECT * FROM projects WHERE id=#attributes.r_pk#
	</cfquery>
	
	<cfquery name="gSub" datasource="webwarecl">
		SELECT * FROM subdivisions WHERE id=#projectInfo.subdivision#
	</cfquery>    
	
	<cfquery name="gAU" datasource="sites">
		SELECT user_id FROM site_associations WHERE assoc_type=1 AND site_id=#URL.current_site_id#
	</cfquery>
	<cfset orec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
	<cfset orec.GetByTypeAndPK("Project", attributes.r_pk)>
	
	<cfif orec.CanWrite(session.user.r_pk)>
		<cfset canEdit = 1>
	<cfelse>
		<cfset canEdit = 0>
	</cfif>
	
<cfoutput>
	<strong class="OH_HEADER">Other Information</strong>
	       
    <span id="otherStat"><strong>No changes made since last save.</strong></span>
    <div style="height:auto; overflow:hidden; margin-top:10px;">
	    
        <div class="cellLabel">Special Instructions:</div>
        <div class="cellC">
			<textarea name="specialinstructions" cols="50" rows="8" class="inputText" id="specialinstructions" onkeyup="invalidateSection('otherStat');">#projectInfo.specialinstructions#</textarea>
		</div>
	</div>
	
	<cfif canEdit>
    	<div style="width:100%; height:40px;">
	    <div style="padding:8px;">	
		<a class="button" href="##" onclick="updateOtherInfo('otherStat', #attributes.r_pk#, GetValue('specialinstructions'));">
			<span>Save Changes</span>
    	</a>
		</div>
		</div>
    </cfif>
</cfoutput>