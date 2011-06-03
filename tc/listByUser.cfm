<cfinclude template="/tc/tc_udf.cfm">

<style type="text/css">
	.tcList 
	{
		margin:5px;
		border:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.tcList th
	{
		background-image:none;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;	
	}
</style>
<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="TS_VIEW">
<cfinclude template="/authentication/authentication_udf.cfm">
<!--
<wwafcomponent>View Timesheets</wwafcomponent>
-->

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfparam name="hrsTotal" default="0">
<cfset hrsTotal="0">





<cfquery name="tcByUser" datasource="webwarecl">
	SELECT * FROM time_card WHERE
	<cfif #url.emp_id# NEQ "noUserFilter">
		emp_id=#url.emp_id# 
		AND
	</cfif>
	date>='#DateFormat(url.startDate, "yyyy/mm/dd")#' 
	AND date<='#DateFormat(url.endDate, "yyyy/mm/dd")#'
	<cfif #url.filter# NEQ "None">
		<cfswitch expression="#url.filter#">
			<cfcase value="Open">
				AND closed=0
			</cfcase>
			<cfcase value="Signed">
				AND closed=1
			</cfcase>
			<cfcase value="Approved">
				AND closed=2
			</cfcase>
		</cfswitch>
	</cfif>
	<cfif #url.jobNum# NEQ "">
		AND clsJobNumber='#url.jobNum#'
	</cfif>
    AND site_id=#url.current_site_id#
	ORDER BY date
</cfquery>

<cfif #url.emp_id# NEQ "noUserFilter">
	<cfquery name="getUserName" datasource="webwarecl">
		SELECT longName FROM Users WHERE id=#url.emp_id#
	</cfquery>
</cfif>




<div class="homeHeader"><img src="/graphics/time.png" align="absmiddle"/> <cfoutput>Timesheets for <cfif #url.emp_id# NEQ "noUserFilter">#getUserName.longName#<cfelse>All Users</cfif> from #url.startDate# until #url.endDate# (#tcByUser.RecordCount# records)</cfoutput><br /><img src="/graphics/page_find.png" align="absmiddle" /> Filter Options: <cfoutput>#url.filter#</cfoutput><br><cfif #url.jobNum# NEQ "">Project Number: <cfoutput>#url.jobNum#</cfoutput></cfif>&nbsp;</div>

<table width="90%" cellspacing="0" class="tcList">

	<tr>
		<th align="left" style="-moz-border-radius-topleft:5px;">Date</th>
		<th align="left">Project No.</th>
		<th align="left">Description</th>
		<th align="left">Hrs.</th>
		<th align="left">Status</th>
		<th align="left" style="-moz-border-radius-topright:5px;">Tools</th>
	</tr>
    <cfparam name="totalHours" default="0">
    
	<cfoutput query="tcByUser">
		
		<cfmodule template="/tc/orms_do.cfm" id="#id#">
		
		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="##EFEFEF">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="##EFEFEF">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#">#DateFormat(date, 'mm/dd/yyyy')#</td>
			<td style="background-color:#ColColor#">
            	<cfmodule template="/tc/components/projectsByCard.cfm" id="#id#">
            </td>
			<td style="background-color:#ColColor#">#JobDescription#</td>
			<td style="background-color:#ColColor#">
            	<cfset totalHours=totalHours+tcHoursByTS(id)>
				<span id="hrs_#RowNum#">#tcHoursByTS(id)#</span>
			</td>
			<td style="background-color:#ColColor#">
				<div id="stat_#id#">
					<cfmodule template="/tc/components/tcStatus.cfm" id="#id#">
				</div>
			</td>
			<td style="background-color:#ColColor#" nowrap>
				<img src="/graphics/printer.png" align="absmiddle" /> <a href="/tc/components/viewTimeCard.cfm?id=#id#&current_site_id=#url.current_site_id#" target="_blank">Print</a><br />
				<cfif #getPermissionByKey("TS_EDIT", url.current_association)# EQ true>
                <img src="/graphics/time_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/edit_ts.cfm?id=#id#')">Edit</a></cfif>
                  
				
                <cfif #getPermissionByKey("TS_DELETE", url.current_association)# EQ true>
					<br />
					<img src="/graphics/time_delete.png" align="absmiddle" /> <a href="javascript:deleteTimesheetConfirm('#id#', 'tcTarget')">Delete</a></cfif><br />
                    
                    <img src="/graphics/clock_go.png" align="absmiddle" /> <a href="##" onclick="iif_export_options('#id#');">Export to QuickBooks</a>
                <cfif #getPermissionByKey("TS_APPROVE", url.current_association)# EQ true>
                	<br />
                    <label><input type="checkbox" name="billed_#id#" id="billed_#id#" onclick="tcSetBilled(#id#, IsChecked('billed_#id#'), GetValue('billed_date_#id#'));" <cfif #billed# EQ 1>checked</cfif> />Billed</label> on date
					&nbsp;<input type="text" name="billed_date_#id#" id="billed_date_#id#" onblur="tcSetBilled(#id#, IsChecked('billed_#id#'), GetValue('billed_date_#id#'));" value="#DateFormat(billed_date, 'mm/dd/yyyy')#"><br />
                    <label><input type="checkbox" name="paid_#id#" id="paid_#id#" onclick="tcSetPaid(#id#, IsChecked('paid_#id#'), GetValue('paid_date_#id#'), GetValue('check_number_#id#'));" <cfif #paid# EQ 1>checked</cfif> />Paid</label> on date
					&nbsp;<input type="text" name="paid_date_#id#" id="paid_date_#id#" onblur="tcSetPaid(#id#, IsChecked('paid_#id#'), GetValue('paid_date_#id#'), GetValue('check_number_#id#'));" value="#DateFormat(paid_date, 'mm/dd/yyyy')#"><br />
					<label>Check No.: <input type="text" name="check_number_#id#" id="check_number_#id#" onblur="tcSetPaid(#id#, IsChecked('paid_#id#'), GetValue('paid_date_#id#'), GetValue('check_number_#id#'));" value="#check_number#">
				</cfif>  
				
				
			</td>
		</tr>
		<tr>
			<td colspan="6" style="padding:0px;">
				<p style="font-size:xx-small"><img src="/graphics/zoom.png" align="absmiddle" /> Full View: [<a href="javascript:showDiv('#id#_fv');">+</a>] [<a href="javascript:hideDiv('#id#_fv');">-</a>] 
				<cfif #closed# EQ 0> | <img src="/graphics/text_signature.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/sign.cfm?id=#id#')">Sign Timesheet</a>
				</cfif>
				
					<cfif #closed# EQ 1>
						<cfif #getPermissionByKey("TS_APPROVE", url.current_association)# EQ true>
                    &nbsp;| <img src="/graphics/accept.png" align="absmiddle" /> <a href="javascript:approveTimesheet(#id#, 'stat_#id#');">Approve Timesheet</a></cfif> | <cfif #getPermissionByKey("TS_REVERSE", url.current_association)# EQ true><img src="/graphics/arrow_left.png" align="absmiddle" /> <a href="javascript:reverseTimesheet(#id#, 'stat_#id#');">Reverse Timesheet</a></cfif>
					</cfif>
				</p>
				
					<div id="#id#_fv" style="display:none;">
							<table border="0" cellpadding="3" align="center" width="85%"><tr><td>
							<table style="border:1px solid ##EFEFEF;">
								<tr>
									<td>
										<cfmodule template="/tc/components/tcHeader.cfm" id="#id#"><br />
										<cfmodule template="/tc/components/lineItemsByTC.cfm" timecard_id="#id#"><br>
										<cfmodule template="/tc/components/tcFooter.cfm" id="#id#">
									</td>
								</tr>
							</table>
							</td></tr></table>
					</div>
					<hr style="border:1px solid ##EFEFEF;"/>
			</td>
		</tr>
	</cfoutput>
</table>
<cfoutput>
<table width="65%">
	<tr>
    	<td align="left">
		<strong>Total Hours for This Query:</strong>
		</td>
        <td align="right">
        	<div align="right" id="totalHours">#totalHours#</div>
        </td>
     </tr>
</table>     
</cfoutput>


