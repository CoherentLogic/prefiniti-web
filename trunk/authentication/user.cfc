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
<cfcomponent displayname="user" output="no" hint="Represents a Prefiniti User"> 
<!-- CLASS									DATABASE FIELD -->
	<cfset this.r_pk = 0>					<!--- id (primary key) --->
    <cfset this.username = "">				<!--- username --->
    <cfset this.password = "">				<!--- password --->
    <cfset this.email = "">					<!--- email --->
    <cfset this.sms_number = "">			<!--- smsNumber --->
    <cfset this.user_picture = "">				<!--- picture --->
    <cfset this.account_enabled = 0>		<!--- account_enabled --->
    <cfset this.gender = "">				<!--- gender --->
    <cfset this.account_confirmed = 0>		<!--- confirmed --->
    <cfset this.sms_confirmed = 0>			<!--- sms_confirmed --->
    <cfset this.first_name = "">			<!--- firstName --->
    <cfset this.middle_initial = "">		<!--- middleInitial --->
    <cfset this.last_name = "">				<!--- lastName --->
    <cfset this.display_name = "">  		<!--- longName --->
    <cfset this.allow_search = 0>			<!--- allowSearch --->
    <cfset this.birthday = #CreateODBCDate(Now())#>				<!--- birthday --->
    <cfset this.relationship_status = "Unlisted">	<!--- relationship_status --->
    <cfset this.so_id = 0>					<!--- so_id --->
    <cfset this.zip_code = "">				<!--- zip_code --->
    <cfset this.password_question = "">		<!--- password_question --->
    <cfset this.password_answer = "">		<!--- password_answer --->
    <cfset this.status = "">				<!--- status --->
    <cfset this.location = "">				<!--- location --->
    <cfset this.om_uuid = "">				<!--- confirm_id --->
    <cfset this.global_admin = 0>			<!--- webware_admin --->
    <cfset this.creation_date = #CreateODBCDateTime(Now())#>		<!--- CreationDate --->
    <cfset this.location_url = "">			<!--- location_url --->
    <cfset this.active_membership_id = 0>		<!--- last_site_id --->
   	<cfset this.first_login = 0>
    <cfset this.object_record = "">				<!--- ORMS record --->
    
    
    <cfset this.written = false>    
    
    <cffunction name="Create" access="public" returntype="authentication.user" output="no">    
		<cfargument name="username" type="string" required="yes">
		<cfargument name="password" type="string" required="yes">
		<cfargument name="password_question" type="string" required="yes">
		<cfargument name="password_answer" type="string" required="yes">		        
        <cfargument name="email" type="string" required="yes">
		<cfargument name="first_name" type="string" required="yes">
		<cfargument name="middle_initial" type="string" required="yes">
		<cfargument name="last_name" type="string" required="yes">
		<cfargument name="birthday" type="string" required="yes">		
        <cfargument name="allow_search" type="boolean" required="yes">
		<cfargument name="zip_code" type="string" required="yes">
		
        <cfset this.om_uuid = CreateUUID()>
        <cfset this.username = username>
        <cfset this.password = Hash(password)>
        <cfset this.password_question = password_question>
        <cfset this.password_answer = password_answer>
        <cfset this.email = email>
        <cfset this.first_name = first_name>
        <cfset this.middle_initial = middle_initial>
        <cfset this.last_name = last_name>
        <cfset this.display_name = FormatName()>
        <cfset this.birthday = CreateODBCDate(birthday)>
        <cfset this.account_confirmed = 0>
        <cfset this.account_enabled = 1>
    	<cfset this.first_login = 1>
            
        <cfif allow_search EQ true>
        	<cfset this.allow_search = 1>
        <cfelse>
        	<cfset this.allow_search = 0>
        </cfif>
        <cfset this.zip_code = zip_code>
        
        <cfset this.Save()>
        <cfset this.SendConfirmationEmail()>
        
        <cfreturn #this#>
	</cffunction>
    
    <cffunction name="FormatName" access="public" returntype="string" output="no">
    	<cfif Len(this.middle_initial) GT 0>
        	<cfset fname = this.first_name & " " & this.middle_initial & ". " & this.last_name>
        <cfelse>
        	<cfset fname = this.first_name & " " & this.last_name>
        </cfif>
        
        <cfreturn #fname#>
    </cffunction>
    
    <cffunction name="Open" access="public" output="no" returntype="authentication.user">
    	<cfargument name="username" type="string" required="yes">
        
        <cfquery name="UOpen" datasource="webwarecl">
        	SELECT 	*
            FROM	users
            WHERE	username='#username#'
		</cfquery>
        
       	<cfset this.r_pk = UOpen.id>								<!--- id (primary key) --->
		<cfset this.username = UOpen.username>						<!--- username --->
        <cfset this.password = UOpen.password>						<!--- password --->
        <cfset this.email = UOpen.email>							<!--- email --->
        <cfset this.sms_number = UOpen.smsNumber>					<!--- smsNumber --->
        <cfset this.user_picture = UOpen.picture>						<!--- picture --->
        <cfset this.account_enabled = UOpen.account_enabled>		<!--- account_enabled --->
        <cfset this.gender = UOpen.gender>							<!--- gender --->
        <cfset this.account_confirmed = UOpen.confirmed>			<!--- confirmed --->
        <cfset this.sms_confirmed = UOpen.sms_confirmed>			<!--- sms_confirmed --->
        <cfset this.first_name = UOpen.firstName>					<!--- firstName --->
        <cfset this.middle_initial = UOpen.middleInitial>			<!--- middleInitial --->
        <cfset this.last_name = UOpen.lastName>						<!--- lastName --->
        <cfset this.display_name = UOpen.longName>  				<!--- longName --->
        <cfset this.allow_search = UOpen.allowSearch>				<!--- allowSearch --->
        <cfset this.birthday = UOpen.birthday>						<!--- birthday --->
        <cfset this.relationship_status = UOpen.relationship_status><!--- relationship_status --->
        <cfset this.so_id = UOpen.so_id>							<!--- so_id --->
        <cfset this.zip_code = UOpen.zip_code>						<!--- zip_code --->
        <cfset this.password_question = UOpen.password_question>	<!--- password_question --->
        <cfset this.password_answer = UOpen.password_answer>		<!--- password_answer --->
        <cfset this.status = UOpen.status>							<!--- status --->
        <cfset this.location = UOpen.location>						<!--- location --->
        <cfset this.om_uuid = UOpen.confirm_id>						<!--- confirm_id --->
        <cfset this.global_admin = UOpen.webware_admin>				<!--- webware_admin --->
        <cfset this.creation_date = UOpen.CreationDate>				<!--- CreationDate --->
        <cfset this.location_url = UOpen.location_url>				<!--- location_url --->
        <cfset this.active_membership_id = UOpen.last_site_id>			<!--- last_site_id --->       
        <cfset this.first_login = UOpen.first_login>
        
        <cfset this.object_record = CreateObject("component", "res").GetByTypeAndPK("User Account", this.r_pk)>
        
        <cfset this.written = true>
        
        <cfreturn #this#>
    </cffunction>
    
    <cffunction name="OpenByPK" access="public" output="no" returntype="authentication.user">
    	<cfargument name="pk" type="numeric" required="yes">
        
        <cfquery name="obpk" datasource="webwarecl">
        	SELECT username FROM users WHERE id=#pk#
        </cfquery>
        
        <cfset ret_val = this.Open(obpk.username)>

        <cfreturn #ret_val#>
    </cffunction>
    
    <cffunction name="Save" access="public" output="no" returntype="void">
    	<cfif this.written>
      		<cfset this.UpdateExistingRecord()>
    	<cfelse>
      		<cfset this.WriteAsNewRecord()>
    	</cfif>
    	<cfmodule template="/authentication/Users/orms_do.cfm" id="#this.r_pk#">
        <cfset this.written = true>
  	</cffunction>
    
    <cffunction name="UpdateExistingRecord" access="public" output="no" returntype="void">
    	<cfquery name="uer" datasource="webwarecl">
        	UPDATE 	users
            SET		username='#this.username#',
            		password='#this.password#',
                    email='#this.email#',
                    smsNumber='#this.sms_number#',
                    picture='#this.user_picture#',
                    account_enabled=#this.account_enabled#,
                    gender='#this.gender#',
                    confirmed=#this.account_confirmed#,
                    sms_confirmed=#this.sms_confirmed#,
                    firstName='#this.first_name#',
                    middleInitial='#this.middle_initial#',
                    lastName='#this.last_name#',
                    longName='#this.display_name#',
                    allowSearch=#this.allow_search#,
                    birthday=#this.birthday#,
                    relationship_status='#this.relationship_status#',
                    so_id=#this.so_id#,
                    zip_code='#this.zip_code#',
                    password_question='#this.password_question#',
                    password_answer='#this.password_answer#',
                    status='#this.status#',
                    location='#this.location#',
                    confirm_id='#this.om_uuid#',
                    webware_admin=#this.global_admin#,
                    location_url='#this.location_url#',
                    last_site_id=#this.active_membership_id#
                    first_login=#this.first_login#
			WHERE	id=#this.r_pk#                    
        </cfquery>          
    </cffunction>
    
    <cffunction name="WriteAsNewRecord" access="public" output="no" returntype="void">
    	<cfset this.om_uuid = CreateUUID()>
        
        <cfset this.creation_date = CreateODBCDateTime(Now())>
        
    	<cfquery name="wanr" datasource="webwarecl">
        	INSERT INTO users
            	(username,
                password,
                email,
                smsNumber,
                picture,
                account_enabled,
                gender,
                confirmed,
                sms_confirmed,
                firstName,
                middleInitial,
                lastName,
                longName,
                allowSearch,
                birthday,
                relationship_status,
                so_id,
                zip_code,
                password_question,
                password_answer,
                status,
                location,
                confirm_id,
                webware_admin,
                CreationDate,
                location_url,
                last_site_id,
                first_login)
			VALUES
            	('#this.username#',
                '#this.password#',
                '#this.email#',
                '#this.sms_number#',
                '#this.user_picture#',
                #this.account_enabled#,
                '#this.gender#',
                #this.account_confirmed#,
                #this.sms_confirmed#,
               	'#this.first_name#',
                '#this.middle_initial#',
                '#this.last_name#',
                '#this.display_name#',
                #this.allow_search#,
                #CreateODBCDate(this.birthday)#,
                '#this.relationship_status#',
                #this.so_id#,
                '#this.zip_code#',
                '#this.password_question#',
                '#this.password_answer#',
                '#this.status#',
                '#this.location#',
                '#this.om_uuid#',
                #this.global_admin#,
                #this.creation_date#,
                '#this.location_url#',
                #this.active_membership_id#,
                #this.first_login#)                                                              
        </cfquery>
        
        <cfquery name="wanr_get_id" datasource="webwarecl">
        	SELECT id FROM users WHERE confirm_id='#this.om_uuid#'
        </cfquery>
        
        <cfset this.r_pk = wanr_get_id.id>               
    </cffunction>
    
	<cffunction name="SendConfirmationEmail" access="public" returntype="void" output="no">
    	<cfoutput>
        <cfmail from="register@prefiniti.com" to="#this.email#" subject="Prefiniti Account Confirmation" type="html">
            <h1>Account Created</h1>
            
            <p>Your Prefiniti account has been created. Please visit the link below to confirm your new account.</p>            
            
            <a href="http://prefiniti15.prefiniti.com/homeres/confirm_account.cfm?om_uuid=#this.om_uuid#">Confirm My Account</a>
            
            <p>Otherwise, copy the following text to your browser's URL bar:</p>
            
            <pre>http://prefiniti15.prefiniti.com/homeres/confirm_account.cfm?om_uuid=#this.om_uuid#</pre>
            
            <p>You will need <a href="http://www.mozilla.com/en-US/firefox/">Mozilla Firefox<a/>, <a href="http://www.google.com/chrome">Google Chrome</a>, or <a href="http://www.apple.com/safari/">Apple Safari</a> to use Prefiniti. We do not support Microsoft Internet Explorer at this time.</p>
        </cfmail>
        </cfoutput>
        
    </cffunction>
    
    <cffunction name="ConfirmAccount" access="public" returntype="void" output="no">
    	<cfset this.account_confirmed = 1>                    
        <cfset this.Save()>
    </cffunction>
    
    <cffunction name="Confirmed" access="public" returntype="boolean" output="no">
    	<cfif this.account_confirmed EQ 0>
        	<cfreturn false>
		<cfelse>
        	<cfreturn true>
		</cfif>                                    
    </cffunction>
    
    <cffunction name="SetPassword" access="public" returntype="void" output="no">
    	<cfargument name="password" type="string" required="yes">
        <cfargument name="password_question" type="string" required="yes">
        <cfargument name="password_answer" type="string" required="yes">
        
        <cfset this.password = Hash(password)>
        <cfset this.password_question = password_question>
        <cfset this.password_answer = password_answer>
        
        <cfset this.Save()>
    </cffunction>
    
    <cffunction name="FirstLogin" access="public" returntype="boolean" output="no">
    	<cfif this.first_login EQ 1>
        	<cfreturn true>
        <cfelse>
        	<cfreturn false>
        </cfif>
    </cffunction>
    
    <cffunction name="Picture" access="public" returntype="string" output="no">
    	<cfargument name="width" type="numeric" required="yes">
        <cfargument name="height" type="numeric" required="yes">
        
    	<cfset po = CreateObject("component", "OpenHorizon.Graphics.Image")>
        <cfset pic = po.Create(this.user_picture, width, height)> 
        
		<cfreturn #pic#>    
    </cffunction>
    
    <cffunction name="Friends" access="public" returntype="array" output="no">
    	<cfquery name="qryFriends" datasource="webwarecl">
        	SELECT * FROM friends WHERE target_id=#this.r_pk#
        </cfquery>
        
        <cfset ret_val = ArrayNew(1)>
        
        <cfoutput query="qryFriends">
        	<cfset t_user = CreateObject("component", "authentication.user").OpenByPK(source_id)>
            
            <cfset ArrayAppend(ret_val, t_user)>
        </cfoutput>
            	               
        <cfreturn #ret_val#>
    </cffunction>
    
    <cffunction name="CommonFriends" access="public" returntype="array" output="no">
    	<cfargument name="target_user" type="authentication.user" required="yes">
        
        <cfset source_friends = this.Friends()>
        <cfset target_friends = target_user.Friends()>
        
        <cfset ret_val = ArrayNew(1)>
        
        <cfloop array="#source_friends#" index="sf">
        	<cfloop array="#target_friends#" index="tf">
            	<cfif sf.r_pk EQ tf.r_pk>
                	<cfset ArrayAppend(ret_val, sf)>
				</cfif>                    
            </cfloop>
        </cfloop>
        
        <cfreturn #ret_val#>    
    </cffunction>
    
    <cffunction name="Online" access="public" returntype="boolean" output="no">       	>
        
        <cfquery name="io" datasource="webwarecl">
        	SELECT 	*	
            FROM	auth_tokens
            WHERE	username='#this.username#'
            AND		active=1
    	</cfquery>
        
        <cfif io.RecordCount GT 0>
        	<cfreturn true>
        <cfelse>
        	<cfreturn false>
        </cfif>
    </cffunction>
    
    <cffunction name="ObjectRecord" access="public" returntype="Res" output="no">
    	<cfreturn #this.object_record#>
    </cffunction>
        
</cfcomponent>