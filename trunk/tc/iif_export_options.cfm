<cfoutput>
<!--
<wwafcomponent>IIF Export Options - #url.id#</wwafcomponent>
-->
</cfoutput>


<h1>Export Timesheet to QuickBooks</h1>

<table width="100%">
	<tr>
    	<td>Company Name:</td>
        <td><input type="text" name="companyName" id="companyName"></td>
	</tr>
    <tr>
    	<td>Company Create Time:</td>
        <td><input type="text" name="companyCreateTime" id="companyCreateTime"></td>
	</tr>
    <tr>
    	<td>QuickBooks Version:</td>
        <td><input type="text" name="QBVer" id="QBVer"></td>
    </tr>
    <tr>
    	<td>QuickBooks Release:</td>
        <td><input type="text" name="QBRel" id="QBRel"></td>
	</tr>        
    <tr>
    	<td>&nbsp;</td>
        <td align="right">
        	<cfoutput>
        	<input type="button" name="genIIF" onclick="iif_export(#url.id#, GetValue('companyName'), GetValue('companyCreateTime'), GetValue('QBVer'), GetValue('QBRel'));" value="Generate IIF">
            </cfoutput>
		</td>
	</tr>                                    
</table>

