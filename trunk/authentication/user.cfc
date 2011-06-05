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
    <cfset this.sms_number = "">			<!--- sms_number --->
    <cfset this.picture = "">				<!--- picture --->
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
    <cfset this.active_membership = 0>		<!--- last_site_id --->
    
    <cfset this.written = false>    
    
    <cffunction name="myFunction" access="public" returntype="string">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>
    
    <cffunction name="Open" access="public" output="no" returntype="authentication.user">
    	<cfargument name="username" type="string" required="yes">
        
        <cfquery name="Open" datasource="webwarecl">
        	SELECT 	*
            FROM	users
            WHERE	username='#username#'
		</cfquery>
        
       	<cfset this.r_pk = UOpen.id>									<!--- id (primary key) --->
		<cfset this.username = UOpen.username>						<!--- username --->
        <cfset this.password = UOpen.password>						<!--- password --->
        <cfset this.email = UOpen.email>								<!--- email --->
        <cfset this.sms_number = UOpen.sms_number>					<!--- sms_number --->
        <cfset this.picture = UOpen.picture>							<!--- picture --->
        <cfset this.account_enabled = UOpen.account_enabled>			<!--- account_enabled --->
        <cfset this.gender = UOpen.gender>							<!--- gender --->
        <cfset this.account_confirmed = UOpen.confirmed>				<!--- confirmed --->
        <cfset this.sms_confirmed = UOpen.sms_confirmed>				<!--- sms_confirmed --->
        <cfset this.first_name = UOpen.firstName>					<!--- firstName --->
        <cfset this.middle_initial = UOpen.middleInitial>			<!--- middleInitial --->
        <cfset this.last_name = UOpen.lastName>						<!--- lastName --->
        <cfset this.display_name = UOpen.longName>  					<!--- longName --->
        <cfset this.allow_search = UOpen.allowSearch>				<!--- allowSearch --->
        <cfset this.birthday = UOpen.birthday>						<!--- birthday --->
        <cfset this.relationship_status = UOpen.relationship_status>	<!--- relationship_status --->
        <cfset this.so_id = UOpen.so_id>								<!--- so_id --->
        <cfset this.zip_code = UOpen.zip_code>						<!--- zip_code --->
        <cfset this.password_question = UOpen.password_question>		<!--- password_question --->
        <cfset this.password_answer = UOpen.password_answer>			<!--- password_answer --->
        <cfset this.status = UOpen.status>							<!--- status --->
        <cfset this.location = UOpen.location>						<!--- location --->
        <cfset this.om_uuid = UOpen.confirm_id>						<!--- confirm_id --->
        <cfset this.global_admin = UOpen.webware_admin>				<!--- webware_admin --->
        <cfset this.creation_date = UOpen.CreationDate>				<!--- CreationDate --->
        <cfset this.location_url = UOpen.location_url>				<!--- location_url --->
        <cfset this.active_membership = UOpen.last_site_id>			<!--- last_site_id --->       
        
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
                    sms_number='#this.sms_number#',
                    picture='#this.picture#',
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
                    last_site_id=#this.active_membership#
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
                sms_number,
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
                last_site_id)
			VALUES
            	('#this.username#',
                '#this.password#',
                '#this.email#',
                '#this.sms_number#',
                '#this.picture#',
                #this.account_enabled,
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
                #this.active_membership#)                                                              
        </cfquery>
        
        <cfquery name="wanr_get_id" datasource="webwarecl">
        	SELECT id FROM users WHERE confirm_id='#this.om_uuid#'
        </cfquery>
        
        <cfset this.r_pk = wanr_get_id.id>               
    </cffunction>
    


</cfcomponent>