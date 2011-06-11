<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_VIEW">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workflow/workflow_udf.cfm">

<cfquery name="projectInfo" datasource="webwarecl">
    SELECT * FROM projects WHERE id=#url.id#
</cfquery>

<cfquery name="gSub" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE id=#projectInfo.subdivision#
</cfquery>    

<cfquery name="gAU" datasource="sites">
	SELECT user_id FROM site_associations WHERE assoc_type=1 AND site_id=#URL.current_site_id#
</cfquery>
		


<style>
	.projTabl td
	{
		background-color:white;
	}		
	.cellLabel
	{
		display:block;
		width:320px;
		float:left;
		clear:left;
		font-size:14px;
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



		


    <cfoutput>
	<cfmodule template="/orms/view_header.cfm" r_type="Project" r_pk="#url.id#">
	<cfset po = CreateObject("component","OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK("Project", url.id)>
	<cfset po.DoAccess("View", url.calledByUser)>
	
	<div style="display:none;">
    <div style="clear:both;width:89%; padding-top:-5px; padding-left:5px; padding-bottom:5px;">    
    <cfmodule template="/workFlow/PPM/components/Views.cfm" project_type="#projectInfo.project_type#" project_id="#projectInfo.id#">
    
<cfif getPermissionByKey("WF_VIEWRFP", #url.current_association#) EQ true>
                				<img src="/graphics/zoom.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/viewRFP.cfm?id=#url.id#&viewOnly=1');">Proposal</a> |&nbsp;
							</cfif>
						</cfoutput>
						<cfif getPermissionByKey("WF_DELETE", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/delete.png" align="absmiddle" /> <a href="javascript:deleteProject('#url.id#')">Delete</a> |&nbsp;</cfoutput>
                        </cfif>
                        <img src="/graphics/printer.png" align="absmiddle"/> <cfoutput><a href="javascript:viewPrintable('#url.id#')">Printable View</a></cfoutput> |&nbsp;
                        
                        <cfif getPermissionByKey("TS_VIEW", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/time_go.png" align="absmiddle"/> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '12/31/2999', 'none', 'no', '#projectInfo.clsJobNumber#')">My Time (This Project)</a></cfoutput> |&nbsp;
                        <cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/time_go.png" align="absmiddle"/> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '12/31/2999', 'none', 'no', '#projectInfo.clsJobNumber#')">All Timesheets</a> |&nbsp;</cfoutput>
                        </cfif>
                        <cfif getPermissionByKey("SC_DISPATCH", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/lorry_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToWindow('/scheduling/dispatch_crew.cfm?project_id=#projectInfo.id#&clsJobNumber=#URLEncodedFormat(projectInfo.clsJobNumber)#&description=#URLEncodedFormat(projectInfo.description)#', 'Dispatch Crew');">Dispatch Crew</a> |</cfoutput>
                      	</cfif>
                        </cfif>
                        <cfoutput>
                        <img src="/graphics/map_go.png" align="absmiddle" />&nbsp;
						<!---<a href="javascript:pf_show_map(); current_map.add_location('Project #projectInfo.clsJobNumber#', '#projectInfo.latitude#', '#projectInfo.longitude#', '#projectInfo.address#', '#projectInfo.city#', '#projectInfo.state#', '#projectInfo.zip#');">Map &amp; Directions</a>--->
						<a href="javascript:popupMap('Project #projectInfo.clsJobNumber#', GetValue('address') + ' ' + GetValue('city') + ', ' + GetValue('state') + ' ' + GetValue('zip'), 'Project #projectInfo.clsJobNumber#', true);">Map &amp; Directions</a>
						
						
						</cfoutput>
	</div>
<table width="100%" cellpadding="10">
<tr>
    <td valign="top" width="250">
    	
    	<div style="width:240px;" class="OH_BOX">
        <strong class="OH_HEADER">Project Summary</strong>
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
            
          
			
        </div>
        
       
    </td>
    
    
</tr>
</table>   
						
</div>						

<div id="pageScriptContent">
	last_section_id='project_files';
</div>                           