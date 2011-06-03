<cfoutput>
<!--
<wwafcomponent>IIF Export - #url.id#</wwafcomponent>
-->
</cfoutput>
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workFlow/workflow_udf.cfm">


<cfdump var="#url#">

<!---
	id = time_card id
	
--->	

<cfquery name="gTC" datasource="webwarecl">
	SELECT emp_id, date FROM time_card WHERE id=#url.id#
</cfquery>

<cfparam name="empName" default="">
<cfset empName = getLongname(gTC.emp_id)>

<cfparam name="tcDate" default="">
<cfset tcDate = DateFormat(gTC.date, "mm/dd/yyyy")>

<cfquery name="gTE" datasource="webwarecl">
	SELECT * FROM time_entries WHERE timecard_id=#URL.id#
</cfquery>
    
<cfparam name="ea" default="">
<cfset ea = ArrayNew(1)>

<cfset hdrString="!TIMERHDR#Chr(9)#VER#Chr(9)#REL#Chr(9)#COMPANYNAME#Chr(9)#IMPORTEDBEFORE#Chr(9)#FROMTIMER#Chr(9)#COMPANYCREATETIME">
<cfset hdrFieldStr="TIMERHDR#Chr(9)##URL.QBVer##Chr(9)##URL.QBRel##Chr(9)##URL.companyName##Chr(9)#N#Chr(9)#Y#Chr(9)##URL.companyCreateTime#">

<cfparam name="lihdr" default="">
<cfset lihdr = "!TIMEACT#Chr(9)#DATE#Chr(9)#JOB#Chr(9)#EMP#Chr(9)#ITEM#Chr(9)#PITEM#Chr(9)#DURATION#Chr(9)#PROJ#Chr(9)#NOTE#Chr(9)#XFERTOPAYROLL#Chr(9)#BILLINGSTATUS">


<cfoutput query="gTE">
	<cfset ArrayAppend(ea, lihdr)>
    
																																								 
</cfoutput>

