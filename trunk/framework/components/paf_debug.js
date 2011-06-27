/*
 * paf_debug.js
 *  Debugging routines for Prefiniti Application Framework
 *
 *  John Willis
 *  john@prefiniti.com
 * 
 *  Created: 30 April 2008
 *
 */
 writeConsole("Core Ready.");
 
 function showConsole()
 {
	 showDiv('prefiniti_console_wrapper');
 }

 function hideConsole()
 {
	 hideDiv('prefiniti_console_wrapper');
 }
 
 function writeConsole(msg)
 {
	 try {
	 var oldText;
	 
	 oldText = GetInnerHTML('prefiniti_console');
	 SetInnerHTML('prefiniti_console', oldText + '<br />' + msg);
	 
	 if(IsChecked('auto_scroll')) {
		 var objDiv = document.getElementById("prefiniti_console");
		 objDiv.scrollTop = objDiv.scrollHeight;
	 }
	 } catch (ex) {}
 }
 
 function cls()
 {
	SetInnerHTML('prefiniti_console', '');
	var objDiv = document.getElementById("prefiniti_console");
	objDiv.scrollTop = objDiv.scrollHeight;
 }