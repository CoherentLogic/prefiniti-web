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
	
	AjaxLoadPageToDiv('orms_active_section', url);
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

function ORMSCommentClick()
{
	setClass('object_comment', 'comment_active');
	SetValue('object_comment', '');
}

function ORMSCommentReset()
{
	setClass('object_comment', 'comment_inactive');
	SetValue('object_comment', 'Enter your comment...');
}

function ORMSPostComment(e)
{
	if (window.event) { 
		e = window.event; 
	}
	if (e.keyCode == 13) {
		comment = GetValue('object_comment');
		orms_id = GetValue('orms_id');
		
		var url = '/orms/comment_post.cfm?comment=' + escape(comment) + "&orms_id=" + escape(orms_id);
		
		AjaxLoadPageToDiv('dev-null', url);
		
		ORMSCommentReset();
	}
}

function ORMSPostEventComment(e, event_r_pk)
{
	var post_target = 'all_comments_' + event_r_pk;
	var comment_box = 'event_comment_' + event_r_pk;
	
	
	if (window.event) { 
		e = window.event; 
	}
	if (e.keyCode == 13) {
		comment = GetValue(comment_box);
		
		var url = '/orms/post_event_comment.cfm?comment=' + escape(comment) + "&event_id=" + escape(event_r_pk);
			
		SetValue(comment_box, '');
		
		showDivBlock(post_target);
		AjaxLoadPageToDiv(post_target, url);				
	}
}


function ORMSLoadSection(r_pk, section_loader)
{
	var url = section_loader + "?r_pk=" + escape(r_pk);
	AjaxLoadPageToDiv('orms_active_section', url);
}

function ORMSDialog(url)
{
	
	/*var loadWin = new function () {
		ColdFusion.navigate(url, 'orms_window');
	};
	
	ColdFusion.Window.create('orms_window', '', url, {height:400,width:640,modal:true,closable:false,draggable:true,resizable:false,center:true,initshow:true,callbackHandler:loadWin});
	*/
	
	showDiv('oh_dialog_background');
	AjaxLoadPageToDiv('orms_dialog_container', url);
		
}



function CloseORMSDialog() 
{
	
	hideDiv('oh_dialog_background');
}

function ORMSLoad(orms_id, section)
{
	var url = "/Prefiniti.cfm?View=" + escape(orms_id);
	url += "&Section=" + section;
	location.replace(url);	
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

function ORMSPlaySound(URL, id)
{
	var sound_id = 'orms_sound_' + id;
	
	ORMSStopSound();
	soundManager.createSound(sound_id, URL);
	soundManager.play(sound_id);
}

function ORMSStopSound(id)
{
	var sound_id = 'orms_sound_' + id;
	
	soundManager.stop(sound_id);
}

function ORMSSetThumbnail(orms_id, file_uuid)
{
	var url = '/cms/set_thumbnail.cfm?orms_id=' + escape(orms_id) + '&file_uuid=' + escape(file_uuid);
	
	var orc = function () {
		AjaxRefreshTarget();	
		
	}
	
	AjaxLoadPageToDiv('dev-null', url, orc);
	
}


function ORMSLoadHistory(start, user_id) 
{
	var url = '/orms/object_history.cfm?FirstRecord=' + escape(start) + '&user_id=' + escape(user_id);
	AjaxLoadPageToDiv('object_history', url);	
}

function ORMSSwitchSites(assoc_id)
{
	SetValue('assoc', assoc_id);
	document.forms['site_selection'].submit();
}

function ORMSLoadFeed(uuid)
{
	var url = '/orms/feed.cfm?uuid=' + escape(uuid);
	
	AjaxLoadPageToDiv('object_feed', url);
}

function ORMSLoadFeedFull(uuid)
{
	var url = '/orms/feed_loader.cfm?uuid=' + escape(uuid);
	
	var orc = function () {
		ORMSPrepareFeed(uuid, 0);
	};
	
	AjaxLoadPageToDiv('orms_active_section', url, orc);
}

/*
 *  notification code
 */
var receiveReq = getXmlHttpRequestObject();
var mTimer = setTimeout('getNotifyText();', 2000);


function getXmlHttpRequestObject() 
{
	if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		return new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		alert('Status: Cound not create XmlHttpRequest Object. Consider upgrading your browser.');
	}
}

