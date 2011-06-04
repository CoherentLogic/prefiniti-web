<cffunction name="wfProjectNumberByID" returntype="string">
	<cfargument name="project_id" type="numeric" required="yes">
    
    <cfquery name="wfpnbi" datasource="webwarecl">
    	SELECT clsJobNumber FROM projects WHERE id=#project_id#
    </cfquery>
    
    <cfif wfpnbi.clsJobNumber NEQ "">
	    <cfreturn #wfpnbi.clsJobNumber#>
	<cfelse>
    	<cfreturn "[No Project Number]">
	</cfif>        
</cffunction>

<cffunction name="wfProjectByJobNumber" returntype="query">
	<cfargument name="clsJobNumber" type="string" required="yes">
    
    <cfquery name="wfpbjn" datasource="webwarecl">
    	SELECT * FROM projects WHERE clsJobNumber='#clsJobNumber#'
	</cfquery>
    
    <cfreturn #wfpbjn#>
</cffunction>            

<cffunction name="wfTimeByProject" returntype="void">
	<cfargument name="project_number" type="string" required="yes">
    
    <cfquery name="wftbp" datasource="webwarecl">
    	SELECT id, emp_id FROM time_card WHERE clsJobNumber='#project_number#'
    </cfquery>
    
    <cfoutput query="wftbp">
   		<table>
        	<tr>
            	<td>#getLongname(emp_id)#</td>
                <td>#wfGTI(id)#</td>
            </tr>
        </table>
    </cfoutput>
    
</cffunction>

<cffunction name="wfGTI" returntype="void">
	<cfargument name="ts_id" type="numeric" required="yes">
    
    
    <cfquery name="wfgtix" datasource="webwarecl">
    	SELECT SUM(hours) AS th FROM time_entries WHERE timecard_id=#ts_id#
    </cfquery>
    
<!---    <cfquery name="muh" datasource="webwarecl">
    	SELECT task_code
    </cfquery>--->
    <cfoutput>#wfgtix.th#</cfoutput>
</cffunction>




<cffunction name="SubdivisionNameByID" returntype="string">
	<cfargument name="id" type="numeric" required="yes">
	
	<cfquery name="GetSubName" datasource="webwarecl">
		SELECT name FROM subdivisions WHERE id=#id#
	</cfquery>
	<cfif GetSubName.RecordCount GT 0>
		<cfreturn #GetSubName.name#>
	<cfelse>
		<cfreturn "">
	</cfif>
</cffunction>			

<cffunction name="CreateBillingEvent" returntype="string">
	<cfargument name="invoice_number" type="string" required="yes">
	<cfargument name="project_number" type="string" required="yes">
	<cfargument name="tax_rate" type="numeric" required="yes">
	<cfargument name="markup" type="numeric" required="yes">
	<cfargument name="start_date" type="string" required="yes">
	<cfargument name="end_date" type="string" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
	
	<cfparam name="billing_event_id" default="">
	<cfset billing_event_id = CreateUUID()>
	
	<cfquery name="getLI" datasource="webwarecl">
		SELECT		te.hours,
	    			te.description AS li_desc,
	                te.mileage,
	                te.id,
	                tc.item,
	                tc.description AS tc_desc,
	                tc.rate,
	                tc.charge_type,
	                th.date,
	                (te.hours * tc.rate) AS subtotal
		FROM		time_entries te
	    JOIN		task_codes tc
	    ON			tc.id = te.taskCodeID
	    JOIN		time_card th
	    ON			th.id = te.timecard_id
	    WHERE		te.project_number='#project_number#'
	    AND			th.date >= #CreateODBCDate(start_date)#
	    AND			th.date <= #CreateODBCDate(end_date)#
	    ORDER BY	th.date
	</cfquery>
	
	<cfquery name="pi" datasource="webwarecl">
		SELECT * FROM projects WHERE clsJobNumber='#project_number#'
	</cfquery>
	
	<cfquery name="orig_si" datasource="sites">
		SELECT * FROM sites WHERE SiteID=#pi.site_id#
	</cfquery>   
	
	<cfquery name="cbe" datasource="webwarecl">
		INSERT INTO billing_events
					(id,
					invoice_number,
					project_number,
					site_id,
					tax_rate,
					markup,
					start_date,
					end_date,
					created_date,
					created_by)
		VALUES		('#billing_event_id#',
					'#invoice_number#',
					'#project_number#',
					#pi.site_id#,
					#tax_rate#,
					#markup#,
					#CreateODBCDate(start_date)#,
					#CreateODBCDate(end_date)#,
					#CreateODBCDate(Now())#,
					#user_id#)
	</cfquery>
	
	<cfoutput query="getLI">
		<cfset CreateBillingEventLineItem(billing_event_id,id,hours,charge_type,rate,date,tc_desc,li_desc)>
	</cfoutput>
	
	<cfreturn #billing_event_id#>
</cffunction>

<cffunction name="CreateBillingEventLineItem" returntype="void">
	<cfargument name="billing_event_id" type="string" required="yes">
	<cfargument name="time_entry_id" type="numeric" required="yes">
	<cfargument name="units" type="numeric" required="yes">
	<cfargument name="unit_type" type="string" required="yes">	
	<cfargument name="rate" type="numeric" required="yes">
	<cfargument name="date" type="string" required="yes">
	<cfargument name="taskcode_desc" type="string" required="yes">
	<cfargument name="line_desc" type="string" required="yes">
	
	
	<cfparam name="beliid" default="">
	<cfset beliid = CreateUUID()>
	
	<cfquery name="cbeli" datasource="webwarecl">
		INSERT INTO		billing_event_line_items
						(id,
						billing_event_id,
						time_entry_id,
						units,
						unit_type,
						rate,
						date,
						taskcode_desc,
						line_desc)
		VALUES			('#beliid#',
						'#billing_event_id#',
						#time_entry_id#,
						#units#,
						'#unit_type#',
						#rate#,
						#CreateODBCDate(date)#,
						'#taskcode_desc#',
						'#line_desc#')
				
	</cfquery>
	
	<cfquery name="get_timecard_id" datasource="webwarecl">
		SELECT timecard_id FROM time_entries WHERE id=#time_entry_id#
	</cfquery>
	
	<cfquery name="update_tc" datasource="webwarecl">
		UPDATE 	time_card 
		SET 	billed=1,
				billed_date=#CreateODBCDateTime(Now())#
		WHERE	id=#get_timecard_id.timecard_id#
	</cfquery>
	
</cffunction>	

<cffunction name="CreateCreditEvent" returntype="string">
	<cfargument name="billing_event_id" type="string" required="yes">
	<cfargument name="credit_type" type="string" required="yes">
	<cfargument name="credit_amount" type="numeric" required="yes">
	<cfargument name="credit_date" type="string" required="yes">
	<cfargument name="check_number" type="string" required="yes">
	<cfargument name="comment" type="string" required="yes">
	<cfargument name="applied_by" type="numeric" required="yes">
	
	
	<cfparam name="ceid" default="">
	<cfset ceid = CreateUUID()>
	
	<cfquery name="cce" datasource="webwarecl">
		INSERT INTO billing_events
					(id,
					billing_event_id,
					credit_type,
					credit_amount,
					credit_date,
					check_number,
					comment,
					applied_by)
		VALUES		('#ceid#',
					'#billing_event_id#',
					'#credit_type#',
					#credit_amount#,
					#CreateODBCDate(credit_date)#,
					'#check_number#',
					'#comment#',
					#applied_by#)
	</cfquery>

	<cfreturn #ceid#>
</cffunction>