<div class="homeHeader"><img src="/graphics/lightning.png" align="absmiddle" /> Business Events</div>

<cfquery name="getEvents" datasource="sites">
	SELECT * FROM department_events ORDER BY event_key
</cfquery>


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

<div style="padding-left:20px;">
    <div style="height:250px; border:1px solid #EFEFEF; overflow:auto; width:440px;">
    <table class="notifyTable" cellspacing="0">
        <tr>
            <th>When this event occurs:</th>
            <th>Notify these departments:</th>
        </tr>
        <cfoutput query="getEvents">
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
                <td style="background-color:#ColColor#">#event_name#</td>
                <td style="background-color:#ColColor#">
                	<cfmodule template="/authentication/components/site_manager/event_departments.cfm" event_id="#id#">
                </td>
            </tr>
        </cfoutput>
    </table>                        
    </div>
</div>    