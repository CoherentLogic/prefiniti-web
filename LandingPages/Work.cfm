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
<cfmodule template="/LandingPages/LandingHeader.cfm">

<cfquery name="MyDepts" datasource="sites">
	SELECT * FROM department_entries WHERE user_id=#url.calledByUser#
</cfquery>	



<div id="landing_work_links" style="display:block;height:100%;position:relative;">

	<div style="width:300px; min-height:120px; float:left;">
	<table cellpadding="5">
    	<tr>
        	<td valign="bottom"><img src="http://us-production-r1g1s1.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/contents.png" /></td>
            <td>
            	<span class="LandingHeaderText">Project Management</span><br />
                <p style="margin-left:10px;">
	                <img class="LandingLink" src="/graphics/page_white_add.png" align="absmiddle"/>&nbsp;
                	<cfmodule template="/framework/link.cfm" perm="WF_CREATE" linkname="New Project..." url="NewProject"><br />
	                <img class="LandingLink" src="/graphics/find.png" align="absmiddle"/>&nbsp;
					<cfmodule template="/framework/link.cfm" perm="WF_VIEW" linkname="Find Projects..." url="FindProject"><br />
	                <img class="LandingLink" src="/graphics/wand.png" align="absmiddle"/>&nbsp;
                    <cfmodule template="/framework/link.cfm" perm="WF_PROCESSORDER" linkname="Approve Projects..." url="/jobViews/newJobs.cfm"><br />    				
				</p>
            </td>
        </tr>
	</table>
    </div>
	<div style="width:300px; min-height:120px; float:left;">
	<table cellpadding="5">
    	<tr>
        	<td valign="bottom"><img src="http://us-production-r1g1s1.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/kalarm.png" /></td>
            <td>
            	<span class="LandingHeaderText">Time Collection</span><br />
                <p style="margin-left:10px;">
	                <img class="LandingLink" src="/graphics/page_white_add.png" align="absmiddle"/>&nbsp;
                	<cfmodule template="/framework/link.cfm" perm="TS_CREATE" linkname="New Timesheet..." url="NewTimesheet"><br />
                    <img class="LandingLink" src="/graphics/find.png" align="absmiddle"/>&nbsp;
					<cfmodule template="/framework/link.cfm" perm="TS_VIEW" linkname="Find Timesheet..." url="FindTimesheet" ><br />
				</p>
            </td>
        </tr>
	</table>  
    </div>          
	<div style="width:300px; min-height:120px; float:left;">
	<table cellpadding="5">
    	<tr>
        	<td valign="bottom"><img src="http://us-production-r1g1s1.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/info.png" /></td>
            <td>
            	<span class="LandingHeaderText">Customize Business</span><br />
                <p style="margin-left:10px;">
	                <img class="LandingLink" src="/graphics/user_edit.png" align="absmiddle"/>&nbsp;
                    <cfmodule template="/framework/link.cfm" perm="AS_VIEW" linkname="Employees and customers..." url="/authentication/components/associationManager.cfm" help="Manage employees and customers"><br />	
                    <img class="LandingLink" src="/graphics/page.png" align="absmiddle"/>&nbsp;
                	<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Change site information..." url="/authentication/components/maintenancePanel.cfm?section=site_information.cfm"><br />
                    <img class="LandingLink" src="/graphics/group_edit.png" align="absmiddle"/>&nbsp;
					<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Manage departments..." url="/authentication/components/maintenancePanel.cfm?section=departments.cfm"><br />
					<img class="LandingLink" src="/graphics/lightning.png" align="absmiddle"/>&nbsp;
					<cfmodule template="/framework/link.cfm" perm="WW_SITEMAINTAINER" linkname="Manage event notifications..." url="/authentication/components/maintenancePanel.cfm?section=order_settings.cfm"><br />
                   
				</p>
            </td>
        </tr>
	</table>  
    </div>
</div> <!--- landing_work_links --->

