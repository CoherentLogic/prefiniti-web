<!--
	<wwafcomponent>Manage Subdivisions</wwafcomponent>
-->

<style type="text/css">
	.pList 
	{
		border-left:1px solid #EFEFEF;
		border-right:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.pList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.pList td
	{
		border-bottom:1px solid #EFEFEF;
	}
	
</style>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfquery name="gSubs" datasource="webwarecl">
	SELECT id, name FROM subdivisions WHERE name != '' ORDER BY name
</cfquery>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top">Manage Subdivisions</h3>
        </div>
    </div>
<br />
<br />
<cfif url.permissionLevel EQ 1>
	<img src="/graphics/map_add.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionAdd.cfm');">Add Subdivision</a>
</cfif>    
<table width="400" cellspacing="0" class="pList" style="margin-left:20px;">
	<tr>
    	<th style="-moz-border-radius-topleft:5px;">Subdivision</th>
        <th style="-moz-border-radius-topright:5px;">Tools</th>
    </tr>
    <cfoutput query="gSubs">
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
        	<td style="background-color:#ColColor#;">#name#</td>
            <td style="background-color:#ColColor#;" align="left" nowrap>
            	<cfmodule template="/workflow/components/subdivisionMap.cfm" id="#id#"><br>
                <img src="/graphics/map_edit.png"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionEdit.cfm?id=#id#');">Edit Subdivision</a><br />
                <cfif url.permissionLevel EQ 1>
	                <img src="/graphics/map_delete.png" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionDeleteConfirm.cfm?id=#id#');">Delete Subdivision</a>
				</cfif>                    
            </td>
        </tr>
    </cfoutput>
</table>