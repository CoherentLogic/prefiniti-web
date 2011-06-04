<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="ctx" default="">

<cfparam name="info_array" default="">
<cfset info_array = arrayNew(1)>
<cfset info_array = listToArray(url.id,"_",false)>

<cfset ctx = createObject("component", "workFlow.PPM.ppm_context")>

<cfparam name="ctx_name" default="">
<cfparam name="ctx_selector" default="">
<cfparam name="ctx_field" default="">
<cfparam name="val_field" default="">
<cfparam name="field_val" default="">

<cfset val_field = "form.#url.id#_edit">
<cfset field_val = Evaluate(val_field)>

<cfset ctx_name = info_array[3]>
<cfset ctx_selector = info_array[4]>
<cfset ctx_field = info_array[5]>

<cfset ctx.Open(ctx_name, ctx_selector, session.user_id)>


<cfset ctx.SetField(ctx_field, field_val)>

<cfparam name="ctx_field_history" default="">
<cfset ctx_field_history = ctx.GetLogEntries(ctx_field)>

<cfparam name="history_line" default="">

<cfif ctx_field_history.RecordCount GT 0>
	<cfoutput query="ctx_field_history" maxrows="1">
        <cfset history_line = getLongname(user_id) & " modified this field on " & dateFormat(change_date, "mm/dd/yyyy") & " at " & timeFormat(change_date, "h:mm tt") & ".">
    </cfoutput>   
<cfelse>
	<cfset history_line = "">
</cfif> 

<cfoutput>#url.id#^#history_line#^#field_val#</cfoutput>
