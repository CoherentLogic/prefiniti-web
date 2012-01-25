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
<cftry>
<cfinclude template="/notifications/notification_udf.cfm">
<cfcatch type="any">
</cfcatch>
</cftry>

<cftry>
<!---<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">--->
<cffunction name="snUserZIP" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="snuz" datasource="#session.framework.BaseDatasource#">
    	SELECT zip_code FROM users WHERE id=#user_id#
    </cfquery>
    
    <cfreturn #snuz.zip_code#>
</cffunction>
    
<cffunction name="snLinkify" returntype="string" output="no">
	<cfargument name="input_text" type="string" required="yes">
    <cfargument name="area" type="string" required="yes">
    
    <cfparam name="ts" default="">
    <cfparam name="ta" default="">
    <cfparam name="resCount" default="">
    
    <cfset ts="">
    <cfset ta=ArrayNew(1)>
    <cfset ta=ListToArray(input_text)>
    <cfoutput>#ArraySort(ta, "textnocase")#</cfoutput>
    
   	<cfloop from="1" to="#ArrayLen(ta)#" index="i">
    	<cfset resCount=searchUsers(area, Trim(ta[i])).RecordCount>
        

    	<cfset ts="#ts#, <a href=""javascript:snSearchByCommon('#Trim(ta[i])#', '#area#')"">#ta[i]#">

		<cfif resCount GT 1>
        	<cfset ts="#ts# <strong>(#resCount#)</strong></a>">
        <cfelse>
        	<cfset ts="#ts#</a>">
		</cfif>            

        
    </cfloop>
    
    <cfif Len(ts) GT 4>
	    <cfreturn Mid(ts, 2, Len(ts) - 1)>
    <cfelse>
    	<cfreturn "">
	</cfif>        
</cffunction>



<cffunction name="requestFriend" returntype="void">
	<cfargument name="source_id" type="numeric" required="yes">
    <cfargument name="target_id" type="numeric" required="yes">
    
    <cfquery name="chkReq" datasource="#session.framework.BaseDatasource#">
    	SELECT id FROM friends WHERE source_id=#source_id# AND target_id=#target_id#
	</cfquery>
            
    <cfif chkReq.RecordCount EQ 0>
	<cfquery name="postRequest" datasource="#session.framework.BaseDatasource#">
    	INSERT INTO friends
        	(source_id,
            target_id,
            request_date,
            confirmed)
		VALUES
        	(#source_id#,
            #target_id#,
            #CreateODBCDateTime(Now())#,
            0)            
	</cfquery>         
    <cfoutput>#ntNotify(target_id, "SN_FRIEND_REQUEST", "#getLongname(source_id)# has requested to be your friend.", "")#</cfoutput>   
    </cfif>
</cffunction>    

<cffunction name="acceptFriendRequest" returntype="void">
	<cfargument name="request_id" type="numeric" required="yes">
    
    <cfquery name="confOrig" datasource="#session.framework.BaseDatasource#">
    	UPDATE friends SET confirmed=1 WHERE id=#request_id#
	</cfquery>
    
    <cfquery name="getOrig" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM friends WHERE id=#request_id#
	</cfquery>
    
    <!---<cffunction name="writeUserEvent" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_icon" type="string" required="yes">
    <cfargument name="event_text" type="string" required="yes">--->
    
    <cfparam name="et" default="">
    <cfset et="#getLongname(getOrig.source_id)# and #getLongname(getOrig.target_id)# are now friends.">
    
     <cfoutput>#ntNotify(getOrig.target_id, "SN_FRIEND_ACCEPT", "#getLongname(getOrig.source_id)# has accepted you as a friend.", "")#</cfoutput>
    
    <cfoutput>
    #writeUserEvent(getOrig.source_id, "user_add.png", et)#
    <cfif getOrig.source_id NEQ getOrig.target_id>
	    #writeUserEvent(getOrig.target_id, "user_add.png", et)#
	</cfif>
	</cfoutput>
    
    
    
	<cfif getOrig.source_id NEQ getOrig.target_id>
    

    
    <cfquery name="postNew" datasource="#session.framework.BaseDatasource#">
    	INSERT INTO friends
        	(source_id,
            target_id,
            request_date,
            confirmed)
		VALUES
        	(#getOrig.target_id#,
            #getOrig.source_id#,
            #CreateODBCDateTime(Now())#,
            1)
	</cfquery>
    </cfif>
