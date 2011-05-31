<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/notifications/notification_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">


<cfparam name="cid" default="#CreateUUID()#">
<cfparam name="sel_username" default="">
<cfset sel_username="#url.Tusername#">

<!-- create the user account -->
<cfquery name="createUserAccount" datasource="webwarecl">
	INSERT INTO Users 
		(birthday,
        longName,        
        firstName,
        middleInitial,
        lastName,
        individual_account,
		company,
		email,
		email_billing,
		gender,
		smsnumber,
		phone,
		fax,
		username,
		confirm_id,
		confirmed,
		account_enabled,
		type,
        last_pwchange,
        webware_admin,
        allowSearch)
	VALUES (
    	#CreateODBCDate(Now())#,
        '#url.firstName# #url.lastName#',
    	'#url.firstName#',
        '',
        '#url.lastName#',
		1,
		0,
		'#url.email#',
		0,
		'#url.gender#',
		'',
		'',
		'',
		'#sel_username#',    <!---TODO--->
		'#cid#',
		0,
		0,
		0,
        #CreateODBCDateTime(Now())#,
        0,
        0)
</cfquery>

<!-- retrieve the user id for the new user -->

<cfquery name="UID" datasource="webwarecl">
	SELECT id FROM Users WHERE confirm_id='#cid#'
</cfquery>

<!-- Create the default association --->
<cfquery name="createAssoc" datasource="sites">
	INSERT INTO site_associations
    	(user_id,
        site_id,
        assoc_type,
        conf_id)
    VALUES
    	(#UID.id#,
        #url.current_site_id#,
        #url.assoc_type#,
        '#cid#')
</cfquery>

<!-- Get the id of the association created -->
<cfquery name="acid" datasource="sites">
	SELECT id FROM site_associations WHERE conf_id='#cid#'
</cfquery>

<!-- update the last_site_id field 
	NOTE: last_site_id actually is an FK to sites.site_associations.id
    -->
<cfquery name="update_last_site_id" datasource="webwarecl">
	UPDATE Users SET last_site_id=#acid.id# WHERE id=#UID.id#
</cfquery>        

<!-- Grant the basic permissions -->

<cfoutput>
	#grantPermission("AS_LOGIN", acid.id)#
    #grantPermission("MA_VIEW", acid.id)#
    #grantPermission("MA_WRITE", acid.id)#
    #grantPermission("SC_VIEW", acid.id)#
    
    <cfif URL.assoc_type EQ 1> <!-- grant permissions for employee accounts -->
    	#grantPermission("CM_STAGE", acid.id)#
        #grantPermission("TS_VIEW", acid.id)#
        #grantPermission("TS_CREATE", acid.id)#
        #grantPermission("TS_EDIT", acid.id)#
        #grantPermission("TS_DELETE", acid.id)#
        #grantPermission("TS_VIEW_TC", acid.id)#
        #grantPermission("GIS_VIEWSUBDIVISION", acid.id)#
        #grantPermission("CM_VIEW_STAGED", acid.id)#
    </cfif>
    
    <cfif url.current_site_id NEQ 5>
        #grantPermission("WF_CREATE", acid.id)#
        #grantPermission("WF_VIEWRFP", acid.id)#
        #grantPermission("WF_SEARCH", acid.id)#
        #grantPermission("WF_VIEW", acid.id)#
    </cfif>
    #ntSetNotification(24, UID.id, 1)#
   	#ntSetNotification(27, UID.id, 1)#
	#ntSetNotification(1, UID.id, 1)#
	#ntSetNotification(2, UID.id, 1)#
	#ntSetNotification(8, UID.id, 1)#
	#ntSetNotification(12, UID.id, 1)#
   	#ntSetNotification(21, UID.id, 1)#        
	#ntSetNotification(19, UID.id, 1)#
	#ntSetNotification(10, UID.id, 1)#
	#ntSetNotification(28, UID.id, 1)#   
</cfoutput>

<!-- Create the directory structure -->
<cfoutput>
	<cfdirectory action="create" directory="D:\Inetpub\Prefiniti15\UserContent\#sel_username#">
    <cfdirectory action="create" directory="D:\Inetpub\Prefiniti15\UserContent\#sel_username#\profile_images">
    <cfdirectory action="create" directory="D:\Inetpub\Prefiniti15\UserContent\#sel_username#\project_files">
    <cfdirectory action="create" directory="D:\Inetpub\Prefiniti15\UserContent\#sel_username#\wallpapers">
    <cfdirectory action="create" directory="D:\Inetpub\Prefiniti15\UserContent\#sel_username#\media">
</cfoutput>
<cfmodule template="/authentication/Users/orms_do.cfm" id="#UID.id#">
<cfoutput>
<cfmail from="register@prefiniti.com" to="#url.email#" subject="#getLongname(URL.CalledByUser)# has invited you to join The Prefiniti Network" type="html">
	<h1>Prefiniti Invitation</h1>
	
	<p>#getLongname(URL.CalledByUser)# has invited you to join The Prefiniti Network for Land Survey and Medical small business. Please visit the link below to confirm your new account. If you do not want a Prefiniti account, just ignore this email.</p>
	
	<p>Your username is <strong>#sel_username#</strong></p>
	
    <p style="color:red;">Once your account is confirmed, log in with the username <strong>#sel_username#</strong> and enter your personal information under &quot;Edit Profile&quot;.</p>
    
	<p>You will need <a href="http://www.mozilla.com/en-US/firefox/">Mozilla Firefox<a/> or <a href="http://www.apple.com/safari/">Apple Safari<a/> to use Prefiniti. We do not support Internet Explorer at this time.</p>
	
	<a href="http://prefiniti15.prefiniti.com/appBase.cfm?sideBar=Register&contentBar=/authentication/components/setInitialPassword.cfm?cid=#cid#">Confirm My Account</a>
	
	<p>Otherwise, copy the following text to your browser's URL bar:</p>
	
	<pre>http://prefiniti15.prefiniti.com/appBase.cfm?sideBar=Register&contentBar=/authentication/components/setInitialPassword.cfm?cid=#cid#</pre>
</cfmail>
</cfoutput>

<cfoutput>
<table width="100%" cellspacing="0">
<tr>
	<td align="center">
		<h3>Invitation Sent</h3>
		
		<p>An e-mail containing instructions for accepting this invitation has been sent to <strong>#url.email#</strong>.</p>
        
        <!---<input type="button" class="normalButton" value="Close" onclick="hideDiv('gen_window_frame');">--->
		<input type="button" class="normalButton" value="Send Another Invitation" onclick="inviteUser();">
		
	</td>
</tr>
</table>
</cfoutput>
