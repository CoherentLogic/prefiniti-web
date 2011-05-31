<style type="text/css">
	.dList 
	{
		border-left:1px solid #EFEFEF;
		border-right:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.dList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.dList td
	{
		border-bottom:1px solid #EFEFEF;
		padding-top:2px;
		padding-bottom:2px;
	}
	
</style>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="AS_VIEW">

<!--
<wwafcomponent>Manage Memberships</wwafcomponent>
<wwaficon>group_edit.png</wwaficon>
-->

<cfquery name="getAssocs" datasource="sites">
	SELECT * FROM site_associations WHERE site_id=#url.current_site_id#
</cfquery>



<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Site Memberships</h3>
        </div>
    </div>
    <br />
    <br />

<div style="padding-left:30px;">
<input type="button" onclick="inviteUser();" value="Invite Customer or Employee" class="normalButton">
<table width="500" cellspacing="0" class="dList">
	<tr>
    	<th style="-moz-border-radius-topleft:5px;">Prefiniti User</th>
        <th>Membership Type</th>
        <th style="-moz-border-radius-topright:5px;">&nbsp;</th>
    </tr>
    	<cfoutput query="getAssocs">
    		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="white">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
    	<tr>
        	<td style="background-color:#ColColor#"><cfmodule template="/jobviews/components/custNameByID.cfm" id="#user_id#"></td>
            <td style="background-color:#ColColor#">
            	<cfif assoc_type EQ 0>
                	Customer
                    <input type="button" class="normalButton" value="Make Employee" onclick="SetAssocType(#id#, 1)"/>
                <cfelse>
                	Employee
                     <input type="button" class="normalButton" value="Make Customer" onclick="SetAssocType(#id#, 0)"/>
                     <cfmodule template="/employees/EmployeeInfoButton.cfm" user_id="#user_id#" site_id="#url.current_site_id#">
				</cfif>
			</td>
            <td style="background-color:#ColColor#">
            	<img src="/graphics/link_edit.png" align="absmiddle"/> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/authentication/components/editAssociation.cfm?id=#id#');">Edit Permissions</a>
            </td>                                    
        </tr>
    </cfoutput>
</table>
</div>