<script language="javascript">
	
	function DoSearch(str, currentUserOnly)
	{
		var url;
		var sfield;
		var stype;
		
		sfield = AjaxGetCheckedValue("SearchField");
		stype = AjaxGetCheckedValue("SearchType");
		
		url = "/forms/searchSubSmall.cfm?SearchType=";
		url += stype;
		url += "&SearchField=";
		url += sfield;
		url += "&SearchValue=";
		url += escape(str);
		url += "&currentUserOnly=" + escape(currentUserOnly);
		url += "&userid=" + escape(glob_userid);

		//alert(url);
		AjaxLoadPageToDiv("tcTarget", url);
	}
</script>
<div>
<form name="searchForm" >

  <table cellspacing="0" width="100%">
  <tr>
  	<td>
	


	<cfif #url.permissionLevel# EQ 0>
	<cfoutput>
		<img src="graphics/report_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/priorityCustomer.cfm?clientid=#url.calledByUser#');">Priority Projects</a><br />
		<img src="graphics/report_go.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'jobViews/allProjectsCustomer.cfm?userid=#url.calledByUser#');">All Projects</a><br />
			
	</cfoutput>
	</cfif>
								<div id="mapInfo" class="OptionsBox">
								No project selected.
							</div>
	</td>
  </tr>
	<tr>
	  <td style="background-color:#666666; color:#FFFFFF">Search Fields</td>
	 </tr>
    <tr>
      <td style="background-color:#FFFFFF"><p>
          <label>
          <input type="radio" name="SearchField" value="clsJobNumber" checked/>
          Project Number</label>
          <br />
          <label>
          <input type="radio" name="SearchField" value="address"/>
          Address</label>
          <br />
          <label>
          <input type="radio" name="SearchField" value="section"/>
          Section</label>
          <br />
          <label>
          <input type="radio" name="SearchField" value="township"/>
          Township</label>
          <br />
          <label>
          <input type="radio" name="SearchField" value="range"/>
          Range</label>
          <br />
          <label>
          <input type="radio" name="SearchField" value="billing_company" />
          Ordered By Company</label>
        </p></td>
    </tr>
	<tr>
		<td style="background-color:#666666; color:#FFFFFF">Criteria</td>
	</tr>
    <tr>
      <td nowrap style="background-color:#FFFFFF"><p>
          <label>
          <input type="radio" name="SearchType" value="BeginsWith" />
          Begins With</label>
          <br />
          <label>
          <input type="radio" name="SearchType" value="Contains" checked />
          Contains</label>
          <br />
        </p></td>
     </tr>
	 <tr>
	  <td>
	  	<input name="SearchValue" id="sv" type="text" width="100%" />
		
		<cfoutput><input type="button" value="Search" class="normalButton" onclick="javascript:DoSearch(GetValue('sv'), <cfif #url.permissionLevel# EQ 0>'true'<cfelse>'false'</cfif>); hideDiv('gen_window_frame');"></cfoutput></td>
    </tr>
    <!--- 	<tr>
	<td colspan="3" align="right"><input name="submit" type="submit" class="normalButton" value="Search Jobs" /></td>
	</tr> --->
  </table>
</form>
<cfquery name="gsubs" datasource="webwarecl">
	SELECT * FROM Subdivisions WHERE approved=1 ORDER BY name
</cfquery>        

	<div style="width:220px; margin:3px; border:1px solid #EFEFEF;">
    	<h3>Search by Subdivision</h3>
        <select name="SubID" id="SubID" style="width:200px; max-width:200px;">
        	<cfoutput query="gsubs">	
            	<option value="#id#">#name#</option>
			</cfoutput>
		</select>
        <input type="button" value="Search by Subdivision" onclick="javascript:SearchBySub(GetValue('SubID'));" />
                                    
	</div>        
</div>