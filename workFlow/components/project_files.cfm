<cfinclude template="/contentmanager/cm_udf.cfm">

<style type="text/css">
	.dList 
	{
		padding-left:20px;
	}
	
	.dList th
	{
		text-align:left;
		background-color:#EFEFEF;
		color:#3399CC;
		font-weight:bold;
		background-image:none;
	}
	
	.dList td
	{
		border-bottom:1px solid #EFEFEF;
		padding:5px;
	}
	
</style>

<cfparam name="project_files" default="">
<cfset project_files=cmsGetProjectFiles(attributes.project_id)>
<cfparam name="view_data" default="">

<cfif project_files.RecordCount GT 0>
	<table width="100%" cellspacing="5" cellpadding="0">	  	   
		<cfoutput query="project_files">
	    <cfset view_data=cmsGetViewData(id, url.current_association)>
	   	<cfif view_data.viewable> 
			<tr>    	   
		        <td width="50" valign="top" align="center">
		        	<cfparam name="ft" default="">
		            <cfif assoc_type EQ 0>
						<cfset ft=cmsFileType(project_files.file_id, "user")>
		    		<cfelse>
		            	<cfset ft=cmsFileType(project_files.file_id, "site")>
					</cfif>
		                                    
		            <img src="#ft.icon#"/>
		       	</td>
		        <td valign="top">
		        	<p style="font-size:14px; margin-top:0px;"><strong style="color:##2957a2;">#view_data.view_link#</strong><br>
				
					<span style="font-size:xx-small; color:##c0c0c0;"><span style="color:black;">#ft.description#</span> posted on #DateFormat(view_data.post_date, "long")#</span>
		            <span style="font-size:xx-small; color:##c0c0c0;"> by #getLongname(view_data.poster_id)#</span>
					</p>
				</td>                                
			</tr>        	
	    </cfif>                                        
		</cfoutput>     
	</table>	
<cfelse>
	<p style="font-size:14px;">No files have been uploaded for this project.</p>
</cfif>		