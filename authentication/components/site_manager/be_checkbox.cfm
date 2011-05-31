<cfquery name="e" datasource="sites">
	SELECT * FROM event_entries
    WHERE	department_id=#attributes.department_id#
    AND		event_id=#attributes.event_id#
</cfquery>

<cfoutput>
<input type="checkbox" name="evt_#attributes.department_id#_#attributes.event_id#" id="evt_#attributes.department_id#_#attributes.event_id#" <cfif e.RecordCount GT 0>checked</cfif> onclick="wwSetEvent(#attributes.site_id#, #attributes.department_id#, #attributes.event_id#, IsChecked('evt_#attributes.department_id#_#attributes.event_id#'));">    
</cfoutput>
