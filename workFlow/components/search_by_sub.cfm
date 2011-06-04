<cfparam name="qry" default="">

	<cfif URL.permissionlevel EQ 0>
    	<cfset qry = "SELECT * FROM projects WHERE subdivision=#URL.SubID# AND clientID=#URL.CalledByUser# ORDER BY clsJobNumber">
    <cfelse>
    	<cfset qry = "SELECT * FROM projects WHERE subdivision=#URL.SubID# AND site_id=#URL.current_site_id# ORDER BY clsJobNumber">
    </cfif>
    
<cfquery name="ss" datasource="webwarecl">
	#qry#
</cfquery>

<!---
<cfoutput>Sub #URL.SubID#, Site #URL.current_site_id#</cfoutput>

<br>
<cfoutput>Query Text #qry#</cfoutput>
--->

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top">Search Projects by Subdivision</h3>
        </div>
    </div>
<br />
<br />

<cfoutput query="ss">
	<a href="javascript:loadProjectViewer(#id#);">#clsJobNumber# - #description#</a><br />
</cfoutput>    

<cfif ss.RecordCount EQ 0>
	<p>No results.</p>
</cfif>    