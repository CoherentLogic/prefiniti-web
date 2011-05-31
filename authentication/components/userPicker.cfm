<div style="width:300px; border:1px solid silver;">
	<table width="100%" border="0" cellspacing="0">
	<tr><th align="left" id="gMsgTitle">User Picker</th><th align="right" style="text-align:right;"><a href="javascript:hideDiv('userPicker');"><img src="/graphics/delete.png" border="0"></a></th></tr></table>
        <div style="padding:5px;">
        <cfoutput><img src="/graphics/find.png" /> <input type="text" style="width:200px;" name="searchCriteria" id="searchCriteria" onkeyup="searchUsers(GetValue('searchCriteria'), '#attributes.nameTgt#', '#attributes.idTgt#');" />	</cfoutput>
        
        <div id="searchTarget">
            <p style="text-indent:3px; font-size:x-small; color:gray;"> Please enter part of the user's name.</p>
        </div>
    </div>
</div>

