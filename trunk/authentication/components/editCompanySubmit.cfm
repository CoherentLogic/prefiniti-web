<!--function updateCompany(id, name, mailing_address, mailing_city, mailing_state,
					   mailing_zip, billing_address, billing_city, billing_state,
					   billing_zip, website)-->
					   
<cfquery name="uC" datasource="webwarecl">
	UPDATE companies
	SET		name='#url.name#',
			mailing_address='#url.mailing_address#',
			mailing_city='#url.mailing_city#',
			mailing_state='#url.mailing_state#',
			mailing_zip='#url.mailing_zip#',
			billing_address='#url.billing_address#',
			billing_city='#url.billing_city#',
			billing_state='#url.billing_state#',
			billing_zip='#url.billing_zip#',
			website='#url.website#'
	WHERE	id=#url.id#
</cfquery>

<p style="color:red">Profile updated.</p>