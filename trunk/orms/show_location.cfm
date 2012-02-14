<div style="height:100%;position:relative;">
	
    <cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/locations.png" caption="Show Location">
    
	
	
	<cfset initial_url="/orms/show_location_iframe.cfm?location_id=" & url.location_id>
	
    
    <div style="padding-left:30px; margin-top:5px; font-size:14px;">
    
		
    	<cfoutput>
    	<iframe frameborder="0" src="#initial_url#" width="580" height="230" name="show_location" id="show_location">
        	
        </iframe>
        </cfoutput>
    
    </div>
    
    <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="locate_object_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Close</span></a>          
            		            
		</div>
	</div>
</div>    
