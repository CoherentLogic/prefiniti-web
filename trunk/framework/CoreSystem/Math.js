/*
 * Math.js
 * Prefiniti math support routines
 *
 * John Willis
 * john@prefiniti.com
 *
 * Created 27 Jun 2008
 */


function MRandomRange(high) 
{
	var rn = 0;
	
	
	rn = Math.floor(Math.random() * high); //Math.floor((high - (low - 1))*Math.random()) + high;
	
	if (rn == 0) {
		rn = 1;
	}
	return rn;

	

}
