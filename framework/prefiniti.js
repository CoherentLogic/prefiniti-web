/*
 *  prefiniti.js
 *   Prefiniti Application Framework
 *   Contains all of the namespaces for the framework
 *
 *  John Willis
 *  john@prefiniti.com
 *
 *  Created: 6 May 2008
 *
 *  Copyright (C) 2008 AJL Intel-Properties LLC
 *  Patent Pending.
 */

/**
* system globals
*/
var p_session = null;						// default prefiniti session object

/**
* constants
*/
// window styles
var WS_ALLOWCLOSE = 1;
var WS_ALLOWMINIMIZE = 2;
var WS_ALLOWMAXIMIZE = 4;
var WS_ALLOWRESIZE = 8;
var WS_SHOWAPPMENU = 16;
var WS_ENABLEPDM = 32;
var WS_ROOT = 64;
var WS_MODAL = 128;
var WS_ALLOWREFRESH = 256;


var WS_DEFAULT 	= 	WS_ALLOWCLOSE | 
					WS_ALLOWMINIMIZE | 
					WS_ALLOWMAXIMIZE | 
					WS_ALLOWRESIZE | 
					WS_SHOWAPPMENU | 
					WS_ENABLEPDM;
					
var WS_DIALOG  =	WS_ALLOWCLOSE |
					WS_ALLOWMINIMIZE |
					WS_ENABLEPDM |
					WS_SHOWAPPMENU;
					
var WS_LEGACY  =	WS_ALLOWCLOSE;
					
var WS_TOOLWINDOW = WS_SHOWAPPMENU;

// root window config
var ROOT_ZINDEX = 250;
var ROOT_REF = null;


// message identifiers
var IWC_REQUESTCLOSE = 1;
var IWC_REQUESTMINIMIZE = 2;
var IWC_REQUESTMAXIMIZE = 3;
var IWC_REQUESTREFRESH = 4;
var IWC_SCREENRESIZED = 5;
var IWC_GPSSTATUSCHANGED = 6;
var IWC_CONNECTIONLOST = 7;
var IWC_CONNECTIONREGAINED = 8;
var IWC_OBJECTDATACHANGED = 9;
var IWC_GOTFOCUS = 10;
var IWC_LOSTFOCUS = 11;
var IWC_REQUESTSAVE = 12;
var IWC_POPULATEFOLDER = 13;
var IWC_SETTITLETEXT = 14;
var IWC_WINDOWGEOMETRYCHANGED = 15;
var IWC_REQUESTRESIZE = 16;
var IWC_ADDTOCART = 17;
var IWC_CHECKOUTCART = 18;
var IWC_LOCATIONCHANGED = 19;
var IWC_PAYMENTCHANGED = 20;
var IWC_SUBMITORDER = 21;

// component identifiers
var C_SESSIONMANAGER = 0;
var C_WINDOWMANAGER = 1;
var C_MAIL = 2;
var C_WORKFLOW = 3;
var C_TIMECOLLECTION = 4;
var C_SCHEDULING = 5;
var C_GIS = 6;

// window states
var WMS_NORMAL = 0;
var WMS_MINIMIZED = 1;
var WMS_MAXIMIZED = 2;

// window transparencies
var WT_FOCUS = "1";
var WT_BACKGROUND = ".70";

// icons
var P_SMALLICON = null;						// small icon resource
var P_LARGEICON = null;						// large icon resource

// reference types
var RT_OBJECT = 1;
var RT_FOLDER = 2; 

// task priorities
var TP_LOW = 0;
var TP_NORMAL = TP_LOW;
var TP_MEDIUM = 1;
var TP_HIGH = 2;

// logout trap
var PAllowSessionLogout = true;

var CurrentZIndex = 300;
var LastPlacementRect = new PRect(20, 20, 0, 0); 


var PDebug = "";


/**
* datatypes
*/

// dimensions
function PDimensions(width, height) { this.width=width; this.height=height; }

// shapes
function PRect(top, left, width, height) { this.top=top; this.left=left; this.width=width; this.height=height; this.area=function(){return this.width * this.height;};}
function PAutoRect(width, height) { 
	var newLeft;
	var newTop;
	var oldLeft = LastPlacementRect.left;
	var oldTop = LastPlacementRect.top;
	
	
	if (oldTop > (p_session.ScreenHeight - height)) {
		LastPlacementRect.top = 20;
		LastPlacementRect.left = 20;
	}
	
	if (oldLeft > (p_session.ScreenWidth - width)) {
		LastPlacementRect.left = 20;
	}

	tempRect = new PRect(LastPlacementRect.top + 20, LastPlacementRect.left + 20, width, height);
	return tempRect;
}
function PColor(red, green, blue) {
	this.Red = red;
	this.Green = green;
	this.Blue = blue;
	this.HTMLColor = "#" + PadLeft(d2h(red), '0', 2) + PadLeft(d2h(green), '0', 2) + PadLeft(d2h(blue), '0', 2);
}

/*
 * background tasks 
 */
var PTasks = new Array(1);
var TaskID = 0;

function PTask (TaskName, TaskFunction, Priority, Enabled, Owner) {
	this.TaskName = TaskName;
	this.TaskFunction = TaskFunction;
	this.Priority = Priority;
	this.Enabled = Enabled;
	this.Owner = Owner;
	this.RunCount = 0;
	this.TID = null;
}

PTask.prototype.Pause = function () {
	this.Enabled = false;
	
	var sr = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(sr, '<font color="red">Pause</font>');
	
};

PTask.prototype.Resume = function () {
	this.Enabled = true;
	
	var sr = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(sr, '<font color="orange">Wait</font>');
	
};

PTask.prototype.Run = function () {
	this.TaskFunction();
};

function PAddTask(Task) {
	PTasks[TaskID] = Task;
	PTasks[TaskID].TID = TaskID;
	
	TaskID++;
	
	return (TaskID - 1);
}

function PauseAllTasks() {
	for (i in PTasks) {
		PTasks[i].Pause();
	}
}

function ResumeAllTasks() {
	for (i in PTasks) {
		PTasks[i].Resume();
	}
}

function PMaxWait()
{
	var LastWait = 1;
	var MaxWait = 0;
	
	for (i in PTasks)
	{
		LastWait = PTasks[i].Priority;
		if (LastWait > MaxWait) {
			MaxWait = LastWait;
		}
	}
	
	return MaxWait;
}

var CurCycle = 0;
var TotalCycles = 0;
var IdleCycles = 0;
var ActiveCycles = 0;

function PRunTaskQueue ()
{
	var tsRef = null;
	var CycleCount = PMaxWait();
	var taskPercent = 0;
	var tasksInCycle = 0;
	
	for (i in PTasks) {
		tasksInCycle = 0;
		if (CurCycle < CycleCount) {
			CurCycle++;
		}
		else {
			CurCycle = 0;
		}
		TotalCycles++;
		
		SetInnerHTML('CMaxWait', CycleCount.toString());
		SetInnerHTML('CCycle', "RTE Usage: " +  parseInt((ActiveCycles * 100) / TotalCycles) + "%");
		
		if(PTasks[i]) {
			if (PTasks[i].Enabled) {
				if (!(CurCycle % PTasks[i].Priority)) {
					tasksInCycle++;
					tsRef = 'TaskStat_' + i.toString();
					SetInnerHTML(tsRef, '<font color="green">Run</font>');
					PTasks[i].Run();
					PTasks[i].RunCount++;
					SetInnerHTML(tsRef, '<font color="orange">Wait</font>');
					tsRef = 'TaskRC_' + i.toString();
					SetInnerHTML(tsRef, PTasks[i].RunCount.toString());
					
				}
			}
			tsRef = 'TaskPercent_' + i.toString();
			taskPercent = parseInt((PTasks[i].RunCount * 100) / (TotalCycles - IdleCycles));
			SetInnerHTML(tsRef, taskPercent + "%");
		}
		if (tasksInCycle == 0) {
			IdleCycles++;
		}
		else {
			ActiveCycles++;
		}
	}
	
	var b = window.setTimeout("PRunTaskQueue();", 1000);
}

