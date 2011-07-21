<div style="height:100%;position:relative;">
	<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.orms_id)>
    <cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/locations.png" caption="Locate #orms_rec.r_type#">
    
    
    <div style="padding-left:30px; margin-top:20px; font-size:14px;">
    
    	<cfoutput>
    	<iframe frameborder="0" src="/orms/locate_object_iframe.cfm?orms_id=#url.orms_id#" width="550" height="230" name="set_location" id="set_location">
        
        </iframe>
        </cfoutput>
    
    </div>
    
    <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="locate_object_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Close</span></a>          
            <cfif orms_rec.IsOwner(session.user.r_pk)>  			
	            <a class="button" href="##" onclick="parent.frames['set_location'].document.forms['location_form'].submit();"><span><strong>Save</strong></span></a>
            </cfif>			            
		</div>
	</div>
</div>    

<!--- parent.frames['framename'].document.forms['formname'].submit();  --->