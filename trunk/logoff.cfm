
	<cfparam name="suid" default="">
	<cfparam name="sln" default="">
	
	

 
<cfset suid=session.userid>
<cfset sln=session.longname>
	<cfset session.loggedin="no">
	<cfset session.username="">
	<cfset session.longname="">
	<cfset session.userid="">
	<cfset session.loadcount="0">
	<cflocation url="/homeres/SignIn/SignIn.cfm" addtoken="no">
	
