<!--
	<wwafcomponent>All Proposals</wwafcomponent>
-->

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfquery name="getRFP" datasource="webwarecl">
	SELECT * FROM projects WHERE site_id=#attributes.site_id# AND rfp=1
</cfquery>

<table width="100%">
	<tr>
    	<th>Your Job Number</th>
    	<th>Project Name</th>
        <th>Location</th>
        <th>Tools</th>
    </tr>
   	<cfoutput query="getRFP">
    <tr>
    	<td>#clientJobNumber#</td>
        <td>#description#</td>
        <td>#address#<br>#city#, #state# #zip#</td>
        <td><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/viewRFP.cfm?id=#id#');">View Proposal</a></td>
    </tr>
    </cfoutput>
</table>