<div style="height:100%;position:relative;">
	<cfquery name="get_mobiles" datasource="#session.framework.BaseDatasource#">
		SELECT * FROM mobile_devices WHERE owner=#session.user.r_pk#
	</cfquery>
	
	<cfset ob = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.target_uuid)>
	
	
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/mobile_device.png" caption="Link Mobile Device">
	
	<div style="padding-left:30px; margin-top:10px; font-size:14px;" id="link_mobile_form">
	
	<p style="font-size:12px; color:#2957a2;">This process will make the <cfoutput>#ob.r_name# #LCase(ob.r_type)#</cfoutput> take its live location from a mobile device.</p>
	
	<form name="link_mobile_device" id="link_mobile_device">
	<cfoutput>
	<input type="hidden" name="target_uuid" id="target_uuid" value="#url.target_uuid#">
	</cfoutput>
	<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">
	
    <tr>
		<td align="right" width="30%"><strong>Mobile Device</strong></td>
		<td align="left" width="70%">
        	<select name="mobile_device" id="mobile_device" size="1">
            	<cfoutput query="get_mobiles">
                	<option value="#om_uuid#">#phone_number#</option>                    
                </cfoutput>
			</select>                
        </td>
	</tr>
    
    
	</table>
	</form>
	
	</div>
	
	<div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="link_mobile_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Cancel</span></a>
			<a class="button" href="##" onclick="LinkMobileDevice();"><span><strong>Link Device</strong></span></a>
			
		</div>
	</div>
</div>
