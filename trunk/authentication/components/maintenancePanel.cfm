<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WW_SITEMAINTAINER">
<!--
<wwafcomponent>Prefiniti Site Maintenance</wwafcomponent>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>webware-16x16.png</wwaficon>
-->

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
    <div style="float:left">
        <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Site Maintenance</h3>
    </div>
</div>
<br />
<br />

<table width="100%">
	<tr>
    	<td valign="top" width="200">
        	<cfoutput>
        	<div style="width:200px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
            	<cfif url.section NEQ "site_information.cfm">
                <div style="padding-bottom:4px;">
                	<img src="/graphics/page.png" align="absmiddle"> <a href="javascript:editSite(#url.current_site_id#, 'site_information.cfm');">Site Information</a>
                </div>
                </cfif>
                <cfif url.section NEQ "departments.cfm">
                <div style="padding-bottom:4px;">
                	<img src="/graphics/group_edit.png" align="absmiddle"> <a href="javascript:editSite(#url.current_site_id#, 'departments.cfm');">Departments</a>
                </div>
                </cfif>
                <cfif url.section NEQ "order_settings.cfm">
                <div style="padding-bottom:4px;">
                	<img src="/graphics/lightning.png" align="absmiddle"> <a href="javascript:editSite(#url.current_site_id#, 'order_settings.cfm');">Business Events</a>
                </div>
                </cfif>
               
                <cfif url.section NEQ "billing.cfm">
                <div style="padding-bottom:4px;">
                	<img src="/graphics/money.png" align="absmiddle"> <a href="javascript:editSite(#url.current_site_id#, 'billing.cfm');">Prefiniti Billing</a>
                </div>
                </cfif>
            	<div id="userActionTarget">
            	</div>    
            </div>
            
			</cfoutput>            
        </td>
		<td valign="top">
        	<cfmodule template="/authentication/components/site_manager/#url.section#" site_id="#url.current_site_id#">
        </td>
    </tr>        
</table>
