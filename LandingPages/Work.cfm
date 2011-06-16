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
                	<cfmodule template="/framework/link.cfm" icon="/graphics/page_white_add.png" perm="WF_CREATE" linkname="New Project..." url="NewProject"><br />					<cfmodule template="/framework/link.cfm" icon="/graphics/find.png"  perm="WF_VIEW" linkname="Find Projects..." url="FindProject"><br />                    <cfmodule template="/framework/link.cfm" icon="/graphics/wand.png" perm="WF_PROCESSORDER" linkname="Approve Projects..." url="/jobViews/newJobs.cfm"><br />    				
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
	                
                	<cfmodule template="/framework/link.cfm" icon="/graphics/page_white_add.png" perm="TS_CREATE" linkname="New Timesheet..." url="NewTimesheet"><br />
					<cfmodule template="/framework/link.cfm" icon="/graphics/find.png" perm="TS_VIEW" linkname="Find Timesheet..." url="FindTimesheet" ><br />
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
                    <cfmodule template="/framework/link.cfm" icon="/graphics/user_edit.png" perm="AS_VIEW" linkname="Employees and customers..." url="/authentication/components/associationManager.cfm" help="Manage employees and customers"><br />	
                	<cfmodule template="/framework/link.cfm" icon="/graphics/page.png" perm="WW_SITEMAINTAINER" linkname="Change site information..." url="/authentication/components/maintenancePanel.cfm?section=site_information.cfm"><br />                   
					<cfmodule template="/framework/link.cfm" icon="/graphics/group_edit.png" perm="WW_SITEMAINTAINER" linkname="Manage departments..." url="/authentication/components/maintenancePanel.cfm?section=departments.cfm"><br />					
					<cfmodule template="/framework/link.cfm" icon="/graphics/lightning.png" perm="WW_SITEMAINTAINER" linkname="Manage event notifications..." url="/authentication/components/maintenancePanel.cfm?section=order_settings.cfm"><br />
                   
				</p>
            </td>
        </tr>
	</table>  
    </div>
</div> <!--- landing_work_links --->



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