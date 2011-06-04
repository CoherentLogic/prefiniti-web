
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/billing/billing_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/framework/framework_udf.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<cfparam name="subdiv_id" default="">
<cfparam name="cid" default="">
<cfset cid=#CreateUUID()#>

<cfif URL.new_sub EQ 1>
	<cfquery name="c_sub" datasource="webwarecl">
    	INSERT INTO subdivisions
        	(name,
            site_id,
            approved,
            conf_id)
		VALUES
        	('#URL.subSuggest#',
            '#url.current_site_id#', 
            0,
            '#cid#')
	</cfquery>
    
    <cfquery name="g_sub" datasource="webwarecl">
    	SELECT * FROM subdivisions WHERE conf_id='#cid#'
	</cfquery>
    <cfset subdiv_id=#g_sub.id#>    
    
<cfelse>    
	<cfset subdiv_id=URL.subSelect>
</cfif>

    
<cfquery name="c" datasource="webwarecl">
	SELECT * FROM Users WHERE id='#URL.clientID#'
</cfquery>
	
<cfquery name="insertOrder" datasource="webwarecl">
	INSERT INTO projects
		(FILINGTYPE,
		CERTIFIEDTO,
		PLATCABINETBOOK,
		DUEDATE,
		SECTION,
		SPECIALINSTRUCTIONS,
		ADDRESS,
		CITY,
		STATE,
		ZIP,
		LATITUDE,
		LONGITUDE,
		STATUS,
		JOBTYPE,
		PAGESLIDE,
		RANGE,
		SUBDIVISION,
		TOWNSHIP,
		SUBDIVISIONORDEED,
		<cfif #URL.filingDate# NEQ "">
			FILINGDATE,
		</cfif>
		REQID,
		CLIENTJOBNUMBER,
		CLIENTID,
		BLOCK,
		LOT,
		DESCRIPTION,
		RECEPTIONNUMBER,
		PAGEORSLIDE,
		VIEWED,
		ORDERED_DATE,
		STAGE,
		ALLOW_PUBLICATION,
        REQUEST_PHOTOS,
        SERVICETYPE,
        RFP,
        SITE_ID,
        BILLING_COMPANY,
        BILLING_ADDRESS,
        BILLING_CITY,
        BILLING_STATE,
        BILLING_ZIP,
        BILLING_PHONE,
        BILLING_FAX)
	VALUES
		('#URL.filingtype#',
		'#URL.certifiedto#',
		'#URL.platcabinetbook#',
		#CreateODBCDateTime(URL.duedate)#,
		'#URL.section#',
		'#URL.specialinstructions#',
		'#URL.address#',
		'#URL.city#',
		'#URL.state#',
		'#URL.zip#',
		<cfif URL.latitude NEQ "">
        	#URL.latitude#,
        <cfelse>
        	0,
        </cfif>
        <cfif URL.longitude NEQ "">
			#URL.longitude#,
        <cfelse>
        	0,
        </cfif>
		'#URL.status#',
		'#URL.jobtype#',
		'#URL.pageslide#',
		'#URL.range#',
		#subdiv_id#,
		'#URL.township#',
		'#URL.subdivisionordeed#',
		<cfif #URL.filingDate# NEQ "">
			#CreateODBCDateTime(URL.filingdate)#,
		</cfif>
		'#URL.reqid#',
		'#URL.clientjobnumber#',
		#URL.clientid#,
		'#URL.block#',
		'#URL.lot#',
		'#URL.description#',
		'#URL.receptionnumber#',
		'#URL.pageorslide#',
		0,
		#CreateODBCDateTime(Now())#,
		0,
		#URL.allow_publication#,
        <cfif URL.request_photos EQ true>
        	1,
        <cfelse>
        	0,
        </cfif>
        '#URL.svctype#',
        <cfif URL.rfp EQ true>
        	1,
        <cfelse>
        	0,
        </cfif>
        	#url.current_site_id#,
            '#URL.billing_company#',
            '#URL.billing_address#',
            '#URL.billing_city#',
            '#URL.billing_state#',
            '#URL.billing_zip#',
            '#URL.billing_phone#',
            '#URL.billing_fax#'
        )
		
</cfquery>

<!---<cffunction name="bCreateEvent" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="event_type" type="string" required="yes">
--->

<cfquery name="getJobID" datasource="webwarecl">
	SELECT * FROM projects WHERE reqid='#URL.reqid#'
</cfquery>    

<cfoutput>
	#bCreateEvent(url.current_site_id, "ORDER")#
</cfoutput>

<cfmodule template="/workFlow/orms_do.cfm" id="#getJobID.id#">


<cfquery name="udl" datasource="sites">
	UPDATE site_associations SET
    	billing_company='#URL.billing_company#',
        billing_address='#URL.billing_address#',
        billing_city='#URL.billing_city#',
        billing_state='#URL.billing_state#',
        billing_zip='#URL.billing_zip#',
        billing_phone='#URL.billing_phone#',
        billing_fax='#URL.billing_fax#'
	WHERE
    	id=#URL.current_association#
</cfquery>                



<!--- willisj 11/28 <cfinsert datasource="#session.datasource#" tablename="projects"> --->
<!---<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	--->
    
<cfoutput>
	#pfCreateItem(URL.description, 0, 1, getJobID.id, "SYSOBJ", getJobID.clientID)#
	<cfif URL.rfp EQ true>
    	#ntBusinessEventNotify("WF_RFP_PLACED", url.current_site_id, "#getLongname(URL.CalledByUser)# has placed a new RFP.", "")#
    <cfelse>
    	#ntBusinessEventNotify("WF_ORDER_PLACED", url.current_site_id, "#getLongname(URL.CalledByUser)# has placed a new order.", "loadProjectViewer(#getJobID.id#);")#
		#ntNotify(URL.clientID, "WF_ORDER_PLACED", "You have placed a new order and will be notified as soon as the order is processed.", "loadProjectViewer(#getJobID.id#);")#
	</cfif>        
</cfoutput>                             

<h1>Order Placed</h1>
<p>You will be notified when we process your order.</p>
	

</body>
</html>
