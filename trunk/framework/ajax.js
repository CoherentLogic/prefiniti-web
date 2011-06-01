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
 
// 
//  $Id$
//
//  ajax.js
//   Common routines for using AJAX functionality
//
//  
//  Authored by:		John Willis
//	Date:				3/14/2007
//
//
//  3/15/2007:		Added AjaxLoadPageToValueCtl(), AjaxSubmitFromTextToDiv(), and AjaxGetCheckedValue()
//


//
// AjaxGetXMLHTTP():
//  Gets an XMLHTTPRequest object in a browser-aware way
//
// Returns a usable XMLHTTPRequest object
//

var lastLoadedURL;

function AjaxGetXMLHTTP()
{
	var xmlHttp;
	
	try {
		xmlHttp = new XMLHttpRequest();
	}
	catch (e) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				return false;
			}
		}
	}
	
	return xmlHttp;
}

function AjaxLoadPageToDiv(DivID, PageURL)
{
	//AjaxNullRequest('/framework/components/syncScriptVariables.cfm');
	
	if (PageURL.indexOf('?') != -1) {
		if(PageURL.indexOf('calledByUser') == -1) {
			PageURL += "&calledByUser=" + escape(glob_userid);
		}
	}
	else {
		if(PageURL.indexOf('calledByUser') == -1) {
			PageURL += "?calledByUser=" + escape(glob_userid);
		}
	}
	
	if(PageURL.indexOf('calledByCompany') == -1) {
		PageURL += "&calledByCompany=" + escape(glob_companyid);
	}
	
	
	if(PageURL.indexOf('userName') == -1) {
		PageURL += "&userName=" + escape(glob_userName);
	}
	
	if(PageURL.indexOf('longName') == -1) {
		PageURL += "&longName=" + escape(glob_longName);
	}
	

	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();

	//alert('AjaxLoadPageToDiv DivID=' + DivID + '  PageURL=' + PageURL);

	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
			
			    // regexp which parses text for value between <title> .. </title> tags
        		var re_title = new RegExp("<wwafcomponent>[\n\r\s]*(.*)[\n\r\s]*</wwafcomponent>", "gmi");
        		// page text
        		var content = xmlHttp.responseText;
        		var title = re_title.exec(content);
				
				
				document.getElementById(DivID).innerHTML = xmlHttp.responseText;
				
				if (title != null) {
					
					var llpURL;
					llpURL='/framework/components/saveLastLoad.cfm?last_loaded_page=';
					llpURL += escape(PageURL);
					llpURL += "&calledByUser=" + glob_userid;
					
					
					AjaxNullRequest(llpURL);
					
					AjaxAppendToList('history', title[1], PageURL);
					SetInnerHTML('documentName', title[1]);
					lastLoadedURL = PageURL;
				}
	
				
				var re_sidebar = new RegExp("<wwafsidebar>[\n\r\s]*(.*)[\n\r\s]*</wwafsidebar>", "gmi");
				var sidebar = re_sidebar.exec(content);
				
				var re_packageName = new RegExp("<wwafpackage>[\n\r\s]*(.*)[\n\r\s]*</wwafpackage>", "gmi");
				var packageName = re_packageName.exec(content);
				
				var re_packageIcon = new RegExp("<wwaficon>[\n\r\s]*(.*)[\n\r\s]*</wwaficon>", "gmi");
				var packageIcon = re_packageIcon.exec(content);
				
				if (packageName != null) {
					SetInnerHTML('packageName', packageName[1]);
				}
				
				if (packageIcon != null) {
					SetInnerHTML('packageIcon', '<img align="absmiddle" src="/graphics/' + packageIcon[1] + '">');
				}
				
				var re_definesmap = new RegExp("<wwafdefinesmap>[\n\r\s]*(.*)[\n\r\s]*</wwafdefinesmap>", "gmi");
				var definesmap = re_definesmap.exec(content);
				
				try {
				if (definesmap[1] == 'false') {
					hideDiv('mapViewBtn');
				}
				else {
					showDiv('mapViewBtn');
				}
				}
				catch (error) {
				}
				
				//var re_script = new RegExp("<wwafscript>[\n\r\s]*(.*)[\n\r\s]*</wwafscript>", "gmi");
				var wscript = document.getElementById(DivID).getElementsByTagName('wwafscript');
				
				if (wscript != null) {
					//alert(wscript);
					//eval(wscript[1]);
				}
				
				if (sidebar != null) {
					nextToClose=null;
					//alert(sidebar[1]);
					AjaxSilentLoad('sbTarget', '/framework/s' + sidebar[1]);
				}
				//alert(document.getElementById('pageScriptContent').innerHTML);
				
				try {
					setMapView();
					
					eval(document.getElementById('pageScriptContent').innerHTML);
					
					var d = document.getElementById('pageScriptContent').parentNode;
  					var olddiv = document.getElementById('pageScriptContent');
  					d.removeChild(olddiv);
					
					setListView();
				}
				catch (error)
				{
					
					setListView();
				}
				
				break;
			case 1:
				document.getElementById(DivID).innerHTML = '<center><p style="background-color:#CCCCCC;color:white;border:solid thin black;width:100px;padding:8px;"><img src="/graphics/progress.gif" align="absmiddle"> <strong>Loading...</strong> </p></center>';
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
} /* AjaxLoadPageToDiv() */

