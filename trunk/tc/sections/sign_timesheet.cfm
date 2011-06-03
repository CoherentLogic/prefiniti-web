
<form name="signTS" id="signTS">
<cfoutput>
	<input type="hidden" name="id" value="#attributes.r_pk#" />
</cfoutput>

<strong class="OH_HEADER">Sign Time Card</strong>

<p style="font-weight:bold">By signing this time card I certify that its contents are accurate to the best of my ability.</p>

<p><label>Please type your initials: <input type="text" id="initials" name="initials"></label></p>

<div style="height:40px; width:100%;">
<div style="padding:8px;">
<cfoutput>
<a class="button" href="####" onclick="signTimesheet(#attributes.r_pk#);"><span>Sign Timesheet</span></a>
</cfoutput>
</div>
</div>
</form>
