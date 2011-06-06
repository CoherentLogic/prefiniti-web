
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<cfoutput><title>Invoice for #form.clsJobNumber#</title></cfoutput>

<cfquery name="getLI" datasource="webwarecl">
	SELECT		te.hours,
    			te.description AS li_desc,
                te.mileage,
                tc.item,
                tc.description AS tc_desc,
                tc.rate,
                tc.charge_type,
                th.date,
                (te.hours * tc.rate) AS subtotal
	FROM		time_entries te
    JOIN		task_codes tc
    ON			tc.id = te.taskCodeID
    JOIN		time_card th
    ON			th.id = te.timecard_id
    WHERE		te.project_number='#form.clsJobNumber#'
    AND			th.date >= #CreateODBCDate(form.startDate)#
    AND			th.date <= #CreateODBCDate(form.endDate)#
    ORDER BY	th.date
</cfquery>                  

<cfquery name="pi" datasource="webwarecl">
	SELECT * FROM projects WHERE clsJobNumber='#form.clsJobNumber#'
</cfquery>

<cfquery name="orig_si" datasource="sites">
	SELECT * FROM sites WHERE SiteID=#pi.site_id#
</cfquery>    

</head>
<style type="text/css">
	body {
		font-family:Arial, Helvetica, sans-serif;
	}
	
	.pretty-table
	{
	  padding: 0;
	  margin: 0;
	  border-collapse: collapse;
	  border: 1px solid #333;
	  font-family: Arial, Helvetica, sans-serif;
	  font-size: 0.9em;
	  color: #000;
	  background: #bcd0e4 url("widget-table-bg.jpg") top left repeat-x;
	}
	
	.pretty-table caption
	{
	  caption-side: bottom;
	  font-size: 0.9em;
	  font-style: italic;
	  text-align: right;
	  padding: 0.5em 0;
	}
	
	.pretty-table th, .pretty-table td
	{
	  border: 1px dotted #666;
	  padding: 0.5em;
	  text-align: left;
	  color: #632a39;
	}
	
	.pretty-table th[scope=col]
	{
	  color: #000;
	  background-color: #8fadcc;
	  text-transform: uppercase;
	  font-size: 0.9em;
	  border-bottom: 2px solid #333;
	  border-right: 2px solid #333;
	}
	
	.pretty-table th+th[scope=col]
	{
	  color: #fff;
	  background-color: #7d98b3;
	  border-right: 1px dotted #666;
	}
	
	.pretty-table th[scope=row]
	{
	  background-color: #b8cfe5;
	  border-right: 2px solid #333;
	}
	
	.pretty-table tr.alt th, .pretty-table tr.alt td
	{
	  color: #2a4763;
	}
	
	

	
	
</style>
<cfparam name="rtot" default="">
<cfset rtot = 0>
<cfparam name="tax" default="">
<cfset tax = 0>
<body>
	<table width="100%">
    	<tr>
        	<td>
            	<cfoutput>
                	<img src="/SiteContent/#pi.site_id#/#orig_si.logo#"  />
                </cfoutput>
            </td>
            <td align="right">
            	<cfoutput>
            	<h2>Invoice</h2>
                
                <p style="font-size:medium;">
                	Invoice No.: #form.invoice_number#<br />
                    Invoice Date: #DateFormat(Now())#<br />
                    
				</p>      
                </cfoutput>                                                         
            </td>            
		</tr>
        <tr>
        	<td valign="top">
            	
            	<cfoutput>
                	Project #form.clsJobNumber#<br />
                    #orig_si.SiteName#<br /><br />
                    <span style="color:#999999;">
                    Client Job Number: #pi.clientJobNumber#
                    </span>
				</cfoutput>
            </td>
            <td valign="top" align="right">
            	
            	<cfoutput>
            	
                	#pi.billing_company#<br />                     
                    #pi.billing_address#<br />
                    #UCase(pi.billing_city)# #pi.billing_state# #pi.billing_zip# <br /><br />
                    
                    #pi.description#				
                </cfoutput>
			</td>                                                                 
		</tr>                                                    
                    
	</table>  
    <hr />
    <br /><br />                              
	<table class="pretty-table">
    	<tr>
        	<th scope="col">Date</th>
            <th scope="col">Description</th>
            
            <th scope="col">Service Type</th>
            
            <th scope="col">Unit Price</th>
            <th scope="col">Quantity</th>
           
            <th scope="col">Item Subtotal</th>
		</tr>
        <cfoutput query="getLI">
        <cfset rtot = rtot + subtotal>
        <tr>
        	<th scope="row">#DateFormat(date, "mm/dd/yyyy")#</th>
            <td>#li_desc#</td>
            
            
            <td>#tc_desc#</td>
            <td>#rate#/#charge_type#</td>
            <td>#hours#</td>
            <td>#DollarFormat(subtotal)#</td>
		</tr>
        </cfoutput>        
        <cfset subtot = rtot>
        <cfset markup = rtot * (form.markup / 100)>
        <cfset rtot = rtot + markup>
        <cfset tax = rtot * (form.taxRate / 100)>
        <cfset gtot = rtot + tax>    
	</table> 
    <center>
    <cfoutput>
    <p style="font-size:xx-small;">
    <em style="font-size:xx-small;">Services billed on this invoice were performed from</em> #DateFormat(form.startDate)# <em style="font-size:xx-small;">through</em> #DateFormat(form.endDate)#.
    </p>
    </cfoutput>
    </center>
    <br />
    <hr />
    <table width="100%">
    	<tr>
        	<td valign="top"><cfoutput>Payment - Invoice #form.invoice_number#</cfoutput></td>
            <td valign="top" align="right">
                <cfoutput>
                <table>
                <tr>	                    
                    <td>Total Excl. Tax:</td>
                    <td align="right">#DollarFormat(subtot)#</td>
                </tr> 
                <tr>                    
                    <td>Profit Mark-Up (#form.markup#%):</td>
                    <td align="right">#DollarFormat(markup)#</td>
                </tr>  
                <tr>
                    
                    <td>Sales Tax (#form.taxRate#%):</td>
                    <td align="right">#DollarFormat(tax)#</td>
                </tr> 
                <tr>                    
                    <td>Total Due:</td>
                    <td align="right"><div style="border:1px solid black; padding:2px; margin:5px;"><strong>#DollarFormat(gtot)#</strong></div></td>
                </tr>    
                </table>
                </cfoutput>
			</td>
		</tr>
	</table>                                    
                    
    
   
</body>
</html>


