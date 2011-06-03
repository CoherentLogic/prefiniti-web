// JavaScript Document

function editProjectNumber()
{
	showDiv('jobNumRW');
	hideDiv('jobNumRO');
}

function saveProjectNumber(project_id, newProjectNumber)
{
	var url;
	url = '/workFlow/components/projectNumberSub.cfm?id=' + project_id;
	url += '&clsJobNumber=' + escape(newProjectNumber);
	
	showDiv('jobNumRO');
	hideDiv('jobNumRW');
	
	if (newProjectNumber != "") {
		SetInnerHTML('jnView', newProjectNumber);
	}
	else {
		SetInnerHTML('jnView', '[None Assigned]');
	}
	
	SetValue('jobNumRW', newProjectNumber);
	
	
	AjaxNullRequest(url);
	
	if (newProjectNumber != "") {
		showMessage('Edit Project Number', 'Project number set to ' + newProjectNumber.toString());
	}
	else {
		showMessage('Edit Project Number', 'Project number removed.');
	}
}

function updateLocationInfo(statusDiv, project_id, address, city, 
							state, zip, latitude, longitude, subdivision, lot, block, 
							section, township, range)
{
	var url;
	url = '/workFlow/components/locationInfoSub.cfm?id=' + project_id;
	url += '&address=' + escape(address);
	url += '&city=' + escape(city);
	url += '&state=' + escape(state);
	url += '&zip=' + escape(zip);
	url += '&latitude=' + latitude;
	url += '&longitude=' + longitude;
	url += '&subdivision=' + escape(subdivision);
	url += '&lot=' + escape(lot);
	url += '&block=' + escape(block);
	url += '&section=' + escape(section);
	url += '&township=' + escape(township);
	url += '&range=' + escape(range);
	
	
	AjaxLoadPageToDiv(statusDiv, url);
}

function updateFilingInfo(statusDiv, project_id, SubdivisionOrDeed, FilingType, PlatCabinetBook,
						  PageOrSlide, PageSlide, ReceptionNumber, FilingDate, CertifiedTo)
{
	
	if(FilingDate == '') {
		alert('You must supply a Filing Date before you save changes to filing information.');
		return;
	}
	
	var url;
	url = '/workFlow/components/filingInfoSub.cfm?id=' + project_id;
	url += '&SubdivisionOrDeed=' + escape(SubdivisionOrDeed);
	url += '&FilingType=' + escape(FilingType);
	url += '&PlatCabinetBook=' + escape(PlatCabinetBook);
	url += '&PageOrSlide=' + escape(PageOrSlide);
	url += '&PageSlide=' + escape(PageSlide);
	url += '&ReceptionNumber=' + escape(ReceptionNumber);
	url += '&FilingDate=' + escape(FilingDate);
	url += '&CertifiedTo=' + escape(CertifiedTo);
	
	AjaxLoadPageToDiv(statusDiv, url);
}

function updateOtherInfo(statusDiv, project_id, specialinstructions)
{
	var url;
	url = '/workFlow/components/otherInfoSub.cfm?id=' + project_id;
	url += '&specialinstructions=' + escape(specialinstructions);
	
	AjaxLoadPageToDiv(statusDiv, url);
}

function setProjectStatus(jobID, statusDiv)
{
	var url;
	
	url = '/workFlow/components/projectStatusSub.cfm?id=' + jobID + '&status=';
	url += AjaxGetCheckedValue('status') + '&SubStatus=' + AjaxGetCheckedValue('SubStatus');
	
	var onRequestCallback = function () {
		//alert("in the update callback");
		AjaxRefreshTarget();
	};
	
	AjaxLoadPageToDiv('dev-null', url, onRequestCallback);
	
	// the below line disabled 6/2/2008 per request of Antropolis. 
	// we'll see how long this one lasts...
	//showMessage('Update Project Status', 'Project status has been updated, customer notified.');
}

function deleteProject(project_id)
{
	AjaxLoadPageToDiv('tcTarget', '/workFlow/components/deleteJobConfirm.cfm?id=' + escape(project_id));	
}

function deleteProjectReal(project_id)
{
	AjaxLoadPageToDiv('tcTarget', '/workFlow/components/delJob.cfm?jobid=' + escape(project_id));
}

function viewPrintable(project_id)
{
	var url;
	url = '/forms/docViewer.cfm?pageTarget=/forms/viewJob.cfm?jobid=' + project_id;
	
	window.open(url,"printView","width=800,height=800,toolbar=0,menubar=1"); 
}

