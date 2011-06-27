<style>
	.prefinitiSearch h1
	{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:large;
		color:#3399CC;
	}
	.prefinitiSearch h2
	{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:small;
		text-indent:5px;
		color:black;
		font-weight:normal;
	}
	.prefinitiSearch td
	{
		background-color:#EFEFEF;
	}
	
</style>
<div style="padding:20px; background-color:white;">
<form name="prefiniti_search" id="prefiniti_search">
<table width="100%" class="prefinitiSearch" cellspacing="0">
	<tr>
    	<td style="background-color:#EFEFEF; -moz-border-radius-topleft:5px; -moz-border-radius-bottomleft:5px; padding:5px;"><h1>Search</h1></td>
        <td align="right" style="background-color:#EFEFEF; -moz-border-radius-topright:5px; -moz-border-radius-bottomright:5px; padding:5px;"><input type="text" name="search_terms" id="search_terms" style="border:none; width:450px; height:40px;" /><input type="button" name="dosearch" onclick="javascript:pfPerformSearch();" value="Begin Search"></td>
    </tr>
    <tr>
    	<td colspan="2" style="background-color:#EFEFEF; -moz-border-radius-topleft:5px; -moz-border-radius-bottomleft:5px; padding:5px; -moz-border-radius-topright:5px; -moz-border-radius-bottomright:5px;">
        	<div id="search_areas" style="display:block;">
            <h2>Look in the following areas</h2>
            
            <blockquote>
        	<table width="100%" cellspacing="0">
           	<tr>
            <td>
            <label><input name="com_projects" id="com_projects" type="checkbox" value="PROJECTS" checked>Projects</label><br>
            <label><input name="com_friends" id="com_friends" type="checkbox" value="FRIENDS" checked>Friends</label><br>
            <label><input name="com_inbox" id="com_inbox" type="checkbox" value="INBOX" checked>Inbox</label><br>
            </td>
            <td>
            <label><input name="com_sent_items" id="com_sent_items" type="checkbox" value="SENT ITEMS" checked>Sent Messages</label><br>
            <label><input name="com_companies" id="com_companies" type="checkbox" value="COMPANIES" checked>Companies</label><br>
            <label><input name="com_schedule" id="com_schedule" type="checkbox" value="SCHEDULE" checked>Schedule</label><br>
            </td>
            <td>
            <label><input name="com_files" id="com_files" type="checkbox" value="FILES" checked>Files</label><br>
            <label><input name="com_blogs" id="com_blogs" type="checkbox" value="BLOGS" checked>Blogs</label><br>         
            <label><input name="com_help" id="com_help" type="checkbox" value="HELP" checked>Help Articles</label>            
            </td>
            </tr>
            </table>    
         
            
            </blockquote>    
            </div>
            <div id="search_results_wrapper" style="display:none;">
            	<div id="search_results">
                
                </div>
            </div>                            
        </td>
    </tr>
</table>
</form>
</div>