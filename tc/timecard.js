/*
 * $Id$
 *
 * Copyright (C) 2011 John Willis
 *
 * This file is part of Prefiniti.
 *
 * Prefiniti is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Prefiniti is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
 
function loadTimesheetView(target, emp_id, startDate, endDate, filter, admin, jobNum)
{
	
	
	var url;
	
	url = '/tc/listByUser.cfm?emp_id=' + emp_id + "&startDate=" + startDate + "&endDate=" + endDate + "&filter=" + filter + "&admin=" + admin + '&jobNum=' + jobNum;
	
	AjaxLoadPageToDiv(target, url);
}

function loadTimesheetPrint(target, emp_id, startDate, endDate, filter, admin, jobNum)
{
	var url;
	
	url = '/forms/docViewer.cfm?pageTarget=';
	
	url += escape("/tc/components/printView.cfm?emp_id=" + emp_id + "&startDate=" + startDate + "&endDate=" + endDate + "&filter=" + filter + "&admin=" + admin  + '&jobNum=' + jobNum + '&current_association=' + glob_current_association + '&current_site_id=' + glob_current_site_id);
	
	
	window.open(url,"printView","width=800,height=800,toolbar=0,menubar=1");
}

function openTS(tsID, sCtl)
{
	url = '/tc/edit_ts.cfm?id=' + tsID;
	AjaxLoadPageToDiv(sCtl, url);
}

function signTimesheet(id) 
{
	
	var responseCB = function () {
		openTS(id, 'tcTarget');
	};
	
	AjaxSubmitForm(AjaxGetElementReference('signTS'), '/tc/sign_sub.cfm', 'tcTarget', responseCB);
	
	
}

function editTimesheetHeader(id, date, clsJobNumber, JobDescription, startTime)
{
	var url;
	url = '/tc/editHeaderSub.cfm?id=' + id + '&date=' + date + '&clsJobNumber=' + clsJobNumber;
	url += '&JobDescription=' + JobDescription + '&startTime=' + startTime;
	
	var responseCB = function () {
		openTS(id, 'tcTarget');
	};
	
	AjaxLoadPageToDiv('userActionTarget', url, responseCB);
	
}

function loadWeekToCtls(startCtl, endCtl)
{
	AjaxLoadPageToValueCtl(startCtl, "/tc/components/firstDayOfWeek.cfm");	
	AjaxLoadPageToValueCtl(endCtl, "/tc/components/lastDayOfWeek.cfm");
}

function approveTimesheet(tsID, sCtl)
{
	url = '/tc/components/approveTC.cfm?id=' + tsID;
	
	AjaxLoadPageToDiv(sCtl, url);
}

function reverseTimesheet(tsID, sCtl)
{
	url = '/tc/components/reverseTC.cfm?id=' + tsID;
	
	AjaxLoadPageToDiv(sCtl, url);
}


function addTwoFields(firstCtl, secondCtl, targetCtl) 
{
		document.getElementById(targetCtl).value = AjaxGetElementReference(firstCtl).value + AjaxGetElementReference(secondCtl).value;
}
	
function subtractTwoFields(firstCtl, secondCtl, targetCtl) 
{
		var res = parseInt(AjaxGetElementReference(secondCtl).value) - parseInt(AjaxGetElementReference(firstCtl).value)
		document.getElementById(targetCtl).value = res;
}

function deleteTimesheetConfirm(tsID, sCtl)
{
	url = '/tc/components/deleteTC.cfm?id=' + tsID;
	url += '&PWindowClientArea=' + escape(sCtl);
	
	AjaxLoadPageToDiv(sCtl, url);
}

function deleteTimesheetSub(tsID, sCtl)
{
	url = '/tc/components/deleteTCSub.cfm?id=' + tsID;
	
	AjaxLoadPageToDiv(sCtl, url);
}

function addLineItem(timecard_id, taskCodeID, project_number, description, hours, odStart, odEnd, mileage)
{
	var url;
	url = "/tc/addEntry_sub.cfm?timecard_id=" + escape(timecard_id);
	url += "&taskCodeID=" + escape(taskCodeID);
	url += "&description=" + escape(description);
	url += "&project_number=" + escape(project_number);
	url += "&hours=" + escape(hours);
	url += "&odStart=" + escape(odStart);
	url += "&odEnd=" + escape(odEnd);
	url += "&mileage=" + escape(mileage);
	
	var responseCB = function () {
		openTS(timecard_id, 'tcTarget');
	};
	
	AjaxLoadPageToDiv('userActionTarget', url, responseCB);
}

function editLineItem(timecard_id, lineitem_id, project_number, taskCodeID, description, hours, odStart, odEnd, mileage)
{
	var url;
	url = "/tc/editLineItemSub.cfm?id=" + escape(lineitem_id);
	url += "&taskCodeID=" + escape(taskCodeID);
	url += "&description=" + escape(description);
	url += "&project_number=" + escape(project_number)
	url += "&hours=" + escape(hours);
	url += "&odStart=" + escape(odStart);
	url += "&odEnd=" + escape(odEnd);
	url += "&mileage=" + escape(mileage);
	url += "&timecard_id=" + escape(timecard_id);
	
	var responseCB = function () {
		openTS(timecard_id, 'tcTarget');
	};
	
	AjaxLoadPageToDiv('userActionTarget', url, responseCB);
}

function deleteLineItem(timecard_id, line_item_id)
{
	var url = "/tc/deleteLineItem.cfm?id=" + escape(line_item_id);
	
	var responseCB = function () {
		openTS(timecard_id, 'tcTarget');
	};
	
	AjaxLoadPageToDiv('userActionTarget', url, responseCB);
}

function createTimesheet(clientArea, emp_id, date, JobNumSel, JobDescription, startTime, submitID)
{
	var url;
	url = "/tc/newts_sub.cfm?emp_id=" + escape(emp_id);
	url += "&date=" + escape(date);
	url += "&JobNumSel=" + escape(JobNumSel);
	
	url += "&JobDescription=" + escape(JobDescription);
	url += "&startTime=" + escape(startTime);
	url += "&submitID=" + escape(submitID);
	
	
	AjaxLoadPageToDiv(clientArea, url);
}

function getTotalHours(highest)
{
	var curDiv = "";
	var cDivName = "";
	var totHours = 0;
	
	for(curDiv = 1; curDiv <= highest; curDiv++) {
		cDivName = 'hrs_' + curDiv.toString();
		totHours += parseFloat(GetInnerHTML(cDivName));
	}
	SetInnerHTML('totalHours', '<strong>' + totHours.toString() + '</strong>');
	return totHours.toString();
}

function AddMileage()
{
	document.getElementById(mileage).value = document.getElementById(odStart).value + document.getElementById(odEnd).value;
}

function tcSetBilled(id, value, billed_date)
{
	var url;
	url = '/tc/components/set_billed.cfm?id=' + escape(id);
	url += '&value=' + escape(value);
	url += '&billed_date=' + escape(billed_date);
	
	AjaxNullRequest(url);
}

function tcSetPaid(id, value, paid_date, check_number)
{
	var url;
	url = '/tc/components/set_paid.cfm?id=' + escape(id);
	url += '&value=' + escape(value);
	url += '&paid_date=' + escape(paid_date);
	url += '&check_number=' + escape(check_number);
	
	AjaxNullRequest(url);
}

function iif_export_options(id)
{
	var url;
	url = "/tc/iif_export_options.cfm?id=" + escape(id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function iif_export(id, companyName, companyCreateTime, QBVer, QBRel)
{
	var url;
	url = "/tc/iif_export.cfm?id=" + escape(id) + "&companyName=" + escape(companyName) + "&companyCreateTime=" + escape(companyCreateTime);
	url += "&QBVer=" + escape(QBVer) + "&QBRel=" + escape(QBRel);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function TCCreateTimesheet()
{
	var onLoadEventHandler = function () {
		
		AjaxLoadPageToDiv('timesheet_creator_form', '/tc/creator/timecard_ready.cfm');		
	}
	
	AjaxSubmitForm(AjaxGetElementReference('create_timesheet'), '/tc/creator/submit_timecard.cfm', 'create_timesheet_buttons', onLoadEventHandler);
		
}