</cffunction>

<cffunction name="rejectFriendRequest" returntype="void">
	<cfargument name="request_id" type="numeric" required="yes">
    
    <cfquery name="rej" datasource="#session.framework.BaseDatasource#">
	    DELETE FROM friends WHERE id=#request_id#
	</cfquery>        
</cffunction>

<cffunction name="deleteFriend" returntype="void">
	<cfargument name="sourceid" type="numeric" required="yes">
    <cfargument name="targetid" type="numeric" required="yes">
    
     <cfoutput>#ntNotify(targetid, "SN_FRIEND_DELETE", "#getLongname(sourceid)# has deleted you as a friend.", "")#</cfoutput>
    
    <cfparam name="et" default="">
    <cfset et="#getLongname(sourceid)# and #getLongname(targetid)# are no longer friends.">
    
    <cfoutput>
    #writeUserEvent(sourceid, "user_delete.png", et)#
    <cfif sourceid NEQ targetid>
    	#writeUserEvent(targetid, "user_delete.png", et)#
    </cfif>
	</cfoutput>
    
    <cfquery name="delSource" datasource="#session.framework.BaseDatasource#">
    	DELETE FROM friends WHERE source_id=#sourceid# AND target_id=#targetid#
	</cfquery>
    
    <cfquery name="delTarget" datasource="#session.framework.BaseDatasource#">
    	DELETE FROM friends WHERE source_id=#targetid# AND target_id=#sourceid#
	</cfquery>
</cffunction> 

<cffunction name="snUsersOnline" returntype="string">                  
    
    <cfreturn "Deprecated">
</cffunction>

<cffunction name="getFriends" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gf" datasource="#session.framework.BaseDatasource#">
    	SELECT friends.source_id, friends.target_id, friends.confirmed, friends.request_date, users.lastName, users.firstName FROM friends, users WHERE users.id=friends.target_id AND friends.source_id=#user_id# AND friends.confirmed=1 ORDER BY users.lastName, users.firstName
    </cfquery>
    
    <cfreturn #gf#>
</cffunction>  

 

