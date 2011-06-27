<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="TS_CREATE">
<!--
<wwafcomponent>New Timesheet</wwafcomponent>
<wwafpackage>Time Management</wwafpackage>
<wwaficon>time.png</wwaficon>
-->


<cfquery name="userinfo" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#URL.userid#
</cfquery>

<cfquery name="qJobNumbers" datasource="webwarecl">
	SELECT clsJobNumber, description FROM projects WHERE site_id=#url.current_site_id# ORDER BY clsJobNumber DESC
</cfquery>

<cfquery name="chkDup" datasource="webwarecl">
	SELECT * FROM time_card WHERE date=#CreateODBCDate(Now())# AND site_id=#url.current_site_id# AND emp_id=#session.user.r_pk#
</cfquery>    

<cfswitch expression="#URL.action#">
	<cfcase value="view">
		View Timesheet
	</cfcase>
	<cfcase value="edit">
		Edit Timesheet
	</cfcase>
	<cfcase value="add">
		<form name="tsNew" action="tc/newts_sub.cfm" method="post">
			<cfoutput>
				<input type="hidden" name="submitID" id="submitID" value="#CreateUUID()#" />
				<input type="hidden" name="emp_id" id="emp_id" value="#url.userid#" />
			</cfoutput>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Create a New Timesheet</h3>
        </div>
    </div> 
    <br />
    <br />
    <div style="border:1px solid blue; width:640px; font-size:10px; color:blue; background-color:#FFC; padding:8px;">
   		<strong>PLEASE NOTE:</strong> Project numbers are now entered separately for each line item. Therefore, you no longer need to create more than one timesheet per day, unless you do work for more than one company on that day.<br /><br />
        <em style="color:red;">If you have problems creating or editing timecards after this change, please try refreshing the page (<strong>F5</strong> on Windows&reg; systems). This will ensure that you are running the latest Prefiniti code.</em>
	</div>      
			<cfif chkDup.RecordCount GT 0>
            	 <div style="border:1px solid blue; width:640px; font-size:10px; color:blue; background-color:#FFC; padding:8px;">
                 	<strong>Existing Timesheet Found</strong><br /><br />
                    
                    <cfoutput>
                    <p>It appears that you have already begun one or more timesheets for today. It is recommended that you add to one of the existing timesheets rather than creating another.</p>
                    </cfoutput>
                    
                    <p>You may choose an existing timesheet from the list below, or scroll down to create a new one.</p>
                    <blockquote>
					<cfoutput query="chkDup">
                    	<a href="####" onclick="openTS(#id#, 'tcTarget');">Timesheet ###id#</a><br />
                    </cfoutput>                                                
					</blockquote>                    
				</div>                    
            </cfif>
            
            <table width="100%">

				<tr>
					<td>Name:</td>
					<td><cfoutput>#userinfo.longname#</cfoutput></td>
				</tr>
				<tr>
					<td>Date:</td>
					<td><cfoutput><cfmodule template="/controls/date_picker.cfm" ctlname="date" startdate="#Now()#"></cfoutput></td>
				</tr>
				<!---<tr>
					<td>Project Number:</td>
					<td>
					 
								<select name="JobNumSel" id="JobNumSel">
										<option value="WEB DEVEL">Web Development</option>
										<option value="SCAN DOCS">Document Scanning</option>
										<option value="ADMIN">Administration</option>
									<cfoutput query="qJobNumbers">
										<option value="#clsJobNumber#">#clsJobNumber#   #description#</option>
									</cfoutput>
								</select>	
						
						
						
						  </td>
				</tr>--->
				<tr>
					<td>Timecard Description:</td>
					<td><input type="text" id="jobDescription" name="jobDescription" /></td>
				</tr>
				<tr>
					<td>Time In:</td>
					<td><input type="text" id="startTime" name="startTime" /></td>
				</tr>
				<tr>
					<!--function createTimesheet(emp_id, date, JobNumSel, JobNumManual, JobDescription, startTime, submitID, JobNumberType)-->
					<td>&nbsp;</td>
                    <cfoutput>
					<td align="right"><input type="button" class="normalButton" name="Submit" value="Create Timesheet" onclick="createTimesheet('tcTarget', GetValue('emp_id'), GetValue('date'), 'NA', GetValue('jobDescription'), GetValue('startTime'), GetValue('submitID'));" /></td></cfoutput>
				</tr>
			</table>
		</form>
	</cfcase>
</cfswitch>

