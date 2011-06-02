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

var refreshTimer;
function SetAssocType(id, type)
{
	var url;
	url = '/authentication/components/setassoctype.cfm?id=' + escape(id);
	url += '&assoc_type=' + escape(type);
	
	var OnRequestCallback = function () { AjaxRefreshTarget(); };

	AjaxLoadPageToDiv('dev-null', url, OnRequestCallback);
}

function editUser(id, section)
{
	var url;
	url = '/socialnet/components/profile_manager/edit_profile.cfm';
	url += '?section=' + escape(section);

	

	AjaxLoadPageToDiv('tcTarget', url);
}

function editSite(id, section)
{
	var url;
	url = '/authentication/components/maintenancePanel.cfm';
	url += '?section=' + escape(section);
	url += '&site_id=' + escape(id);

	

	AjaxLoadPageToDiv('tcTarget', url);
}

function changeAccountInfo(id)
{
	var url;
	url = '/authentication/components/editAccount.cfm?id=' + escape(id);
	url += '&isAdmin=' + escape(glob_isAdmin);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function changeAccountType(id)
{
	var url;
	url = '/authentication/components/changeAccountType.cfm?id=' + escape(id);
	url += '&isAdmin=' + escape(glob_isAdmin);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function changePassword(id)
{
	var url;
	url = "/authentication/components/changePassword.cfm?id=" + escape(id);
	url += '&isAdmin=' + escape(glob_isAdmin);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function addCompany()
{
	var url;
	if (!glob_isAdmin) {
		AjaxLoadAuthenticationErrorPage();
	}
	else {
		url = '/authentication/components/addCompany.cfm';
	
		AjaxLoadPageToDiv('tcTarget', url);
	}
}

function addUser()
{
	var url;
	if (!glob_isAdmin) {
		AjaxLoadAuthenticationErrorPage();
	}
	else {
		url = '/authentication/components/addAccount.cfm';
	
	
		AjaxLoadPageToDiv('tcTarget', url);
	}
}

function createAccount(username, longName, email)
{
	var url;
	url = '/authentication/components/addAccountSubmit.cfm?p_username=' + escape(username);
	url += '&longName=' + escape(longName);
	url += '&email=' + escape(email);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function editCompany(id)
{
	var url;
	if (!glob_isAdmin) {
		AjaxLoadAuthenticationErrorPage();
	}
	else {
		url="/authentication/components/editCompany.cfm?id=" + escape(id);
	
		AjaxLoadPageToDiv('tcTarget', url);
	}
}


function updateAccountInfo(id, company, longName, email, smsNumber, gender, bio, title, phone, fax, remember_page)
{
	
	var url;
	url = "/authentication/components/editAccountSubmit.cfm?id=" + escape(id);
	url += "&company=" + escape(company);
	url += "&longName=" + escape(longName);
	url += "&email=" + escape(email);
	url += "&smsNumber=" + escape(smsNumber);
	url += "&gender=" + escape(gender);
	url += "&bio=" + escape(bio);
	url += "&title=" + escape(title);
	url += "&phone=" + escape(phone);
	url += "&fax=" + escape(fax);
	url += "&remember_page=" + escape(remember_page);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

//updateAccountType(#url.id#, AjaxGetCheckedValue('type'), GetValue('orderRep'), GetValue('admin'), GetValue('tcAdmin'))

function updateAccountType(id, type, orderRep, admin, tcAdmin, account_enabled, order_processor, site_maintainer, receives_timesheet_reminders)
{
	var url;
	var roleStr;
	var adminStr;
	var enabledStr;
	var opStr;
	var smStr;
	var trStr;
	
	url = "/authentication/components/accountTypeSubmit.cfm?id=" + escape(id);
	url += "&type=" + escape(type);
	
	if (orderRep == true) {
		roleStr = escape("ORDER REP");	
	}
	
	if (admin == true) {
		roleStr = escape("ADMIN");
	}
	
	url += "&role=" + roleStr;
	
	if (tcAdmin == true) {
		adminStr = "yes";
	}
	else {
		adminStr = "no";
	}
	
	url += "&tcadmin=" + escape(adminStr);
	
	if (account_enabled == true) {
		enabledStr = "1";
	}
	else {
		enabledStr = "0";
	}
	
	url += "&account_enabled=" + escape(enabledStr);
	
	if (order_processor == true) {
		opStr = "1";
	}
	else {
		opStr = "0";
	}
	
	url += "&order_processor=" + escape(opStr);
	
	if (site_maintainer == true) {
		smStr = "1";
	}
	else {
		smStr = "0";
	}
	
	url += "&site_maintainer=" + escape(smStr);
	
	if (receives_timesheet_reminders == true) {
		trStr = "1";
	}
	else {
		trStr = "0";
	}
	
	url += "&receives_timesheet_reminders=" + escape(trStr);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function updateCompany(id, name, mailing_address, mailing_city, mailing_state,
					   mailing_zip, billing_address, billing_city, billing_state,
					   billing_zip, website)
{
	var url;
	url = '/authentication/components/editCompanySubmit.cfm?id=' + escape(id);
	url += '&name=' + escape(name);
	url += '&mailing_address=' + escape(mailing_address);
	url += '&mailing_city=' + escape(mailing_city);
	url += '&mailing_state=' + escape(mailing_state);
	url += '&mailing_zip=' + escape(mailing_zip);
	url += '&billing_address=' + escape(billing_address);
	url += '&billing_city=' + escape(billing_city);
	url += '&billing_state=' + escape(billing_state);
	url += '&billing_zip=' + escape(billing_zip);
	url += '&website=' + escape(website);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function createCompany(name, mailing_address, mailing_city, mailing_state,
					   mailing_zip, billing_address, billing_city, billing_state,
					   billing_zip, website)
{
	var url;
	url = '/authentication/components/addCompanySubmit.cfm';
	url += '?name=' + escape(name);
	url += '&mailing_address=' + escape(mailing_address);
	url += '&mailing_city=' + escape(mailing_city);
	url += '&mailing_state=' + escape(mailing_state);
	url += '&mailing_zip=' + escape(mailing_zip);
	url += '&billing_address=' + escape(billing_address);
	url += '&billing_city=' + escape(billing_city);
	url += '&billing_state=' + escape(billing_state);
	url += '&billing_zip=' + escape(billing_zip);
	url += '&website=' + escape(website);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function checkAcctType()
{
	var curVal;
	curVal = AjaxGetCheckedValue('individual_account');
	
	if (curVal == 1) {
		SetValue('company', GetValue('longName'));
	}
	else {
		SetValue('company', '');
	}
	
	return;
}

function copyAddress()
{
	if (IsChecked('chkCopyAddress')) {
		SetValue('billing_address', GetValue('mailing_address'));
		SetValue('billing_city', GetValue('mailing_city'));
		SetValue('billing_state', GetValue('mailing_state'));
		SetValue('billing_zip', GetValue('mailing_zip'));
	}
	else {
		SetValue('billing_address', '');
		SetValue('billing_city', '');
		SetValue('billing_state', '');
		SetValue('billing_zip', '');		
	}
}

function companyNameChanged()
{
	
	SetRadioCheckedValue('individual_account', '0');
}

function checkAvailability(username)
{
	var url;
	url = "/authentication/components/checkAvailability.cfm?suggested_username=" + escape(username);
	
	AjaxLoadPageToDiv('availability', url);
}

function registerAccount(firstName, middleInitial, lastName, email, email_billing, gender, smsnumber, phone, fax, mailEqualsBill,
						 mailing_address, mailing_city, mailing_state, mailing_zip,
						 billing_address, billing_city, billing_state, billing_zip, username, availability, allowSearch, birthday, entered_captcha, actual_captcha, referral_code)
{
	// form validation
	if (entered_captcha != actual_captcha) {
		//alert(entered_captcha + ' ' + actual_captcha);
		SetInnerHTML('captcha_status', '<p style="color:red">CAPTCHA text does not match</p>');
		return;
	}
	
	if (firstName == "") {
		showMessage('Registration Error', 'You must enter your first name');
		return;
	}
	
	/*if (middleInitial == "") {
		showMessage('Registration Error', 'You must enter your middle initial');
		return;
	}*/
	
	if (lastName == "") {
		showMessage('Registration Error', 'You must enter your last name');
		return;
	}
	
	if (email == "") {
		showMessage('Registration Error', 'You must enter your e-mail address');
		return;
	}
	
	if (phone == "") {
		showMessage('Registration Error', 'You must enter your phone number');
		return;
	}
	
	if (mailing_address == "") {
		showMessage('Registration Error', 'You must enter your physical address');
		return;
	}
	
	if (mailing_city == "") {
		showMessage('Registration Error', 'You must enter your physical address');
		return;
	}
	
	if (mailing_state == "") {
		showMessage('Registration Error', 'You must enter your physical address');
		return;
	}
	
	if (mailing_zip == "") {
		showMessage('Registration Error', 'You must enter your physical address');
		return;
	}
	
	if (billing_address == "") {
		showMessage('Registration Error', 'You must enter your billing address');
		return;
	}
	
	if (billing_city == "") {
		showMessage('Registration Error', 'You must enter your billing address');
		return;
	}
	
	if (billing_state == "") {
		showMessage('Registration Error', 'You must enter your billing address');
		return;
	}
	
	if (billing_zip == "") {
		showMessage('Registration Error', 'You must enter your billing address');
		return;
	}
	
	if (username == "") {
		showMessage('Registration Error', 'You must choose a login name');
	}
	
	if (birthday == "") {
		showMessage('Registration Error', 'You must enter your birthday');
	}
	
	if (availability == "<span style=\"color: red;\">This login name is already in use. Please choose another.</span>") {
		showMessage('Registration Error', 'The login name you have chosen is in use.');
		return;
	}
	
	if (availability == "") {
		showMessage('Registration Error', 'You have not validated your username.');
		return;
	}
	// end of form validation
	
	/*longName, individual_account, company, email, email_billing, gender, smsnumber, phone, fax,
						 mailing_address, mailing_city, mailing_state, mailing_zip,
						 billing_address, billing_city, billing_state, billing_zip, username, availability*/
	
	// build submission URL
	var url;
	url = "/authentication/components/registerSubmit.cfm?firstName=" + escape(firstName);
	url += "&middleInitial=" + escape(middleInitial);
	url += "&lastName=" + escape(lastName);
	url += "&email=" + escape(email);
	url += "&email_billing=" + escape(email_billing);
	url += "&gender=" + escape(gender);
	url += "&smsnumber=" + escape(smsnumber);
	url += "&phone=" + escape(phone);
	url += "&fax=" + escape(fax);
	url += "&mailing_address=" + escape(mailing_address);
	url += "&mailing_city=" + escape(mailing_city);
	url += "&mailing_state=" + escape(mailing_state);
	url += "&mailing_zip=" + escape(mailing_zip);
	url += "&billing_address=" + escape(billing_address);
	url += "&billing_city=" + escape(billing_city);
	url += "&billing_state=" + escape(billing_state);
	url += "&billing_zip=" + escape(billing_zip);
	url += "&reg_username=" + escape(username);
	url += "&mailEqualsBill=" + escape(mailEqualsBill);	
	url += "&allowSearch=" + escape(allowSearch);
	url += "&birthday=" + escape(birthday);
	url += "&referral_code=" + escape(referral_code);
	
	AjaxLoadPageToDiv('tcTarget', url);
	

}

function inviteUser()
{
	AjaxLoadPageToWindow('/authentication/components/invite_user.cfm', 'Invite User');
	
}

function setPassword(id, pw, pwConfirm)
{
	
	if (pw != pwConfirm) {
		showMessage('Authentication Error', 'The passwords you entered do not match.');
		return;
	}
	
	var url;
	url = "/authentication/components/setPasswordSubmit.cfm?id=" + escape(id);
	url += "&password=" + escape(pw);
	
	
	AjaxLoadPageToDiv('userActionTarget', url);
	
}

function setInitialPassword(id, pw, pwConfirm)
{
	
	if (pw != pwConfirm) {
		showMessage('Authentication Error', 'The passwords you entered do not match.');
		return;
	}
	
	var url;
	url = "/authentication/components/setInitialPasswordSubmit.cfm?id=" + escape(id);
	url += "&password=" + escape(pw);
	
	
	AjaxLoadPageToDiv('tcTarget', url);
	
}

function getWebWareLogin()
{
	window.open("/default.cfm","_blank","width=1000,height=800,toolbar=0,menubar=0,scrollbars=1"); 
}

function changePicture(id)
{
	var url;
	url = "/authentication/components/changePicture.cfm?id=" + escape(id);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}
	
function doPictureUpload(id)
{
	window.open("","uploadStatusWindow","width=420,height=220,toolbar=0"); 
    var a = window.setTimeout("document.uploadPicture.submit();",500);
	
	refreshTimer = window.setTimeout("refreshProfile(" + id + ", true);", 3500);
}

function refreshProfile(id, enabled)
{
	if (enabled == true)
	{
		AjaxRefreshTarget();
		refreshTimer = null;
	}

}
		
function setMaintenance(maint)
{
	var url;
	var mStr;
	
	if (maint == true) {
		mStr = "1";
	}
	else {
		mStr = "0";
	}
	
	url = "/authentication/components/setMaintenance.cfm?maintenance=" + escape(mStr);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function setLoginsDisabled(ld)
{
	var url;
	var mStr;
	
	if (ld == true) {
		mStr = "1";
	}
	else {
		mStr = "0";
	}
	
	url = "/authentication/components/setLoginsDisabled.cfm?logins_disabled=" + escape(mStr);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}

function loadMaintenancePanel()
{
	AjaxLoadPageToDiv('tcTarget', '/authentication/components/maintenancePanel.cfm');
}

function confirmSMS(userid, number)
{
	var url;
	url = "/authentication/components/confirmSMS.cfm?userid=" + escape(userid);
	url += "&number=" + escape(number);
	
	AjaxLoadPageToDiv('smsConfTarget', url);
}

function viewProfile(userid)
{
	var url;
	url = "/socialnet/components/view_profile.cfm?userid=" + escape(userid);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function viewProfile15(userid)
{
	var url;
	url = "/socialnet/components/view_profile.cfm?userid=" + escape(userid);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function searchUsers(namePart, nameTgt, idTgt)
{
	var url;
	url = '/authentication/components/userPickerResults.cfm?namePart=' + escape(namePart);
	url += '&nameTgt=' + escape(nameTgt);
	url += '&idTgt=' + escape(idTgt);
	
	AjaxSilentLoad('searchTarget', url);
}

function copyUserSearch(id, name, nameTgt, idTgt)
{
	SetInnerHTML(nameTgt, name);
	SetValue(idTgt, id);
	
	hideDiv('userPicker');
}

function setPermission(perm_id, assoc_id, checked)
{	
	var url;
	url = '/authentication/components/setPerm.cfm?perm_id=' + escape(perm_id);
	url += '&assoc_id=' + escape(assoc_id);
	url += '&checked=' + escape(checked);
	
	AjaxNullRequest(url);
}

function invalidateComponent()
{
	return;
	showDiv('cmp_invalid');
	hideDiv('cmp_valid');
}

function validateComponent()
{
	return;;
	showDiv('cmp_valid');
	hideDiv('cmp_invalid');
	
}

function wwCreateDepartment(site_id, department_name)
{
	var url;
	url = '/authentication/components/site_manager/add_department_sub.cfm?site_id=' + escape(site_id);
	url += '&department_name=' + escape(department_name);
	
	AjaxNullRequest(url);
	hideDiv('gen_window_frame');
	editSite(glob_current_site_id, "departments.cfm");
}

function wwDeleteDepartment(department_id)
{
	var url;
	url = '/authentication/components/site_manager/delete_department.cfm?id=' + escape(department_id);
	
	var onTransferCompleted = function () {
		AjaxRefreshTarget();	
	}
	
	AjaxLoadPageToDiv('dev-null', url, onTransferCompleted);
}
	
function wwAddMember(department_id, user_id)
{
	var url;
	url = '/authentication/components/site_manager/add_department_member_sub.cfm?department_id=' + escape(department_id);
	url += '&user_id=' + escape(user_id);
	
	AjaxNullRequest(url);
	hideDiv('gen_window_frame');
	editSite(glob_current_site_id, "departments.cfm");
}

function wwSetManager(department_id, user_id)
{
	var url;
	url = '/authentication/components/site_manager/make_manager_sub.cfm?department_id=' + escape(department_id);
	url += '&user_id=' + escape(user_id);
	
	AjaxLoadPageToDiv('userActionTarget', url);
	editSite(glob_current_site_id, "departments.cfm");
}

function wwDeleteDepartmentMember(id)
{
	var url;
	url = '/authentication/components/site_manager/delete_member_sub.cfm?id=' + escape(id);
	
	AjaxLoadPageToDiv('userActionTarget', url);
	editSite(glob_current_site_id, "departments.cfm");
}

function wwSetEvent(site_id, department_id, event_id, value)
{
	//alert("Department ID: " + department_id + " Event ID: " + event_id + " Value: " + value);

	var url;
	url = '/authentication/components/site_manager/set_event.cfm?department_id=' + escape(department_id);
	url += '&event_id=' + escape(event_id);
	url += '&value=' + escape(value);
	url += '&site_id=' + escape(site_id);
	
	AjaxLoadPageToDiv('userActionTarget', url);
}