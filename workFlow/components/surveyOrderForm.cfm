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

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_CREATE">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="qryUsers" datasource="webwarecl">
	SELECT id, longName FROM Users ORDER BY longName
</cfquery>

<cfquery name="getAddr" datasource="sites">
	SELECT * FROM site_associations WHERE id=#url.current_association#
</cfquery>
    
<!---JOB ORDER FORM--->
<!--
<wwafcomponent>Place Order</wwafcomponent>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Place Order</h3>
        </div>
    </div>
    <br />
    <br />
<form name="reqJob" action="job-submit.cfm" method="post">
	<input type="hidden" name="reqid" <cfoutput>value="#CreateUUID()#"</cfoutput>>
	<input type="hidden" name="status" value="0" />
    
    <cfoutput><input name="current_association" value="#url.current_association#" type="hidden"/></cfoutput>
	<cfoutput><input type="hidden" name="clientID" value="#url.calledByUser#" /></cfoutput>
	<input type="hidden" name="new_sub" id="new_sub" value="1" />
    
	
	<table width="600" class="pList" style="margin-left:20px;" cellpadding="0" cellspacing="0">
		<tr>
		  <th colspan="5" style="-moz-border-radius-topleft:5px; -moz-border-radius-topright:5px;">Basic Order Information</th>
	  </tr>
      	<tr>
        	<td>&nbsp;</td>
            <td>Order As:</td>
            <td colspan="3">
            	<cfoutput query="getAddr">
            	<label>Please enter the name of your company: <input type="text" name="billing_company" id="billing_company" value="#billing_company#"/></label><br />
                <label>Bill to Address: <input type="text" name="billing_address" id="billing_address" value="#billing_address#" /></label><br /> 
                <label>City: <input type="text" name="billing_city" id="billing_city" value="#billing_city#"/></label>
                <label>State: <input type="text" name="billing_state" id="billing_state" width="2" masxlength="2" size="2"  value="#billing_state#"/></label>
                <label>ZIP: <input type="text" name="billing_zip" id="billing_zip" width="10" maxlength="10"  size="10" value="#billing_zip#"/></label><br />
                <label>Phone: <input type="text" name="billing_phone" id="billing_phone" width="13" maxlength="45" size="13" /></label><br />
                <label>Fax: <input type="text" name="billing_fax" id="billing_fax" width="13" maxlength="45" size="13" /></label>
                </cfoutput>
                
                
            </td>
		</tr>            
		<tr>
		  <td width="277">&nbsp;</td>
			<td width="277">Job Name:</td>
		  <td colspan="3"><p>
			<input type="text" name="description" /> 
			<br /><font color="red">This field should be a short, easy-to-remember description of the job.</font></p></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>Service Type:</td>
			<td colspan="3">
            
            <label><input type="radio" name="svctype" value="Survey" onclick="setProjectType(AjaxGetCheckedValue('svctype'));"/>Survey</label><br />
            <div id="Survey" style="display:none;">
            <blockquote>
              <p>
			  <label>
				<input type="radio" name="JobType" value="Improvement Survey - Metes & Bounds" />
				Improvement Survey - Metes & Bounds</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Improvement Survey - Lot & Block" />
				Improvement Survey - Lot & Block</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="ALTA/ACSM Land Title Survey" />
				ALTA/ACSM Land Title Survey</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Claim of Exemption" />
				Claim of Exemption</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Plat of Survey" />
				Plat of Survey</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Legal Description" />
				Legal Description</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Improvement Location Report" />
				Improvement Location Report</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Flood Certification" />
				Flood Certification</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Topographic Survey" />
				Topographic Survey</label>
			  <br />
			  <label>
				<input type="radio" name="JobType" value="Aerial Mapping" />
				Aerial Mapping</label><br />
               <label><input type="radio" name="JobType" value="Boundary Dispute Resolution" />Boundary Dispute Resolution</label>
               <br />
               <label>
               <input type="radio" name="JobType" value="Title Search" />Title Search</label>
               <br />
               <label>
               <input type="radio" name="JobType" value="Permit-Related Site Plan" />Permit-Related Site Plan</label>
			 	<br />
               <label>
               <input type="radio" name="JobType" value="Subdivision" />Subdivision</label>
			</p>
            </blockquote>
            </div>
            <label><input type="radio" name="svctype" value="Construction" onclick="setProjectType(AjaxGetCheckedValue('svctype'));" />Construction Layout</label><br />
            <div id="Construction" style="display:none;">
            <blockquote>
            <p>
              <label>
                <input type="radio" name="JobType" value="Roadway" id="JobType_0" />
                Roadway</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Airport" id="JobType_1" />
                Airport</label>
              <br />

              <label>
                <input type="radio" name="JobType" value="Commercial Building(s)" id="JobType_3" />
                Commercial Building(s)</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Subdivision" id="JobType_4" />
                Subdivision</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Control Plan" id="JobType_5" />
                Control Plan</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Lot Corners" id="JobType_6" />
                Lot Corners</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="House Corners" id="JobType_7" />
                House Corners</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Home or Mobile Home Pad" id="JobType_8" />
                Home or Mobile Home Pad</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Bridge" id="JobType_9" />
                Bridge</label>
              <br />
              <label>
                <input type="radio" name="JobType" value="Utilities" id="JobType_10" />
                Utilities</label>
              <br />
            </p>
            </blockquote>
            </div>            </td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>Due Date:</td>
			<td colspan="3"><input type="text" name="duedate" id="duedate" readonly/> <a href="javascript:popupDate(AjaxGetElementReference('duedate'));"><img src="/graphics/date.png" border="0" /></a> (click the calendar icon to choose a date)</td>
		<tr>
		  <td>&nbsp;</td>
		  <td>Street Address:</td>
		  <td colspan="3"><input type="text" name="address" id="address" onblur="calcLatLng(); updateMap();"/></td>
	  </tr>
		<tr>
		  <td>&nbsp;</td>
			<td>City:</td>
			<td colspan="3"><input type="text" name="city" id="city" onblur="calcLatLng(); updateMap();"/></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>State:</td>
			<td colspan="3"><input type="text" maxlength="2"  name="state" id="state" onblur="calcLatLng(); updateMap();"/></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>ZIP Code: </td>
			<td colspan="3"><input type="text" maxlength="10"  name="zip" id="zip" onblur="calcLatLng(); updateMap();"/></td>
		</tr>
		
		<tr>
		  <td>&nbsp;</td>
			<td>Latitude: </td>
			<td colspan="3"><input type="text" maxlength="10"  name="latitude" id="latitude" onchange=""/></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>Longitude: </td>
			<td colspan="3"><input type="text" maxlength="10"  name="longitude" id="longitude" onchange=""/></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>Map:</td>
			<td colspan="3"><div id="inlineMap" style="width:350px; height:200px; border:solid 1px silver">
			</div>							</td>
		<tr>
			<td><a href="javascript:loadHelp('Subdivision', 'DeedBookPage.cfm', 'SUB-SUB.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
			<td>Subdivision:</td>
		  <td colspan="3">
			<input type="text" name="subSuggest" id="subSuggest" onkeyup="AjaxLoadPageToDiv('subTarget', '/workflow/components/subdiv_search.cfm?name=' + GetValue('subSuggest'));" />
            <!--- <input type="button" onclick="alert(GetValue('subSuggest'));" value="test" /> --->
            <div id="subTarget"></div>
        </td>
		</tr>
		<tr>
		  <td><a href="javascript:loadHelp('Lot', 'DeedBookPage.cfm', 'SUB-LOT.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
			<td>Lot:</td>
			<td colspan="3"><input type="text" name="lot" /> </td>
		</tr>
		<tr>
		  <td><a href="javascript:loadHelp('Block', 'DeedBookPage.cfm', 'SUB-BLOCK.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
			<td>Block:</td>
			<td colspan="3"><input type="text" name="block" /></td>
		</tr>
		<tr>
		  <td><a href="javascript:loadHelp('Section', 'TractOfLand.cfm', 'TRACT-SECT.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
			<td>Section:</td>
			<td colspan="3"><input type="text" name="section" id="section"/></td>
		</tr>
		<tr>
		  <td><a href="javascript:loadHelp('Township', 'TractOfLand.cfm', 'TRACT-TWN.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
			<td>Township:</td>
			<td colspan="3"><input type="Text" name="township" id="township" /></td>
		</tr>
		<tr>
		  <td><a href="javascript:loadHelp('Range', 'TractOfLand.cfm', 'TRACT-RNG.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
			<td>Range:</td>
			<td colspan="3"><input type="text" name="range" id="range"/></td>
		</tr>
		<!---<tr>
		  <td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="3"><input type="button" class="normalButton" value="Calculate Section/Township/Range" onclick="loadTRS();" /></td>
		</tr>--->
		<tr>
		  <th colspan="5">Filing Information</th>
	  </tr>
		<tr>
		  <td><a href="javascript:loadHelp('Filing Information', 'DeedBookPage.cfm', 'SUBD-DEED-INFO.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
		  <td>Filing Type:</td>
		  <td colspan="2"><p>
		    <label>
		    <input type="radio" name="FilingTypeGroup" value="Deed Book" onclick="DeedBook();" id="FilingTypeGroup_0" />
