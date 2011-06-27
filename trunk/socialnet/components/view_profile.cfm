
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfquery name="profile" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#url.userid#
</cfquery>

<cfquery name="source_age" datasource="webwarecl">
	SELECT birthday FROM Users WHERE id=#url.calledByUser#
</cfquery>

<cfquery name="visit_count" datasource="webwarecl">
	SELECT id FROM profile_visits WHERE target_id=#url.userid#
</cfquery>

    
<cfoutput>
<!--
<wwafcomponent>#profile.longName#'s Profile</wwafcomponent>
<wwafsidebar>sb_Home.cfm</wwafsidebar>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>#getPicture(url.userid)#</wwaficon>
-->
</cfoutput>

<cfquery name="gpCount" datasource="webwarecl">
	SELECT id FROM projects WHERE clientID=#url.userid#
</cfquery>

<cfmodule template="/orms/view_header.cfm" r_type="User Account" r_pk="#url.userid#">
<cfset po = CreateObject("component","Res").GetByTypeAndPK("User Account", url.userid)>
<cfset po.DoAccess("View", url.calledByUser)>

<div style="display:none;">
<cfparam name="source_age" default="">
<cfparam name="target_age" default="">
<cfparam name="adult_visits_minor" default="false">


<cfset source_age=DateDiff("yyyy", source_age.birthday, Now())>
<cfset target_age=DateDiff("yyyy", profile.birthday, Now())>

<cfif source_age GE 18 AND target_age LT 18>
	<cfset adult_visits_minor=true>
<cfelse>
	<cfset adult_visits_minor=false>
</cfif> 

