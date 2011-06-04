<cfquery name="qryGetJobNumber" datasource="webwarecl">
	SELECT status, SubStatus FROM projects WHERE id=#url.id#
</cfquery>

<table width="100%" cellspacing="0">
		 
		  <tr>
		    <td valign="top">Progress</td>
			<td valign="top">
			<p>
			  <label>
			    <input type="radio" name="status" value="0" <cfif #qryGetJobNumber.Status# EQ 0>checked</cfif> />
			    Incomplete</label>
			  <br />
			  <label>
			    <input type="radio" name="status" value="1" <cfif #qryGetJobNumber.Status# EQ 1>checked</cfif>/>
			    Complete</label>
			  <br />
			  </p>			  </td>
			  </tr>
			  <tr>
			    <td valign="top">Status</td>
			  <td rowspan="2">
			    <p>
			      <label>
			        <input type="radio" name="SubStatus" value="Pending" <cfif #qryGetJobNumber.SubStatus# EQ "Pending">checked</cfif>/>
			        Pending</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Awarded" <cfif #qryGetJobNumber.SubStatus# EQ "Awarded">checked</cfif>/>
			        Awarded</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Not Awarded" <cfif #qryGetJobNumber.SubStatus# EQ "Not Awarded">checked</cfif>/>
			        Not Awarded</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="In Progress" <cfif #qryGetJobNumber.SubStatus# EQ "In Progress">checked</cfif>/>
			        In Progress</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Paid" <cfif #qryGetJobNumber.SubStatus# EQ "Paid">checked</cfif>/>
			        Paid</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Closed" <cfif #qryGetJobNumber.SubStatus# EQ "Closed">checked</cfif> />
			        Closed</label>
			      <br />
			      </p>
				    <div align="right">
						<cfoutput>
			  				<input type="button" class="normalButton" name="updateStatus" value="Update Project Status" onclick="javascript:setProjectStatus(#url.id#, 'psStatus');"/>
						</cfoutput>			  		</div>			  	</td>
			  </tr>
			  <tr>
			    <td valign="bottom" id="psStatus">&nbsp;</td>
  </tr>
			  </table>
       	  </form>