Deed Book</label>
		    <br />
		    <label>
		    <input type="radio" name="FilingTypeGroup" value="Subdivision Book" onclick="SubdivisionBook();" id="FilingTypeGroup_1" />
Subdivision Book</label>
		    <br />
		    <label>
		    <input type="radio" name="FilingTypeGroup" value="Subdivision Cabinet" onclick="SubdivisionCabinet();" id="FilingTypeGroup_2" />
Subdivision Cabinet</label>
		    <br />
		    <label>
		    <input type="radio" name="FilingTypeGroup" value="Subdivision Plat" onclick="SubdivisionPlat();" id="FilingTypeGroup_3" />
Subdivision Plat</label>
		    <br />
		  </p>
          <input type="hidden" name="SubdivisionOrDeed" id="SubdivisionOrDeed" />
			<input type="hidden" name="FilingType" id="FilingType" />
          </td>
		  <td width="226"><input type="text" name="PlatCabinetBook" /></td>
	  </tr>
	  <tr>
	    <td><a href="javascript:loadHelp('Deed-Filing Date', 'DeedBookPage.cfm', 'DEED-PAGE.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
		  <td></td>
		  <td width="231" colspan="2"><p>
			<label>
			  <input type="radio" name="PageOrSlide" value="Page" checked/>
			  Page</label>
			<br />
			<label>

			  <input type="radio" name="PageOrSlide" value="Slide" />
			  Slide</label>
			<br />
			</p></td>
		  <td width="226"><input type="text" name="PageSlide" /></td>
	  </tr>
	  <tr>
	    <td><a href="javascript:loadHelp('Reception Number', 'DeedBookPage.cfm', 'DEED-RECNO.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
		<td>Reception or Document Number: </td>
		<td colspan="3"><input name="ReceptionNumber" type="text" id="ReceptionNumber" /></td>
	  </tr>
	  <tr>
	    <td><a href="javascript:loadHelp('Deed-Filing Date', 'DeedFilingDate.cfm', 'SUBD-DEED-INFO.jpg');"><img src="/graphics/help.png" border="0" /></a></td>
		<td>Filing Date: </td>
		<td colspan="3"><input name="FilingDate" type="text" id="FilingDate" /> <a href="javascript:popupDate(AjaxGetElementReference('FilingDate'));"><img src="/graphics/date.png" border="0" /></a> (click the calendar icon to choose a date)<br />Hint:  You can manually edit any date entered in this field.</td>
	  </tr>
	  <tr>
		  <th colspan="5">Job Information</th>
	  </tr>
		<tr>
		  <td><a href="javascript:loadHelp('Certified To', 'CertifiedTo.cfm', '');"><img src="/graphics/help.png" border="0" /></a></td>
		  <td>Certified To: </td>
		  <td colspan="3"><input name="CertifiedTo" type="text" id="CertifiedTo" size="50" /> 
			<font color="red">(i.e. last name of client)</font> </td>
	  </tr>
		<tr>
		  <td>&nbsp;</td>
			<td>Other Job Information (description of work, special instructions, etc.):</td>
			<td colspan="3"><textarea name="specialinstructions" rows="5" cols="50"></textarea></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
			<td>Your Job Number:</td>
			<td colspan="3"><input type="text" name="clientJobNumber" /></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>Publication options: </td>
		  <td colspan="3"><p>
			<label>
			  <input type="radio" name="allow_publication" value="1"/>
			  Allow us to publish this order in our site news</label>
			<br />
			<label>
			  <input type="radio" name="allow_publication" value="0" checked />
			  Keep this order private</label>
			<br />
		  </p>          </td>
	  </tr>
		<!--- <tr>
			<td>Attach File:</td>
			<td><input type="file" name="fileattach" /></td>
		</tr> --->
		<tr>
		  <td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>
             	<label><input type="checkbox" name="request_photos" />Request photos of property</label><br />
                <label><input type="checkbox" name="rfp" />Submit as Request for Proposal</label>
            </td>
        </tr>
		<tr>
		  <td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="3" align="right">
         		
                <input type="submit" class="normalButton" name="Submit" value="Submit Request" />            </td>
		</tr>
	</table>
  
</form>
<script language="javascript">
	var dueDateCal = new calendar2(document.forms['reqJob'].elements['duedate']);
	var filingDateCal = new calendar2(document.forms['reqJob'].elements['FilingDate']);
</script>