function getNotifyText() 
{
	var url = '/OpenHorizon/Storage/EventFeed/EventXML.cfm?user_id=' + escape(glob_userid) + '&acknowledged=0&received=0';
	
	if (receiveReq.readyState == 4 || receiveReq.readyState == 0) {
		receiveReq.open("GET", url, true);
		receiveReq.onreadystatechange = handleReceiveNotify; 
		receiveReq.send(null);
	}			
}

function handleReceiveNotify() 
{
	if (receiveReq.readyState == 4) {
		var notify_div = document.getElementById('notify_target');
		var xmldoc = receiveReq.responseXML;
		var message_nodes = xmldoc.getElementsByTagName("event"); 
		var n_messages = message_nodes.length;
		
		if (n_messages > 0) {
			notify_div.innerHTML = "";
		}
		
		for (i = 0; i < n_messages; i++) {
			var id_node = message_nodes[i].getElementsByTagName("id");
			var text_node = message_nodes[i].getElementsByTagName("text");
			var time_node = message_nodes[i].getElementsByTagName("timestamp");
			var user_node = message_nodes[i].getElementsByTagName("user");
			var object_node = message_nodes[i].getElementsByTagName("object");
			var event_node = message_nodes[i].getElementsByTagName("objectevent");
									
			n_id = id_node[0].firstChild.nodeValue;
			n_text = text_node[0].firstChild.nodeValue;
			n_time = time_node[0].firstChild.nodeValue;
			n_user = user_node[0].firstChild.nodeValue;
			n_object = object_node[0].firstChild.nodeValue;
			n_event = event_node[0].firstChild.nodeValue;								
			
			var message_html = '<a href="http://www.prefiniti.com/Prefiniti.cfm?View=' + escape(n_object) + '">' + n_text + '</a><br><br>';
			notify_div.innerHTML += message_html;			
			
		}
		
		if (n_messages > 0) {
			showDivBlock('notify_wrapper');
		}
		
		
		mTimer = setTimeout('getNotifyText();',2000);	
	}
}

/*
 * event feed code
 */
 
var receiveEventReq = getXmlHttpRequestObject();
var evTimer = "";
var g_object_id = "";
var g_last_id = "";
function ORMSPrepareFeed(object_id, last_id) 
{
	var call = 'getFeedText("' + object_id + '", ' + last_id + ');';
	
	evTimer = setTimeout(call, 2000);
	g_object_id = object_id;
	g_last_id = last_id;
}

function getFeedText(object_id, last_id) 
{
	var url = '/OpenHorizon/Storage/EventFeed/ObjectEventXML.cfm?target_uuid=' + escape(object_id) + '&last_id=' + escape(last_id);
	
	if (receiveEventReq.readyState == 4 || receiveEventReq.readyState == 0) {
		receiveEventReq.open("GET", url, true);
		receiveEventReq.onreadystatechange = handleFeedReceiveEvent; 
		receiveEventReq.send(null);
	}			
}

function handleFeedReceiveEvent() 
{
	if (receiveEventReq.readyState == 4) {		
		var xmldoc = receiveEventReq.responseXML;
		var message_nodes = xmldoc.getElementsByTagName("objectevent"); 
		var n_messages = message_nodes.length;
		
		for (i = 0; i < n_messages; i++) {
			var id_node = message_nodes[i].getElementsByTagName("id");												
			n_id = id_node[0].firstChild.nodeValue;
						
			g_last_id = n_id;			
						
			var url = '/orms/single_event_loader.cfm?event_id=' + escape(n_id);
			
			AjaxPrependPageToDiv('object_feed', url);			
		}		
		
		
		ORMSPrepareFeed(g_object_id, g_last_id);
	}
}

function ORMSSubscribe(OID, UserID)
{
	var url = '/orms/subscription.cfm?action=subscribe&om_uuid=' + escape(OID) + '&user_id=' + escape(UserID);
	
	var orc = function () {
		AjaxRefreshTarget();	
		
	}
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}

function ORMSUnSubscribe(OID, UserID)
{
	var url = '/orms/subscription.cfm?action=unsubscribe&om_uuid=' + escape(OID) + '&user_id=' + escape(UserID);
	
	var orc = function () {
		AjaxRefreshTarget();	
		
	}
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}



