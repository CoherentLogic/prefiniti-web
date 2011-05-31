<!---<cfoutput>#getPermissionByKey("AS_LOGIN", session.current_association)#</cfoutput>--->
<cfinclude template="/authentication/authentication_udf.cfm">
<cfif getPermissionByKey("#attributes.perm_key#", #url.current_association#) EQ false>
	<center>
    <div style="margin:30px; padding:30px; width:450px; border:1px solid #EFEFEF;" align="center">
        <img src="/graphics/prefiniti-small.png" style="padding-bottom:20px;">
        <h3 class="stdHeader">Permission Denied</h3>
        
        <p>This application requires the <strong><cfoutput>#getPermissionNameByKey(attributes.perm_key)#</cfoutput></strong> permission to view.</p>
        <p>You do not currently have this permission.</p>
    </div>
    </center>
    <cfabort>
<cfelse>
   
</cfif>    