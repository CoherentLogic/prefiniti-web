<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="ctx" default="">
<cfset ctx = CreateObject("component", "workFlow.PPM.ppm_context")>
<cfset ctx.Open(URL.context, URL.selector, session.user_id)>

<cfparam name="eh" default="">
<cfset eh = ctx.GetLogEntries(URL.field)>

<cfoutput>
<strong>Edit History - #URL.context# #URL.selector#</strong><br><br>
</cfoutput>
<cfif eh.RecordCount GT 0>
<table width="550" cellpadding="0" cellspacing="0">
	
    <cfoutput query="eh">
		<tr>
        	<td>
            	<img src="#getPicture(user_id)#" width="48" height="48" align="absmiddle">
                #getLongname(user_id)#
			</td>
            <td>
            	#DateFormat(change_date, "mm/dd/yyyy")# #TimeFormat(change_date, "h:mm tt")#
			</td>
			<td>
            	#change_value#
            </td>
            <td>
            	<input type="button" value="Revert">
            </td>
        </tr>
	</cfoutput>
</table>            
<cfelse>
	<strong>No edit history for this field.</strong>
</cfif>                                                        