function invalidateSection(statusDiv, windowHandle)
{
	if (windowHandle) {
		var wRef = p_session.Framework.FindWindow(windowHandle);
		if (wRef) {
			wRef.NeedsSaving = true;
		}
	}
	SetInnerHTML(statusDiv, '<font color="red">Save needed.</font>');
}

function validateSection(statusDiv)
{
	SetInnerHTML(statusDiv, '<font color="#33FF00">No changes made since last save.</font>');
}

function loadProjectViewer(id)
{
	var url;
	url = "/workFlow/components/projectViewer.cfm?id=" + id;

	AjaxLoadPageToDiv('tcTarget', url);
}

function invoice_project(clsJobNumber)
{
	var url;
	url = "/workFlow/components/invoiceProject.cfm?clsJobNumber=" + escape(clsJobNumber);
	url = get15URLString(url);
	
	window.open(url, "inv_project_" + clsJobNumber);
}

function invoice_project_new(clsJobNumber)
{
	var url;
	url = "/workFlow/components/billing/project_billing_settings.cfm?clsJobNumber=" + escape(clsJobNumber);
	url = get15URLString(url);
	
	window.open(url, "inv_project_" + clsJobNumber);
}

function view_invoice_pdf(billing_event_id)
{
	if (billing_event_id == '') {
		return;
	}
	var url;
	url = "/workFlow/components/billing/project_view_invoice_as_pdf.cfm?billing_event_id=" + escape(billing_event_id);
	url = get15URLString(url);
	
	window.open(url, "view_invoice_" + billing_event_id);
}

function view_invoice_html(billing_event_id)
{
	if (billing_event_id == '') {
		return;
	}
	var url;
	url = "/workFlow/components/billing/project_view_invoice_as_html.cfm?billing_event_id=" + escape(billing_event_id);
	url = get15URLString(url);
	
	window.open(url, "view_invoice_" + billing_event_id);
}

function invoice_action(action, billing_event_id)
{
	switch (action) {
		case 'view_html':
			view_invoice_html(billing_event_id);
			break;
		case 'view_pdf':
			view_invoice_pdf(billing_event_id);
			break;
		case 'send':
			send_invoice(billing_event_id);
			break;
		case 'apply_payment':
			apply_invoice_payment(billing_event_id);
			break;
		case 'view_payments':
			view_payments(billing_event_id);
			break;
		case 'delete':
			delete_invoice(billing_event_id);
			break;
 	} /* switch (action) */ 
}


function assignDrafter(projectID, drafterID)
{
	var url;
	url = "/workflow/components/assignDrafter.cfm?projectID=" + escape(projectID);
	url += "&drafterID=" + escape(drafterID);
	
	AjaxLoadPageToDiv('cur_drafter', url);
	hideDiv('drafterSelect');
}

function assignSurveyor(projectID, surveyorID)
{
	var url;
	url = "/workflow/components/assignSurveyor.cfm?projectID=" + escape(projectID);
	url += "&surveyorID=" + escape(surveyorID);
	
	AjaxLoadPageToDiv('cur_surveyor', url);
	hideDiv('surveyorSelect');
}

function setValueLcl()
{
	document.getElementById("subText").value=document.getElementById("subList").value;
}

function setProjectType(ptype)
{
	if(ptype == 'Survey') {
		showDiv('Survey');
		hideDiv('Construction');
	}
	else {
		showDiv('Construction');
		hideDiv('Survey');
	}
}



function DeedBook()
{
	SetValue('SubdivisionOrDeed', 'Deed');
	SetValue('FilingType', 'Book');
}

function SubdivisionBook()
{
	SetValue('SubdivisionOrDeed', 'Subdivision');
	SetValue('FilingType', 'Book');
}

function SubdivisionCabinet()
{
	SetValue('SubdivisionOrDeed', 'Subdivision');
	SetValue('FilingType', 'Cabinet');
}

function SubdivisionPlat()
{
	SetValue('SubdivisionOrDeed', 'Subdivision');
	SetValue('FilingType', 'Plat');
}

function hideAllDocuments()
{
	hideDiv('divScopeOfServices');
	hideDiv('divRateSchedule');
	hideDiv('divTimeline');
	hideDiv('divTotalCost');
	hideDiv('divContract');
}

function chooseDocument()
{
	hideAllDocuments();
	
	var divStr;
	divStr = 'div' + GetValue('sectionSel');
	
	showDiv(divStr);
	
}