<cffunction name="searchUsers" returntype="query">
	<cfargument name="search_field" type="string" required="yes">
    <cfargument name="search_value" type="string" required="yes">
    
    <cfquery name="s" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM users WHERE allowSearch=1 AND (#search_field# LIKE '%#search_value#%' OR #search_field# LIKE '%#search_value#' OR #search_field# LIKE '#search_value#%')  ORDER BY lastName, firstName
	</cfquery>
    
    <cfreturn #s#>        
</cffunction>    

<cffunction name="getRequests" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gr" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM friends WHERE target_id=#user_id# AND confirmed=0
    </cfquery>
    
    <cfreturn #gr#>
</cffunction>

<cffunction name="getUsername" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gu" datasource="#session.framework.BaseDatasource#">
    	SELECT LTRIM(username) AS UN FROM users WHERE id=#user_id#
    </cfquery>
    
    <cfreturn #gu.UN#>
</cffunction>

<cffunction name="getHisHer" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">

	<cfquery name="ghh" datasource="#session.framework.BaseDatasource#">
    	SELECT gender FROM users WHERE id=#user_id#
    </cfquery>
    
    <cfif ghh.gender EQ "M">
    	<cfreturn "his">
    <cfelse>
    	<cfreturn "her">
	</cfif>        
</cffunction>    
<cffunction name="getPicture" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gp" datasource="#session.framework.BaseDatasource#">
    	SELECT picture, username, gender FROM users WHERE id=#user_id#
    </cfquery>        
    
    <cfif #gp.picture# EQ "">
		<cfif #gp.gender# EQ "M">
            <cfreturn "/graphics/prefuser.png">
        <cfelseif #gp.gender# EQ "F">
            <cfreturn "/graphics/prefuserfem.png">
        <cfelse>
            <cfreturn "/graphics/prefuser.png">
        </cfif>
    <cfelse>
        <cfreturn "#gp.picture#">
    </cfif>
    
    
</cffunction>    

<cffunction name="getOnline" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfreturn "Deprecated">
</cffunction>

<cffunction name="getOnlineBool" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfreturn false>        
</cffunction>

<cffunction name="getLongname" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gl" datasource="#session.framework.BaseDatasource#">
    	SELECT longName FROM users WHERE id=#user_id#
	</cfquery>
    
    <cfreturn #gl.longName#>
</cffunction>

<cffunction name="getFirstname" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gf" datasource="#session.framework.BaseDatasource#">
    	SELECT firstName FROM users WHERE id=#user_id#
	</cfquery>
    
    <cfreturn #gf.firstName#>
</cffunction>

<cffunction name="getEmail" returntype="string">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="ge" datasource="#session.framework.BaseDatasource#">
    	SELECT email FROM users WHERE id=#user_id#
	</cfquery>
    
    <cfreturn #ge.email#>
</cffunction>

<cffunction name="getBirthday" returntype="date">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gl" datasource="#session.framework.BaseDatasource#">
    	SELECT birthday FROM users WHERE id=#user_id#
	</cfquery>
    
    <cfreturn #gl.birthday#>
</cffunction>

<cffunction name="getAge" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
	
	<cfparam name="age" default="">
	<cfset age = DateDiff("yyyy", getBirthday(user_id), Now())>

	<cfreturn #age#>
</cffunction>	
	

<cffunction name="getComments" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gc" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM comments WHERE to_id=#user_id# ORDER BY sent_date DESC
	</cfquery>
    
    <cfif gc.RecordCount GT 0>
            
    </cfif>
    
    <cfreturn #gc#>        
</cffunction>

<cffunction name="setCommentsRead" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
	<cfquery name="setRead" datasource="#session.framework.BaseDatasource#">
    	UPDATE comments SET c_read=1 WHERE to_id=#user_id#
	</cfquery>
</cffunction>    
    
<cffunction name="postComment" returntype="void">
	<cfargument name="fromid" type="numeric" required="yes">
    <cfargument name="toid" type="numeric" required="yes">
    <cfargument name="comment_body" type="string" required="yes">
    
    <cfparam name="et" default="">
    <cfset et="#getLongname(fromid)# left a comment for #getLongname(toid)#.">
    
    <cfoutput>
    #writeUserEvent(fromid, "comment_add.png", et)#
    <cfif fromid NEQ toid>
    	#writeUserEvent(toid, "comment_add.png", et)#
    </cfif>
	</cfoutput>
    
    <cfoutput>#ntNotify(toid, "SN_COMMENT_POSTED", "#getLongname(fromid)# has left you a comment.", "viewProfile(#toid#);")#</cfoutput>
    
    <cfquery name="pc" datasource="#session.framework.BaseDatasource#">
    	INSERT INTO comments
        	(from_id,
            to_id,
            body,
            sent_date,
            c_read)
		VALUES
        	(#fromid#,
            #toid#,
            '#comment_body#',
            #CreateODBCDateTime(Now())#,
            0)
	</cfquery>
                            
</cffunction>    

<cffunction name="snGetBlogs" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="sngb" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM blogs WHERE user_id=#user_id# ORDER BY post_date DESC
	</cfquery>
    
    <cfreturn #sngb#>
</cffunction>    

<cffunction name="snGetBlog" returntype="query">
	<cfargument name="blog_id" type="numeric" required="yes">
    
    <cfquery name="sngb1" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM blogs WHERE id=#blog_id#
	</cfquery>
    
    <cfreturn #sngb1#>
</cffunction>  

<cffunction name="snPostBlog" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="subject" type="string" required="yes">
    <cfargument name="body_copy" type="string" required="yes">
    <cfargument name="public" type="numeric" required="yes">
    
    <cfquery name="snpb" datasource="#session.framework.BaseDatasource#">
    	INSERT INTO blogs
        	(user_id,
            subject,
            body_copy,
            post_date,
            public)
		VALUES
        	(#user_id#,
            '#subject#',
            '#body_copy#',
            #CreateODBCDateTime(Now())#,
            #public#)            
    </cfquery>
    
    <cfif public NEQ 0>
    	<cfparam name="et" default="">
    	<cfset et="#getLongname(user_id)# has posted a new blog.">
    
    	<cfoutput>
    	#writeUserEvent(user_id, "note_add.png", et)#
        </cfoutput>
	</cfif>        
</cffunction>        
    
    
            
<cffunction name="isFriend" returntype="boolean">
	<cfargument name="sourceid" type="numeric" required="yes">
    <cfargument name="targetid" type="numeric" required="yes">	
	
    <cfquery name="if" datasource="#session.framework.BaseDatasource#">
    	SELECT id FROM friends WHERE source_id=#sourceid# AND target_id=#targetid# AND confirmed=1
    </cfquery>
    
    <cfif if.RecordCount EQ 0>
    	<cfreturn false>
    <cfelse>
    	<cfreturn true>
	</cfif>        
</cffunction>                                                                    

<cffunction name="writeUserEvent" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_icon" type="string" required="yes">
    <cfargument name="event_text" type="string" required="yes">
    
    <cfquery name="wue" datasource="#session.framework.BaseDatasource#">
    	INSERT INTO user_events
        	(user_id,
            event_date,
            event_icon,
            event_text)
		VALUES
        	(#user_id#,
            #CreateODBCDateTime(Now())#,
            '#event_icon#',
            '#event_text#')
	</cfquery>
</cffunction> 

<cffunction name="getUserEvents" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gue" datasource="#session.framework.BaseDatasource#">
    	SELECT * FROM user_events WHERE user_id=#user_id# ORDER BY event_date DESC
	</cfquery>
    
    <cfreturn #gue#>            
</cffunction>

<cffunction name="getFriendEvents" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gfe" datasource="#session.framework.BaseDatasource#">
    	SELECT DISTINCT 
        	user_events.event_text, 
        	user_events.event_date,
            user_events.event_icon    
        FROM 		user_events 
        INNER JOIN 	friends 
        ON 			friends.target_id=user_events.user_id 
        WHERE		friends.source_id=#user_id#
        ORDER BY 	user_events.event_date DESC
	</cfquery>
    
    <cfreturn #gfe#>            
</cffunction>

<cffunction name="isProfilePicture" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="file_name" type="string" required="yes">
    
    <cfquery name="gpp" datasource="#session.framework.BaseDatasource#">
    	SELECT picture FROM users WHERE id=#user_id#
    </cfquery>
    
    <cfif #gpp.picture# EQ #file_name#>
    	<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>            	
</cffunction>    

<cffunction name="setProfilePicture" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="file_name" type="string" required="yes">
   
   	<cfquery name="spp" datasource="#session.framework.BaseDatasource#">
   		UPDATE users SET picture='#file_name#' WHERE id=#user_id#
	</cfquery>
</cffunction>   

<cffunction name="isSO" returntype="boolean">
	<cfargument name="src" type="numeric" required="yes">
	<cfargument name="tgt" type="numeric" required="yes">
	
	<cfquery name="isso_src" datasource="#session.framework.BaseDatasource#">
		SELECT so_id, relationship_status FROM users WHERE id=#src# 
	</cfquery>
	
	<cfif isso_src.so_id EQ tgt>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

<cffunction name="relationshipStatus" returntype="string">
	<cfargument name="tgt" type="numeric" required="yes">
	
	<cfquery name="rs" datasource="#session.framework.BaseDatasource#">
		SELECT relationship_status FROM users WHERE id=#tgt#
	</cfquery>
	
	<cfreturn #rs.relationship_status#>
</cffunction>

<cfcatch type="any">
</cfcatch>
</cftry>