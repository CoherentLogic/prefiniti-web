// JavaScript Document

function dp_copy(dp_id)
{
	var monthCtl;
	var dayCtl; 
	var yearCtl;
	
	var tgtCtl;
	
	var dateStr;
	
	monthCtl = dp_id + '_month';
	dayCtl = dp_id + '_day';
	yearCtl = dp_id + '_year';
	
	//alert(monthCtl);
	
	dateStr = GetValue(yearCtl) + '/' + GetValue(monthCtl) + '/' + GetValue(dayCtl);

//	alert(dateStr);

	SetValue(dp_id, dateStr);
	
	
}