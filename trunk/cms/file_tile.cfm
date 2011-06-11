<cfset f = CreateObject("component", "OpenHorizon.Storage.File").Open(attributes.file_uuid)>

<cfoutput>
<div style="width:200px;height:30px;float:left;text-align:left; margin:3px; overflow:hidden;" onclick="ORMSPreviewFile('#f.file_uuid#', '#attributes.target_uuid#');">	
    	<span class="LandingHeaderText" style="margin-top:8px; font-size:12px;"><img src="#f.TypeIcon().icon#" width="25" height="25" align="absmiddle" />   
        #f.original_filename#</span>
</div>
</cfoutput>
	