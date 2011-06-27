<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(attributes.orms_id)>
<cfset u = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(o.r_pk)>

<cfif u.relationship_status NEQ "Single">
	<cfset so = CreateObject("component", "OpenHorizon.Identity.User").OpenByPK(u.so_id)>
</cfif>

<div style="margin-top:20px;">
	<h2>Information</h2>
	<cfoutput>
	<strong>Age:</strong> #u.Age()#<br>
    
    <cfif u.relationship_status EQ "Single">
    	<strong>Relationship Status:</strong> Single<br>
   	<cfelse>
    	<strong>#u.relationship_status#</strong>: <a href="##" onclick="ORMSLoad('#so.ObjectRecord().r_id#', '')">#so.display_name#</a>
    </cfif>
    
    </cfoutput>
    
    <h2>Friends</h2>
	<cfset g_friends = u.Friends()>
    
    
    <cfloop array="#g_friends#" index="fr">            
            <cfoutput>
                <img src="#fr.Picture(16, 16)#" width="16" align="absmiddle" style="margin-left:3px;" /> <a href="##" onclick="ORMSLoad('#fr.ObjectRecord().r_id#', '')">#fr.display_name#</a><br />
            </cfoutput>      
    </cfloop>
</div>
