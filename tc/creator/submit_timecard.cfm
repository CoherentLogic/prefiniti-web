<!---

$Id$

Copyright (C) 2011 John Willis
 
This file is part of Prefiniti.

Prefiniti is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Prefiniti is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.

--->
<cfinclude template="/framework/framework_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="CreateTimesheet" datasource="webwarecl">
	INSERT INTO time_card 
		(emp_id,
		date,
		JobDescription,
		startTime,
		submitID,
        site_id)
	VALUES (#url.client_id#,
			#CreateODBCDateTime(url.date)#,
			'#url.JobDescription#',
			#CreateODBCDateTime(Now())#,
			'#url.om_uuid#',
            #url.site_id#)		
</cfquery>

<cfquery name="gTSid" datasource="webwarecl">
	SELECT id FROM time_card WHERE submitID='#url.om_uuid#'
</cfquery>

<cfmodule template="/tc/orms_do.cfm" id="#gTSid.id#">

<div style="display:none;">

<cfset po = CreateObject("component","Res").GetByTypeAndPK("Time Card", gTSid.id)>
<cfset po.DoAccess("View", url.calledByUser)>
</div>
<cfoutput>
<a class="button" href="##" onclick="CloseORMSDialog(); openTS(#gTSid.id#, 'tcTarget');"><span><strong>Finish</strong></span></a>
</cfoutput>
			