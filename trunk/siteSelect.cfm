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
	}
	
</style>
<cfset session.loadcount=0>
<cfquery name="getSites" datasource="sites">
	SELECT * FROM site_associations WHERE user_id=#session.userid#
</cfquery>

<cfquery name="getLastSite" datasource="webwarecl">
	SELECT last_site_id FROM users WHERE id=#session.userid# 
</cfquery>    

<center>
<div align="center" style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;">
<img src="/graphics/prefiniti-small.png" style="padding-bottom:20px;" />
<h3 class="stdHeader">Select Site</h3>

<p>Your Prefiniti account is valid for the web sites listed below. Please choose one.</p>

<form name="chooseSite" action="/siteSelectSubmit.cfm" method="post">
<table width="100%" cellspacing="0" class="dList">
	<tr>
    	<th style="-moz-border-radius-topleft:5px;">&nbsp;</th>
    	<th style="text-align:left">Site Name</th>
        <th style="-moz-border-radius-topright:5px; text-align:left;">Account Type</th>
    </tr>
    <cfoutput query="getSites">
    <tr>
    	<td><input type="radio" name="siteAssociation" value="#id#" <cfif id EQ getLastSite.last_site_id>checked</cfif> /></td>
    	<td><cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#"></td>
        <td>
        	<cfif #assoc_type# EQ 0>
           		Customer
            <cfelseif assoc_type EQ 1>
            	Employee
            <cfelse>
            	Friend
			</cfif>
        </td>
    </tr>
    </cfoutput>
    <tr>
    	<td colspan="3" align="right">
        	<br>
            <br>
            <br>
        	<input type="submit" class="normalButton" name="submit" value="Continue to Home">
        </td>
	</tr>       
</table>
</form>
</div>
</center>
<script>
	hideSplash();
</script>