<cfquery name="get_tables" datasource="webwarecl">
	SELECT r_type, db_table, db_pkfield, db_dsn, updater FROM orms_creators ORDER BY r_type
</cfquery>

<cfoutput query="get_tables">
    Object Type:  #r_type#<br>
    DSN: #db_dsn#<br>
    Table: #db_table#<br>
    PK Field: #db_pkfield#<br>	
	<cfmodule template="tables-to-orms.cfm" type="#r_type#" table="#db_table#" pkfield="#db_pkfield#" dsn="#db_dsn#" updater="#updater#">
    <hr>
</cfoutput>