function PEnableTaskQueue ()
{
	PRunTaskQueue();
}

function PAutoUpdater(ResourceURL, TargetDiv)
{
	var udf = function() {
		AjaxSilentLoad(TargetDiv, ResourceURL);
	};
	
	return udf;
}	

function PadLeft(IStr, Char, Count)
{
	var cDiff = Count - IStr.length;
	var apStr = "";
	
	for (i = 0; i < cDiff; i++) {
		apStr += Char;
	}
	
	return apStr + IStr;
}
	
	
function PCircle(x, y, radius) { this.x=x; this.y=y; this.radius=radius; this.Area=function(){return (Math.PI * this.radius * this.radius); };}


// sessions
function PSession(Framework) 
{
	this.ActiveStylesheet = "gecko";
	this.UserID = null;
	this.Framework = Framework;

	this.WindowsHidden = false;
	this.ScreenWidth = 0;
	this.ScreenHeight = 0;
	this.ActiveWindowHandle = null;
	this.PreviousWindowHandle = null;
}

PSession.prototype.SetScreenDimensions = function (width, height) {
	this.ScreenWidth = width;
	this.ScreenHeight = height;
	
	var sdim = new PDimensions(width, height);
	
	var nbRef = AjaxGetElementReference('PNotifyBoxWrapper');
	if (nbRef) {
		// when centering an element, we set its 'left' property equal to
		// the difference between half of the screen width and half of the element width.
		// in this case, the 'magic' number 175 is half the width of PNotifyBoxWrapper.
		// we could have said (p_session.ScreenWidth / 2) - (parseInt(nbRef.style.width) / 2), but since
		// PNotifyBoxWrapper's width is a known constant value, we used a numeric literal
		// instead for computational efficiency.
		var leftPos = ((p_session.ScreenWidth / 2) - 175) + "px";
		nbRef.style.left = leftPos;
	}
	
	var dfRef = AjaxGetElementReference('DesktopFolder');
	
	if (nbRef && dfRef) {	
		dfRef.style.top = parseInt(nbRef.offsetHeight).toString() + "px";
	}
	
	p_session.CenterDock();
	
	
	this.Framework.PostGlobalMessage(IWC_SCREENRESIZED, C_SESSIONMANAGER, sdim);
};

PSession.prototype.CenterDock = function () {
	var dockRef = AjaxGetElementReference('PDesktopManager');
	if (dockRef) {
		var curDockWidth = parseInt(dockRef.offsetWidth);
		var leftPos = ((p_session.ScreenWidth / 2) - (curDockWidth / 2)) + "px";
		dockRef.style.left = leftPos;
	}
};

function HideResChanged() {
	var container = AjaxGetElementReference('PDesktopWindow');
	container.removeChild(AjaxGetElementReference('ResNotifier'));
	//PShowNavigator();
}



PSession.prototype.LogOut = function () {
	//PAllowSessionLogout = true;
	this.Framework.PostGlobalMessage(IWC_REQUESTCLOSE, C_WINDOWMANAGER);
	
	if (PAllowSessionLogout) {
		location.replace("/logoff.cfm");
	}
};


// icon object
function PIcon(url, dimensions)
{
	this.URL = url;
	this.Dimensions = dimensions;
	this.HTMLImgTag = '<img src="' + this.URL + '" height="' + this.Dimensions.height + '" width="' + this.Dimensions.width + '" align="absmiddle" border="0" style="margin:2px;">';
	this.HTMLImgTag32 = '<img src="' + this.URL + '" height="32" width="32" align="absmiddle" border="0">';
}

