<cfinclude template="/workFlow/workflow_udf.cfm">

<!---
<cffunction name="CreateBillingEvent" returntype="string">
	<cfargument name="invoice_number" type="string" required="yes">
	<cfargument name="project_number" type="string" required="yes">
	<cfargument name="tax_rate" type="numeric" required="yes">
	<cfargument name="markup" type="numeric" required="yes">
	<cfargument name="start_date" type="string" required="yes">
	<cfargument name="end_date" type="string" required="yes">
--->

<cfset be_id = CreateBillingEvent(form.invoice_number, form.clsJobNumber, form.taxRate, form.markup, form.startDate, form.endDate, form.calledByUser)>