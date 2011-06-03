<link href="../css/gecko.css" rel="stylesheet" type="text/css">
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Sign Timesheet</h3>
        </div>
    </div>
    <br />
    <br />
<form name="signTS" id="signTS">
<cfoutput>
	<input type="hidden" name="id" value="#url.id#" />
</cfoutput>
<table width="100%" cellpadding="8px">

<tr>
	<td colspan="2">
		<table border="1">
			<tr>
				<td>
					<cfmodule template="/tc/components/tcHeader.cfm" id="#url.id#"><br />
					<cfmodule template="/tc/components/lineItemsByTC.cfm" timecard_id="#url.id#"><br />
					<cfmodule template="/tc/components/tcFooter.cfm" id="#url.id#">
				</td>
			</tr>
		</table>
	</td>
	</tr>
<tr>
	<td colspan="2"><p style="font-weight:bold">By signing this timesheet I certify that its contents are accurate to the best of my ability.</p></td>
</tr>
<tr>
	<td>Initials:</td>
	<td><input type="text" id="initials" name="initials"></td>
</tr>

<tr>
	<td colspan="2" align="right"><input name="Submit" type="button" class="normalButton" value="Sign Timesheet" onclick="AjaxSubmitForm(AjaxGetElementReference('signTS'), '/tc/sign_sub.cfm', 'tcTarget');"></td>
	
</tr>
</table>
</form>