// window object
function PWindow(handle, title, rect, icon, style, messagehandler, background_color) 
{
	this.Handle = handle;
	this.Title = title;
	this.Rect = rect;
	this.Icon = icon;
	this.LastClientURL = "";
	
	//alert(background_color.HTMLColor);
	dispatch();
	if(style & WS_ROOT) {
		this.WindowState = WMS_MAXIMIZED;
	}
	else {
		this.WindowState = WMS_NORMAL;
	}
	
	this.RestoreRect = this.Rect;
	
	this.NeedsSaving = false;
	
	
	if(messagehandler) {
		this.MessageHandler = messagehandler;
	}
	else {
		this.MessageHandler = p_session.Framework.DefaultMessageHandler;
	}
	
	if(style) {
		this.Style = style;
	}
	else {
		this.Style = WS_DEFAULT;
	}
	
	if(background_color) {
		this.BackgroundColor = background_color;
		//alert("i'm a zulu");
	}
	else {
		this.BackgroundColor = new PColor(255, 255, 255);
		//alert("i'm not a zulu");
	}
	
	try {
	writeConsole("PWindow created at " + this.Rect.top + ", " + this.Rect.left);
	writeConsole("&nbsp;Title: " + this.Title);
	writeConsole("&nbsp;Handle: " + this.Handle);
	writeConsole("&nbsp;Width: " + this.Rect.width);
	writeConsole("&nbsp;Height: " + this.Rect.height);
	writeConsole("&nbsp;Icon URL: " + this.Icon.URL);
	writeConsole("&nbsp;Icon: " + this.Icon.HTMLImgTag);
	} catch (ex) {}
	
	// create the div for the window
	var theDiv = document.createElement('div');
	theDiv.setAttribute('id', this.Handle);
	theDiv.style.position = "absolute";
	theDiv.style.top = this.Rect.top + "px";
	theDiv.style.left = this.Rect.left + "px";
	theDiv.style.width = this.Rect.width + "px";
	theDiv.style.height = this.Rect.height + "px";
	
	LastPlacementRect.top = this.Rect.top;
	LastPlacementRect.left = this.Rect.left;
	
	
	//don't put a border around root window or dynamically depth-position it
	if (style & WS_ROOT) {
		theDiv.style.zIndex = ROOT_ZINDEX;
		theDiv.style.backgroundColor = "#3399CC";
		theDiv.style.overflow = "hidden";
		theDiv.onmousedown = function (event) {
			if (event.which == 3) {
				PGetDesktopMenu(this, event);
			}
		};
	}
	else {
		theDiv.style.border = "1px solid black";
		theDiv.style.zIndex = CurrentZIndex + 1;
		theDiv.style.backgroundColor = this.BackgroundColor.HTMLColor;
	}
	
	
	
	// increase the depth index
	CurrentZIndex++;
	
	// add the window div to the root window
	if (style & WS_ROOT) {
		document.getElementById('window_container').appendChild(theDiv);
	}
	else {
		if (document.getElementById('PDesktopWindow')) {
			document.getElementById('PDesktopWindow').appendChild(theDiv);		
		}
		else {
			document.getElementById('window_container').appendChild(theDiv);
		}
	}
	
	if (this.Style & WS_ENABLEPDM) {
		// create the PDesktopManager icon
		var iconHtml = '<a href="javascript:p_session.Framework.SetFocus(\'' + this.Handle + '\');">';
		iconHtml += this.Icon.HTMLImgTag32 + '<span id="' + this.Handle + '_PDMIconText" style="display:none;">' + this.Title + '</span></a>';
		var PDMDiv = document.createElement('div');
		
		PDMDiv.setAttribute('id', this.Handle + '_PDMIcon');
		
		
		if (document.getElementById('PWindowList')) {
			document.getElementById('PWindowList').appendChild(PDMDiv);
			SetInnerHTML(this.Handle + '_PDMIcon', iconHtml);
			setClass(this.Handle + '_PDMIcon', 'PDMWindowIcon');
		}
		
		p_session.CenterDock();
	}
	
	
	var th = null;
	
	if (style & WS_ROOT) {
		th = '<div id="DesktopFolder" class="DesktopFolder"></div>';
		SetInnerHTML(this.Handle, th);
	}
	else {
		th = '<div class="PWindowTitle" id="' + this.Handle + '_title" onclick="p_session.Framework.SetFocus(\'' + this.Handle + '\');" onmousedown="p_session.Framework.PMoveWindow(this.parentNode, event, \'' + this.Handle + '\');">';
		
		
		if(this.Style & WS_SHOWAPPMENU) {
			var theIcon = this.Icon;
			var mh;
			mh = '<img src="' + theIcon.URL + '" height="' + theIcon.Dimensions.height + '" width="' + theIcon.Dimensions.width + '" align="absmiddle" border="0" style="margin:2px;" onclick="PGetWindowMenu(\'' + this.Handle + '\', this, event)">';
			th += mh;

		}
		else {
			var theIcon = this.Icon;
			var mh;
			mh = '<img src="' + theIcon.URL + '" height="' + theIcon.Dimensions.height + '" width="' + theIcon.Dimensions.width + '" align="absmiddle" border="0" style="margin:2px;">';
			th += mh;
		}
		
		th += '<span id="' + this.Handle + '_TitleText">' + this.Title + '</span>';
		th += '<div class="PWindowControls">';
		/*th += '<a href="javascript:p_session.Framework.RefreshWindow(\'' + this.Handle + '\');">';
		th += '<img src="/graphics/arrow_refresh_small_gray.png" align="absmiddle" style="margin:2px;" border="0">';
		th += '</a>';*/
		
		if(this.Style & WS_ALLOWREFRESH) {
			th += '<a href="javascript:p_session.Framework.PostLocalMessage(\'' + this.Handle + '\', IWC_REQUESTREFRESH, C_WINDOWMANAGER);">';
			th += '<img src="/graphics/refresh.png" align="absmiddle" style="margin:2px;" border="0">';
			th += '</a>';
		}
		
		if(this.Style & WS_ALLOWMINIMIZE) {
			th += '<a href="javascript:p_session.Framework.PostLocalMessage(\'' + this.Handle + '\', IWC_REQUESTMINIMIZE, C_WINDOWMANAGER);">';
			th += '<img src="/graphics/bullet_arrow_down.png" align="absmiddle" style="margin:2px;" border="0">';
			th += '</a>';
		}
		
		if(this.Style & WS_ALLOWMAXIMIZE) {
			th += '<a href="javascript:p_session.Framework.PostLocalMessage(\'' + this.Handle + '\', IWC_REQUESTMAXIMIZE, C_WINDOWMANAGER);">';
			th += '<img src="/graphics/bullet_arrow_up.png" align="absmiddle" style="margin:2px;" border="0">';
			th += '</a>';
		}
		
		if(this.Style & WS_ALLOWCLOSE) {
			th += '<a href="javascript:p_session.Framework.PostLocalMessage(\'' + this.Handle + '\', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">';
			th += '<img src="/graphics/small_close.png" align="absmiddle" style="margin:2px;" border="0">';
			th += '</a>';
		}
		
		th += '</div></div>';
		th += '<div id="' + this.Handle + '_MenuStrip" class="MenuStrip"></div>';
		th += '<div id="' + this.Handle + '_ToolbarStrip" class="ToolbarStrip" ></div>';
		th += '<div id="' + this.Handle + '_ClientArea" class="PWindowClientArea" onclick="p_session.Framework.SetFocus(\'' + this.Handle + '\');"></div>';
		
		if(this.Style & WS_ALLOWRESIZE) {
			th += '<div style="width:100%; text-align:right;"><img style="cursor:nw-resize;"  src="/graphics/draghandle.png" onmousedown="p_session.Framework.PResizeWindow(\'' + this.Handle + '\', event);"></div>';
		}
		
		
		SetInnerHTML(this.Handle, th);
		
		p_session.Framework.SetFocus(this.Handle);
		
		var removeHeight = 0;
		if(this.Style & WS_ALLOWRESIZE) {
			removeHeight = 36;
		}
		else {
			removeHeight = 20;
		}
		
		
		AjaxGetElementReference(this.Handle + '_ClientArea').style.height = (this.Rect.height - removeHeight) + 'px';
		AjaxGetElementReference(this.Handle + '_ClientArea').style.width = this.Rect.width + 'px';
		
		if(this.Style & WS_MODAL) {
			AjaxGetElementReference('scrFade').style.zIndex = ROOT_ZINDEX + 1;
			showDiv('scrFade');
			
		}
		
	}
	
}

PWindow.prototype.WriteWindowInfo = function () {
	writeConsole("Handle: " + this.Handle);
	writeConsole("Title: " + this.Title);
	writeConsole("ClientArea: " + this.Handle + "_ClientArea");
	writeConsole("Icon: " + this.Icon.HTMLImgTag);
	writeConsole("Icon Dimensions: " + this.Icon.Dimensions.width + "x" + this.Icon.Dimensions.height);
	writeConsole("Window Left: " + this.Rect.left);
	writeConsole("Window Top: " + this.Rect.top);
	writeConsole("Window Width: " + this.Rect.width);
	writeConsole("Window Height: " + this.Rect.height);
	
	var wRef;
	
	try {
		wRef = AjaxGetElementReference(this.Handle);
		if(wRef) {
			writeConsole("Window exists in browser DOM");
		}
		else {
			writeConsole("Window does not exist in browser DOM");
		}
	}
	catch (ex) {
		writeConsole("Window does not exist in browser DOM");
	}
	
	try {
		wRef = AjaxGetElementReference(this.Handle + "_ClientArea");
		writeConsole("ClientArea exists in browser DOM");
	}
	catch (ex) {
		writeConsole("ClientArea does not exist in browser DOM");
	}
}
	
PrefinitiFramework.prototype.SetTitleText = function (handle, titleText) {
	var theDiv;
	theDiv = handle + '_TitleText';
	
	SetInnerHTML(theDiv, titleText);
	
	theDiv = handle + '_PDMIconText';
	
	SetInnerHTML(theDiv, titleText);
};


PWindow.prototype.LoadClientArea = function (URL, onTransferCompleted) {
	var ClientAreaDiv;
	ClientAreaDiv = this.Handle + '_ClientArea';
	
	var firstChar;
	
	if(URL.indexOf("?") == -1) {
		firstChar = '?';
	}
	else {
		firstChar = '&';
	}
	
	URL += firstChar + 'PWindowHandle=' + escape(this.Handle);
	URL += '&PWindowClientArea=' + escape(ClientAreaDiv);
	
	
//	alert(URL);
	AjaxLoadPageToDiv(ClientAreaDiv, URL, onTransferCompleted);
	
	this.LastClientURL = URL;
};

