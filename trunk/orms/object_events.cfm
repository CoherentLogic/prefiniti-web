
<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(attributes.orms_id)>

<div class="LandingHeaderText" style="font-weight:bold; width:100%; padding-bottom:20px; border-bottom:1px solid #c0c0c0; margin-bottom:30px;">
	<cfoutput>
        #o.r_type# Events
    </cfoutput>    
    
    <cfif o.CanRead(attributes.user_id)>	
        <div style="margin-top:20px;">
        
        <input 		type="text"
                    class="comment_inactive"
                    style="padding:5px; border:1px solid #c0c0c0; width:700px;" 
                    id="object_comment" 
                    name="object_comment" 
                    onkeypress="ORMSPostComment(event);"
                    onclick="ORMSCommentClick();"
                    value="Enter your comment...">
        
        <cfoutput>
        <input type="hidden" id="orms_id" name="orms_id" value="#o.r_id#" />
        </cfoutput>
        </div>
    </cfif>                                    
</div>




<div id="object_feed">

</div>