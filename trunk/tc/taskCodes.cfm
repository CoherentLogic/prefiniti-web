<style type="text/css">
	.pList 
	{
		border-left:1px solid #EFEFEF;
		border-right:1px solid #EFEFEF;
		-moz-border-radius-topleft:5px;
		-moz-border-radius-topright:5px;
	}
	
	.pList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.pList td
	{
		border-bottom:1px solid #EFEFEF;
	}
	
</style>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="TS_VIEW_TC">
<cfinclude template="/authentication/authentication_udf.cfm">
<!--
	<wwafcomponent>Manage Task Codes</wwafcomponent>
<wwafpackage>Time Management</wwafpackage>
<wwaficon>time.png</wwaficon>
-->
<link href="../css/gecko.css" rel="stylesheet" type="text/css">

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfquery name="getTaskCodes" datasource="webwarecl">
	SELECT * FROM task_codes WHERE site_id=#url.current_site_id# ORDER BY task_id 
</cfquery>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Manage Task Codes</h3>
        </div>
    </div>
    <br />
    <br />
<table width="600" style="margin-left:20px;" cellpadding="0" cellspacing="0" class="pList">
	<tr>
		<th style="-moz-border-radius-topleft:5px;">Task Code</th>
		<th>Item</th>
		<th>Description</th>
		<th>Rate</th>
		<th>Charge Type</th>
		<th style="-moz-border-radius-topright:5px;">Tools</th>
	</tr>
	
	<cfoutput query="getTaskCodes">
		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="white">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
		<tr>
			<td style="background-color:#ColColor#">#task_id#</td>
			<td style="background-color:#ColColor#">#item#</td>
			<td style="background-color:#ColColor#">#description#</td>
			<td style="background-color:#ColColor#">#rate#</td>
			<td style="background-color:#ColColor#">#charge_type#</td>
			<td style="background-color:#ColColor#" nowrap><img src="/graphics/page_edit.png"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'tc/taskCodeEdit.cfm?id=#id#')">Edit</a><br>
			<img src="/graphics/page_delete.png"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'tc/taskCodeDelete.cfm?id=#id#')">Delete</a>
			</td>
		</tr>
	</cfoutput>
</table>
<br>
<cfif #getPermissionByKey("TS_CREATE_TC", url.current_association)# EQ true>
<form name="addTaskCode" id="addTaskCode" action="tc/addTask_sub.cfm" method="post">
	<table width="600" style="padding-left:20px;" class="pList" cellpadding="0" cellspacing="0">
		<tr>
		  <th colspan="2" style="-moz-border-radius-topleft:5px; -moz-border-radius-topright:5px;">Add Task Code</th>
	  </tr>
		<tr>
			<td>Task Code</td>
			<td><input type="text" name="task_id"></td>
		</tr>
		<tr>
			<td>Item</td>
			<td><input type="text" name="item"></td>
		</tr>
		<tr>
			<td>Description</td>
			<td><input type="text" name="description"></td>
		</tr>
		<tr>
			<td>Rate</td>
			<td><input type="text" name="rate"></td>
		</tr>
		<tr>
			<td>Charge Type</td>
			<td>
				<select name="charge_type">
					<option value="Hour">Hour</option>
					<option value="Layer">Layer</option>
					<option value="Day">Day</option>
					<option value="Unit">Unit</option>
					<option value="Category">Category</option>
					<option value="Sheet">Sheet</option>
				</select>			</td>
		</tr>
		<tr>
		  <td colspan="2" align="right"><input type="button" class="normalButton" name="Submit" value="Add Task Code" onclick="AjaxSubmitForm(AjaxGetElementReference('addTaskCode'), '/tc/addTask_sub.cfm', 'tcTarget');"></td>
	  </tr>
	</table>
</form>
</cfif>