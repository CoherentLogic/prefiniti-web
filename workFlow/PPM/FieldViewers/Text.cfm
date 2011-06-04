<!---
	ATTRIBUTES:
	
	Context			PPM Context
	Selector		Context Selector
	Field			Target Field
	Label			Field Label
--->

<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="fieldValue" default="">

<cfparam name="ctx" default="">
<cfset ctx = createObject("component", "workFlow.PPM.ppm_context")>
<cfset ctx.Open(attributes.Context, attributes.Selector, session.user_id)>
<cfset fieldValue = ctx.GetField(attributes.Field)>

<cfparam name="ctx_field_history" default="">
<cfset ctx_field_history = ctx.GetLogEntries(attributes.Field)>

<cfparam name="history_line" default="">

<cfif ctx_field_history.RecordCount GT 0>
	<cfoutput query="ctx_field_history" maxrows="1">
        <cfset history_line = getLongname(user_id) & " modified this field on " & dateFormat(change_date, "mm/dd/yyyy") & " at " & timeFormat(change_date, "h:mm tt") & ".">
    </cfoutput>   
<cfelse>
	<cfset history_line = "">
</cfif>         

<cfoutput>
	<cfparam name="row_id" default="">
    <cfset row_id="_PPM_FIELD_#attributes.Context#_#attributes.Selector#_#attributes.Field#">
    
	<div class="_PPM_FIELD_ROW" id="#row_id#" onmouseover="ppm_field_row_mouseover('#row_id#');" onmouseout="ppm_field_row_mouseout('#row_id#');">
		<table width="100%" cellpadding="0" cellspacing="0">
        <tr>
        <td width="10%" align="center" valign="middle">
        <div id="#row_id#_toolIcons" style="font-size:10px; font-weight:normal; display:none;">
        	<img src="/graphics/page_white_edit.png" align="absmiddle" onclick="ppm_edit_field('#row_id#');">
        </div>&nbsp;
        </td>
        <td width="20%" valign="middle">
        #attributes.Label#
        
        </td>
        <td width="70%" valign="middle">
        
        	<span id="#row_id#_static_value">#fieldValue#</span><br />
            
            
            <div class="_PPM_FIELD_TOOLS" id="#row_id#_tools" style="display:none;">
            	
                <cfform name="#row_id#_form">
                	
                    <cfinput type="hidden" name="#row_id#_Context" value="#attributes.Context#" />
                    <cfinput type="hidden" name="#row_id#_Selector" value="#attributes.Selector#" />
                    <cfinput type="hidden" name="#row_id#_Field" value="#attributes.Field#" />
                    
                    
                	<cfinput name="#row_id#_edit" value="#fieldValue#" />
               
                <input type="button" id="#row_id#_apply" value="Apply" onclick="ppm_text_field_apply('#row_id#');"/>
                <input type="button" id="#row_id#_revert" value="Revert" onclick="ppm_text_field_revert('#row_id#');"/>
                <input type="button" id="#row_id#_changelog" value="Edit History" onclick="ppm_edit_history('#row_id#');" />
                <input type="button" id="#row_id#_cancel" value="Cancel" onclick="document.getElementById('#row_id#_tools').style.display='none'; document.getElementById('#row_id#_static_value').style.display='inline';" />
                <input type="hidden" id="#row_id#_revert_value" value="#fieldValue#" />
                
               	 </cfform> 
                <div id="#row_id#_history" style="font-size:8px; font-style:italic; padding:2px;">#history_line#</div>
            </div>    
            
        
        </td>
        </tr>
        </table>       
	</div>
</cfoutput>  