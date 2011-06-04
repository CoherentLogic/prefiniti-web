<cfquery name="gProj" datasource="webwarecl">
	SELECT * FROM projects WHERE id='#url.id#'
</cfquery>
<link href="../../css/gecko.css" rel="stylesheet" type="text/css">


<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Edit Proposal</h3>

<form name="bidProposal" id="bidProposal">
  <table width="100%" cellspacing="0" cellpadding="5">
    <tr>
      <td align="left" class="menuTable" style="color:white; padding:5px;"><a href="#"><img src="/graphics/database_save.png" border="0" /></a> <a href="#"><img src="/graphics/email_go.png" border="0" /></a> </td>
      <td align="right" class="menuTable" style="color:white; padding:5px;">Now Editing:
        <select name="sectionSel" id="sectionSel" size="1" onchange="chooseDocument();">
            <option value="ScopeOfServices">Scope of Services</option>
            <option value="RateSchedule">Rate Schedule</option>
            <option value="Timeline">Timeline</option>
            <option value="Contract">Contract</option>
            <option value="TotalCost">Total Cost</option>
          </select>
      </td>
    </tr>
    <tr>
      <td colspan="2" style="background-color:#C0C0C0; color:black" align="right"><h2 align="right">Bid Proposal</h2></td>
    </tr>
    <tr>
      <td colspan="2" style="background-color:#EFEFEF; color:black"><strong>Client:</strong>
          <cfmodule template="/jobViews/components/companyByClientID.cfm" id="#gProj.clientID#">
          <br />
          <strong>Ordered By:</strong>
          <cfmodule template="/jobViews/components/custNameByID.cfm" id="#gProj.clientID#">
          <br />
          <strong>Order Date:</strong> <cfoutput>#gProj.ordered_date#</cfoutput><br />
          <strong>Project Type:</strong> <cfoutput>#gProj.ServiceType# #gProj.jobtype#</cfoutput><br />
          <strong>Location:</strong> <cfoutput>#gProj.address#, #gProj.city#, #gProj.state#  #gProj.zip#</cfoutput><br />
          <strong>Subdivision:</strong> <cfoutput>#gProj.subdivision# Lot #gProj.lot# Block #gProj.block#</cfoutput><br />
          <strong>Legal Description:</strong> <cfoutput>Section #gProj.section#, #gProj.township#, #gProj.range#<br />
              <br />
            <strong><a href="javascript:showDiv('specialinstructions');">[Show Special Instructions]</a></strong>
              <div id="specialinstructions" style="display:none; width:150px;"><br />
                #gProj.specialinstructions#<br />
                <br />
                <a href="javascript:hideDiv('specialinstructions');">[Hide]</a></div>
          </cfoutput> </td>
    </tr>
    <tr>
      <td colspan="2" align="center"><div id="divScopeOfServices">
          <h4>Scope of Services</h4>
        <cfoutput>
          <textarea name="ScopeOfServices" cols="60" rows="10" id="ScopeOfServices">#gProj.ScopeOfServices#</textarea>
        </cfoutput> </div>
          <div id="divRateSchedule" style="display:none;">
            <h4>Rate Schedule</h4>
            <cfoutput>
              <textarea name="RateSchedule" cols="60" rows="10" id="RateSchedule">#gProj.RateSchedule#</textarea>
            </cfoutput> </div>
        <div id="divTimeline" style="display:none;">
            <h4>Timeline</h4>
          <cfoutput>
            <textarea name="Timeline" cols="60" rows="10" id="Timeline">#gProj.Timeline#</textarea>
          </cfoutput> </div>
        <div id="divTotalCost" style="display:none;">
            <h4>Total Cost</h4>
          <cfoutput>
            <input type="text" name="TotalCost" cols="60" rows="10" id="TotalCost" value="#gProj.TotalCost#" />
          </cfoutput> </div>
        <div id="divContract" style="display:none;">
            <h4>Contract</h4>
          <cfoutput>
            <textarea name="Contract" cols="60" rows="10" id="Contract">#gProj.Contract#</textarea>
          </cfoutput> </div></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td align"right"><div align="right"> <cfoutput>
        <input type="hidden" name="projectID" value="#url.id#" />
      </cfoutput>
              <input type="button" class="normalButton" value="Submit Proposal" onclick="AjaxSubmitForm(AjaxGetElementReference('bidProposal'), '/workflow/components/submitRFP.cfm', 'tcTarget');" />
      </div></td>
    </tr>
  </table>
</form>