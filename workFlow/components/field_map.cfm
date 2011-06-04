<cfinclude template="/contentmanager/cm_udf.cfm">
<style type="text/css">
	.ptList
	{
	
	}
	
	.ptList th
	{
		text-align:left;
		color:#3399CC;
		font-weight:bold;
		background-color:#EFEFEF;
		background-image:none;
	}
	
	.ptList td
	{
		border-bottom:1px solid #EFEFEF;
	}
					
	
</style>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; clear:right; background-color:white; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> <cfoutput>
	<cfif mode EQ 0> <!--- user --->
    	#cmsUserFileDescription(url.notes_file_id)#
    <cfelse>
    	#cmsSiteFileDescription(url.notes_file_id)#
    </cfif>
</cfoutput></h3>
        </div>
    </div>

<table style="clear:left;">
	<tr>
    	<td align="center" valign="top" width="250">
        	<div style="padding:5px; text-align:left; margin:5px; background-color:#EFEFEF; -moz-border-radius:5px; width:220px; height:auto;">
            	<div id="point_info">
					<strong>No point selected.</strong>
				</div>
                
                <div style="background-color:white;">
                	<table width="100%" class="ptList" cellspacing="0">
                    <tr>
                    	<th>Pt</th>
                        <th>Lat</th>
                        <th>Lon</th>
                        <th>&nbsp;</th>
                        <th><img src="/graphics/eye.png" /></th>
					</tr>                        
                    
                	<cfparam name="f_path" default="">

					<cfif mode EQ 0>
                        <cfset f_path=cmsUserFilePath(url.notes_file_id)>
                    <cfelse>
                        <cfset f_path=cmsSiteFilePath(url.notes_file_id)>
                    </cfif>       
                    
                    <cfparam name="column_index" default="0">
                    <cfparam name="row_index" default="0">
                    <cfparam name="point_name" default="">
                    <cfparam name="latitude" default="">
                    <cfparam name="longitude" default="">
                    <cfparam name="elevation" default="">
                    <cfparam name="tmp_str" default="">
                    <cfparam name="current_character" default="">
                    <cfparam name="column_array" default="">
                    <cfset column_array=ArrayNew(2)>
                    <cfset space_count=0>
                    <cfloop file="#f_path#" index="line">
                        <cfset row_index = row_index + 1>
                        <cfset line="#line# ">
                        <cfloop index="cChar" from="1" to="#Len(line)#">
                            <cfset current_character=Mid(line, cChar, 1)>
                            <cfif current_character EQ " ">
                                <cfset column_index = column_index + 1>	
                                <cfset column_array[row_index][column_index]=tmp_str>
                                <cfset tmp_str="">
                            <cfelse>
                                <cfset tmp_str="#tmp_str##current_character#">
                            </cfif>                    
                        </cfloop>
                        <cfoutput>
                        	<tr>
                            	<td>#column_array[row_index][1]#</td>
                                <td>#column_array[row_index][2]#</td>
                                <td>#column_array[row_index][3]#</td>
                                <td><a href="javascript:centerToMarker(#row_index#);"><img src="/graphics/map_magnify.png" border="0" align="absmiddle"/></a></td>
                                <td><input type="checkbox" id="vis_#row_index#" onclick="showHideMarker(#row_index#, IsChecked('vis_#row_index#'));" checked/></td>
                                
							</tr>                                
                        </cfoutput>
                        <cfset column_index=0>
                    </cfloop>
                    
                    </table>
                
                </div>
            </div>
		</td>
        <td align="left" valign="top">

		<div id="fn_map_target" style="height:400px; width:350px;">
        
		</div>    
        </td>
	</tr>
</table>            



<div id="pageScriptContent" style="display:inline;">
	getMapNoMsg('fn_map_target');
	<cfloop from="1" to="#row_index#" index="i">
    	<cfoutput>
		showLatLong('#column_array[i][1]#', #column_array[i][2]#, #column_array[i][3]#, #column_array[i][4]#);
        </cfoutput>
	</cfloop>
    <cfoutput>
    	showLatLong('Project Location', #url.project_lat#, #url.project_lng#, 0);
	</cfoutput>        
</div>