<div style="height:100%;position:relative;">
	<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.orms_id)>
    <cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/locations.png" caption="Live Location">
    
	<cfset devices = orms_rec.LinkedDevices()>
	
	<cfset initial_url="/orms/live_location_iframe.cfm?orms_id=" & orms_rec.r_id & "&device_id=" & devices[1].r_id>
	
    
    <div style="padding-left:30px; margin-top:5px; font-size:14px;">
    
		<label>Location Provider:
			<select name="loc_prov" id="loc_prov" <cfoutput>onchange="LoadLiveLocation('#orms_rec.r_id#')"</cfoutput>>
			<cfloop array="#devices#" index="device">
				<cfoutput>
					<option value="#device.r_id#">#device.r_name#</option>
				</cfoutput>
			</cfloop>
			</select>
		</label>	
    	<cfoutput>
    	<iframe frameborder="0" src="#initial_url#" width="580" height="230" name="live_location" id="live_location">
        	
        </iframe>
        </cfoutput>
    
    </div>
    
    <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="locate_object_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Close</span></a>          
            		            
		</div>
	</div>
</div>    
