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

function ORMSBeginUpload() 
{
	document.forms["upload_file"].submit();	
	showDivBlock('upload_progress');
	hideDiv('file_uploader_form');
	
}

function ORMSUploadFinished()
{
	showDivBlock('file_uploader_form');
	hideDiv('upload_progress');
	showDivBlock('upload_finished');
	document.forms["upload_file"].reset();	
}

function ORMSPreviewFile(file_uuid, orms_id)
{
	var url = '/cms/preview_file.cfm?file_uuid=' + escape(file_uuid) + '&orms_id=' + escape(orms_id);
	AjaxLoadPageToDiv('file_preview', url);
	var url = '/cms/file_actions.cfm?file_uuid=' + escape(file_uuid) + '&orms_id=' + escape(orms_id);
	AjaxLoadPageToDiv('file_actions', url);
}

function ORMSDeleteFile(orms_id, file_uuid)
{
	var answer = confirm("Are you sure you wish to delete this file? Neither you nor any member of Prefiniti customer service will be able to get it back later.");
	if(answer) {	
		var url = '/cms/delete_file.cfm?file_uuid=' + escape(file_uuid);
		
		var OnRequestCompleted = new function () {
			
			CloseORMSDialog();		
		}
		
		AjaxLoadPageToDiv('dev-null', url, OnRequestCompleted);
	}
	
	
}

function ORMSPlaySound(URL)
{
	soundManager.createSound('orms_sound', URL);
	soundManager.play('orms_sound');
}

function ORMSStopSound()
{
	soundManager.stop('orms_sound');
}

function ORMSSetThumbnail(orms_id, file_uuid)
{
	var url = '/cms/set_thumbnail.cfm?orms_id=' + escape(orms_id) + '&file_uuid=' + escape(file_uuid);
	
	var orc = new function () {
		AjaxRefreshTarget();	
		AjaxRefreshTarget();
	}
	
	AjaxLoadPageToDiv('dev-null', url, orc);
	
}
