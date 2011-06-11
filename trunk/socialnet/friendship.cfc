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
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfcomponent displayname="friendship" hint="Represents a friendship on Prefiniti" output="no">
	<cfset this.om_uuid = "">
	<cfset this.source_friend = "">
    <cfset this.target_friend = "">
    <cfset this.requested = false>
    <cfset this.confirmed = 0>  
    <cfset this.declined = false>   
    <cfset this.request_date = CreateODBCDateTime(Now())>
    <cfset r_pk = 0>

	<cffunction name="Open" access="public" returntype="socialnet.friendship">
		<cfargument name="source_friend" type="OpenHorizon.Identity.User" required="yes">
		<cfargument name="target_friend" type="OpenHorizon.Identity.User" required="yes">

		<cfset this.source_friend = source_friend>
        <cfset this.target_friend = target_friend>
        
		<cfquery name="fe" datasource="webwarecl">
        	SELECT 	* 
            FROM 	friends 
            WHERE 	source_id=#this.source_friend.r_pk#
            AND		target_id=#this.target_friend.r_pk#
		</cfquery>
        
        <cfif fe.RecordCount GT 0>
        	<cfset this.requested = true>
            <cfset this.om_uuid = fe.om_uuid>
            <cfset this.request_date = fe.request_date>
            <cfset this.r_pk = fe.id>
		<cfelse>
        	<cfset this.om_uuid = CreateUUID()>
        	<cfset this.requested = false>
        </cfif>                        

		<cfreturn #this#>
	</cffunction>
    
    <cffunction name="Request" access="public" returntype="socialnet.friendship">
    	<cfif this.requested EQ false>        
        	<cfset this.request_date = CreateODBCDateTime(Now())>
        	<cfquery name="RequestFriend" datasource="webwarecl">
	            INSERT INTO	friends
                			(source_id,
                            target_id,
                            confirmed,
                            request_date,
                            om_uuid)
				VALUES		(#this.source_friend.r_pk#,
                			#this.target_friend.r_pk,
                            #this.confirmed#,
                            #this.request_date#,
                            '#this.om_uuid#')
			</cfquery>
            <cfset this.requested = true>
            <cfset ntNotify(this.target_friend.r_pk, "SN_FRIEND_REQUEST", this.source_friend.display_name & " has requested friendship with " & this.target_friend.display_name & ".", "")>
		</cfif>            
	
    	<cfreturn #this#>                                                      
    </cffunction>
    
    <cffunction name="Confirm" access="public" returntype="socialnet.friendship">
    	<cfif this.requested EQ true>
        	<cfquery name="ConfirmFriend" datasource="webwarecl">
            	UPDATE	friends
                SET		confirmed=1
                WHERE	id=#this.r_pk#
            </cfquery>
            <cfset ntNotify(this.source_friend.r_pk, "SN_FRIEND_ACCEPT", this.target_friend.display_name & " has accepted " & this.source_friend.display_name & " as a friend.", "")>
        </cfif>  
        <cfreturn #this#>
    </cffunction>
    
    <cffunction name="Decline" access="public" returntype="socialnet.friendship" output="no">
		<cfif this.requested EQ true>
        	<cfquery name="DeclineFriend" datasource="webwarecl">
            	DELETE FROM	friends
                WHERE		id=#this.r_pk#
            </cfquery>
            <cfset ntNotify(this.source_friend.r_pk, "SN_FRIEND_DECLINE", this.target_friend.display_name & " has declined " & this.source_friend.display_name & " as a friend.", "")>
            <cfset this.declined = true>
            <cfset this.requested = false>
    	<cfreturn #this#>
	</cffunction>
</cfcomponent>