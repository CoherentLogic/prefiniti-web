<cfset viewed_user = CreateObject("component","OpenHorizon.Identity.User").OpenByPK(attributes.r_pk)>
<cfset viewing_user = CreateObject("component","OpenHorizon.Identity.User").OpenByPK(url.calledByUser)>

<cfset common_friends = viewing_user.CommonFriends(viewed_user)>

<span class="LandingHeaderText">Friends in Common</span><br /><br />

<cfloop array="#common_friends#" index="sf">	
   	<cfoutput>
       	<img src="#sf.Picture(20, 20)#"  align="absmiddle" style="margin-left:3px;" /> <a href="##" onclick="ORMSLoad('#sf.ObjectRecord().r_id#', '')">#sf.display_name#</a><br />
    </cfoutput>
</cfloop>    
<Br />