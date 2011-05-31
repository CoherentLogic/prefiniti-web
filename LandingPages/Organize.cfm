<cfmodule template="/LandingPages/LandingHeader.cfm">

<cfparam name="UserColl" default="">
<cfset UserColl=ArrayNew(1)>
<cfset UserColl[1]=#url.calledByUser#>

<p style="margin-left:5px;">
	<div id="schedArea" style="width:100%; height:350px; overflow:auto;">
		<cfmodule template="/controls/day_view.cfm" users="#UserColl#" date="#DateFormat(Now(), 'mm/dd/yyyy')#">
	</div>
</p>
    
<h3>Other Scheduling Tools</h3>
<p style="margin-left:5px;">
	<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="View full schedule" url="MySchedule" help="View full schedule"><br />
</p>
