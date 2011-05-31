

    
	<cfoutput>
		<script language="javascript">
			glob_userid='#session.userid#';

		
			glob_site_maintainer = '#session.site_maintainer#';
			glob_userName = '#session.userName#';
			glob_longName = '#session.longname#';
			glob_current_association = #session.current_association#;
			glob_current_site_id = #session.current_site_id#;
			glob_browser = '#session.browserType#';
			glob_FrameworkRevision = 1.5;
	
		</script>
	</cfoutput>	
    
   

<!---<cfquery name="profile" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#session.userid#   
</cfquery>
<cfset session.webware_admin="#profile.webware_admin#">
	<cfoutput>
	<script>
		glob_prefiniti_admin='#session.webware_admin#';
	</script>		
    </cfoutput>--->
