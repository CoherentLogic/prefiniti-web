// JavaScript Document



function ppm_field_row_mouseover(id) 
{
	document.getElementById(id).setAttribute('class', '_PPM_FIELD_ROW_HOVER');
	document.getElementById(id + "_toolIcons").style.display = "inline";
}

function ppm_field_row_mouseout(id) 
{
	document.getElementById(id).setAttribute('class', '_PPM_FIELD_ROW');
	document.getElementById(id + "_toolIcons").style.display = "none";	
}

function ppm_edit_history(id)
{
	var field_info = id.split("_");
	var context = field_info[3];
	var selector = field_info[4];
	var field = field_info[5];
	
	var url = "/workFlow/PPM/components/EditHistory.cfm?context=" + escape(context);
	url += "&selector=" + escape(selector);
	url += "&field=" + escape(field);
	
	ColdFusion.Window.create(id + "_EditHistoryWindow", "Field Edit History", url, {modal:true,center:true,draggable:false,width:600,height:400,initshow:true});

	
}

function ppm_edit_field(id)
{
	tools_div = id + "_tools";
	edit_div = id + "_edit";
	static_field = id + "_static_value";
	
	document.getElementById(tools_div).style.display = "inline";
	document.getElementById(static_field).style.display = "none";
	document.getElementById(edit_div).focus();
	document.getElementById(edit_div).select();
	
}

function ppm_parse_response(text)
{
	var resp = text.split("^");
	
	var row_id = resp[0];
	var value = resp[2];
	var history = resp[1];
	
	
	var static_field = row_id + "_static_value";
	document.getElementById(static_field).style.display = "inline";
	document.getElementById(row_id + "_tools").style.display = "none";
	document.getElementById(static_field).innerHTML = value;
	document.getElementById(row_id + "_history").innerHTML = history;
	
}

function ppm_text_field_apply(id)
{
		
	
	edit_field = id + "_edit";
	static_field = id + "_static_value";
	tools_div = id + "_tools";
	
	edit_form = id + "_form";
	ColdFusion.Ajax.submitForm(edit_form, '/workFlow/PPM/FieldWriters/Text.cfm?id=' + id, ppm_parse_response);
	
	document.getElementById(static_field).innerHTML = document.getElementById(edit_field).value;
	document.getElementById(tools_div).style.display = "none";
}

function ppm_text_field_revert(id)
{
	edit_field = id + "_edit";
	revert_field = id + "_revert_value";
	
	document.getElementById(edit_field).value = document.getElementById(revert_field).value;
	document.getElementById(edit_field).select();
}