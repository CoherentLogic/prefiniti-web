<cfajaximport tags="cfajaxproxy,cfgrid,cfform,cflayout-border,cftree,cflayout-tab,cfwindow">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<cfoutput><title>Project #URL.clsJobNUmber# - Apply Credit</title></cfoutput>
<style type="text/css">
	body {
		font-family:Arial, Helvetica, sans-serif;
	}
</style>
</head>

<body>
	<table width="100%" cellpadding="0" cellspacing="0">
    	<tr>
        	<td></td>
		</tr>
	</table>                    

	
</body>
</html>

<cfquery name="pi" datasource="webwarecl">
	SELECT * FROM projects WHERE clsJobNumber='#url.clsJobNumber#'
</cfquery>

<cfquery name="orig_si" datasource="sites">
	SELECT * FROM sites WHERE SiteID=#pi.site_id#
</cfquery>

<cfwindow name="InvoiceSettings" title="Invoice Project #URL.clsJobNumber#" width="500" height="450" initshow="true" draggable="false" resizable="false" modal="true" center="true" closable="false" bodystyle="background-color:##EFEFEF">
	<h2><img src="http://us-production-r1g1s1.prefiniti.com/graphics/AppIconResources/crystal_project/32x32/actions/money.png" align="absmiddle" /> Invoice Project</h2>
   
   
	<cfform name="InvoiceSettings" format="xml" skin="basiccss" width="400" preservedata="Yes" action="/workFlow/components/billing/project_generate_invoice.cfm" method="post">
    	<cfformgroup type= "fieldset" label="Date Range">
        	<cfformgroup type="horizontal">
            	<cfinput type="datefield" size="20" name="startDate" label="From" required="yes">
                <cfinput type="datefield" name="endDate" label="To" required="yes">
			</cfformgroup>
       	</cfformgroup>                
    	<cfformgroup type="fieldset" label="Invoicing Options">
            <cfformgroup type="vertical">
                <cfinput type="hidden" name="clsJobNumber" value="#url.clsJobNumber#">
				<cfinput type="hidden" name="calledByUser" value="#url.calledByUser#">    
                <cfinput type="text" name="taxRate" label="Tax rate" required="yes" value="#orig_si.salestax_rate#">   
                <cfinput type="text" name="markup" label="Markup %" required="yes" value="0">
                <cfinput type="text" name="invoice_number" label="Invoice No.">
               
                <cfinput type="submit" name="submit" label="Create Invoice" value="Create Invoice" align="right" style="float:right;">
            </cfformgroup>
         </cfformgroup>
    </cfform>    
</cfwindow>