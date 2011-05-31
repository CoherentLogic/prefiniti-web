<cfinclude template="/authentication/authentication_udf.cfm">

<cfif getPermissionByKey('#attributes.perm#', #url.current_association#) EQ true>
	<cfoutput>
        <cfswitch expression="#attributes.url#">
            <cfcase value="MyOpenTimesheets">
                <a href="javascript:loadTimesheetView('tcTarget', glob_userid, '1/1/1980', '1/1/2999', 'Open', glob_isTCAdmin, ''); dispatch();">My open timesheets</a>
            </cfcase>
            <cfcase value="NewTimesheet">
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/timesheet.cfm?action=add&userid=' + glob_userid); dispatch();">Start a new timesheet</a>
            </cfcase>
            <cfcase value="ViewProfile">
            	<a href="javascript:viewProfile15(glob_userid); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="EditProfile">
            	<a href="javascript:editUser(glob_userid, '#attributes.profile_section#'); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="AddPhotos">
            	<a href="javascript:viewPictures(glob_userid, true); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="Invite">
            	#attributes.linkname# (coming soon)
            </cfcase>
            <cfcase value="PostBlog">
            	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/post_blog.cfm'); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="ViewBlog">
            	#attributes.linkname# (coming soon)
            </cfcase>
            <cfcase value="UserFiles">
            	<a href="javascript:cmsBrowseFolder(glob_userid, 'project_files', '', 'user', ''); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="FindFriends">
            	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm'); dispatch();">#attributes.linkname#</a>
            </cfcase>
            <cfcase value="ViewComments">
            	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/view_comments.cfm'); dispatch();">#attributes.linkname#</a>
            </cfcase>
			<cfcase value="DepartmentLink">
				<cfquery name="GetDepartmentName" datasource="sites">
					SELECT * FROM departments WHERE id=#attributes.department_id#
				</cfquery>
				
				<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/view_department.cfm?department_id=#GetDepartmentName.id#&date=#DateFormat(Now(), 'mm/dd/yyyy')#');">#GetDepartmentName.department_name#</a> 					
			</cfcase>
			<cfcase value="MyDepartments">
				<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">#attributes.linkname#</a>
			</cfcase>
            <cfcase value="MySchedule">
            	<a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "mm/dd/yyyy")#'); dispatch();">#attributes.linkname#</a>
			</cfcase>               
            <cfdefaultcase>
                <a href="##" onmouseover="Tip('#attributes.help#');" onmouseout="UnTip();" onclick="OpenLink('#attributes.url#');">#attributes.linkname#</a>
            </cfdefaultcase> 
        </cfswitch>           
    </cfoutput>
</cfif>