PWindow.prototype.RefreshClientArea = function ()
{
	//alert("Refresh with " + this.LastClientURL);
	this.LoadClientArea(this.LastClientURL, null);
};

PWindow.prototype.CreateChildFrame = function (id, CSS_Class) {
	var parentRef = AjaxGetElementReference(this.Handle + '_ClientArea');
	
	if (parentRef) {
		var ChildFrameDiv = document.createElement('div');
	
		ChildFrameDiv.setAttribute('id', id);
		parentRef.appendChild(ChildFrameDiv);
	
		var frameRef = AjaxGetElementReference(id);
	
		if (CSS_Class) {
			setClass(id, CSS_Class);
		}
		
		return frameRef;
	}
	else {
		return null;
	}
};

PWindow.prototype.LoadToolbarStrip = function (URL, otc) {
	var ToolbarStripDiv;
	ToolbarStripDiv = this.Handle + '_ToolbarStrip';
	
	var wRef = this;
	var ToolbarAddedHandler = function () {

		if(wRef.Style & WS_ALLOWRESIZE) {
			wRef.removeHeight = ((AjaxGetElementReference(wRef.Handle + '_Sizer').offsetHeight * 3) + 2) + AjaxGetElementReference(wRef.Handle + '_ToolbarStrip').offsetHeight;
		}
		else {
			wRef.removeHeight = 20 + AjaxGetElementReference(wRef.Handle + '_ToolbarStrip').offsetHeight;
		}
		
		
		AjaxGetElementReference(wRef.Handle + '_ClientArea').style.height = (wRef.Rect.height - wRef.removeHeight) + 'px';
		AjaxGetElementReference(wRef.Handle + '_ClientArea').style.width = wRef.Rect.width + 'px';
		
		otc();
		
	};
	
	AjaxLoadPageToDiv(ToolbarStripDiv, URL, ToolbarAddedHandler);
};

PWindow.prototype.SetClientAreaHTML = function (htmlcode) {
	var ClientAreaDiv;
	ClientAreaDiv = this.Handle + '_ClientArea';
	
	SetInnerHTML(ClientAreaDiv, htmlcode);
};
 
// the Prefiniti object
function PrefinitiFramework()
{
	this.Windows = new Array(1);
	this.Timers = new Array(1); 
	
	var WindowsFound = 0;
	
	this.SetFocus = function (handle)
	{
	
		for(win in this.Windows) {
			if (this.Windows[win].Handle == handle) {
				WindowsFound++;
				
				if(this.Windows[win].Handle != 'PDesktopWindow') {
					try {
						AjaxGetElementReference(this.Windows[win].Handle).style.opacity = WT_FOCUS;
					}
					catch (ex) {}
				}
				setClass(this.Windows[win].Handle + '_title', 'PWindowTitle');
				setClass(this.Windows[win].Handle + '_PDMIcon', 'PDMWindowIcon');
				
				p_session.PreviousWindowHandle = p_session.ActiveWindowHandle;
				p_session.ActiveWindowHandle = this.Windows[win].Handle;
				
				CurrentZIndex++;
				AjaxGetElementReference(this.Windows[win].Handle).style.zIndex = CurrentZIndex.toString();
				AjaxGetElementReference(this.Windows[win].Handle).style.display = "block";
	
				p_session.Framework.PostLocalMessage(this.Windows[win].Handle, IWC_GOTFOCUS, C_WINDOWMANAGER);
				var navRef = AjaxGetElementReference('PrefinitiLauncher');
				if (navRef) {
					navRef.style.display = "none";
				}
			}
			else {
				if(this.Windows[win].Handle != 'PDesktopWindow') {
					try {
						AjaxGetElementReference(this.Windows[win].Handle).style.opacity = WT_BACKGROUND;
					}
					catch (ex) {}
				}
				setClass(this.Windows[win].Handle + '_title', 'PWindowTitleInactive');
				setClass(this.Windows[win].Handle + '_PDMIcon', 'PDMWindowIconInactive');
				//p_session.Framework.PostLocalMessage(this.Windows[win].Handle, IWC_LOSTFOCUS, C_WINDOWMANAGER);
			}
		}
		
		if(WindowsFound == 0) {
		//	p_session.Framework.SetFocus(p_session.PreviousWindowHandle);
		}
		
	};
	
	this.UnsetFocus = function (handle)
	{
	
		for(win in this.Windows) {
			if (this.Windows[win].Handle == handle) {
				if(this.Windows[win].Handle != 'PDesktopWindow') {
					try {
						AjaxGetElementReference(this.Windows[win].Handle).style.opacity = WT_BACKGROUND;
					}
					catch (ex) {}
				}
				setClass(this.Windows[win].Handle + '_title', 'PWindowTitleInactive');
				setClass(this.Windows[win].Handle + '_PDMIcon', 'PDMWindowIconInactive');
				//p_session.Framework.PostLocalMessage(this.Windows[win].Handle, IWC_LOSTFOCUS, C_WINDOWMANAGER);
			}
		}
		
	};
	
}

PrefinitiFramework.Debug = function (caller, e) { 
	var msg = null;
	msg = 'PrefinitiFramework: an exception has occured in ' + caller + '():<br>';
	msg += '&nbsp;Exception Type: ' + e.name + '<br>';
	msg += '&nbsp;Line Number: ' + e.number + '<br>';
	msg += '&nbsp;Description: ' + e.description;
	
	writeConsole(msg);
	
};

PrefinitiFramework.prototype.DefaultMessageHandler = function (handle, msg_id, sender_component, message_object) {
	switch (msg_id) {
		case IWC_REQUESTCLOSE:
			
			var wRef = p_session.Framework.FindWindow(handle);
			if (wRef) {
				if (wRef.NeedsSaving) {
					var ans;
					ans = confirm("Changes have been made to " + wRef.Title + ".\n\nAre you sure you wish to close this window?");
					if (ans) {
						PAllowSessionLogout = true;
						p_session.Framework.DeleteWindow(handle);
					}
					else {
						PAllowSessionLogout = false;
					}
				}
				else {
					p_session.Framework.DeleteWindow(handle);
				}
			}
			
			
			break;
		
		case IWC_REQUESTMINIMIZE:
			p_session.Framework.HideWindow(handle);
			
			break;
		
		case IWC_REQUESTMAXIMIZE:
			p_session.Framework.MaximizeWindow(handle);
			break;
		
		case IWC_REQUESTREFRESH:
			var wRef = p_session.Framework.FindWindow(handle);
			wRef.RefreshClientArea();
			
			break;
		
		case IWC_SCREENRESIZED:	
			break;
		
		case IWC_GPSSTATUSCHANGED:
			break;
		
		case IWC_CONNECTIONLOST:
			break;
		
		case IWC_CONNECTIONREGAINED:
			break;
		
		case IWC_OBJECTDATACHANGED:
			break;
		
		case IWC_GOTFOCUS:
			break;
		
		case IWC_LOSTFOCUS:
			break;
		case IWC_SETTITLETEXT:
			p_session.Framework.SetTitleText(handle, message_object);
			break;
		case IWC_WINDOWGEOMETRYCHANGED:
			var wRef;
			wRef = p_session.Framework.FindWindow(handle);
			
			wRef.Rect = message_object;
			break;
		case IWC_REQUESTRESIZE:
			var wRef;
			wRef = p_session.Framework.FindWindow(handle);
			
			wRef.Rect = message_object;
			var winDiv = AjaxGetElementReference(wRef.Handle);
			
			winDiv.style.left = message_object.left + "px";
			winDiv.style.top = message_object.top + "px";
			winDiv.style.width = message_object.width + "px";
			winDiv.style.height = message_object.height + "px";
			
			var caRef;
			caRef = AjaxGetElementReference(handle + "_ClientArea");
			
			caRef.style.width = message_object.width + "px";
			caRef.style.height = (message_object.height - 36) + "px";
			break;
	}
};