function AjaxSubmitForm(formRef, postTarget, targetDiv)
{
	var url;
	url = postTarget + "?postedByUser=" + glob_userid;
	
   for(i=0; i < formRef.elements.length; i++) {
   
   //alertText += "Element Type: " + formRef.elements[i].type + "\n"

      if(formRef.elements[i].type == "text" || formRef.elements[i].type == "textarea" || formRef.elements[i].type == "button") {
      	url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].value);
	  }
      else if(formRef.elements[i].type == "checkbox") {
      	//lertText += "Element Checked? " + formRef.elements[i].checked + "\n"
		url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].checked);
      }
      else if(formRef.elements[i].type == "hidden") {
	  	url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].value);
	  }
	  else if(formRef.elements[i].type == "radio") {
		  if (formRef.elements[i].checked) {
			  url += "&" + formRef.elements[i].name + "=" + escape(formRef.elements[i].value);
		  }
	  }
	  else if(formRef.elements[i].type == "select-one" ) {
      	//alertText += "Selected Option's Text: " + formRef.elements[i].options[formRef.elements[i].selectedIndex].text + "\n"
      	url += "&" + formRef.elements[i].name + "=" + escape( formRef.elements[i].options[formRef.elements[i].selectedIndex].text);
	  }
   
   }

	AjaxLoadPageToDiv(targetDiv, url);
}

function AjaxRefreshTarget()
{
	
	AjaxLoadPageToDiv('tcTarget', lastLoadedURL);
}


function AjaxLoadPageToValueCtl(CtlID, PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				document.getElementById(CtlID).value = xmlHttp.responseText;
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}

function AjaxSilentLoad(CtlID, PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	if (PageURL.indexOf('?') != -1) {
		PageURL += "&calledByUser=" + escape(glob_userid);
	}
	else {
		PageURL += "?calledByUser=" + escape(glob_userid);
	}
	
	PageURL += "&calledByCompany=" + escape(glob_companyid);
	PageURL += "&permissionLevel=" + escape(glob_usertype);
	PageURL += "&order_processor=" + escape(glob_order_processor);
	PageURL += "&isTCAdmin=" + escape(glob_isTCAdmin);
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				document.getElementById(CtlID).innerHTML = xmlHttp.responseText;
				break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}

function AjaxLoadPageToPopup(PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
			if(xmlHttp.responseText != '') {
				showMessage('Login Event', xmlHttp.responseText);
			}
			break;
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}


function AjaxNullRequest(PageURL)
{
	var xmlHttp;
	xmlHttp = AjaxGetXMLHTTP();
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
			try {
					//alert(xmlHttp.responseText);
					eval(xmlHttp.responseText);
				}
				catch (error)
				{
					//alert(error);
				}
		}
	}
	xmlHttp.open("GET", PageURL, true);
	xmlHttp.send(null);
}
		
function AjaxSubmitFromTextToDiv(CtlID, ResultDiv, ActionURL)
{
	var xmlHttp;
	var params;
	
	xmlHttp = AjaxGetXMLHTTP();
	
	xmlHttp.onreadystatechange = function()
	{
		switch(xmlHttp.readyState) {
			case 4:
				if (ResultDiv != null) {
					document.getElementById(ResultDiv).innerHTML = xmlHttp.responseText;
					break;
				}
				break;
		}
	}
	
	params = "?";
	params += document.getElementById(CtlID).name;
	params += "=";
	params += escape(document.getElementById(CtlID).value);
	
	
	xmlHttp.open("GET", ActionURL + params, true);
	xmlHttp.send(null);
	
}

function AjaxGetCheckedValue(CtlGroupName)
{
	var nodes;
	nodes = document.getElementsByName(CtlGroupName);
	
	for (i = 0; i < nodes.length; i++) {
		if (nodes[i].checked) {
			return nodes[i].value;
			break;
		}
	}
	return null;
}

function AjaxGetElementReference(ctlID)
{
	return document.getElementById(ctlID);
}

