<cfparam name="totalHours" default="0">
<cfset tco = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK("Time Card", attributes.r_pk)>

<cfquery name="getHeader" datasource="webwarecl">
	SELECT * FROM time_card WHERE id=#attributes.r_pk#
</cfquery>


<cfset CanEdit = false>

<cfif tco.CanWrite(URL.CalledByUser)>
	<cfset CanEdit = true>
</cfif>

<cfoutput>		
		<strong class="OH_HEADER">Edit Summary</strong>
		
		<form name="tsHeader" action="/tc/editHeaderSub.cfm" method="post">
	    <label>Date: <cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#getHeader.date#"></label><br />	
	    <label>Description: <input type="text" id="JobDescription" name="JobDescription" value="#getHeader.JobDescription#" /></label><br />
		<label>Time In: <input type="text" id="startTime" name="startTime" value="#TimeFormat(getHeader.startTime, 'h:mm tt')#"/></label><br /><br />
		
		<cfif CanEdit><a class="button" href="##" onclick="editTimesheetHeader('#attributes.r_pk#', GetValue('date'), 'NA', GetValue('JobDescription'), GetValue('startTime'));"><span>Save Changes</span></a></cfif>
		<br>
		<div id="userActionTarget" style="display:none;">&nbsp;</div>
		</form>	
</cfoutput>	

<br><br>