PrefinitiFramework.prototype.PostGlobalMessage = function (msg_id, sender_component, message_object) {
	for(win in this.Windows) {
		this.Windows[win].MessageHandler(this.Windows[win].Handle, msg_id, sender_component, message_object);
	}
};

PrefinitiFramework.prototype.PostLocalMessage = function (handle, msg_id, sender_component, message_object) {
	var wRef;
	wRef = p_session.Framework.FindWindow(handle);
	
	if (wRef) 
		wRef.MessageHandler(handle, msg_id, sender_component, message_object);
};

PrefinitiFramework.prototype.CreateWindow = function (winobj) {
	try {
		
		this.Windows.push(winobj);
	
		var wr = p_session.Framework.FindWindow(winobj.Handle);
		return wr;
	}
	catch (ex) {
		writeConsole(ex);
		return null;
	}
	
	try {
		dispatch();
	} catch (ex) {}
};

PrefinitiFramework.prototype.FindWindow = function (handle) {
	for(win in this.Windows) {
		if (this.Windows[win].Handle == handle) {
			return (this.Windows[win]);
		}
	}
	return (null);
};

PrefinitiFramework.prototype.FindWindowByTitle = function (title) {
	for(win in this.Windows) {
		if (this.Windows[win].Title == title) {
			return (this.Windows[win].Handle);
		}
	}
	return (null);
};

PrefinitiFramework.prototype.HideWindow = function (handle) {
	var wRef;
	var winDiv;

	wRef = this.FindWindow(handle);
	
	if (wRef) {
		winDiv = AjaxGetElementReference(wRef.Handle);
		winDiv.style.display = "none";
		wRef.WindowState = WMS_MINIMIZED;
	}
};

PrefinitiFramework.prototype.MaximizeWindow = function (handle) {
	var wRef;
	var winDiv;

	wRef = this.FindWindow(handle);
	
	//alert("BEFORE: RestoreRect=" + wRef.RestoreRect.width + " Rect=" + wRef.Rect.width + " WS=" + wRef.WindowState);
//	alert(wRef.WindowState);	
	if (wRef.WindowState == WMS_NORMAL) {
		if (wRef) {
			
			var heightOfNotifications = AjaxGetElementReference('PNotifyBoxWrapper').offsetHeight;
			var heightOfDock = 48; //AjaxGetElementReference('PDesktopManager').offsetHeight + 20;
			
			var totalHeightRemoved = heightOfNotifications - heightOfDock;
			
			
			winDiv = AjaxGetElementReference(wRef.Handle);
			/*winDiv.style.width = p_session.ScreenWidth + "px";
			winDiv.style.height = (p_session.ScreenHeight - totalHeightRemoved) + "px";
			winDiv.style.left = "0px";
			winDiv.style.top = heightOfNotifications + "px";*/
			wRef.WindowState = WMS_MAXIMIZED;
			wRef.RestoreRect = wRef.Rect;
			var newWinRect = new PRect(heightOfNotifications, 0, p_session.ScreenWidth, p_session.ScreenHeight - totalHeightRemoved);
			
			p_session.Framework.PostLocalMessage(handle, IWC_REQUESTRESIZE, C_WINDOWMANAGER, newWinRect);
			
			
			//AjaxGetElementReference(this.Handle + '_ClientArea').style.height = (this.Rect.height - 20) + 'px';
			//AjaxGetElementReference(this.Handle + '_ClientArea').style.width = this.Rect.width + 'px';
		}
	}
	else {
		if (wRef) {
			winDiv = AjaxGetElementReference(wRef.Handle);
			/*winDiv.style.width = wRef.RestoreRect.width + "px";
			winDiv.style.height = wRef.RestoreRect.height + "px";
			winDiv.style.left = wRef.RestoreRect.left + "px";
			winDiv.style.top = wRef.RestoreRect.top + "px";*/
			
			p_session.Framework.PostLocalMessage(handle, IWC_REQUESTRESIZE, C_WINDOWMANAGER, wRef.RestoreRect);
			
			wRef.WindowState = WMS_NORMAL;
			wRef.Rect = wRef.RestoreRect;
		}
	}
	//alert("AFTER: RestoreRect=" + wRef.RestoreRect.width + " Rect=" + wRef.Rect.width + " WS=" + wRef.WindowState);
		
};

PrefinitiFramework.prototype.DeleteWindow = function (handle) {
	var wRef;
	wRef = this.FindWindow(handle);
	
	var winDiv;
	
	if (wRef) {
		// delete the displayed HTML for the window
		winDiv = AjaxGetElementReference(wRef.Handle);
		if (wRef.Style & WS_ROOT) {
			var d = document.getElementById('window_container');
		}
		else {
			if(document.getElementById('PDesktopWindow')) {
				var d = document.getElementById('PDesktopWindow');
			}
			else {
				var d = document.getElementById('window_container');
			}
		}
		d.removeChild(winDiv);
		
		if (wRef.Style & WS_ENABLEPDM) {
			// delete the displayed HTML for the DM icon
			winDiv = AjaxGetElementReference(wRef.Handle + '_PDMIcon');
			if (winDiv) {
				d = document.getElementById('PWindowList');
				d.removeChild(winDiv);
			}
			
			p_session.CenterDock();
		}
		
		if (wRef.Style & WS_MODAL) {
			hideDiv('scrFade');
		}
		
		// remove the window from the Windows array
		for (win in this.Windows) {
			if (this.Windows[win].Handle == handle) {
				this.Windows.splice(win, 1);
			}
		}
	}
};

PrefinitiFramework.prototype.ShowDesktop = function () {
	//if (!p_session.WindowsHidden) {
		p_session.Framework.PostGlobalMessage(IWC_REQUESTMINIMIZE, C_WINDOWMANAGER);
	//	p_session.WindowsHidden = true;
	//}
	//else {
	//	for (win in this.Windows) {
	//		p_session.Framework.SetFocus(this.Windows[win].Handle);
	//	}
	//	p_session.WindowsHidden = false;
	//}
};
		

PrefinitiFramework.prototype.CascadeWindows = function () {
	var x = 20;
	var y = 20;
	var cHandle;
	var wRef;
	
	CurrentZIndex = 300;
	
	for(win in this.Windows) {
		
		cHandle = this.Windows[win].Handle;
		
		if (cHandle != "PDesktopWindow") {
			wRef = AjaxGetElementReference(cHandle);
			
			
			if (wRef) {
				wRef.style.left = x + 'px';
				wRef.style.top = y + 'px';
				wRef.style.zIndex = CurrentZIndex;
				
				x += 20;
				y += 20;
				
				CurrentZIndex++;
			
			}
		}
	}
};

PrefinitiFramework.prototype.GetApplicationPanel = function (id) {
	var url;
	url = "/framework/components/AppPanel.cfm?id=" + escape(id);
	
	AjaxLoadPageToDiv('PLInfoArea', url);
};

var PSelected = null;

