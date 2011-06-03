<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="udHeader" datasource="webwarecl">
	UPDATE time_card 
	SET		date			=	#CreateODBCDateTime(url.date)#,
			clsJobNumber	=	'#url.clsJobNumber#',
			JobDescription	=	'#url.JobDescription#',
			startTime		=	#CreateODBCDateTime(url.startTime)#
	WHERE	id				=	#url.id#
</cfquery>

<cfmodule template="/tc/orms_do.cfm" id="#url.id#">

<strong>Timesheet Saved</strong>

<cfoutput>
#ntBusinessEventNotify("TC_TIMESHEET_EDITED", url.current_site_id, "Timesheet summary edited by #getLongname(url.CalledByUser)#.", "")#
</cfoutput>	