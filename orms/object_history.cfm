<cfquery name="gro" datasource="webwarecl">
	SELECT r_id FROM orms_access_log WHERE a_user_id=#url.user_id# ORDER BY a_date DESC
</cfquery>

<div style="padding:8px;">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td align="left" style="background-color:transparent;">
<cfoutput>
<cfif URL.FirstRecord GT 1>
	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/1leftarrow.png" onclick="ORMSLoadHistory(#URL.FirstRecord - 4#, #URL.user_id#)"/>
</cfif>
</cfoutput>
</td>
<td align="center" style="background-color:transparent;">


<cfoutput query="gro" startrow="#url.FirstRecord#" maxrows="4">	
		<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(r_id)>
    	<div onmouseover="Tip('#o.r_type# #o.r_name#');" onmouseout="UnTip();" onclick="ORMSLoad('#o.r_id#', '');" style="float:left; width:#980 / 4#; overflow:hidden;">
        	<table>
			<tr>
            <td>
            	<img src="#o.r_thumb#" width="48" height="48" style="margin-left:3px; margin-right:3px;" />   
			</td>
            <td><span class="LandingHeaderText">#o.r_name#</span></td>
            </tr>
            </table>                
        </div>
        
</cfoutput>
</td>
<td align="right" style="background-color:transparent;">
<cfoutput>
	<img src="/graphics/AppIconResources/crystal_project/32x32/actions/1rightarrow.png" onclick="ORMSLoadHistory(#URL.FirstRecord + 4#, #URL.user_id#)"/>
</cfoutput>
</td>
</tr>
</table>
</div>