<div id="landing_timesheet_search" style="display:none;height:100%;position:relative;">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
	
    <!---<cfquery name="gUsers" datasource="webwarecl">
		SELECT longName, id FROM Users WHERE type=1 ORDER BY lastName, firstName 
	</cfquery>--->
    
    <cfquery name="gUsers" datasource="sites">
		SELECT user_id FROM site_associations WHERE site_id=#url.current_site_id# AND assoc_type=1
	</cfquery>

	<cfquery name="qjnv" datasource="webwarecl">
		SELECT clsJobNumber, description FROM projects WHERE site_id=#url.current_site_id#
	</cfquery>
    
    <table cellpadding="10">
    	<tr>
        	<td valign="bottom"><img src="http://us-production-r1g1s1.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/find.png" /></td>
            <td>
            	<span class="LandingHeaderText">Find Timesheet</span><br />
            </td>
		</tr>
	</table>                  
				<cfoutput>
							
							
							<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) NEQ true>
								<form name="dateSelEmp">
								<table width="100%" cellpadding="0" cellspacing="0">
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
							<div style="width:300px; float:left; font-size:12px;">
                            <table width="100%" cellpadding="0" cellspacing="0">								
								<tr>
									<td align="right">Employee</td>
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
									<td align="right">From</td>
									<td align="left" nowrap><input name="startDate" id="startDate" type="text" size="15" readonly> 
									<a href="javascript:popupDate(AjaxGetElementReference('startDate'));"><img src="/graphics/date.png" border="0"></a></td>
								</tr>
								<tr>
									<td align="right">Until</td>
									<td align="left" nowrap><input name="endDate" id="endDate" type="text" size="15" readonly> 
									<a href="javascript:popupDate(AjaxGetElementReference('endDate'));"><img src="/graphics/date.png" border="0"></a></td>
								</tr>
								<tr>
									<td align="right"></td>
									<td align="left">
										<input type="button" onclick="javascript:loadWeekToCtls('startDate', 'endDate');">Use Current Week</a>
									</td>
								</tr>
							</table>
                            </div>
                            <div style="width:300px; float:left; font-size:12px;">
                            <table>                                
								<tr>
									<td align="right"></td>
									<td align="left" nowrap><p>
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
									  </p>									</td>
								</tr>
								<tr>
                                	<td>&nbsp;</td>
                                    <td>
                                	<div style="display:none;">
                                        <table><tr>
                                        <td>Project Number:</td>
                                        <td>
                                            <select name="projectNumber" id="projectNumber">
                                                    <option value="" selected="selected">No filter</option>
                                                <cfoutput query="qjnv">
                                                    <option value="#clsJobNumber#">#clsJobNumber#</option>
                                                </cfoutput>
                                                
                                            </select>
                                        </td></tr></table>
                                    </div>
                                    </td>                                    
								</tr>
								<tr>
									<td colspan="2" align="right">
																		</td>
								</tr>
								
							</table>
                            </div>
                            <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
							<div style="padding:8px; float:right;" id="search_timesheet_buttons" >
                            <cfoutput>
                                          <a class="button" href="##" name="cancelFindTS" onclick="hideDiv('landing_timesheet_search'); showDiv('landing_work_links');">Cancel</a>
										  <a class="button" href="##" name="printByUser" onclick="javascript:loadTimesheetPrint('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber'))">View Printable</a>
									    <a class="button"  name="getByUser"
										onclick="javascript:loadTimesheetView('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber')); hideDiv('gen_window_frame');">View Editable</a></cfoutput>	
                            </div>
                            </div>                                       
							</form>
                         
                                                     
							
							</cfif>
							
							
								
</div>	<!--- landing_timesheet_search --->

<div id="landing_project_search" style="display:none; width:100%;">
	<script language="javascript">
        
        function DoSearch(str, currentUserOnly)
        {
            var url;
            var sfield;
            var stype;
            
            sfield = AjaxGetCheckedValue("SearchField");
            stype = AjaxGetCheckedValue("SearchType");
            
            url = "/forms/searchSubSmall.cfm?SearchType=";
            url += stype;
            url += "&SearchField=";
            url += sfield;
            url += "&SearchValue=";
            url += escape(str);
            url += "&currentUserOnly=" + escape(currentUserOnly);
            url += "&userid=" + escape(glob_userid);
    
            //alert(url);
            AjaxLoadPageToDiv("tcTarget", url);
        }
    </script>
     <table cellpadding="10">
    	<tr>
        	<td valign="bottom"><img src="http://us-production-r1g1s1.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/find.png" /></td>
            <td>
            	<span class="LandingHeaderText">Find Project</span><br />
            </td>
		</tr>
	</table>
	
    <form name="searchForm" >
    		<div style="width:300px; height:200px; float:left; margin-left:30px;">
	      	<span class="LandingHeaderText" style="font-size:14px;">Search Type</span><br />
            <p style="margin-left:10px;"> 
              <label>
              <input type="radio" name="SearchField" value="clsJobNumber" checked/>
              Project Number</label>
              <br />
              <label>
              <input type="radio" name="SearchField" value="address"/>
              Address</label>
              <br />
              <label>
              <input type="radio" name="SearchField" value="section"/>
              Section</label>
              <br />
              <label>
              <input type="radio" name="SearchField" value="township"/>
              Township</label>
              <br />
              <label>
              <input type="radio" name="SearchField" value="range"/>
              Range</label>
              <br />
              <label>
              <input type="radio" name="SearchField" value="billing_company" />
              Ordered By Company</label> 
            </p>             
            </div>
            <div style="width:300px; height:200px; float:left;">
            <span class="LandingHeaderText" style="font-size:14px;">Criteria</span><br />
            
              <label>
              <input type="radio" name="SearchType" value="BeginsWith" />
              Begins With</label>
              <br />
              <label>
              <input type="radio" name="SearchType" value="Contains" checked />
              Contains</label>
              <br />
          
	            <input name="SearchValue" id="sv" type="text" width="100%;" />
    	        
            
       		</div>
            <div style="width:100%; margin-top:20px; float:left; text-align:right;">
	            <input type="button" name="cancelFindProject" value="Cancel" onclick="hideDiv('landing_project_search'); showDiv('landing_work_links');" />
            	<input type="button" style="margin-right:20px;" value="Search" onclick="javascript:DoSearch(GetValue('sv'), 'false'); hideDiv('gen_window_frame');">
            </div>
    </form>
</div> <!--- landing_project_search --->

<div id="landing_project_search_subdivision" style="display:none;">    
    <cfquery name="gsubs" datasource="webwarecl">
        SELECT * FROM Subdivisions WHERE approved=1 ORDER BY name
    </cfquery>        
    
        <div style="width:220px; margin:3px; border:1px solid #EFEFEF;">
            <h3>Search by Subdivision</h3>
            <select name="SubID" id="SubID" style="width:200px; max-width:200px;">
                <cfoutput query="gsubs">	
                    <option value="#id#">#name#</option>
                </cfoutput>
            </select>
            <input type="button" value="Search by Subdivision" onclick="javascript:SearchBySub(GetValue('SubID'));" />
                                        
        </div>        
   
</div> <!--- landing_project_search_subdivision --->			