// prefiniti ORMS search
// copyright (c) 2010 prefiniti inc

function ORMSSearch(search_value) 
{
	var url = '/orms/basic_search.cfm?search_value=' + escape(search_value);
	
	AjaxLoadPageToDiv('tcTarget', url);
}		

function ORMSSearchKeyPress(e)
{
	// look for window.event in case event isn't passed in
	if (window.event) { 
		e = window.event; 
	}
	if (e.keyCode == 13) {
		ORMSSearch(GetValue('searchBox'));
		ORMSSearchReset();
	}
}

function ORMSSearchReset()
{
	setClass('searchBox', 'search_inactive');
	SetValue('searchBox', 'Type your search terms and press Enter');
}

function ORMSSearchClick()
{
	setClass('searchBox', 'search_active');
	SetValue('searchBox', '');
}

function ORMSPostComment(r_id, user_id)
{
	var onResponse = function () {
		//alert("r_id=" + r_id + " user_id=" + user_id);
		var comment_form_url = "/orms/comment_form_loader.cfm?r_id=" + escape(r_id) + "&user_id=" + escape(user_id);
		var comment_view_url = "/orms/comment_view_page_loader.cfm?r_id=" + escape(r_id);
		
		AjaxLoadPageToDiv('orms_comment_form', comment_form_url);
		AjaxLoadPageToDiv('orms_comments', comment_view_url);
			
	}
	
	AjaxSubmitForm(AjaxGetElementReference('orms_post_comment'), '/orms/comment_post.cfm', 'orms_comment_form', onResponse);
}

function ORMSLoadSection(r_pk, section_loader)
{
	var url = section_loader + "?r_pk=" + escape(r_pk);
	AjaxLoadPageToDiv('orms_active_section', url);
}

function ORMSDialog(url)
{
	showDiv('oh_dialog_background');
	AjaxLoadPageToDiv('orms_dialog_container', url);
		
}

function CloseORMSDialog() 
{
	hideDiv('oh_dialog_background');
}

function ORMSLoad(orms_id, section)
{
	var url = "/orms/loader.cfm?orms_id=" + escape(orms_id);
	url += "&section=" + section;
	AjaxLoadPageToDiv('tcTarget', url);	
}

var orms_sidebar_shown = 1;
function ORMSShowHideSidebar()
{
	if(orms_sidebar_shown == 1) {
		hideDiv('orms_sidebar');
		orms_sidebar_shown = 0;
		document.getElementById('orms_content').style.width = '100%';
	}
	else {
		showDiv('orms_sidebar');
		orms_sidebar_shown = 1;
		document.getElementById('orms_content').style.width = '60%';
	}
}

var notifications_shown = 0;
function ShowNotifications()
{
	if (notifications_shown == 0) {
		showDiv('notification_content');
		notifications_shown = 1;
	}
	else {
		hideDiv('notification_content');
		notifications_shown = 0;
	}
}
