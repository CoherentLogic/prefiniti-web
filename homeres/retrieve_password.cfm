<cfquery name="GetQuestion" datasource="webwarecl">
	SELECT password_question FROM users WHERE email='#form.email#'
</cfquery>    

<div class="mainArea" style="background-image:url(/homeres/back.jpg)">

	<cfif GetQuestion.RecordCount EQ 0>
    	<h1>No Such Account</h1>
        
        <p>There is no account on Prefiniti with the e-mail address you specified.</p>
        
        <p>Please call 1-8-PREFINITI or write our <a href="mailto:support@prefiniti.com">support staff</a> for assistance with this problem.</p>
        
        <p>We sincerely apologize for the inconvenience.</p>
	<cfelseif GetQuestion.RecordCount GT 1>
    	<h1>Cannot Retrieve Password</h1>
        
        <p>There appears to be a problem with your account.</p>
        
		<p>Please call 1-8-PREFINITI or write our <a href="mailto:support@prefiniti.com">support staff</a> for assistance with this problem.</p>
        
        <p>We sincerely apologize for the inconvenience.</p>                
	<cfelse>
    	<h1>Account Retrieved</h1>
        
        <p><strong>Instructions:</strong> Please answer the question shown below and click "Reset Password"</p>
        
        
        <div style="background-color:#EFEFEF; -moz-border-radius:5px; padding:5px; color:black; width:440px;">
        	<cfquery name="GetQuestion" datasource="webwarecl">
            	SELECT password_question, id FROM users WHERE email='#form.email#'
			</cfquery>
            
            <p><strong><cfoutput>#GetQuestion.password_question#</cfoutput></strong> (your answer is not case-sensitive)</p>            <form name="pwa" id="pwa" action="/homeres/challenge_answer.cfm" method="post">
            	<cfoutput>
                <input type="hidden" name="my_question" id="my_question" value="#GetQuestion.password_question#">
                <input type="hidden" name="my_id" id="my_id" value="#GetQuestion.id#">
                </cfoutput>
            	<input type="text" name="my_answer" id="my_answer" width="50" style="width:240px;">
                <input type="submit" name="submit" value="Reset Password">
            </form>
        </div>
        
        <blockquote>
    
    </cfif>
</div>