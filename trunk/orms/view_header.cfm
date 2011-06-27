<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">
<cfset orms = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>

<cfset orms_rec = orms.GetByTypeAndPK(attributes.r_type, attributes.r_pk)>

<style type="text/css">
	.orms_table th {
		background-color:#efefef;
		font-weight:bold;
		background-image:none;
		color:black;
		text-align:left;
	}
	
	.orms_table td {
		padding:2px;
		border-bottom:1px solid #c0c0c0;
	}
	
</style>

<cfif IsDefined("attributes.section")>
	<cfset sec = attributes.section>
<cfelse>
	<cfset sec = "">
</cfif>

<cfmodule template="/orms/permissions.cfm" r_type="#orms_rec.r_type#" r_pk="#orms_rec.r_pk#" user_id="#session.user.r_pk#" section="#sec#">
	