function PObjectClick(EventParams, IconHandle, ObjectTypeID, ObjectID, ReferenceType, FolderID, DOMElement, FolderItemID)
{
	var mouseButton = 'LEFT';
	var IconRef = AjaxGetElementReference(DOMElement);
	if(IconRef) {
		
	}
	
	
	if (navigator.appName == 'Netscape' && EventParams.which == 3) {
		mouseButton = 'RIGHT';
	}
	else {
		if (navigator.appName == 'Microsoft Internet Explorer' && event.button==2) {
			mouseButton = 'RIGHT';
		}
	}
	
	switch(ReferenceType) {
		case RT_OBJECT:
			switch(mouseButton) {
				case 'LEFT':
					if(PSelected == IconRef) {
						POpenObject(ObjectTypeID, ObjectID);
						soundManager.play('SND_OBJECTCLICK');
					}
					else {
						if(PSelected) {
							PSelected.style.backgroundColor = "";
							PSelected.style.opacity = "1";
						}
						PSelected = IconRef;
						PSelected.style.backgroundColor = "#EFEFEF";
						PSelected.style.opacity = ".40";
						//PSelected.style.positioning = "absolute";
						//alert(PSelected.id);
						p_session.Framework.PDragIcon(PSelected, EventParams, null);
					}
					break;
				case 'RIGHT':
					PGetObjectMenu(IconHandle, EventParams, ObjectTypeID, ObjectID, FolderItemID);
					break;
			}
			break;
		case RT_FOLDER:
			switch(mouseButton) {
				case 'LEFT':
					if(PSelected == IconRef) {
						soundManager.play('SND_OBJECTCLICK');
						POpenFolder(FolderID);
					}
					else {
						if(PSelected) {
							PSelected.style.backgroundColor = "";
							PSelected.style.opacity = "1";
						}
						PSelected = IconRef;
						PSelected.style.backgroundColor = "#EFEFEF";
						PSelected.style.opacity = ".40";
						p_session.Framework.PDragIcon(PSelected, EventParams, null);
					}
					
					break;
				case 'RIGHT':
					PGetFolderMenu(FolderID, IconHandle, EventParams, FolderItemID);
					break;
			}
			break;
	}
	
	return true;
	//alert("Object ID " + ObjectID.toString() + " of type " + ObjectTypeID.toString() + " was " + mouseButton + " clicked.");
}

function GetStockIcon(id, theme, context, icon, size, clickAction, dblClickAction) {
	var path;
	var imgTag;
	
	path = "/graphics/AppIconResources/" + theme + "/";
	path += size.width + "x" + size.height + "/";
	path += context + "/" + icon + ".png";

	imgTag = '<a href="' + path + '" width="' + size.width + '" height="' + size.height + '" ';
	
	if (clickAction) {
		imgTag += 'onclick="' + clickAction + '" ';
	}
	
	if (dblClickAction) {
		imgTag += 'ondblclick="' + clickAction + '" ';
	}
	
	imgTag += 'border="0" align="absmiddle">';
	
	return imgTag;
}

function InitializePrefiniti() 
{
	hideSplash();
	
	var wcDiv = document.createElement('div');
	wcDiv.setAttribute('id', 'window_container');
	wcDiv.style.position = "absolute";
	wcDiv.style.top = "0px";
	wcDiv.style.left = "0px";
	wcDiv.style.width = "0px";
	wcDiv.style.height = "0px";
	
	document.body.appendChild(wcDiv);
	
	
	
	try {
		writeConsole("Prefiniti Application Framework 1.0");
		writeConsole("&nbsp;Copyright &copy; 2008, AJL Intel-Properties LLC");
		writeConsole("");
		writeConsole("Initializing framework...");
	}
	catch (ex) {}
	
	document.oncontextmenu = function () { return false };
	document.onresize = handleAppResize ();
	
	if (!p_session) {
		P_SMALLICON = new PDimensions(16, 16);
		P_LARGEICON = new PDimensions(32, 32);
		p_session = new PSession(new PrefinitiFramework());
		handleAppResize();
		CreateDesktop();
		soundManager.createMovie('/sm2/soundmanager2.swf');
		soundManager.onload = function() {
			soundManager.createSound({
			 id:'SND_SIGNON',
			 url:'/audio/pregreet.mp3'
			});
			soundManager.createSound({
			 id:'SND_OBJECTCLICK',
			 url:'/audio/click.mp3'
			})
			if (glob_userid != 732) {				//TEMPORARY UNTIL SOUNDS THEMEABLE
				soundManager.play('SND_SIGNON');
			}
		
		}

		
		//fwRegisterAutoUpdate('/framework/components/sitestats_steel.cfm', 'PNotifyBox');
		//fwRegisterAutoUpdate('/clock/clock.cfm', 'SystemClock');
		//fwRegisterAutoUpdate('/framework/components/gps_module.cfm', 'SystemGPS');
		
		//var tf = function () { return null; };
		
		var pt;
		pt = new PTask ('Notification Listener', PAutoUpdater('/framework/components/sitestats_steel.cfm', 'PNotifyBox'), 10, true, glob_userid);
		PAddTask(pt);
		pt = new PTask ('System Clock', PAutoUpdater('/clock/clock.cfm', 'SystemClock'), 5, true, glob_userid);
		PAddTask(pt);
		pt = new PTask ('GPS Status Listener', FWCheckGPS, 5, true, glob_userid);
		PAddTask(pt);
		pt = new PTask ('GPS Updater', PAutoUpdater('/framework/components/gps_module.cfm', 'SystemGPS'), 5, true, glob_userid);
		PAddTask(pt);
		
		PEnableTaskQueue();
		
		
		
		try { writeConsole("Framework initialization successful."); } catch(ex) {}
		
		p_session.CenterDock();
		
		
		return true;
	}
	else {
		writeConsole("Framework initialization could not be completed.");
		return false;
	}
}

function CreateDesktop()
{
	var dtRect = new PRect(0, 0, p_session.ScreenWidth, p_session.ScreenHeight);
	var dtIcon = new PIcon('/graphics/show_desktop.png', P_SMALLICON);
	var dtWindowHandle = "PDesktopWindow";
	var dtWindow = new PWindow(dtWindowHandle, 
							   "Prefiniti Desktop", 
							   dtRect, 
							   dtIcon, 
							   WS_ROOT, 
							   DesktopMessageHandler);
	
	ROOT_REF = p_session.Framework.CreateWindow(dtWindow);
	p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_SCREENRESIZED, 
										 C_WINDOWMANAGER, 
										 new PDimensions(p_session.ScreenWidth, p_session.ScreenHeight));
	p_session.Framework.PostLocalMessage('PDesktopWindow', 
										 IWC_POPULATEFOLDER, 
										 C_WINDOWMANAGER,
										 null);	
}

