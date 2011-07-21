<cfquery name="qryGetJobNumber" datasource="webwarecl">
	SELECT status, SubStatus FROM projects WHERE id=#attributes.r_pk#
</cfquery>

<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset o.GetByTypeAndPK("Project", attributes.r_pk)>

<cfset canEdit = false>
<cfif o.CanWrite(session.user.r_pk) AND o.IsPeer(session.user.r_pk, "Employee")>
	<cfset canEdit = true>
</cfif>

<table width="100%" cellspacing="0">
		 
		  <tr>
		    <td valign="top">Progress</td>
			<td valign="top">
			<p>
			  <label>
			    <input type="radio" name="status" value="0" <cfif #qryGetJobNumber.Status# EQ 0>checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			    Incomplete</label>
			  <br />
			  <label>
			    <input type="radio" name="status" value="1" <cfif #qryGetJobNumber.Status# EQ 1>checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			    Complete</label>
			  <br />
			  </p>			  </td>
			  </tr>
			  <tr>
			    <td valign="top">Status</td>
			  <td rowspan="2">
			    <p>
			      <label>
			        <input type="radio" name="SubStatus" value="Pending" <cfif #qryGetJobNumber.SubStatus# EQ "Pending">checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			        Pending</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Awarded" <cfif #qryGetJobNumber.SubStatus# EQ "Awarded">checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			        Awarded</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Not Awarded" <cfif #qryGetJobNumber.SubStatus# EQ "Not Awarded">checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			        Not Awarded</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="In Progress" <cfif #qryGetJobNumber.SubStatus# EQ "In Progress">checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			        In Progress</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Paid" <cfif #qryGetJobNumber.SubStatus# EQ "Paid">checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			        Paid</label>
			      <br />
			      <label>
			        <input type="radio" name="SubStatus" value="Closed" <cfif #qryGetJobNumber.SubStatus# EQ "Closed">checked</cfif> <cfif NOT canEdit>disabled</cfif>/>
			        Closed</label>
			      <br />
			      </p>
				    <cfif canEdit>
					    <div align="right" style="height:40px;">
						    <div style="padding:8px;">
							<cfoutput>
				  				<a class="button" href="####" onclick="setProjectStatus(#attributes.r_pk#, 'psStatus');"/><span>Update Project Status</span></a>
							</cfoutput>			  		
							</div>			  	
						</div>
					</cfif>
				</td>
			  </tr>
			  <tr>
			    <td valign="bottom" id="psStatus">&nbsp;</td>
  </tr>
			  </table>
       	  </form>