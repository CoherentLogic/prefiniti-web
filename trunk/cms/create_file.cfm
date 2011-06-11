<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.target_uuid)>

<div style="height:100%;position:relative;">
	<cfmodule template="/orms/dialog_header.cfm" icon="/graphics/navicons/files.png" caption="Upload File">
    
    <div style="padding-left:30px; margin-top:20px; font-size:14px;" id="file_uploader_form">
    	
        <div style="display:none;width:100%;text-align:center; margin-bottom:40px;" id="upload_finished" class="LandingHeaderText">
        	Upload Finished!
        </div>
        
        <form 	name="upload_file" 
        		id="upload_file" 
                method="post" 
				<cfoutput>action="/cms/upload.cfm?target_uuid=#URL.target_uuid#"</cfoutput> 
                enctype="multipart/form-data" 
                target="upload_target">
                
        	<table width="100%" cellpadding="10" cellspacing="0" class="orms_dialog">            
                <tr>
                    <td align="right" width="30%"><strong><cfoutput>#orms_rec.r_type#</cfoutput></strong></td>
                    <td align="left" width="70%"><cfoutput>#orms_rec.r_name#</cfoutput></td>
                </tr>
                <tr>
                    <td align="right" width="30%"><strong>File</strong></td>
                    <td align="left" width="70%"><input id="FileContents" name="FileContents" type="file" /></td>
                </tr>
                <tr>
                    <td align="right" width="30%"><strong>Keywords</strong></td>
                    <td align="left" width="70%"><textarea name="Keywords" id="Keywords"></textarea></td>
                </tr>
                                        
            </table>            
         
        </form>
		             
        <iframe id="upload_target" name="upload_target" src="" style="width:0;height:0;border:0px solid #fff; display:none;"></iframe>
    </div>
    
    <div style="text-align:center; width:100%; display:none;" id="upload_progress">
    	<div style="padding:40px; padding-top:60px; text-align:center; width:auto;">
    	<div class="LandingHeaderText">Please Wait</div>
    	<img src="/cms/upload_progress.gif">
        </div>
    </div>
    
    <div style="position:absolute; bottom:0px; border-top:1px solid #c0c0c0; width:100%; height:45px; background-color:#efefef;">
		<div style="padding:8px; float:right;" id="create_timesheet_buttons" >
			<a class="button" href="##" onclick="CloseORMSDialog();"><span>Cancel</span></a>
			<a class="button" href="##" onclick="ORMSBeginUpload();"><span><strong>Next</strong></span></a>
			
		</div>
	</div>
    
</div>    