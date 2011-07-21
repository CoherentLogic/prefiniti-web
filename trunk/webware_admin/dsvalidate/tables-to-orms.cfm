<cfquery name="go" datasource="#attributes.dsn#">
	SELECT #attributes.pkfield# AS ormspk FROM #attributes.table#
</cfquery>

<cfoutput>Records: #go.RecordCount#<br></cfoutput>

<cfoutput query="go">
	{#attributes.type#/#ormspk#} -&gt; 
    <cftry>
		<cfset ot = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").GetByTypeAndPK(attributes.type, ormspk)>
        &nbsp; #ot.r_id# <strong style="color:green">[ORMS RECORD OK]</strong>
        <cfcatch type="any">
        	#UCase(cfcatch.Message)# <strong style="color:red;">[ORMS RECORD MISSING]</strong>
            <cfset session.total_errors = session.total_errors + 1>
            <cfset session.reverse_index_errors = session.reverse_index_errors + 1>
            <cftry>
	            <cfmodule template="#attributes.updater#" id="#ormspk#">
    	        [FIXED]
        		<cfset session.total_errors_fixed = session.total_errors_fixed + 1>
                <cfset session.reverse_index_errors_fixed = session.reverse_index_errors_fixed + 1>
            	<cfcatch type="any">
                [COULD NOT FIX]
                </cfcatch>
           	</cftry>
        </cfcatch>
    </cftry>
    <br>
</cfoutput>