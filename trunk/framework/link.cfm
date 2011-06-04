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
<cfinclude template="/authentication/authentication_udf.cfm">

<style type="text/css">
	.LandingLink {
		font-size:12px;
		padding-top:3px;
		margin-bottom:3px;
	}
</style>

<cfif getPermissionByKey('#attributes.perm#', #url.current_association#) EQ true>
	<cfoutput>    
        <cfswitch expression="#attributes.url#">        
			<cfcase value="FindProject">
            	<a class="LandingLink" href="javascript:hideDiv('landing_work_links'); showDivBlock('landing_project_search');">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="NewProject">
	            <cfset createProjectLink = CreateObject("component","res").GetByTypeAndPK("User Account", url.calledByUser).GetCreator("Project")>
                <a class="LandingLink" href="##" onclick="dispatch(); ORMSDialog('#createProjectLink#')">#attributes.linkname#</a>
			</cfcase>                
            <cfcase value="FindTimesheet">
                <a class="LandingLink" href="##" onclick="dispatch(); ORMSDialog('/tc/search.cfm');">#attributes.linkname#</a>
			</cfcase>                
            <cfcase value="MyOpenTimesheets">
                <a class="LandingLink" href="javascript:loadTimesheetView('tcTarget', glob_userid, '1/1/1980', '1/1/2999', 'Open', glob_isTCAdmin, ''); dispatch();">My open timesheets</a>
            </cfcase>
            <cfcase value="NewTimesheet">
                <cfset createTimesheetLink = CreateObject("component","res").GetByTypeAndPK("User Account", url.calledByUser).GetCreator("Time Card")>
                <a class="LandingLink" href="##" onclick="dispatch(); ORMSDialog('#createTimesheetLink#')">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="ViewProfile">
            	<a class="LandingLink" href="javascript:viewProfile15(glob_userid); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="EditProfile">
            	<a class="LandingLink" href="javascript:editUser(glob_userid, '#attributes.profile_section#'); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="AddPhotos">
            	<a class="LandingLink" href="javascript:viewPictures(glob_userid, true); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="Invite">
            	#attributes.linkname# (coming soon)
            </cfcase>
            <cfcase value="PostBlog">
            	<a class="LandingLink" href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/post_blog.cfm'); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="ViewBlog">
            	#attributes.linkname# (coming soon)
            </cfcase>
            <cfcase value="UserFiles">
            	<a class="LandingLink" href="javascript:cmsBrowseFolder(glob_userid, 'project_files', '', 'user', ''); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="FindFriends">
            	<a class="LandingLink" href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm'); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="ViewComments">
            	<a class="LandingLink" href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/view_comments.cfm'); dispatch();">#attributes.linkname#</a>
            </cfcase>
			<cfcase value="DepartmentLink">
				<cfquery name="GetDepartmentName" datasource="sites">
					SELECT * FROM departments WHERE id=#attributes.department_id#
				</cfquery>
				
				<a class="LandingLink" href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/view_department.cfm?department_id=#GetDepartmentName.id#&date=#DateFormat(Now(), 'mm/dd/yyyy')#');">#GetDepartmentName.department_name#</a> 					
			</cfcase>
			<cfcase value="MyDepartments">
				<a class="LandingLink" href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">#attributes.linkname#</a>
			</cfcase>
            <cfcase value="MySchedule">
            	<a class="LandingLink" href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "mm/dd/yyyy")#'); dispatch();">#attributes.linkname#</a>
			</cfcase>               
            <cfdefaultcase>
                <a class="LandingLink" href="##" onclick="OpenLink('#attributes.url#');">#attributes.linkname#</a>
            </cfdefaultcase>                        
    	</cfswitch>                        
    </cfoutput>   
</cfif>