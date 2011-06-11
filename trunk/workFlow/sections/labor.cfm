<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workflow/workflow_udf.cfm">

	<cfquery name="projectInfo" datasource="webwarecl">
	    SELECT * FROM projects WHERE id=#attributes.r_pk# AND site_id=#url.current_site_id#
	</cfquery>
	
	<cfquery name="get_invoices" datasource="webwarecl">
		SELECT * FROM billing_events WHERE project_number='#projectInfo.clsJobNumber#'
	</cfquery>
	
	<cfset orec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
	<cfset orec.GetByTypeAndPK("Project", attributes.r_pk)>
	
	<cfif orec.CanWrite(URL.CalledByUser)>
		<cfset canEdit = 1>
	<cfelse>
		<cfset canEdit = 0>
	</cfif>
	
<cfoutput>
	<strong class="OH_HEADER">Labor &amp; Invoicing</strong>
	<table>
   	<tr>
    <td><strong>Charge Type:</strong></td>
    <td>
    	<cfif projectInfo.charge_type EQ "Lump Sum">
        	Lump Sum - #DollarFormat(projectInfo.total_quoted_price)# 
		<cfelse>
          	Time &amp; Materials
		</cfif>                                                        
 	</td>
	</tr>
	</table>                                    
          
    <!---<img src="/graphics/printer.png" align="absmiddle" /> <a href="/workFlow/components/projectLaborPrintable.cfm?project_number=#projectInfo.clsJobNumber#" target="_blank">Printable View</a> |&nbsp;--->
    <!---<img src="/graphics/money.png" align="absmiddle" /> <a href="##" onclick="invoice_project('#projectInfo.clsJobNumber#');">Invoice This Project</a>&nbsp;|--->
    
	

	<!---<cfmodule template="/workFlow/components/projectLabor.cfm" project_number="#projectInfo.clsJobNumber#" printable="no">--->
</cfoutput> 
	
	<div style="width:450px;height:200px;overflow:auto;border:1px solid #efefef;">
		<strong class="OH_HEADER">Invoices</strong><br>
		<cfoutput>
		<img src="/graphics/money.png" align="absmiddle" /> <a href="##" onclick="invoice_project_new('#projectInfo.clsJobNumber#');">Invoice This Project</a>
		</cfoutput>
		<table width="100%" cellpadding="6" cellspacing="0">
		<cfoutput query="get_invoices">
			<tr>
				<td valign="top">
					<strong>#invoice_number#</strong><br/>
					
					#DateFormat(start_date, "mm/dd/yyyy")# - #DateFormat(end_date, "mm/dd/yyyy")#
													
				</td>
				<td valign="top">
					<select name="invoice_actions_#id#" id="invoice_actions_#id#" onchange="invoice_action(GetValue('invoice_actions_#id#'), '#id#')">
						<option value="select_action" selected>Invoice options</option>
						<option value="view_html">View as HTML</option>
						<option value="view_pdf">View as PDF</option>
						<option value="send">Send Electronic Invoice</option>
						<option value="apply_payment">Apply Payment</option>
						<option value="view_payments">Payment History</option>
						<option value="delete">Delete</option>
					</select>
				</td>
			</tr>
		</cfoutput>
		</table>
	</div>

	<!--- <select name="invoices" id="invoices">
		 
		<cfoutput query="get_invoices">          
			<option value="#id#">#invoice_number# (#DateFormat(start_date, "mm/dd/yyyy")# - #DateFormat(end_date, "mm/dd/yyyy")#)</option>
		</cfoutput>
	</select>
	
	<a href="##" onclick="view_invoice_pdf(GetValue('invoices'));">View PDF</a> | <a> --->
	