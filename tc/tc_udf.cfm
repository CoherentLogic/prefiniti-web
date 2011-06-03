<cffunction name="tcHoursByTS" returntype="numeric">
	<cfargument name="timecard_id" type="numeric" required="yes">
    
    <cfquery name="h" datasource="webwarecl">
        SELECT hours FROM time_entries WHERE timecard_id=#timecard_id#
    </cfquery>
    
    <cfparam name="hs" default="0">
    
    <cfset hs="0">
    
    <cfoutput query="h">
        <cfset hs=#hs#+#hours#>
    </cfoutput>
    
    <cfreturn #hs#>
</cffunction>

<cffunction name="tcTIDbyLIID" returntype="numeric">
	<cfargument name="lineitem_id" type="numeric" required="yes">

	<cfquery name="getTID" datasource="webwarecl">
    	SELECT timecard_id FROM time_entries WHERE id=#lineitem_id#
	</cfquery>
    
    <cfreturn #getTID.timecard_id#>
</cffunction>    

<cffunction name="tcDateByLineItem" returntype="date">
	<cfargument name="lineitem_id" type="numeric" required="yes">
    
    
    
    <cfquery name="getDt" datasource="webwarecl">
    	SELECT date FROM time_card WHERE id=#tcTIDbyLIID(lineitem_id)#
	</cfquery>
    
    <cfif IsDate(getDt.Date)>
	    <cfreturn #getDt.date#>
	<cfelse>
    	<cfparam name="tDate" default="">
        <cfset tDate = CreateODBCDateTime(Now())>
    </cfif>        
</cffunction>                  

<cffunction name="tcEmployeeByLineItem" returntype="numeric">
	<cfargument name="lineitem_id" type="numeric" required="yes">
    
    
    <cfquery name="getEmp" datasource="webwarecl">
    	SELECT emp_id FROM time_card WHERE id=#tcTIDbyLIID(lineitem_id)#
	</cfquery>
 
 	<cfreturn #getEmp.emp_id#>
</cffunction>    

<cffunction name="tcTaskCodeByLineItem" returntype="string">
	<cfargument name="lineitem_id" type="numeric" required="yes">
     
	<cfparam name="taskcode_tid" default="">
	<cfset taskcode_tid = tcTIDbyLIID(lineitem_id)>
	
	<cfquery name="getsiteid" datasource="webwarecl">
		SELECT site_id FROM time_card WHERE id=#taskcode_tid#
	</cfquery>
    
    <cfquery name="getTC" datasource="webwarecl">
    	SELECT 	taskCodeID FROM	time_entries WHERE id=#tcTIDbyLIID(lineitem_id)#
	</cfquery>
 
 	<cfif getTC.taskCodeID NEQ "">

  		<cfquery name="getTask" datasource="webwarecl">
    		SELECT task_id, item FROM task_codes WHERE id=#getTC.taskCodeID# 
		</cfquery>

   	 	<cfreturn "#getTask.task_id#: #getTask.item#">

    <cfelse>
	 	<cfreturn "No Task ID">

    </cfif>
            
</cffunction> 



<cffunction name="tcApprovedByLineItem" returntype="boolean">
	<cfargument name="lineitem_id" type="numeric" required="yes">

	<cfquery name="getApproved" datasource="webwarecl">
    	SELECT closed FROM time_card WHERE id=#tcTIDbyLIID(lineitem_id)#
	</cfquery>
    
    <cfif getApproved.closed EQ 2>
		<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>                    	  
</cffunction>