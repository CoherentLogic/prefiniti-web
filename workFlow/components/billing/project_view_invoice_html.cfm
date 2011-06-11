
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<cfquery name="get_billing_event" datasource="webwarecl">
	SELECT * FROM billing_events WHERE id='#attributes.billing_event_id#'
</cfquery>

<cfquery name="get_line_items" datasource="webwarecl">
	SELECT * FROM billing_event_line_items WHERE billing_event_id='#attributes.billing_event_id#'
</cfquery>                  

<cfquery name="pi" datasource="webwarecl">
	SELECT * FROM projects WHERE clsJobNumber='#get_billing_event.project_number#'
</cfquery>

<cfset orms = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset orms_rec = orms.GetByTypeAndPK("Project", pi.id)>

<cfquery name="orig_si" datasource="sites">
	SELECT * FROM sites WHERE SiteID=#pi.site_id#
</cfquery>    
<cfoutput><title>Invoice for #get_billing_event.project_number#</title></cfoutput>

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
        	<td valign="top">
            	<cfoutput>
                	<img src="/SiteContent/#pi.site_id#/#orig_si.logo#"  />
                </cfoutput>
            </td>
            <td align="right" valign="top">
            	<cfoutput>
            	<h2 style="margin-top:0px;">Invoice</h2>
                
                <p style="font-size:medium;">
                	Invoice No.: #get_billing_event.invoice_number#<br />
                    Invoice Date: #DateFormat(Now())#<br />                   
				</p>      
                </cfoutput>                                                         
            </td>            
		</tr>
        <tr>
        	<td valign="top">
            	
            	<cfoutput>
                	Project #get_billing_event.project_number#<br />
                    #orig_si.SiteName#
				</cfoutput>
            </td>
            <td valign="top" align="right">
            	
            	<cfoutput>
            	
                	#pi.billing_company#<br />                     
                    #pi.billing_address#<br />
                    #UCase(pi.billing_city)# #pi.billing_state# #pi.billing_zip#
				
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
        <cfoutput query="get_line_items">
		<cfset subtotal = rate * units>
        <cfset rtot = rtot + subtotal>
        <tr>
        	<th scope="row">#DateFormat(date, "mm/dd/yyyy")#</th>
            <td>#line_desc#</td>
            
            
            <td>#taskcode_desc#</td>
            <td>#rate#/#unit_type#</td>
            <td>#units#</td>
            <td>#DollarFormat(subtotal)#</td>
		</tr>
        </cfoutput>        
        <cfset subtot = rtot>
        <cfset markup = rtot * (get_billing_event.markup / 100)>
        <cfset rtot = rtot + markup>
        <cfset tax = rtot * (get_billing_event.tax_rate / 100)>
        <cfset gtot = rtot + tax>    
	</table> 
    <center>
    <cfoutput>
    <p style="font-size:xx-small;">
    <em style="font-size:xx-small;">Services billed on this invoice were performed from</em> #DateFormat(get_billing_event.start_date)# <em style="font-size:xx-small;">through</em> #DateFormat(get_billing_event.end_date)#.
    </p>
    </cfoutput>
    </center>
    <br />
    <hr />
    <table width="100%">
    	<tr>
        	<td valign="top">
				<cfoutput> 
					<img src="http://picasso.coherent-logic.com:8500/repos/#orms_rec.r_owner#/Project/#orms_rec.r_id#/barcode.png"><br>
				</cfoutput>
				<span style="font-size:10px; text-decoration:italic;"><em>Scan the above QR Code with your mobile phone to view this project in Prefiniti.</em></span>
			</td>
            <td valign="top" align="right">
                <cfoutput>
                <table>
                <tr>	                    
                    <td>Total Excl. Tax:</td>
                    <td align="right">#DollarFormat(subtot)#</td>
                </tr> 
                <tr>                    
                    <td>Profit Mark-Up (#get_billing_event.markup#%):</td>
                    <td align="right">#DollarFormat(markup)#</td>
                </tr>  
                <tr>
                    
                    <td>Sales Tax (#get_billing_event.tax_rate#%):</td>
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