function DesktopMessageHandler(handle, msg_id, sender_component, message_object)
{
	//alert(handle);
	switch (msg_id) {
		case IWC_POPULATEFOLDER:
			PPopulateFolder('DesktopFolder', 0, 'VT_ICON');
			break;
		case IWC_SCREENRESIZED:	
			
			
			var wRef;
			wRef = AjaxGetElementReference("PDesktopWindow");
			wRef.style.width = message_object.width + "px";
			wRef.style.height = message_object.height + "px";
			
			/*var clockRef = AjaxGetElementReference('SystemClock');
			if (clockRef) {
				clockRef.style.zIndex = p_session.Framework.FindWindow('PDesktopWindow').style.zIndex + 10;
			}*/
			
			// load the resized desktop wallpaper.
			// lots of undue cleverness in here, but it felt right at the time...
			var url;
			url = '/framework/components/get_desktop_background.cfm?Width=' + escape(message_object.width);
			url += '&Height=' + escape(message_object.height);
			
			
			AjaxLoadPageToDiv('dev-null', url);
			
			var targetDiv = AjaxGetElementReference('PDesktopWindow');
			var newDiv = document.createElement('div');
			newDiv.setAttribute('id', 'ResNotifier');
			
			targetDiv.appendChild(newDiv);
			
			var onCompleteCallback = function () {
				SetInnerHTML('screenRes', message_object.width + "x" + message_object.height);
				
				window.setTimeout('HideResChanged();', 1000);
				
			};
			
			AjaxLoadPageToDiv('ResNotifier', '/framework/components/resolution_changed.cfm', onCompleteCallback);
			break;
		default:
			p_session.Framework.DefaultMessageHandler(handle, msg_id, sender_component, message_object);
			break;
	}
}
	
function PRunCode(code)
{
	writeConsole("PFrameworkRun: " + code);
	
	try {
		eval(code);
	}
	catch (ex) {
		writeConsole("PFrameworkRun exception: " + ex.toString());
	}
}


function PShowNavigator()
{
	var navRef = AjaxGetElementReference('PrefinitiLauncher');
	navRef.style.display = "inline";
	navRef.style.zIndex = CurrentZIndex + 1;
	
	p_session.Framework.UnsetFocus(p_session.ActiveWindowHandle);
	
	//p_session.WindowsHidden = false;
	//p_session.Framework.ShowDesktop();
}		

function PGetDesktopMenu(desktopObject, e)
{
	var DesktopMenu = new Array(1);
	
	DesktopMenu[0] = '<img src="/graphics/folder_add.png"><a href="javascript:PCreateFolder(0);">Create Folder...</a>';
	DesktopMenu[1] = '<img src="/graphics/arrow_refresh_small.png"><a href="javascript:p_session.Framework.PostLocalMessage(\'PDesktopWindow\', IWC_POPULATEFOLDER, C_WINDOWMANAGER);">Refresh Now</a>';
	DesktopMenu[2] = '<img src="/graphics/application_view_list.png"><a href="javascript:PPopulateFolder(\'DesktopFolder\', 0, \'VT_LIST\');">View as List</a>';
	DesktopMenu[3] = '<img src="/graphics/application_view_icons.png"><a href="javascript:PPopulateFolder(\'DesktopFolder\', 0, \'VT_ICON\');">View as Icons</a>';
	DesktopMenu[4] = '<img src="/graphics/AppIconResources/crystal_project/16x16/actions/agt_add-to-desktop.png"><a href="javascript:cmsPrepareUploader(\'*.*\', \'All Files\', \'user\', ' + glob_current_site_id + ', ' + glob_userid + ', \'project_files\', \'\', 0);">Upload files to Desktop...</a>';
	DesktopMenu[5] = '<img src="/graphics/cog.png"><a href="javascript:PBackgroundServices();">Background Services...</a>';
	
	
	dropdownmenu(desktopObject, e, DesktopMenu, '150px;');
} 

function PGetWindowMenu(windowHandle, iconObject, e)
{
	var WindowMenu = new Array(1);
	WindowMenu[0] = '<img src="/graphics/bullet_arrow_down.png"><a href="javascript:p_session.Framework.PostLocalMessage(\'' + windowHandle + '\', IWC_REQUESTMINIMIZE, C_WINDOWMANAGER);">Minimize</a>';
	WindowMenu[1] = '<img src="/graphics/small_close.png"><a href="javascript:p_session.Framework.PostLocalMessage(\'' + windowHandle + '\', IWC_REQUESTCLOSE, C_WINDOWMANAGER);">Close</a>';
	
	dropdownmenu(iconObject, e, WindowMenu, '150px');
}

function PGetObjectMenu(OnObject, EventHandle, ObjectTypeID, ObjectID, FolderItemID)
{
	var ObjectMenu = new Array(1);
	
	ObjectMenu[0]='<img src="/graphics/page_white_go.png"><a href="javascript:POpenObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Open</strong></a>'; 
	ObjectMenu[1]='<img src="/graphics/bin.png"><a href="javascript:PDeleteObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Delete</strong></a>'; 
	ObjectMenu[2]='<img src="/graphics/page_white_edit.png"><a href="javascript:PRenameObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Rename</strong></a>'; 
	ObjectMenu[3]='<img src="/graphics/show_desktop.png"><a href="javascript:PCreateReference(0, ' + ObjectTypeID + ', ' + ObjectID + ', \'SYSOBJ\');"><strong>Create link on desktop</strong></a>'; 
	ObjectMenu[4]='<img src="/graphics/folder_add.png"><a href="javascript:PBrowseReference(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Create link in folder</strong></a>'; 
	ObjectMenu[5]='<img src="/graphics/basket_add.png"><a href="javascript:PGrabObject(' + FolderItemID + ');">Grab this item</a>';
	ObjectMenu[6]='<img src="/graphics/group_add.png"><a href="javascript:PShareObject(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Share this item...</strong></a>'; 
	ObjectMenu[7]='<img src="/graphics/wrench.png"><a href="javascript:PObjectInfo(' + ObjectTypeID + ', ' + ObjectID + ');"><strong>Properties...</strong></a>';
	
	
	dropdownmenu(OnObject, EventHandle, ObjectMenu, '170px');
}

function PGetFolderMenu(FolderID, OnObject, EventHandle, FolderItemID) 
{
	var FolderMenu = new Array(1);
	FolderMenu[0]='<img src="/graphics/folder_explore.png"><a href="javascript:POpenFolder(' + FolderID + ');">Browse This Folder</a>';
	FolderMenu[1]='<img src="/graphics/folder_edit.png"><a href="javascript:PRenameFolder(' + FolderID + ');">Rename This Folder...</a>';
	FolderMenu[2]='<img src="/graphics/folder_delete.png"><a href="javascript:PDeleteFolder(' + FolderID + ');">Move to Bin</a>';
	FolderMenu[3]='<img src="/graphics/folder_user.png"><a href="javascript:PShareFolder(' + FolderID + ');">Share This Folder...</a>';
	if (PBICount() > 0) {
		FolderMenu[4]='<img src="/graphics/basket_remove.png"><a onmousedown="javascript:PLetGoMenu(this, event, ' +  FolderID + ');" href="##">Let Go of ' + PBICount() + ' Items Here &gt;&gt;</a>';
	}
	
	dropdownmenu(OnObject, EventHandle, FolderMenu, '180px');
	
}

function PLetGoMenu(OnObject, EventHandle, TargetFolderID)
{
	var LetGoMenu = new Array(1);
	LetGoMenu[0]='<img src="/graphics/page_white_copy.png"><a href="javascript:PCopySelected(' + TargetFolderID + ');">Copy</a>';
	LetGoMenu[1]='<img src="/graphics/page_white_put.png"><a href="javascript:PMoveSelected(' + TargetFolderID + ');">Move</a>';
	
	dropdownmenu(OnObject, EventHandle, LetGoMenu, '170px');
}
	


function PAddEvent(obj, evType, fn)
{ 

	if (obj.addEventListener) { 
		obj.addEventListener(evType, fn, false); 
		return true; 
	} 
	else if (obj.attachEvent) { 
		var r = obj.attachEvent("on"+evType, fn); 
		return r; 
	} 
	else { 
		return false; 
	} 
}

