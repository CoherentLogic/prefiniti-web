
<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_PROCESSORDER">
<cfquery name="gProj" datasource="webwarecl">
	SELECT * FROM projects WHERE id='#url.id#'
</cfquery>

<!--- <cfoutput>
<!--
	<wwafcomponent>Process Order: Temporary ID #gProj.id#</wwafcomponent>
-->
</cfoutput>   --->  

<cfquery name="gSub" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE id=#gProj.subdivision#
</cfquery>    

<cfquery name="gas" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE approved=1 AND site_id=#URL.current_site_id# ORDER BY name
</cfquery>    

<cfif #gProj.maint_lock# EQ 1 AND #url.calledByUser# NEQ 1>
	<h1>Access Denied</h1>
	<p>This project has been locked for maintenance, and can only be modified by the webmaster.</p>
	<cfabort>
</cfif>


<form name="processOrder" id="processOrder" method="post">
<cfoutput><input type="hidden" name="clientID" value="#gProj.clientID#">
<input type="hidden" id="project_id" name="id" value="#url.id#" />
</cfoutput>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Process Order</h3>
        </div>
    </div>
    <br />

<table width="100%" cellspacing="0" cellpadding="5">

	<tr>
		<td colspan="2" style="font-size:x-small;">
			
            <h1 style="font-size:large;">Order From <cfmodule template="/jobViews/components/custNameByID.cfm" id="#gProj.clientID#"></h1>
			<blockquote>
			<strong>Order Date:</strong> <cfoutput>#gProj.ordered_date#</cfoutput><br>
			<strong>Project Type:</strong> <cfoutput>#gProj.jobtype#</cfoutput><br>
			<strong>Location:</strong> <cfoutput>#gProj.address#, #gProj.city#, #gProj.state#  #gProj.zip#</cfoutput><br>
			<strong>Subdivision:</strong> <cfoutput>#gSub.name#</cfoutput><br>
			<strong>Legal Description:</strong> <cfoutput>Section #gProj.section#, #gProj.township#, #gProj.range#</cfoutput>
            </blockquote>
            <hr />
		</td>
	</tr>
	<tr>
		<td valign="top">Choose the charge type for this order:</td>
		<td valign="top">
			<p>
			<label>
			<input type="radio" name="charge_type" value="Lump Sum" checked>
			Lump Sum</label>
			<br>
			
            <blockquote>
            	<label>Total Quoted Price: <input type="text" name="total_quoted_price" id="total_quoted_price" /></label>
			</blockquote>
            <label>
            <input type="radio" name="charge_type" value="Time & Materials">
            Time & Materials</label>
			<br>
			</p>
		</td>
	</tr>
	<tr>
		<td valign="top">Assign a project number:</td>
		<td valign="top">
			<input type="text" name="clsJobNumber" id="clsJobNumber" readonly>
			<input type="button" class="normalButton" onClick="javascript:AjaxLoadPageToValueCtl('clsJobNumber', '/workFlow/components/getPN.cfm');" value="Get Project Number">
		</td>
	</tr>
    <tr>
    	<td valign="top">Verify Subdivision:</td>
        <td valign="top">
        	<cfif gSub.approved EQ 0>
            	<div id="subdivision_approval">
                <cfif #gSub.name# NEQ "">
	                <p>The customer has entered <strong><cfoutput>#gSub.name#</cfoutput></strong> as the subdivision for this project.</p>
                    <p>This subdivision has not been entered into the database.</p>
                
                <cfelse>
                	<p>The customer has not chosen a subdivision for this order. Please choose one now if required.</p>
                </cfif>
                        
                
                <div style="-moz-border-radius:5px; border:1px solid #efefef; padding:5px; width:220px; height:150px; float:left;">
                <strong><input type="radio" name="subdivision_option" value="approve" style="padding:0px;" checked /> Option 1: </strong>Approve With Edits<br /><br />
                <cfoutput>
                <label>Subdivision Name: <input type="text" name="new_subdivision" id="new_subdivision" value="#gSub.name#" /></label>
                <br />
                </cfoutput>
                
                
                <cfoutput>
                <input type="hidden" name="original_id" id="original_id" value="#gSub.id#" />
                </cfoutput>
                
                </div>
                <div style="-moz-border-radius:5px; margin-left:5px; border:1px solid #efefef; padding:5px; width:220px; height:150px; float:left;">
                <strong><input type="radio" name="subdivision_option" value="choose"  style="padding:0px;"/> Option 2: </strong>Choose Existing Subdivision<br /><br />
                
                <select name="subdivision_select" size="5" id="subdivision_select" style="width:180px; overflow:auto;">
                	<cfoutput query="gas">
                    	<option value="#id#">#name#</option>
					</cfoutput>                        
                </select>
                
                
                </div>
                </div>
                <div style="clear:both; padding-top:10px;">
                	<!-- function wfpProcessSubdivision(status_div, subdivision_option, new_subdivision, subdivision_select, project_id) -->
                    <img src="/graphics/accept.png" align="absmiddle" /> <a href="javascript:wfpProcessSubdivision('subdivision_approval', AjaxGetCheckedValue('subdivision_option'), GetValue('new_subdivision'), GetValue('subdivision_select'), GetValue('project_id'), GetValue('original_id'));">Save subdivision information</a><br />
                	
                </div>
                
			<cfelse>
            	<p>The customer has chosen <strong><cfoutput>#gSub.name#</cfoutput></strong> as the subdivision for this project.</p>
                <p>No further action required.</p>
			</cfif>
		</td>
	</tr>                                                    
	<tr>
		<td valign="top">Press release:</td>
		<td valign="top">
			<textarea name="articleText" cols="50" rows="8" <cfif #gProj.allow_publication# EQ 0>readonly</cfif>><cfoutput>#gProj.billing_company#</cfoutput> ordered a <cfoutput>#gProj.jobtype#</cfoutput></textarea>
			<blockquote>
			<label><input type="checkbox" name="publish" <cfif #gProj.allow_publication# EQ 1>checked<cfelse>disabled</cfif>>Publish in site news</label>
			</blockquote>
		</td>
	</tr>
	<tr>
		<td valign="top">Choose processing options:</td>
		<td valign="top">
			<p>
			<label>
			<input type="radio" name="stage" value="1" checked>
			Accept this order and award project</label>
			<br>
			<label>
			<input type="radio" name="stage" value="0">
			Reverse order to client</label>
				<blockquote>
					<label>Explanation: <input type="text" name="reverse_explanation"></label>
				</blockquote>
			</p>		
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" onclick="AjaxSubmitForm(AjaxGetElementReference('processOrder'), '/workflow/components/processOrderSub.cfm', 'tcTarget');" name="submit" value="Process This Order">
		</td>
	</tr>
	
</table>
</form>
