<cfset usr = CreateObject("component","Res").GetByTypeAndPK("User Account", attributes.r_pk)>

<cfinclude template="/authentication/authentication_udf.cfm">

<strong class="OH_HEADER">Locations</strong>

<cfif usr.CanWrite(URL.CalledByUser)>
	<cfparam name="u" default="">
	<cfset u=getUserLocations(#attributes.r_pk#)>
	
	
	        
		<cfoutput query="u">
	    	
	   		<form name="#id#_form" id="#id#_form">	
	        <input type="hidden" name="location_id" id="location_id" value="#id#" />
	        <div style="border:1px solid ##EFEFEF; margin-top:20px; padding:5px; background-color:##EFEFEF; width:300px; -moz-border-radius-topleft:5px; -moz-border-radius-topright:5px;">
	        
	        <input type="text" id="description" name="description" value="#description#" />
	        <label><input type="checkbox" name="public_location" id="public_location" <cfif #public_location# EQ 1>checked</cfif> />Show in profile</label>
			</div>
			<div style="border:1px solid ##EFEFEF; margin-bottom:20px; padding:0px;">
	    	<table width="550">
	        	
	            <tr>
	            	<td>Location Options:</td>
	                <td>
	                	<label><input type="checkbox" name="billing" id="billing" value="1" <cfif #billing# EQ 1>checked</cfif>>Use this location for billing</label>
	                </td>
				</tr>
	            <tr>
	            	<td></td>
	                <td>
	                	<label><input type="checkbox" name="mailing" id="mailing" value="1" <cfif #mailing# EQ 1>checked</cfif>>Use this location for mailing</label>
	                </td>
				</tr>                  
	            <tr>
	            	<td>Address:</td>
	                <td><input type="text" id="address" name="address" value="#address#" /></td>
	            </tr>
	            <tr>
	            	<td>City:</td>
	                <td><label><input type="text" id="city" name="city" value="#city#" maxchars="255"/></label><br />
	                <label>State: <input type="text" id="state" name="state" width="2" maxchars="2" value="#state#"/></label><br />
	                <label>ZIP: <input type="text" id="zip" name="zip" maxchars="11" value="#zip#" /></label>
	                </td>
	            </tr>   
	            <tr>	
	            	<td align="left"><div id="loc_#id#"></div></td>
	            	<td align="left">
	                	<input type="button" class="normalButton" name="submit_#id#" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('#id#_form'), '/socialnet/components/profile_manager/location_edit_sub.cfm', 'loc_#id#', function () { p_session.Framework.PostGlobalMessage(IWC_LOCATIONCHANGED, C_WINDOWMANAGER, null); });">
					</td>
				</tr>                
	
	                 
	            
			</table>                
	        </div>
	        </form>
	        
	    </cfoutput>
	    
	</div>
	
	<img src="/graphics/map_add.png" align="absmiddle"/> <strong><a href="javascript:showDiv('addLocDiv');">Add Location</a></strong>
	<div style="border:1px solid #EFEFEF; display:none;" id="addLocDiv">
		<form name="newLoc" id="newLoc">
	   
	<cfoutput>       <input type="hidden" name="user_id" id="user_id" value="#url.calledByUser#" /></cfoutput>
			<div style="border:1px solid ##EFEFEF; margin-bottom:20px; padding:0px;">
	    	<table width="550">
	        	<tr>
	            	<td>Description:</td>
					<td><input type="text" id="description" name="description"/>
	                </td>								            </tr>      
	            <tr>
	            	<td>Location Options:</td>
	                <td>
	                	<label><input type="checkbox" name="billing" id="billing" value="1">Use this location for billing</label>
	                </td>
				</tr>
	            <tr>
	            	<td></td>
	                <td>
	                	<label><input type="checkbox" name="mailing" id="mailing" value="1">Use this location for mailing</label>
	                </td>
				</tr>
	            <tr>
	            	<td></td>
	                <td><label><input type="checkbox" name="public_location" id="public_location" />Show in profile</label></td>				
	            </tr>                 
	            <tr>
	            	<td>Address:</td>
	                <td><input type="text" id="address" name="address"  />St, Ave, Ln, Rd, etc...</td>
	            </tr>
	            <tr>
	            	<td>City:</td>
	                <td><label><input type="text" id="city" name="city"  maxchars="255"/></label>
	                <label>State: <input type="text" id="state" name="state" width="2" maxchars="2" /></label>
	                <label>ZIP: <input type="text" id="zip" name="zip" maxchars="11"  /></label>
	                </td>
	            </tr>   
	            <tr>	
	            	<td align="left"><div id="addLoc"></div></td>
	            	<td align="right">
	                	<input type="button" class="normalButton" name="submit_#id#" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('newLoc'), '/socialnet/components/profile_manager/location_add_sub.cfm', 'addLoc', function () { p_session.Framework.PostGlobalMessage(IWC_LOCATIONCHANGED, C_WINDOWMANAGER, null); });">
					</td>
				</tr>                
	
	                 
	            
			</table>  
	        </div>             
	     
	        </form>
	        </div>
<cfelse>

</cfif>	       