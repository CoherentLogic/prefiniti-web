/*
 * home.js
 * DHTML/AJAX functions for the home page
 *
 * John Willis
 * john@prefiniti.com
 *
 * Created 27 Jun 2008
 *
 */
 
var LAST_IMAGE = 5; //change this to increase or decrease the range of images scrolled

var imgIndex = 1;
function HScrollBackground()
{
	var imgURL = 'url(/homeres/back_0' + imgIndex.toString() + '.jpg)';
	document.getElementById('mainArea').style.backgroundImage = imgURL;
	
	window.setTimeout("HScrollBackground();", 10000);
	
	if (imgIndex < LAST_IMAGE) {
		imgIndex++;
	}
	else {
		imgIndex = 1;
	}
}