function SetInnerText(ctlID, txt)
{
		document.getElementById(ctlID).InnerText = txt;
}

function SetInnerHTML(ctlID, html)
{
		document.getElementById(ctlID).innerHTML = html;
}


function GetInnerText(ctlID)
{
		return document.getElementById(ctlID).innerText;
}

function GetInnerHTML(ctlID)
{
		return document.getElementById(ctlID).innerHTML;
}

function GetValue(ctlID)
{
		try {
			return document.getElementById(ctlID).value;
		}
		catch (ex) {
			//alert('error in GetValue for ctlID=' + ctlID);
		}
}

function SetValue(ctlID, newValue)
{
		document.getElementById(ctlID).value = newValue;
}

function IsChecked(ctlID)
{
	return document.getElementById(ctlID).checked;
}

function SetChecked(ctlID, newValue)
{
	document.getElementById(ctlID).checked = newValue;
}

function SetRadioCheckedValue(radioObj, newValue) {
	if(!radioObj)
	{ alert('bad radio object');
		return;}
	var radioLength = radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		radioObj[i].checked = false;
		if(radioObj[i].value == newValue.toString()) {
			radioObj[i].checked = true;
		}
	}
}

function showDiv(which) 
{
	document.getElementById(which).style.display="inline";
	soundManager.play('click');
}



function showDivBlock(which) 
{
	document.getElementById(which).style.display="block";
	soundManager.play('click');
}

function hideDiv(which) 
{
	try {
		document.getElementById(which).style.display="none";
	}
	catch(error) {
		//alert('hideDiv error for div with id of ' + which);
	}
}

function moveDiv(which, left, top)
{
	document.getElementById(which).style.left = left += 'px';
	document.getElementById(which).style.top = top += 'px';
}
		
function getRefToDiv(divID,oDoc) {
   if( !oDoc ) { oDoc = document; }
   if( document.layers ) {
       if( oDoc.layers[divID] ) { return oDoc.layers[divID]; } else {
           //repeatedly run through all child layers
           for( var x = 0, y; !y && x < oDoc.layers.length; x++ ) {
               //on success, return that layer, else return nothing
               y = getRefToDiv(divID,oDoc.layers[x].document); }
           return y; } }
   if( document.getElementById ) {
       return document.getElementById(divID); }
   if( document.all ) {
       return document.all[divID]; }
   return false;
}

function moveDivTo(x,y) 
{
	myReference = getRefToDiv( 'mydiv' );
	if( !myReference ) { 
		return; 
	}

	if( myReference.style ) { 
		myReference = myReference.style; 
	}

	var noPx = document.childNodes ? 'px' : 0;
	myReference.left = x + noPx;
	myReference.top = y + noPx;
}

function findPosX(obj) {
	var curleft = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft;
		
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft;
		}
	}
	
	return curleft;
}

function findPosY(obj) {
	var curtop = 0;
	if (obj.offsetParent) {
		curtop = obj.offsetTop;
		while (obj = obj.offsetParent) {
			curtop += obj.offsetTop;
		}
	}
	return curtop;
}

function mouseX(evt) {
	if (evt.pageX) return evt.pageX;
	else if (evt.clientX)
	   return evt.clientX + (document.documentElement.scrollLeft ?
	   document.documentElement.scrollLeft :
	   document.body.scrollLeft);
	else return null;
	}
	function mouseY(evt) {
		
	if (evt.pageY) return evt.pageY;
	else if (evt.clientY)    
	   return evt.clientY + (document.documentElement.scrollTop ?
	   document.documentElement.scrollTop :
	   document.body.scrollTop);
	else return null;
}

function AjaxExecuteScript(div)
{
	var x = div.getElementsByTagName("script");
	
	for(var i=0;i<x.length;i++) {
		eval(x[i].text);
		var scriptTag = document.createElement('script');
		scriptTag.innerHTML = x[i].text;
		scriptTag.type = 'text/javascript';
		var head = document.getElementsByTagName('head').item(0);
		head.appendChild(scriptTag);
	}
} 

function AjaxLoadAuthenticationErrorPage()
{
	AjaxLoadPageToDiv('tcTarget', '/authentication/components/AuthError.cfm');
}

function AjaxAppendToList(listBox, itemText, itemValue)
{
  var elSel = document.getElementById(listBox);
  if (elSel.selectedIndex >= 0) {
    var elOptNew = document.createElement('option');
    elOptNew.text = itemText;
    elOptNew.value = itemValue;
      
    try {
      elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
    }
    catch(ex) {
      elSel.add(elOptNew); // IE only
    }
  }
}