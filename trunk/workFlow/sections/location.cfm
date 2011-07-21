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
		
		<strong class="OH_HEADER">Location Information</strong>
		
        <span id="locStat"><strong>No changes made since last save.</strong></span>
           
        
        <div style="height:auto; overflow:hidden; margin-top:10px;">
        <div class="cellLabel">Street Address:</div>
        <div class="cellC">
			<input name="address" <cfif canEdit EQ 0>readonly</cfif> id="address" type="text" value="#projectInfo.address#"    onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>  
		</div>            
		<div class="cellLabel">City:</div>
        <div class="cellC">
        	<input name="city" <cfif canEdit EQ 0>readonly</cfif> id="city" type="text" value="#projectInfo.city#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>
		</div>
        <div class="cellLabel">State:</div>
        <div class="cellC">
        	<input name="state" <cfif canEdit EQ 0>readonly</cfif> id="state" type="text" value="#projectInfo.state#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>
		</div>
        <div class="cellLabel">ZIP:</div>
        <div class="cellC">
        	<input name="zip" <cfif canEdit EQ 0>readonly</cfif> id="zip" type="text" value="#projectInfo.zip#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>
			<cfif canEdit>
				<br><a class="button" href="##" onclick="calcLatLng();"><span>Calculate Lat/Lng</span></a> 
			</cfif>
		</div>
        <div class="cellLabel">Latitude:</div>
        <div class="cellC">
        	<input name="latitude" <cfif canEdit EQ 0>readonly</cfif> id="latitude" type="text" value="#projectInfo.latitude#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
		</div>
        <div class="cellLabel">Longitude:</div>
        <div class="cellC">
        	<input name="longitude" <cfif canEdit EQ 0>readonly</cfif> id="longitude" type="text" value="#projectInfo.longitude#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
		</div>
        <div class="cellLabel">Subdivision:</div>
        <div class="cellC">
        	<input name="sdf" readonly id="sdf" type="text" value="#gSub.name#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
        	<input name="subdivision" readonly id="subdivision" type="hidden" value="#gSub.id#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
		</div><br />
        <div class="cellLabel">Lot:</div>
        <div class="cellC">
        	<input name="lot" <cfif canEdit EQ 0>readonly</cfif> id="lot" type="text" value="#projectInfo.lot#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
        </div>
		<div class="cellLabel">Block:</div>
        <div class="cellC">
			<input name="block" <cfif canEdit EQ 0>readonly</cfif> id="block" type="text" value="#projectInfo.block#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
			<cfif canEdit>
				<br><a class="button" href="##" onclick="loadTRS();"><span>Get Sec/Twn/Range</span></a>
			</cfif>
		</div>
        
		<div class="cellLabel">Section:</div>
        <div class="cellC">
        	<input name="section" <cfif canEdit EQ 0>readonly</cfif> id="section" type="text" value="#projectInfo.section#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
		</div>            
		<div class="cellLabel">Township:</div>
        <div class="cellC">
        	<input name="township" <cfif canEdit EQ 0>readonly</cfif> id="township" type="text" value="#projectInfo.township#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
		</div>            
		<div class="cellLabel">Range:</div>
        <div class="cellC">
        	<input name="range" <cfif canEdit EQ 0>readonly</cfif> id="range" type="text"  value="#projectInfo.range#" onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
            
    	</div>
		</div>
		<cfif canEdit>
	        <div style="width:100%; height:40px;">
		    <div style="padding:8px;">
	        <a class="button" href="##" onclick="updateLocationInfo('locStat', #attributes.r_pk#, GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'), GetValue('latitude'), GetValue('longitude'), GetValue('subdivision'), GetValue('lot'), GetValue('block'), GetValue('section'), GetValue('township'), GetValue('range'));">
            <span>Save Changes</span>				
            </a>
			</div>
			</div>
        </cfif>
	</cfoutput>
		