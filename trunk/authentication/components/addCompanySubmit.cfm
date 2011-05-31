<!--function updateCompany(id, name, mailing_address, mailing_city, mailing_state,
					   mailing_zip, billing_address, billing_city, billing_state,
					   billing_zip, website)-->
					   
<cfquery name="uC" datasource="webwarecl">
	INSERT INTO companies 
			(name,
			mailing_address,
			mailing_city,
			mailing_state,
			mailing_zip,
			billing_address,
			billing_city,
			billing_state,
			billing_zip,
			website)
	VALUES	('#url.name#',
			'#url.mailing_address#',
			'#url.mailing_city#',
			'#url.mailing_state#',
			'#url.mailing_zip#',
			'#url.billing_address#',
			'#url.billing_city#',
			'#url.billing_state#',
			'#url.billing_zip#',
			'#url.website#')
</cfquery>

<p style="color:red">Company created.</p>