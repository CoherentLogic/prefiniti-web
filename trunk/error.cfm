<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Error Occured</title>
<link rel="stylesheet" type="text/css" href="/css/gecko.css" />
<style type="text/css">
	.errDiv {
		border:1px solid #c0c0c0;
		
		text-align:left;
		margin-left:auto;
		margin-right:auto;
		width:550px;
		height:275px;
		margin-top:70px;
	}
	
	p {
		font-family:"Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
		font-size:12px;
	}
	
	html {
		height:100%;
		width:100%;
	}
</style>
<script type="text/javascript">
	function show_element_block(div_id) {
		document.getElementById(div_id).style.display = 'block';
	}
	
	function hide_element(div_id) {
		document.getElementById(div_id).style.display = 'none';
	}
	
	function show_element_inline(div_id) {
		document.getElementById(div_id).style.display = 'inline';
	}
	
	function show_details() {
		hide_element('show_details_button');
		show_element_inline('hide_details_button');
		show_element_block('error_details');
		document.getElementById('error_box').style.height = "310px";
	}
	
	function hide_details() {
		show_element_inline('show_details_button');
		hide_element('hide_details_button');
		hide_element('error_details');
		document.getElementById('error_box').style.height = "275px";
	}
	
	
</script>
</head>

<cfset errtemplate = error.RootCause.TagContext[1].Template>

<cfquery name="insert_error" datasource="#session.framework.BaseDatasource#">
	INSERT INTO site_errors
    	(error_code,
        error_summary,
        error_description,
        error_template,
        session_key,
        current_object,
        extended_info)
	VALUES
    	('#error.RootCause.ErrorCode#',
        '#error.RootCause.Message#',
        '#error.RootCause.Detail#',
        <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#errtemplate#:#error.RootCause.TagContext[1].Line#"/>,        
        '#session.authentication_key#',
        '#session.current_object#',
        '#error.RootCause.ExtendedInfo#')  
</cfquery>

<body>

	<div class="errDiv" id="error_box">
    	<div style="width:100%; background-color:#efefef; border-bottom:1px solid #c0c0c0; height:60px;">
	
        
        <img src="/graphics/prenew-small.png" style="margin:15px;" />
        
		</div>
        
        <div style="padding:40px;">
		<cfoutput>
        
        <div class="LandingHeaderText" style="margin-top:10px; margin-bottom:20px;">#error.RootCause.Message#</div>
        
        <p style="margin-bottom:20px;">#error.RootCause.Detail#</p>
        
        <a class="button" href="##" id="show_details_button" onclick="show_details();"><span>More</span></a>
        <a class="button" href="##" id="hide_details_button" onclick="hide_details();" style="display:none;"><span>Less</span></a>
        <div id="error_details" style="display:none; width:500px; margin-top:50px;">
        	<strong>Error Code:</strong> #error.RootCause.ErrorCode#<br />
            <strong>Current Object:</strong> #session.current_object#<br />
       		<strong>Authentication Key:</strong> #session.authentication_key#<br  />
			<strong>Extended Information:</strong> #error.RootCause.ExtendedInfo#<br />        
        </div>
		
		</cfoutput>
        </div>
        
        
        
        
    </div>
    
    
    <br />
    
    

</body>
</html>
