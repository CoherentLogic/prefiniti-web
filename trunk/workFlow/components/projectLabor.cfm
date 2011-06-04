<cfinclude template="/tc/tc_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="getLabor" datasource="webwarecl">
	SELECT * FROM time_entries WHERE project_number='#attributes.project_number#'
</cfquery>

<cfquery name="getHours" datasource="webwarecl">
	SELECT SUM(hours) AS projHours FROM time_entries WHERE project_number='#attributes.project_number#'
</cfquery>
    
<cfoutput><h1>Labor for #attributes.project_number#</h1></cfoutput>

<cfparam name="divWidth" default="">
<cfparam name="divHeight" default="">
<cfparam name="borderStr" default="">

<cfif attributes.printable EQ "yes">
	<cfset divWidth="600px">
    <cfset divHeight="auto">
    <cfset borderStr="none">
<cfelse>
	<cfset divWidth="auto">
    <cfset divHeight="200px">
    <cfset borderStr="1px solid black">
</cfif>

<cfparam name="styleStr" default="">
<cfset styleStr="width:#divWidth#; height:#divHeight#; overflow:auto; border:#borderStr#">
    

<cfif attributes.printable NEQ "yes">
<div <cfoutput>style="#styleStr#"</cfoutput>>
</cfif>
<table cellpadding="0" cellspacing="1" width="100%">
<tr>
	<th>Date</th>
    <th>Employee</th>
    <th>Task Code</th>
    <th>Description</th>
    <th>Miles</th>
    <th>Hours</th>
</tr>
<cfparam name="rowColor" default="">
<cfoutput query="getLabor">

	<cfif attributes.printable EQ "no">
		<cfif tcApprovedByLineItem(id) EQ true>
            <cfset rowColor = "##9FC">
        <cfelse>
            <cfset rowColor = "##FCF">
        </cfif>        
    <cfelse>
    	<cfset rowColor = "white">
	</cfif>        
    
	<tr>
    	<td style="background-color:#rowColor#;">#DateFormat(tcDateByLineItem(id), 'mm/dd/yyyy')#</td>
        <td style="background-color:#rowColor#;">#getLongname(tcEmployeeByLineItem(id))#</td>
        <td style="background-color:#rowColor#;">#tcTaskCodeByLineItem(id)#</td>
        <td style="background-color:#rowColor#;">#description#</td>
        <td style="background-color:#rowColor#;">#odEnd - odStart#</td>
        <td style="background-color:#rowColor#;">#hours#</td>
	</tr>        	
</cfoutput>
</table>
<cfif attributes.printable NEQ "yes">
</div>
</cfif>
<strong>LEGEND:</strong>
<table>
<tr>
	<td style="background-color:#9FC;">APPROVED</td>
    <td style="background-color:#FCF;">NOT APPROVED</td>
</tr>
</table>

<cfif getHours.projHours NEQ "">
<div style="font-size:14px;">    
<strong>Total hours worked: </strong> <cfoutput>#Round(getHours.projHours)#</cfoutput>
</div>
<cfelse>
<strong>No hours worked on this project.</strong>
</cfif>
