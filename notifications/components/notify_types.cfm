<cfinclude template="/notifications/notification_udf.cfm">

<style type="text/css">
	.notifyTable {
		width:100%;
		

	}
	
	.notifyTable th {
		text-align:left;
		font-weight:bold;
		background-image:none;
		background-color:#C0C0C0;
		color:#3399CC;
	}
	
	.notifyTable td {
		padding:3px;
	}
</style>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfparam name="ntypes" default="">
<cfset ntypes=ntAllTypes()>
<div style="height:250px; border:1px solid #EFEFEF; overflow:auto; width:500px;">
<table class="notifyTable" cellspacing="0">
	<tr>
    	<th>When this event occurs:</th>
        <th>I want to be notified by:</th>
    </tr>
	<cfoutput query="ntypes">
    	<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="##EFEFEF">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
        	<td style="background-color:#ColColor#">#description#</td>
            <td style="background-color:#ColColor#"><cfmodule template="/notifications/components/notify_methods.cfm" user_id="#attributes.user_id#" event_id="#id#"></td>
		</tr>
	</cfoutput>
</table>                        
</div>