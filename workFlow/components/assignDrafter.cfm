<cfquery name="aDR" datasource="webwarecl">
	UPDATE projects
	SET drafter_id=#url.drafterID#
	WHERE id=#url.projectID#
</cfquery>

<cfmodule template="/jobviews/components/custNameByID.cfm" id="#url.drafterID#"><br /><a href="javascript:showDiv('drafterSelect');" style="color:blue;">Change Drafter</a>