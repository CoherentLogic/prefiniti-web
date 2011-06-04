<cfquery name="gProj" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.id#
</cfquery>

<form name="viewRFP" method="post">
<table width="100%">
<tr>
    	<td rowspan="2" style="background-color:#EFEFEF; color:black"></td>
	  <td style="background-color:#C0C0C0; color:black" align="right"><h2 align="right">Bid Proposal</h2></td>
	</tr>
    <tr>
      <td style="background-color:#EFEFEF; color:black"><strong>Client:</strong>
        <cfoutput>#gProj.billing_company#</cfoutput>
        <br>
        <strong>Ordered By:</strong>
        <cfmodule template="/jobViews/components/custNameByID.cfm" id="#gProj.clientID#">
        <br>
        <strong>Order Date:</strong> <cfoutput>#gProj.ordered_date#</cfoutput><br>
        <strong>Project Type:</strong> <cfoutput>#gProj.ServiceType# #gProj.jobtype#</cfoutput><br>
        <strong>Location:</strong> <cfoutput>#gProj.address#, #gProj.city#, #gProj.state#  #gProj.zip#</cfoutput><br>
        <strong>Subdivision:</strong> <cfoutput>#gProj.subdivision# Lot #gProj.lot# Block #gProj.block#</cfoutput><br>
        <strong>Legal Description:</strong> <cfoutput>Section #gProj.section#, #gProj.township#, #gProj.range#</cfoutput> </td>
    </tr>
    <tr>
      <td>Scope of Services:</td>
      <td><cfoutput><p>#gProj.ScopeOfServices#</p></cfoutput></td>
    </tr>
    <tr>
      <td>Rate Schedule:</td>
      <td><cfoutput><p>#gProj.RateSchedule#</p></cfoutput></td>
    </tr>
    <tr>
      <td>Timeline:</td>
      <td><cfoutput><p>#gProj.Timeline#</p></cfoutput></td>
    </tr>
    <tr>
      <td>Contract:</td>
      <td><cfoutput><p>#gProj.Contract#</p></cfoutput></td>
    </tr>
    <tr>
      <td>Total Cost:</td>
      <td align="right"><cfoutput><strong>$#gProj.TotalCost#</strong></cfoutput></td>
    </tr>
    <cfif NOT IsDefined("url.viewOnly")>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">
        <cfoutput>
        <input type="button" class="normalButton" name="acceptProposal" id="acceptProposal" value="Accept Proposal" onclick="acceptRFP(#gProj.id#);">
        <input type="button" class="normalButton" name="declineProposal" id="declineProposal" value="Decline Proposal" onclick="declineRFP(#gProj.id#);">
        </cfoutput>
      </div></td>
    </tr>
    </cfif>
</table>
</form>