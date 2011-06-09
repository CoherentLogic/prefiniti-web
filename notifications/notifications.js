function ntSetNotify(user_id, event_id, method, value)
{
	var url;
	url = '/notifications/components/set_notify.cfm?user_id=' + escape(user_id);
	url += '&event_id=' + escape(event_id);
	url += '&method=' + escape(method);
	url += '&value=' + escape(value);
	
	AjaxNullRequest(url);
}