function acceptRFP(id)
{
	var url;
	url = '/workflow/components/acceptRFP.cfm?id=' + escape(id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function declineRFP(id)
{
	var url;
	url = '/workflow/components/declineRFP.cfm?id=' + escape(id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

var last_section_id='builtin:project_files';

function show_project_section(id)
{
	var args = id.split(":")
	
	if (args[0] == 'builtin') {
		hideDiv(last_section_id);
		showDiv(args[1]);
		
		last_section_id = args[1];
	}
	else if (args[0] == 'ppm_module') {
		
		var ppm_module_id = args[1];
		var ppm_project_type = args[2];
		var ppm_project_id = args[3];
		
		var url = "/workFlow/PPM/components/ppm_module.cfm?ppm_module_id=" + escape(ppm_module_id)
		url += "&ppm_project_type=" + escape(ppm_project_type);
		url += "&ppm_project_id=" + escape(ppm_project_id);
		
		hideDiv(last_section_id);
		showDiv('ppm_module');
		AjaxLoadPageToDiv('ppm_module', url);
		
		last_section_id = 'ppm_module';
	}
}

function wfpProcessSubdivision(status_div, subdivision_option, new_subdivision, subdivision_select, project_id, original_id)
{
	var url;
	url = '/workflow/components/process_subdivision.cfm?status_div=' + escape(status_div);
	url += '&subdivision_option=' + escape(subdivision_option);
	url += '&new_subdivision=' + escape(new_subdivision);
	url += '&subdivision_select=' + escape(subdivision_select);
	url += '&project_id=' + escape(project_id);
	url += '&original_id=' + escape(original_id);
	
	//alert(url);
	
	AjaxLoadPageToDiv(status_div, url);
	hideDiv('status_div');
	return;
}

function SearchBySub(subID) 
{
	var url;
	url = '/workflow/components/search_by_sub.cfm?SubID=' + escape(subID);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function ProjLoadProjectTypes(site_id) 
{
	var url ="/workFlow/creator/project_types.cfm?site_id=" + escape(site_id);
	
	AjaxLoadPageToDiv('proj_types', url);	
}

function ProjCreateProject()
{
	var onLoadEventHandler = function () {
		
		AjaxLoadPageToDiv('project_creator_form', '/workFlow/creator/project_ready.cfm');		
	}
	
	AjaxSubmitForm(AjaxGetElementReference('create_project'), '/workFlow/creator/submit_project.cfm', 'create_project_buttons', onLoadEventHandler);
		
}

function ProjAddMilestone(project_id)
{
	var url = '/workFlow/sections/milestones/milestone_add.cfm?project_id=' + escape(project_id);
	
	ORMSDialog(url);
}

function ProjAssignTaskCodesToMilestone(milestone_id)
{
	
	// this loads the task code assignment form to add_milestone_form
	// once the milestone has been submitted.
	var onLoadEventHandler = function () {
		var turl = "/workFlow/sections/milestones/assign_task_codes.cfm?milestone_id=" + escape(milestone_id);
		
		AjaxLoadPageToDiv('add_milestone_form', turl);
	}
	
	// this submits the milestone to the database
	var url = "/workFlow/sections/milestones/submit_milestone.cfm";	
	AjaxSubmitForm(AjaxGetElementReference('add_milestone'), url, 'add_milestone_buttons', onLoadEventHandler);
	
}

function ProjMTCUpdate(milestone_id, taskcode_id)
{
	var ctlbase = taskcode_id + "_" + milestone_id + "_";
	var billing_type = GetValue(ctlbase + "billing_type");
	var written = IsChecked(ctlbase + "written");
	var rate = GetValue(ctlbase + "rate");
	var charge_type = GetValue(ctlbase + "charge_type");
	
	var url = '/workFlow/sections/milestones/mtc_update.cfm?milestone_id=' + escape(milestone_id);
	url += '&taskcode_id=' + escape(taskcode_id);
	url += '&billing_type=' + escape(billing_type);
	url += '&written=' + escape(written);
	url += '&rate=' + escape(rate);
	url += '&charge_type=' + escape(charge_type);
	
	AjaxLoadPageToDiv('MTC_Update', url);
}

function ProjMTCUpdateCheck(milestone_id, taskcode_id)
{
	var ctlbase = taskcode_id + "_" + milestone_id + "_";
	SetChecked(ctlbase + "written", true);	
}

function ProjUpdateMilestone(milestone_id)
{
	var url = '/workFlow/sections/milestones/milestone_update.cfm';
	var milestone_form = "edit_milestone_" + milestone_id;
	
	AjaxSubmitForm(AjaxGetElementReference(milestone_form), url, 'milestone_extended_' + milestone_id, AjaxRefreshTarget);
}