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
	
	<cfif orec.CanWrite(URL.CalledByUser)>
		<cfset canEdit = 1>
	<cfelse>
		<cfset canEdit = 0>
	</cfif>
	
	<cfoutput>
	<strong class="OH_HEADER">Filing Information</strong>
    
		
        <span id="filingStat"><strong>No changes made since last save.</strong></span>
    
   		<div style="height:auto; overflow:hidden; margin-top:10px;">
        <div class="cellLabel">                        
			<p style="margin-top:0px;">
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="SubdivisionOrDeed" value="Subdivision" <cfif #projectInfo.SubdivisionOrDeed# EQ "Subdivision">checked</cfif> onclick="invalidateSection('filingStat');"/>Subdivision
				</label>
				<br />
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="SubdivisionOrDeed" value="Deed" <cfif #projectInfo.SubdivisionOrDeed# EQ "Deed">checked</cfif> onclick="invalidateSection('filingStat');"/>Deed
                </label>
				<br />
			</p>
			<p>
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Plat" <cfif #projectInfo.FilingType# EQ "Plat">checked</cfif> onclick="invalidateSection('filingStat');"/>
Plat
				</label>
				<br />
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Cabinet"  			
						<cfif #projectInfo.FilingType# EQ "Cabinet">checked</cfif> onclick="invalidateSection('filingStat');"/>Cabinet
				</label>
				<br />
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Book"  <cfif #projectInfo.FilingType# EQ "Book">checked</cfif> onclick="invalidateSection('filingStat');"/>Book
				</label>
				<br />
			</p>          
        </div>
        <div class="cellC" style="clear:right;">
            <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="PlatCabinetBook" name="PlatCabinetBook" value="#projectInfo.PlatCabinetBook#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
        </div>
    
        <div class="cellLabel">
        <p><label>
                                  <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="PageOrSlide" value="Page" <cfif #projectInfo.PageOrSlide# EQ "Page">checked</cfif> onclick="invalidateSection('filingStat');"/>
                                  Page</label>
                                <br />
                                <label>
                                  <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="PageOrSlide" value="Slide" <cfif #projectInfo.PageOrSlide# EQ "Slide">checked</cfif> onclick="invalidateSection('filingStat');"/>
                                  Slide</label>
                                <br />
                                </p>
        </div>
        <div class="cellC">                            
            <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="PageSlide" name="PageSlide" value="#projectInfo.PageSlide#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
        </div>
   
    <div class="cellLabel" style="clear:left;">Reception or Document Number:</div>
    <div class="cellC">
		<input type="text" <cfif canEdit EQ 0>readonly</cfif> id="ReceptionNumber" name="ReceptionNumber"  value="#projectInfo.ReceptionNumber#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
	</div>
    <div class="cellLabel">Filing Date:</div>
    <div class="cellC">
		<input type="text" <cfif canEdit EQ 0>readonly</cfif> id="FilingDate" name="FilingDate"  value="#DateFormat(projectInfo.FilingDate, 'mm/dd/yyyy')#"  onkeyup="invalidateSection('filingStat');" class="inputText"/> <a href="javascript:popupDate(AjaxGetElementReference('FilingDate'));"><img src="graphics/date.png" border="0" /></a>
	</div>
    <div class="cellLabel">Certified To:</div>
    <div class="cellC">
    	<input type="text" <cfif canEdit EQ 0>readonly</cfif> id="CertifiedTo" name="CertifiedTo"  value="#projectInfo.CertifiedTo#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
	</div>        
   </div>
	
	<cfif canEdit>
		<div style="width:100%; height:40px;">
	    <div style="padding:8px;">
    		<a class="button" href="##" onclick="updateFilingInfo('filingStat', #attributes.r_pk#, AjaxGetCheckedValue('SubdivisionOrDeed'), AjaxGetCheckedValue('FilingType'), GetValue('PlatCabinetBook'), AjaxGetCheckedValue('PageOrSlide'), GetValue('PageSlide'), GetValue('ReceptionNumber'), GetValue('FilingDate'), GetValue('CertifiedTo'));">
        	<span>Save Changes</span></a>
		</div>
		</div>
    </cfif> 
	
</cfoutput>