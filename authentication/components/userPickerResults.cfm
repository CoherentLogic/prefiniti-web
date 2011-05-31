<cfquery name="usres" datasource="webwarecl">
	SELECT longName, id FROM Users WHERE longName LIKE '%#URL.namePart#%'
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<table width="100%">
	<cfoutput query="usres">
		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>    
        <tr>
        	<td style="background-color:#ColColor#">
            	<a href="javascript:copyUserSearch('#id#', '#longName#', '#url.nameTgt#', '#url.idTgt#');">#longName#</a>
            </td>
       	</tr>
	</cfoutput>
</table>	