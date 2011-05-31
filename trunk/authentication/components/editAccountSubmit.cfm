

<cfquery name="uAI" datasource="webwarecl">
	UPDATE Users
	SET		company=#url.company#,
			longName='#url.longName#',
			email='#url.email#',
			smsNumber='#url.smsNumber#',
			gender='#url.gender#',
			bio='#url.bio#',
			title='#url.title#',
			phone='#url.phone#',
			fax='#url.fax#',
            <cfif #url.remember_page# EQ "yes">
	            remember_page=1
            <cfelse>
            	remember_page=0
            </cfif>
	WHERE	id=#url.id#
</cfquery>

<p style="color:red">Profile updated.</p>