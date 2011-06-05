<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
	
    <cfquery name="gUsers" datasource="sites">
		SELECT user_id FROM site_associations WHERE site_id=#url.current_site_id# AND assoc_type=1
	</cfquery>

	<cfquery name="qjnv" datasource="webwarecl">
		SELECT clsJobNumber, description FROM projects WHERE site_id=#url.current_site_id#
	</cfquery>
    
    <style type="text/css">
		.PaddedThingy td {
			font-size:12px;
		}	
		.PaddedThingy td label {
			font-size:12px;
			margin:8px;
		}
		.PaddedThingy td select {
			font-size:12px;			
		}
		 
	</style>
    
	<div style="height:100%;position:relative;" class="PaddedThingy">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/timesheet.png" caption="Find Timesheet">                
	<cfoutput>
        
		<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) NEQ true>
            <form name="dateSelEmp">
            <table width="100%" cellpadding="5" cellspacing="0">
                <tr>
                    <th colspan="2"><cfoutput>View by Date</cfoutput></th>
                </tr>                    
                <tr>
                    <td align="right">From</td>
                    <td align="left" nowrap><input name="startDateEmp" id="startDateEmp" type="text" size="15" readonly> 
                    <a href="javascript:popupDate(AjaxGetElementReference('startDateEmp'));"><img src="/graphics/date.png" border="0"></a></td>
                </tr>
                <tr>
                    <td align="right">Until</td>
                    <td align="left" nowrap><input name="endDateEmp" id="endDateEmp" type="text" size="15" readonly> 
                    <a href="javascript:popupDate(AjaxGetElementReference('endDateEmp'));;"><img src="/graphics/date.png" border="0"></a></td>
                </tr>
                <tr>
                    <td align="right"></td>
                    <td align="left">
                        <input type="button" class="normalButton" onclick="javascript:loadWeekToCtls('startDateEmp', 'endDateEmp');" value="Use Current Week" /><br />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <input type="button" name="cancelFindTS" value="Cancel" onclick="hideDiv('landing_timesheet_search'); showDiv('landing_work_links');" />
                        <input type="button" name="printByUserEmp" value="View All Printable" 
                        onclick="javascript:loadTimesheetPrint('tcTarget', #url.calledByUser#, GetValue('startDateEmp'), GetValue('endDateEmp'), 'None', 'no', '')"/>
                        <input type="button" name="getByUser" value="View Editable" 
                        onclick="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, GetValue('startDateEmp'), GetValue('endDateEmp'), 'Open', 'no', '')"/>
                    </td>
                </tr>
                
            </table>
            </form>
            <script language="javascript">
                var startDateEmpCal = new calendar2(document.forms['dateSelEmp'].elements['startDateEmp']);
                var endDateEmpCal = new calendar2(document.forms['dateSelEmp'].elements['endDateEmp']);
            </script>
        </cfif>
    </cfoutput>
	<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
        <form name="dateSel">
        <div style="width:300px; float:left; font-size:12px; margin-top:30px;">
        <table width="100%" cellpadding="5" cellspacing="0">								
            <tr>
                <td align="right"><span style="font-weight: bold">Employee</span></td>
                <td>
                    <select name="byUser" id="byUser">
                            <option value="noUserFilter">All Users</option>
                        <cfoutput query="gUsers">
                            <option value="#user_id#">#getLongname(user_id)#</option>
                        </cfoutput>	
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right"><span style="font-weight: bold">From</span></td>
                <td align="left" nowrap><input name="startDate" id="startDate" type="text" size="15" readonly> 
                <a href="javascript:popupDate(AjaxGetElementReference('startDate'));"><img src="/graphics/date.png" border="0"></a></td>
            </tr>
            <tr>
                <td align="right"><span style="font-weight: bold">Until</span></td>
                <td align="left" nowrap><input name="endDate" id="endDate" type="text" size="15" readonly> 
                <a href="javascript:popupDate(AjaxGetElementReference('endDate'));"><img src="/graphics/date.png" border="0"></a></td>
            </tr>
            <tr>
                <td align="right"></td>
                <td align="left">
                    <a class="button" onclick="javascript:loadWeekToCtls('startDate', 'endDate');"><span>Use Current Week</span></a>
                </td>
            </tr>
        </table>
        </div>
        <div style="width:300px; float:left; font-size:12px; margin-top:30px;">
        <table>                                
            <tr>
                <td align="right"></td>
                <td align="left" nowrap><p style="margin-top:0px; padding-top:0px;">           
                  <label>
                    <input name="filterBy" type="radio" value="None" checked="checked" />
                    View All</label>
                  <br />
                  <label>
                    <input type="radio" name="filterBy" value="Signed" />
                    Signed Only</label>
                  <br />
                  <label>
                    <input type="radio" name="filterBy" value="Open" />
                    Open Only</label>
                  <br />
                  <label>
                    <input type="radio" name="filterBy" value="Approved" />
                    Approved Only</label>
                  <br />
                  </p>									
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                <div style="display:none;">
                    <table>
                        <tr>
                            <td>Project Number:</td>
                            <td>
                                <select name="projectNumber" id="projectNumber">
                                        <option value="" selected="selected">No filter</option>
                                    <cfoutput query="qjnv">
                                        <option value="#clsJobNumber#">#clsJobNumber#</option>
                                    </cfoutput>
                                    
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                </td>                                    
            </tr>                
        </table>
        </div>
        
        <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
            <div style="padding:8px; float:right;" id="search_timesheet_buttons" >
                <cfoutput>
                    <a class="button" href="##" name="cancelFindTS" onclick="CloseORMSDialog();"><span>Cancel</span></a>
                    <a class="button" href="##" name="printByUser" onclick="javascript:loadTimesheetPrint('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber'))"><span>View Printable</span></a>
                    <a class="button"  name="getByUser" onclick="javascript:loadTimesheetView('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber')); hideDiv('gen_window_frame');"><span>View Editable</span></a>
                </cfoutput>	
            </div>
        </div>                                       
        </form>                                                          
    </cfif>
    
							
				