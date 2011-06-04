<link rel="stylesheet" href="/css/gecko.css">

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_VIEW">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workflow/workflow_udf.cfm">

<cfquery name="projectInfo" datasource="webwarecl">
    SELECT * FROM projects WHERE id=#url.id# AND site_id=#url.current_site_id#
</cfquery>

<cfquery name="gSub" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE id=#projectInfo.subdivision#
</cfquery>    

<cfquery name="gAU" datasource="sites">
	SELECT user_id FROM site_associations WHERE assoc_type=1 AND site_id=#URL.current_site_id#
</cfquery>
		
<cfif #projectInfo.maint_lock# EQ 1 AND #url.calledByUser# NEQ 1>
	<h1>Access Denied</h1>
	<p>This project has been locked for maintenance, and can only be modified by the webmaster.</p>
	<cfabort>
</cfif>

<style>
	.projTabl td
	{
		background-color:#EFEFEF;
	}		
	.cellLabel
	{
		display:block;
		width:320px;
		float:left;
		clear:left;
	}
	.cellC
	{
		float:left;
		display:inline;
	}	
</style>

<cfparam name="canEdit" default="0">

<cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
	<cfset canEdit=1>
<cfelse>
	<cfset canEdit=0>
</cfif>

<cfoutput>
<!--
<wwafcomponent>Project View - #projectInfo.clsJobNumber#</wwafcomponent>
<wwafsidebar>sb_ProjectView.cfm?id=#url.id#</wwafsidebar>
<wwafdefinesmap>true</wwafdefinesmap>
<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
</cfoutput>



		