<cfif url.calledByUser NEQ 732>
	<cfif #url.calledByUser# NEQ #url.userid#>
        <cfquery name="ud_visits" datasource="webwarecl">
            INSERT INTO profile_visits
                (source_id,
                target_id,
                visit_date,
                source_age,
                target_age)
            VALUES 
                (#url.calledByUser#,
                #url.userid#,
                #CreateODBCDate(Now())#,
                #source_age#,
                #target_age#)
        </cfquery>        
    </cfif>
</cfif>

    

<cfoutput query="profile">
						<table width="100%">
							<tr>
								<td rowspan="2" align="left" valign="top" width="150">
									
                                    <div style="width:150px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
                                    	<cfparam name="thePic" default="">
                                    	<cfif URL.CalledByUser EQ 734 AND URL.userid EQ 734>
                                        	<cfparam name="rpb" default="">
                                            <cfset rpb = RandRange(1, 1000)>
                                            
                                            <cfif rpb GE 950>
                                            	<cfset thePic = "http://prefiniti15.prefiniti.com/pb/pb.jpg">
                                            <cfelse>
                                            	<cfset thePic = "#getPicture(id)#">
                                            </cfif>
                                        <cfelse>
                                        	<cfset thePic = "#getPicture(id)#">
                                        </cfif>
                                        <img src="#thePic#" width="150"  />
                                    	<div style="padding-top:3px;">
                                        <cfswitch expression="#online#">
                                            <cfcase value="0"><img src="/graphics/status_offline.png" align="absmiddle"/> <font color="red">User is offline</font></cfcase>
                                            <cfcase value="1"><img src="/graphics/status_online.png" align="absmiddle"/> <font color="green">User is online</font></cfcase>
                                        </cfswitch>
                                        </div>
                                        <br /><br />
                                        
                                        <cfif isFriend(#url.calledByUser#, #id#) EQ false AND url.calledByUser NEQ id>
                                        	<img src="/graphics/user_add.png" align="absmiddle"/> <span id="frBlock_#id#"><a href="javascript:requestFriend(#id#);">Add Friend</a></span>
                                        <br />
                                        </cfif>
                                        <cfif isFriend(#url.calledByUser#, #id#) EQ true>
                                        	<cfif #url.calledByUser# EQ #id#>
                                            	<img src="/graphics/photos.png" align="absmiddle" /> <a href="javascript:viewPictures(#id#, true);"> View Photos</a><br />
                                            <cfelse>
                                            	<img src="/graphics/photos.png" align="absmiddle" /> <a href="javascript:viewPictures(#id#, false);"> View Photos</a><br />
                                            </cfif>
                                        	<img src="/graphics/user_delete.png" align="absmiddle" /> <a href="javascript:confirmDeleteFriend(#url.calledByUser#, #id#);">Delete Friend</a><br />
                                            <img src="/graphics/email_add.png" align="absmiddle"/> <a href="javascript:mailTo(#id#, '#longName#');">Send Message</a><br />
                                            
										</cfif>                                            
                                        
                                   	</div>
                                    
                                    <br>
													
								</td>
								<td valign="top" align="left"><h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:##3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-bottom:0px;">#longName#</h3>
								<cfif adult_visits_minor EQ true>
                                	<strong style="color:red;">You are an adult visiting a minor's profile. This activity may be logged in our records for security purposes.<br />In addition, #longName# and his or her friends will be able to see how many visits to minor's profiles you have conducted with this account.</strong>
								</cfif>
								<cfif isFriend(#url.calledByUser#, #id#) EQ true OR #url.calledByUser# EQ #id#>
								<p><strong>Status:</strong> #status#<br />
								<strong>Location:</strong> #location# <cfif url.userid EQ url.calledByUser>[<a href="##" onclick="OpenLanding('Account.cfm');">Update status &amp; location</a>]</cfif></p>
								<cfif url.calledByUser NEQ url.userid>
                                <a href="##" onclick="showDivBlock('postCommentDiv');">Leave #firstName# a comment</a>
								<div id="postCommentDiv" style="display:none;">
								
                                <cfmodule template="/socialnet/components/post_comment.cfm" from_id="#url.calledByUser#" to_id="#id#">
                                </div>
                                </cfif> 
								<br>
								<br>
                                <cfinclude template="/socialnet/components/profile_tab_row.cfm">    
								<br>
								<br>
								</cfif>
    							<cfif isFriend(#url.calledByUser#, #id#) EQ true OR #url.calledByUser# EQ #id#>                        
                                <div style="padding-left:30px;" id="Information">
                                <table width="100%" cellspacing="0" cellpadding="1">
                                  	<tr>
                                    	<td><strong>Last Login:</strong></td>
                                        <td>#DateFormat(last_login, "mm/dd/yyyy")# #TimeFormat(last_login, "h:mm tt")#</td>
									</tr>
                                    <tr>
                                    	<td><strong>Profile Views:</strong></td>
                                        <td>#visit_count.RecordCount#</td>
									</tr>                                                                               
                                    <tr>
                                    	<td><strong>Birthday:</strong></td>
                                        <td>#DateFormat(birthday, "d mmmm yyyy")# (#DateDiff("yyyy", birthday, Now())# years old)</td>
                                    </tr>
                                    
                                    <tr>
                                    	<td><strong>Gender:</strong></td>
                                        <td>
                                        	<cfif #gender# EQ "m">
                                            	Male
                                            <cfelse>
                                            	Female
                                            </cfif>    
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td><strong>Relationship Status:</strong></td>
                                        <td>#relationship_status#
                                        
                                        <cfswitch expression="#relationship_status#">
                                        	<cfcase value="No Answer">
                                            
                                            </cfcase>
                                            <cfcase value="Single">
                                            
                                            </cfcase>
                                            
                                            <cfcase value="In a Relationship">
                                            	with <a href="javascript:viewProfile(#so_id#);">#getLongname(profile.so_id)#</a>
                                            </cfcase>
                                            
                                            <cfcase value="In an Open Relationship">
                                            	with <a href="javascript:viewProfile(#so_id#);">#getLongname(profile.so_id)#</a>
                                        	</cfcase>
                                            
                                            <cfcase value="Married">
                                            	to <a href="javascript:viewProfile(#so_id#);">#getLongname(profile.so_id)#</a>
                                            </cfcase>
										</cfswitch>
										</td>
                                    </tr>
									<tr>
                                    	<td><strong>Prefiniti Orders:</strong></td>
                                        <td>#gpCount.RecordCount#</td>
                                    </tr>
                                    <tr>
                                    	<td valign="top"><strong>Site Memberships:</strong></td>
                                        <td valign="top"><cfmodule template="/socialnet/components/view_memberships.cfm" user_id="#id#"></td>
									</tr>
                                 
                                    <tr>
                                    	<td valign="top"><strong>Public Locations:</strong></td>
                                        <td valign="top"><cfmodule template="/socialnet/components/profile_manager/view_public_locations.cfm" user_id="#id#">
                                        </td>
									</tr>                                                                                  
                                  </table>
                                
								</div>
                                <cfelse>
									
								</cfif>
								
								
								<cfif isFriend(#url.calledByUser#, #id#) EQ true OR #url.calledByUser# EQ #id#>
                                <div id="News" style="display:none;">
                                <cfmodule template="/socialnet/components/view_user_events.cfm" user_id="#id#" start_row="1" records_per_page="20" load_to="News"></div>
                                
                                <div id="Background" style="padding-left:30px; display:none;">
                                	#background#
                                </div>
                                
                                
                                <div id="Interests" style="padding-left:30px; display:none;">
                                	#snLinkify(interests, "interests")#
                                </div>
                                
                                
                                <div id="Music" style="padding-left:30px; display:none;">
                                	#snLinkify(music, "music")#
                                </div>
                                
                                <div id="Visitors" style="padding-left:30px; display:none;">
                                	<cfmodule template="/socialnet/components/profile_visits.cfm" user_id="#id#">
								</div>                         
                                
								<div id="Blog" style="display:none;">
                                <cfmodule template="/socialnet/components/view_bloglist.cfm" user_id="#id#" calling_user="#url.calledByUser#">
                                </div>
								
                                <div id="Comments" style="display:none;">
                                 <cfmodule template="/socialnet/components/read_comments.cfm" user_id="#id#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="10" load_to="Comments"></div>
                                </div>
								
								
								<div id="Friends" style="display:none;"> 
            	<cfmodule template="/socialnet/components/friends_list.cfm"  user_id="#id#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="30" load_to="Friends" >
                				</div>
                                <cfelse>
                                <div style="padding:30px;">
                                	<strong>You must add this person as a friend before viewing this profile.</strong>
                                </div>
								</cfif>                                    
                                 
                                
                                </td>
							</tr>
							
						</table>
					</cfoutput>
</div>				