function NullFunction()
{
	return;
}

function d2h(d) 
{
	return d.toString(16);
}

function h2d(h) 
{
	return parseInt(h, 16);
} 

function DumpWindows() 
{
	for(win in p_session.Framework.Windows) {
		p_session.Framework.Windows[win].WriteWindowInfo();
	}
}

PrefinitiFramework.prototype.PMoveWindow = function(control, event, handle) 
{
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	try {
		document.addEventListener("mousemove", moveHandler, true);
		document.addEventListener("mouseup", upHandler, true);
	}
	catch (ex) {
		document.attachEvent("onmousemove", moveHandler);
		document.attachEvent("onmouseup", upHandler);
	}
	
    if (event.stopPropagation) {
		event.stopPropagation();
	}
    else {
		event.cancelBubble = true;                    
	}

    if (event.preventDefault) {
		event.preventDefault();     
	}
    else {
		event.returnValue = false;
	}
	
	var wRef;
	wRef = p_session.Framework.FindWindow(handle);
	
	if (wRef) {
		p_session.Framework.PostLocalMessage(handle, 
											 IWC_WINDOWGEOMETRYCHANGED, 
											 C_WINDOWMANAGER, 
											 new PRect(event.clientY - deltaY, 
													   event.clientX - deltaX, 
													   wRef.Rect.width, 
													   wRef.Rect.height));
	}
	
	function moveHandler(e) {
		if (!e) e = window.event;
		
		control.style.left = (e.clientX - deltaX) + "px";
		control.style.top = (e.clientY - deltaY) + "px";
		
		if(e.stopPropagation) e.stopPropagation();
		else e.cancelBubble = true;
	}
	
	function upHandler(e) {
		if (!e) e = window.event;  // IE event model

		// Unregister the capturing event handlers.
		if (document.removeEventListener) {    // DOM Event Model
		  document.removeEventListener("mouseup", upHandler, true);
		  document.removeEventListener("mousemove", moveHandler, true);
		}
		else {       // IE 5+ Event Model
		  document.detachEvent("onmouseup", upHandler);
		  document.detachEvent("onmousemove", moveHandler);
		}
		
		if(e.stopPropagation) e.stopPropagation();
		else e.cancelBubble = true;
	}
};

PrefinitiFramework.prototype.PResizeWindow = function(handle, event) 
{
	var control = AjaxGetElementReference(handle);
	var clientArea = AjaxGetElementReference(handle + '_ClientArea');
	
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	var width = parseInt(control.style.width);
	var height = parseInt(control.style.height);
	
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	

	
	
	document.addEventListener("mousemove", moveResizeHandler, true);
	document.addEventListener("mouseup", upResizeHandler, true);
	
	event.stopPropagation();
	event.preventDefault();
	
	/*var wRef;
	wRef = p_session.Framework.FindWindow(handle);
	
	if (wRef) {
		p_session.Framework.PostLocalMessage(handle, IWC_WINDOWGEOMETRYCHANGED, C_WINDOWMANAGER, new PRect(event.clientY - deltaY, event.clientX - deltaX, wRef.Rect.width, wRef.Rect.height));
	}*/
	
	function moveResizeHandler(event) {
		var realX = mouseX(event);
		var realY = mouseY(event);
		//writeConsole("realX=" + realX.toString() + " x=" + x.toString());
		control.style.width = (realX - x) + "px";
		control.style.height = (realY - y) + "px";
		clientArea.style.width = (realX - x) + "px";
		clientArea.style.height = (realY - y - 36) + "px";
		event.stopPropagation();
	}
	
	function upResizeHandler(event) {
		
		document.removeEventListener("mouseup", upResizeHandler, true);
		document.removeEventListener("mousemove", moveResizeHandler, true);
		
		event.stopPropagation();
	}
};

PrefinitiFramework.prototype.PDragIcon = function(control, event, handle) 
{
	//control = AjaxGetElementReference(control);
	//alert(control.id);
	var x = parseInt(control.style.left);
	var y = parseInt(control.style.top);
	
	var deltaX = event.clientX - x;
	var deltaY = event.clientY - y;
	
	document.addEventListener("mousemove", dragIconMoveHandler, true);
	document.addEventListener("mouseup", dragIconUpHandler, true);
	
	event.stopPropagation();
	event.preventDefault();
	
	
	function dragIconMoveHandler(event) {
		control.style.left = (event.clientX - deltaX) + "px";
		control.style.top = (event.clientY - deltaY) + "px";
		event.stopPropagation();
	}
	
	function dragIconUpHandler(event) {
		document.removeEventListener("mouseup", dragIconUpHandler, true);
		document.removeEventListener("mousemove", dragIconMoveHandler, true);
		
		event.stopPropagation();
	}
};

function ZoomIcon(i)
{
	r = AjaxGetElementReference(i);
	
	if (r) {
		r.style.width = "58px";
		r.style.height = "58px";
		r.parentNode.style.marginTop = "-38px";
	}
	
	p_session.CenterDock();
}

function UnZoomIcon(i)
{
	r = AjaxGetElementReference(i);
	
	if (r) {
		r.style.width = "32px";
		r.style.height = "32px";
		r.parentNode.style.marginTop = "-30px";
	}
	
	p_session.CenterDock();
}

// welcome screen stuff
// 7/16/2008

function PWelcomeScreen() 
{
	var WShandle 	= 'WelcomeScreen';
	var WStitle 	= 'Welcome to Prefiniti';
	var WSicon 		= new PIcon('/graphics/pi-16x16.png', P_SMALLICON);
	var WSstyle 	= WS_DIALOG;
	var WSrect 		= new PAutoRect(600, 450);
	
	var WSwin		= new PWindow(WShandle, 
								  WStitle,
								  WSrect,
								  WSicon,
								  WSstyle,
								  null,
								  new PColor(255, 255, 255));
	
	var wRef		= p_session.Framework.CreateWindow(WSwin);
	wRef.LoadClientArea("/framework/components/PWelcomeScreen.cfm");
	
	
}

function wsResetAll()
{
	hideDiv('CWork');
	hideDiv('CShop');
	hideDiv('CSocialize');
	setClass('tab_work', 'PTabButtonInactive');
	setClass('tab_shop', 'PTabButtonInactive');
	setClass('tab_socialize', 'PTabButtonInactive');
	
}

function wsOpen(sectionName)
{
	wsResetAll();
	
	switch(sectionName) {
		case 'Work':
			showDivBlock('CWork');
			setClass('tab_work', 'PTabButtonActive');
		break;
		case 'Shop':
			showDivBlock('CShop');
			setClass('tab_shop', 'PTabButtonActive');	
		break;
		case 'Socialize':
			showDivBlock('CSocialize');
			setClass('tab_socialize', 'PTabButtonActive');
		break;
	}
}



/* new cart mgmt stuff */

function SetAssoc(SourceOTID, SourceOIID, DestOTID, DestOIID, Value)
{
	var url;
	url = '/framework/components/SetAssoc.cfm?SourceOTID=' + escape(SourceOTID);
	url += '&SourceOIID=' + escape(SourceOIID);
	url += '&DestOTID=' + escape(DestOTID);
	url += '&DestOIID=' + escape(DestOIID);
	if (Value) {
		url += '&Value=1';
	}
	else {
		url += '&Value=0';
	}
	
	AjaxLoadPageToDiv('dev-null', url);
}