<cflayout type="border">
	<cflayoutarea position="top" title="Project">
		<cfmodule template="/workFlow/PPM/components/Views.cfm" project_type="#projectInfo.project_type#" project_id="#projectInfo.id#">

		<cfoutput>            
        <cfif getPermissionByKey("WF_VIEWRFP", #url.current_association#) EQ true>
        	<img src="/graphics/zoom.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/viewRFP.cfm?id=#url.id#&viewOnly=1');">Proposal</a> |&nbsp;
        </cfif>
        </cfoutput>
		<cfif getPermissionByKey("WF_DELETE", #url.current_association#) EQ true>
        	<cfoutput>
            	<img src="/graphics/delete.png" align="absmiddle" /> <a href="javascript:deleteProject('#url.id#')">Delete Project</a> |&nbsp;
			</cfoutput>
        </cfif>
        <img src="/graphics/printer.png" align="absmiddle"/> <cfoutput><a href="javascript:viewPrintable('#url.id#')">Printable Order</a></cfoutput> |&nbsp;
                                
        <cfif getPermissionByKey("TS_VIEW", #url.current_association#) EQ true>
				<cfoutput>
                    <img src="/graphics/time_go.png" align="absmiddle"/> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '12/31/2999', 'none', 'no', '#projectInfo.clsJobNumber#')">My Timesheets (This Project)</a>
                </cfoutput> |&nbsp;
            <cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
                <cfoutput>
                    <img src="/graphics/time_go.png" align="absmiddle"/> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '12/31/2999', 'none', 'no', '#projectInfo.clsJobNumber#')">All Timesheets</a> |&nbsp;
                </cfoutput>
            </cfif>
            <cfif getPermissionByKey("SC_DISPATCH", #url.current_association#) EQ true>
                <cfoutput>
                    <img src="/graphics/lorry_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToWindow('/scheduling/dispatch_crew.cfm?project_id=#projectInfo.id#&clsJobNumber=#URLEncodedFormat(projectInfo.clsJobNumber)#&description=#URLEncodedFormat(projectInfo.description)#', 'Dispatch Crew');">Dispatch Crew</a> |
                </cfoutput>
			</cfif>
		</cfif>
        <cfoutput>
        	<img src="/graphics/map_go.png" align="absmiddle" />&nbsp;
            <a href="javascript:popupMap('Project #projectInfo.clsJobNumber#', GetValue('address') + ' ' + GetValue('city') + ', ' + GetValue('state') + ' ' + GetValue('zip'), 'Project #projectInfo.clsJobNumber#', true);">Map &amp; Directions</a>
		</cfoutput>
	</cflayoutarea>        
	<cflayoutarea position="left" title="Project Summary" splitter="true" collapsible="true" size="200" maxsize="200">	            
      <table width="100%" cellspacing="0" class="projTabl">     
          <tr>
              <td><strong>Company:</strong></td>
              <td><cfoutput>#projectInfo.billing_company#<br />#projectInfo.billing_address#<br />#projectInfo.billing_city#, #projectInfo.billing_state# #projectInfo.billing_zip#<br />
              Phone: #projectInfo.billing_phone#<br />
              Fax: #projectInfo.billing_fax#</cfoutput></td>
          </tr>
          <tr>
              <td><strong>Ordered By:</strong></td>
              <td><cfoutput>#getLongname(projectInfo.clientID)#<br />
              <a href="mailto:#getEmail(projectInfo.clientID)#">#getEmail(projectInfo.clientID)#</a></cfoutput></td>
          </tr>                    
          
          <tr>
              <td><strong>Description:</strong></td>
              <td><cfoutput>#projectInfo.description#</cfoutput></td>
          </tr>
          <tr>
              <td><strong>Project Number:</strong></td>
              <td>
                  <div id="jobNumRO" style="display:inline">
                      <span id="jnView">
                          <cfoutput>
                              <cfif #projectInfo.clsJobNumber# EQ "">[None Assigned]</cfif>#projectInfo.clsJobNumber#
                          </cfoutput>
                      </span> 
                      
                  </div>
                  <div id="jobNumRW" style="display:none">
                      <cfoutput>
                          <input type="text" class="inputText" value="#projectInfo.clsJobNumber#" id="jobNumEdit"/> <a href="javascript:saveProjectNumber(#url.id#, GetValue('jobNumEdit'));"><img src="/graphics/database_save.png" border="0"/></a>
                      </cfoutput>
                  </div>
              </td>
          </tr>
          <tr>
              <td><strong>Client Project No.:</strong></td>
              <td><cfoutput>#projectInfo.clientJobNumber#</cfoutput></td>
          </tr>
          <tr>
              <td><strong>Project Type:</strong></td>
              <td><cfoutput>#projectInfo.jobtype#</cfoutput></td>
          </tr>
          <tr>
              <td><strong>Order Placed:</strong></td>
              <td><cfoutput>#DateFormat(projectInfo.ordered_date, 'mm/dd/yyyy')#</cfoutput></td>
          </tr>
          <tr>
              <td ><strong>Due Date:</strong></td>
              <td ><cfoutput>#DateFormat(projectInfo.duedate, 'mm/dd/yyyy')#</cfoutput></td>
          </tr>	
          <tr>
              <td><strong>Project Status:</strong></td>
              <td><cfoutput><cfif #projectInfo.status# EQ 0>Incomplete<cfelse>Complete</cfif> <cfif #projectInfo.SubStatus# NEQ ""><br>[#projectInfo.SubStatus#]</cfif></cfoutput></td>
          </tr>	
  
          <cfif #projectInfo.status# EQ 0>
              <tr>
                  <td colspan="2">Project has been open for <strong><cfoutput>#DateDiff("d", projectInfo.ordered_date, Now())#</cfoutput> days.</strong></td>
              </tr>
              <tr>
                  <td colspan="2">
                      <cfif #DateDiff("d", Now(), projectinfo.duedate)# GT 1>
                          You have <strong><cfoutput>#DateDiff("d", Now(), projectinfo.duedate)#</cfoutput> days remaining</strong> to complete this project on time.
                      <cfelseif #DateDiff("d", Now(), projectinfo.duedate)# EQ 0>
                          You have <strong><cfoutput>#DateDiff("h", Now(), projectinfo.duedate)#</cfoutput> hours remaining</strong> to complete this project on time.
                      <cfelse>
                          <span style="color:red;">This project is past due.</span>
                      </cfif>
                  </td>
              </tr>
          </cfif>
      </table>
	</cflayoutarea>                    
            
    <cflayoutarea position="center">		
    	<cflayout type="tab" name="Project">
            <cflayoutarea name="Timeline" title="Information">
    
				<cfoutput>
                <center>
                    <cfmodule template="/workflow/components/project_timeline.cfm" project_id="#url.id#">
                </center>
                </cfoutput>
			</cflayoutarea>                
    	
        	<cflayoutarea name="ProjectFiles" title="Project Files">
				<cfoutput>
                
                    <div class="homeHeader"><img src="/graphics/folder_explore.png" align="absmiddle"/> Project Files</div>
                    <cfmodule template="/workflow/components/project_files.cfm" project_id="#url.id#"><br />
                    <img style="margin-left:30px;" src="/graphics/folder_go.png" align="absmiddle"/> <a href="javascript:cmsBrowseFolder(#url.calledByUser#, 'project_files', '#projectInfo.clsJobNumber#', 'site', '');">View staging area for this project</a>
                
                </cfoutput>                
			</cflayoutarea>
            
            <cflayoutarea name="TimeInfo" title="Labor &amp; Invoicing">
        		<cfoutput>
                <table>
                    <tr>
                        <td><strong>Charge Type:</strong></td>
                        <td>
                            <cfif projectInfo.charge_type EQ "Lump Sum">
                                Lump Sum - #DollarFormat(projectInfo.total_quoted_price)# 
                            <cfelse>
                                Time &amp; Materials
                            </cfif>                                                        
                                
                        
                        </td>
                    </tr>
                </table>                                    
                
              
                <a href="/workFlow/components/projectLaborPrintable.cfm?project_number=#projectInfo.clsJobNumber#" target="_blank">Printable View</a>
               <cfmodule template="/workFlow/components/projectLabor.cfm" project_number="#projectInfo.clsJobNumber#" printable="no"><br />
               </cfoutput>
			</cflayoutarea>               
            
	            
    		<cflayoutarea name="LocInf" title="Location">    
            	<cfoutput>
    			<div class="homeHeader"><img src="/graphics/map.png" align="absmiddle" /> Location</div>
                <div style="padding-left:20px;">
                    <cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
                        <a href="javascript:updateLocationInfo('locStat', #url.id#, GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'), GetValue('latitude'), GetValue('longitude'), GetValue('subdivision'), GetValue('lot'), GetValue('block'), GetValue('section'), GetValue('township'), GetValue('range'));">
                            <img src="/graphics/database_save.png" border="0"/>				
                        </a>
                    </cfif>
                    <span id="locStat"><strong>No changes made since last save.</strong></span>
                   
                </div>
                <div style="padding-left:20px; padding-top:20px;"> 
                <div class="cellLabel">Street Address:</div>
                <div class="cellC">
                    <input name="address" <cfif canEdit EQ 0>readonly</cfif> id="address" type="text" value="#projectInfo.address#"    onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>  
                </div>            
                <div class="cellLabel">City:</div>
                <div class="cellC">
                    <input name="city" <cfif canEdit EQ 0>readonly</cfif> id="city" type="text" value="#projectInfo.city#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>
                </div>
                <div class="cellLabel">State:</div>
                <div class="cellC">
                    <input name="state" <cfif canEdit EQ 0>readonly</cfif> id="state" type="text" value="#projectInfo.state#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>
                </div>
                <div class="cellLabel">ZIP:</div>
                <div class="cellC">
                    <input name="zip" <cfif canEdit EQ 0>readonly</cfif> id="zip" type="text" value="#projectInfo.zip#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText" onblur="calcLatLng();"/>
                    <cfif #url.permissionLevel# EQ 1>
                        <input type="button" class="normalButton" name="cc" value="Calculate Latitude/Longitude" onclick="calcLatLng();" />
                    </cfif>
                </div>
                <div class="cellLabel">Latitude:</div>
                <div class="cellC">
                    <input name="latitude" <cfif canEdit EQ 0>readonly</cfif> id="latitude" type="text" value="#projectInfo.latitude#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>
                <div class="cellLabel">Longitude:</div>
                <div class="cellC">
                    <input name="longitude" <cfif canEdit EQ 0>readonly</cfif> id="longitude" type="text" value="#projectInfo.longitude#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>
                <div class="cellLabel">Subdivision:</div>
                <div class="cellC">
                    <input name="sdf" readonly id="sdf" type="text" value="#gSub.name#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                    <input name="subdivision" readonly id="subdivision" type="hidden" value="#gSub.id#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div><br />
                <div class="cellLabel">Lot:</div>
                <div class="cellC">
                    <input name="lot" <cfif canEdit EQ 0>readonly</cfif> id="lot" type="text" value="#projectInfo.lot#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>
                <div class="cellLabel">Block:</div>
                <div class="cellC">
                    <input name="block" <cfif canEdit EQ 0>readonly</cfif> id="block" type="text" value="#projectInfo.block#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>
                <div class="cellLabel">Section:</div>
                <div class="cellC">
                    <input name="section" <cfif canEdit EQ 0>readonly</cfif> id="section" type="text" value="#projectInfo.section#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>            
                <div class="cellLabel">Township:</div>
                <div class="cellC">
                    <input name="township" <cfif canEdit EQ 0>readonly</cfif> id="township" type="text" value="#projectInfo.township#"  onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>            
                <div class="cellLabel">Range:</div>
                <div class="cellC">
                    <input name="range" <cfif canEdit EQ 0>readonly</cfif> id="range" type="text"  value="#projectInfo.range#" onkeyup="invalidateSection('locStat', '#url.PWindowHandle#');" class="inputText"/>
                    <cfif #url.permissionLevel# EQ 1>
                        <input type="button" class="normalButton" value="Calculate Section/Township/Range" onclick="loadTRS();" />
                    </cfif>
                </div>
            	</div>
                </cfoutput>
            </cflayoutarea>
    
   			<cflayoutarea name="FilingInfo" title="Filing Information">
    			<cfoutput>
                <div class="homeHeader" style="clear:both"><img src="/graphics/folder_page.png" align="absmiddle" /> Filing Information</div>
                <div style="padding-left:20px;">
                    <cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
                        <a href="javascript:updateFilingInfo('filingStat', #url.id#, AjaxGetCheckedValue('SubdivisionOrDeed'), AjaxGetCheckedValue('FilingType'), GetValue('PlatCabinetBook'), AjaxGetCheckedValue('PageOrSlide'), GetValue('PageSlide'), GetValue('ReceptionNumber'), GetValue('FilingDate'), GetValue('CertifiedTo'));">
                        <img src="/graphics/database_save.png" border="0"/></a>
                    </cfif> 
                    <span id="filingStat"><strong>No changes made since last save.</strong></span>
                </div>
                <div style="padding-left:20px; padding-top:20px;">         
                <div style="clear:both;">   
                    <div class="cellLabel">                        
                        <p>
                            <label>
                                <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="SubdivisionOrDeed" value="Subdivision" <cfif #projectInfo.SubdivisionOrDeed# EQ "Subdivision">checked</cfif> onclick="invalidateSection('filingStat', '#url.PWindowHandle#');"/>Subdivision
                            </label>
                            <br />
                            <label>
                                <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="SubdivisionOrDeed" value="Deed" <cfif #projectInfo.SubdivisionOrDeed# EQ "Deed">checked</cfif> onclick="invalidateSection('filingStat',  '#url.PWindowHandle#');"/>Deed
                            </label>
                            <br />
                        </p>
                        <p>
                            <label>
                                <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Plat" <cfif #projectInfo.FilingType# EQ "Plat">checked</cfif> onclick="invalidateSection('filingStat', '#url.PWindowHandle#');"/>
            Plat
                            </label>
                            <br />
                            <label>
                                <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Cabinet"  			
                                    <cfif #projectInfo.FilingType# EQ "Cabinet">checked</cfif> onclick="invalidateSection('filingStat', '#url.PWindowHandle#');"/>Cabinet
                            </label>
                            <br />
                            <label>
                                <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Book"  <cfif #projectInfo.FilingType# EQ "Book">checked</cfif> onclick="invalidateSection('filingStat', '#url.PWindowHandle#');"/>Book
                            </label>
                            <br />
                        </p>          
                    </div>
                    <div class="cellC" style="clear:right;">
                        <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="PlatCabinetBook" name="PlatCabinetBook" value="#projectInfo.PlatCabinetBook#" onkeyup="invalidateSection('filingStat', '#url.PWindowHandle#');" class="inputText"/>
                    </div>
                </div>
                <div style="clear:both;">
                    <div class="cellLabel">
                    <p><label>
                                              <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="PageOrSlide" value="Page" <cfif #projectInfo.PageOrSlide# EQ "Page">checked</cfif> onclick="invalidateSection('filingStat', '#url.PWindowHandle#');"/>
                                              Page</label>
                                            <br />
                                            <label>
                                              <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="PageOrSlide" value="Slide" <cfif #projectInfo.PageOrSlide# EQ "Slide">checked</cfif> onclick="invalidateSection('filingStat', '#url.PWindowHandle#');"/>
                                              Slide</label>
                                            <br />
                                            </p>
                    </div>
                    <div class="cellC">                            
                        <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="PageSlide" name="PageSlide" value="#projectInfo.PageSlide#" onkeyup="invalidateSection('filingStat', '#url.PWindowHandle#');" class="inputText"/>
                    </div>
                </div>
                <div class="cellLabel" style="clear:left;">Reception or Document Number:</div>
                <div class="cellC">
                    <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="ReceptionNumber" name="ReceptionNumber"  value="#projectInfo.ReceptionNumber#" onkeyup="invalidateSection('filingStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>
                <div class="cellLabel">Filing Date:</div>
                <div class="cellC">
                    <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="FilingDate" name="FilingDate"  value="#DateFormat(projectInfo.FilingDate, 'mm/dd/yyyy')#"  onkeyup="invalidateSection('filingStat', '#url.PWindowHandle#');" class="inputText"/> <cfif #url.permissionLevel# EQ 1><a href="javascript:popupDate(AjaxGetElementReference('FilingDate'));"><img src="graphics/date.png" border="0" /></a></cfif>
                </div>
                <div class="cellLabel">Certified To:</div>
                <div class="cellC">
                    <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="CertifiedTo" name="CertifiedTo"  value="#projectInfo.CertifiedTo#" onkeyup="invalidateSection('filingStat', '#url.PWindowHandle#');" class="inputText"/>
                </div>        
                </div>
				</cfoutput>              
            </cflayoutarea>
            
            <cflayoutarea name="OtherInfo" title="Information">           
	            <cfoutput>
                <div class="homeHeader"><img src="/graphics/folder_explore.png" align="absmiddle"/> Other Project Information</div>              
                <div style="margin-left:20px;">
                <span id="otherStat"><strong>No changes made since last save.</strong></span>
                <cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
                	<a href="javascript:updateOtherInfo('otherStat', #url.id#, GetValue('specialinstructions'));">
                    <img src="/graphics/database_save.png" border="0"/></a>
                </cfif>
                <div class="cellLabel">Special Instructions:</div>
                <div class="cellC"><textarea name="specialinstructions" cols="50" rows="8" class="inputText" id="specialinstructions" onkeyup="invalidateSection('otherStat', '#url.PWindowHandle#');">#projectInfo.specialinstructions#</textarea></div>
                </div>
                </cfoutput>
			</cflayoutarea>                    
            
            <cflayoutarea name="PPMModule" title="PPM Modules">
                <div id="ppm_module" style="display:none;">
                
    			</div>
			</cflayoutarea>                
		</cflayout>
	</cflayoutarea>
</cflayout>            		                
					

<div id="pageScriptContent">
	last_section_id='project_files';
</div>                           