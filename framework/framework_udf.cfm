<!---

$Id$

Copyright (C) 2011 John Willis
 
This file is part of Prefiniti.

Prefiniti is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Prefiniti is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.

--->

<cftry>
<cfinclude template="/contentmanager/cm_udf.cfm">
<cfcatch type="any">

</cfcatch>
</cftry>
<cffunction name="fwGetSidebarHeadingsEx" returntype="void">
	<cfargument name="current_association" type="numeric" required="yes"> 
     
    <cfoutput>
     	#pfGlobalLoadCheck(current_association)#
	</cfoutput>        
     
	<cfparam name="apps" default="">
    <cfset apps = pfGetInstalledApplications(current_association)>
    
    <cfoutput query="apps">
			
            
    	<a class="PWindowGCIcon" href="##">
        	<img src="/graphics/AppIconResources/#URL.PDMDefaultTheme#/32x32/apps/#AppIcon#" 
            	border="0" 
                align="absmiddle"  
                id="PLIcon_#id#" 
                onmouseover="ZoomIcon('PLIcon_#id#'); Tip('#AppName#');" 
                onmouseout="UnZoomIcon('PLIcon_#id#'); UnTip();"
                onclick="p_session.Framework.GetApplicationPanel(#id#);"/>
		</a>
            
            
            
    </cfoutput>
    
    <!---<cfparam name="ut" default="">
    <cfset ut=#session.usertype#>
    
    <cfif ut EQ 0>
    	<cfset ut="CUSTOMER">
    <cfelse>
    	<cfset ut="EMPLOYEE">
    </cfif>
    
    <cfoutput query="apps">
    	<cfif (RequiredPermissions EQ "NONE" OR getPermissionByKey("#RequiredPermissions#", session.current_association) EQ true) AND (AccountType EQ ut OR AccountType EQ "BOTH")>
    	
			<span id="PLIcon_#id#">
            
            <img src="/graphics/AppIconResources/#session.PDMDefaultTheme#/48x48/apps/#AppIcon#" width="48" onmouseover="PLHighlightApp('PLIcon_#id#', '#AppName#');" onclick="p_session.Framework.GetApplicationPanel(#id#);"/>
            </span>
        
        </cfif>
    </cfoutput>
	--->
</cffunction>

<cffunction name="pfGlobalLoadCheck" returntype="void">
	<cfargument name="current_association" type="numeric" required="yes">
    
    <cfparam name="IsInstalled" default="">
    <cfset IsInstalled = false>
    
    <!-- get a list of applications to be globally loaded -->
    <cfquery name="globalApps" datasource="webwarecl">
    	SELECT * FROM applications WHERE GlobalLoad=1
	</cfquery>        

	<!-- check to see if these applications are installed to this association -->
    <cfoutput query="globalApps">
    	<cfset IsInstalled = pfIsApplicationInstalled(id, current_association)>
        <cfparam name="rs" default="">
        <cfif IsInstalled EQ false>
        	<cfset rs = pfInstallApplication(id, current_association)>
		</cfif>
	</cfoutput>
    
    <!-- make sure the user has a Trash bin -->
    <cfquery name="uid" datasource="sites">
    	SELECT user_id FROM site_associations WHERE id=#current_association#
	</cfquery>
    <cfparam name="UserID" default="">
    <cfset UserID=#uid.user_id#>
            
    <cfquery name="ct" datasource="webwarecl">
    	SELECT * FROM folders WHERE UserID=#UserID# AND IsBin=1
    </cfquery>
    
    <cfparam name="GenCode" default="">
    <cfset GenCode = CreateUUID()>
    
    <cfif ct.RecordCount EQ 0>
    	<cfquery name="CreateTrash" datasource="webwarecl">
        	INSERT INTO folders(ParentFolderID, FolderName, UserID, GenCode, IsBin)
            VALUES (0, 'Trash Bin', #UserID#, '#GenCode#', 1)
		</cfquery>            
        <cfquery name="GetTrashFolderID" datasource="webwarecl">
        	SELECT * FROM folders WHERE GenCode='#GenCode#'
		</cfquery>
        <cfquery name="CreateTrashItem" datasource="webwarecl">
        	INSERT INTO folder_items (ItemType, ItemName, ObjectTypeID, ObjectID, TargetFolderID, ContainingFolder, UserID)
            VALUES		('FOLDER',
            			'Trash Bin',
                        0,
                        0,
                        #GetTrashFolderID.id#,
                        0,
                        #UserID#)
		</cfquery>
	</cfif>                                   
</cffunction>

<cffunction name="pfIsApplicationInstalled" returntype="boolean">
	<cfargument name="AppID" type="numeric" required="yes">
    <cfargument name="AssocID" type="numeric" required="yes">
    
    <cfquery name="pfiai" datasource="webwarecl">
    	SELECT id FROM installedapplications WHERE app_id=#AppID# AND assoc_id=#AssocID#
	</cfquery>
    
    <cfif pfiai.RecordCount EQ 0>
    	<cfreturn false>
	<cfelse>
    	<cfreturn true>
    </cfif>
</cffunction>

<cffunction name="pfInstallApplication" returntype="void">
	<cfargument name="AppID" type="numeric" required="yes">
    <cfargument name="AssocID" type="numeric" required="yes">
    
    <cfquery name="gan" datasource="webwarecl">
    	SELECT AppName FROM applications WHERE id=#AppID#
	</cfquery>        
    
    <cfquery name="pfia" datasource="webwarecl">
    	INSERT INTO installedapplications(assoc_id, app_id, AppName)
        VALUES (#AssocID#, #AppID#, '#gan.AppName#')
	</cfquery>
</cffunction>

<cffunction name="pfUninstallApplication" returntype="void">
	<cfargument name="AppID" type="numeric" required="yes">
    <cfargument name="AssocID" type="numeric" required="yes">
    
    <cfquery name="pfua" datasource="webwarecl">
    	DELETE FROM installedapplications WHERE assoc_id=#AssocID# AND app_id=#AppID#
	</cfquery>
</cffunction>                                                                    
    	

<!---id, theme, context, icon, size, clickAction, dblClickAction--->
<cffunction name="pfGetStockIcon" returntype="string">
	<cfargument name="id"  required="yes" type="string">
    <cfargument name="theme" required="yes" type="string">
    <cfargument name="context" required="yes" type="string">
    <cfargument name="icon" required="yes" type="string">
    <cfargument name="size"	 required="yes" type="string">
    <cfargument name="caption" required="yes" type="string">
    <cfargument name="view" required="yes" type="string" default="VT_ICON">
    <cfargument name="clickAction" required="yes" type="string">
    <cfargument name="dblClickAction" required="yes" type="string">
    
    
    <cfparam name="HTMLImageTag" default="">
    <cfparam name="HTMLbase" default="">
    
    
    <cfswitch expression="#view#">
    	<cfcase value="VT_ICON">
        	<cfset HTMLbase="/graphics/AppIconResources/#theme#/#size#x#size#/#context#/#icon#">
			<cfset HTMLImageTag='<div id="#id#" class="ObjectIcon" align="center"><img onmousedown="#clickAction#" name="#id#" src="#HTMLbase#"  border="0" align="absmiddle"><br><a href="##" onmousedown="#clickAction#">#caption#</a></div>'>
		</cfcase>
        <cfcase value="VT_LIST">
        	<cfset HTMLbase="/graphics/AppIconResources/#theme#/#size#x#size#/#context#/#icon#">
			<cfset HTMLImageTag='<div id="#id#" class="ObjectListItem" align="left"><label><img onmousedown="#clickAction#" id="#id#" name="#id#" src="#HTMLbase#"  ondblclick="#dblClickAction#" border="0" align="absmiddle"> <a href="##" onmousedown="#clickAction#">#caption#</a></label></div>'>
		</cfcase>
	</cfswitch>        
                    
    
    <cfreturn #HTMLImageTag#>    
</cffunction>    

<cffunction name="pfGetApplications" returntype="query">
	<cfquery name="pfga" datasource="webwarecl">
    	SELECT * FROM applications ORDER BY AppName
	</cfquery>
    
    <cfreturn #pfga#>    
</cffunction>

<cffunction name="pfGetInstalledApplications" returntype="query">
	<cfargument name="assoc_id" required="yes" type="numeric">
    
    
    <cfquery name="pfgia" datasource="webwarecl">
    	SELECT 	applications.AppName, 
        		applications.id,
                applications.AppIcon,
                applications.RequiredPermissions,
                applications.GlobalLoad,
                applications.AppDescription,
                applications.ShortName,
                applications.AccountType,
                installedapplications.assoc_id
		FROM	applications, installedapplications
        WHERE	applications.id = installedapplications.app_id
        AND		installedapplications.assoc_id = #assoc_id#
	</cfquery>
    
    <cfreturn #pfgia#>
</cffunction>                         

<cffunction name="pfGetExportedObjects" returntype="query">
	<cfargument name="AppID" required="yes" type="numeric">
    
    <cfquery name="pfgeo" datasource="webwarecl">
    	SELECT * FROM exportedobjects WHERE AppID=#AppID#
	</cfquery>
    
    <cfreturn #pfgeo#>        
</cffunction>

<cffunction name="pfObjectInformation" returntype="struct">
	<cfargument name="ObjectID" required="yes" type="numeric">
    
    <cfquery name="pfoi" datasource="webwarecl">
    	SELECT * FROM exportedobjects WHERE id=#ObjectID#
	</cfquery>
    
    <cfquery name="pfoi_app" datasource="webwarecl">
    	SELECT AppName FROM applications WHERE id=#pfoi.AppID#
	</cfquery>        
    
    <cfparam name="oi" default="">
    <cfset oi = StructNew()>
    
    <cfset oi.Description = pfoi.Description>
    <cfset oi.Icon = pfoi.Icon>
    <cfset oi.MasterTable = pfoi.MasterTable>
    <cfset oi.IDFieldName = pfoi.IDFieldName>
    <cfset oi.ObjectNameFieldName = pfoi.ObjectNameFieldName>
    <cfset oi.ObjectSiteIDFieldName = pfoi.ObjectSiteIDFieldName>
    <cfset oi.ObjectUserIDFieldName = pfoi.ObjectUserIDFieldName>
    <cfset oi.Datasource = pfoi.Datasource>
    <cfset oi.IconContext = pfoi.IconContext>
    <cfset oi.LegacyCreator = pfoi.LegacyCreator>
    <cfset oi.AppID = pfoi.AppID>
    <cfset oi.Application = pfoi_app.AppName>
    
    <cfreturn #oi#>
</cffunction> 

<cffunction name="pfGetObject" returntype="struct" output="no">
	<cfargument name="ObjectTypeID" required="yes" type="numeric">
    <cfargument name="ObjectID" required="yes" type="numeric">
    
    <cfparam name="o" default="">
    <cfset o = StructNew()>
    
    <cfparam name="r" default="">
    <cfset r = StructNew()>
    
    
    <cfset o = pfObjectInformation(ObjectTypeID)>
    
    
    <cfquery name="pfgo" datasource="#o.Datasource#">
    	SELECT 	#o.IDFieldName#, 
        		#o.ObjectNameFieldName# 
                <cfif o.ObjectSiteIDFieldName NEQ "NA">
                , #o.ObjectSiteIDFieldName#
                </cfif>
                <cfif o.ObjectUserIDFieldName NEQ "NA">
                , #o.ObjectUserIDFieldName#
                </cfif>
        FROM	#o.MasterTable#
        WHERE	#o.IDFieldName#=#ObjectID#
	</cfquery>
    
    <cfif pfgo.RecordCount GT 0>
		<cfset r.Name = Evaluate("pfgo.#o.ObjectNameFieldName#")>
    	<cfset r.ID = Evaluate("pfgo.#o.IDFieldName#")>
    <cfelse>
    	<cfset r.ID = 0>
        <cfset r.name = "__ORPHANED">
	</cfif>
    <cfreturn #r#>
</cffunction>



<cffunction name="pfObjectList" returntype="array" output="no">
	<cfargument name="ObjectTypeID" required="yes" type="numeric">
    <cfargument name="UserID" required="yes" type="numeric">
    <!---<cfargument name="SiteID" required="yes" type="numeric">--->
    
    <cfparam name="objList" default="">
    <cfparam name="objData" default="">
    
    <cfquery name="GObj" datasource="webwarecl">
    	SELECT * FROM exportedobjects WHERE id=#ObjectTypeID#
    </cfquery>
    
    <cfquery name="pfol" datasource="#GObj.Datasource#">
    	SELECT 	#GObj.ObjectNameFieldName#, #GObj.IDFieldName#
        FROM 	#GObj.MasterTable# 
        <cfif #GObj.ObjectUserIDFieldName# NEQ "NA">
	        WHERE	#GObj.ObjectUserIDFieldName#=#UserID#
		</cfif>
    	<!---WHERE 	#GObj.ObjectSiteIDFieldName#=#SiteID#
        AND		#GObj.ObjectUserIDFieldName#=#UserID#--->
	</cfquery>
    
    <cfset objList=ArrayNew(1)>
    
    <cfoutput query="pfol">
    	<cfset objData=StructNew()>
        
        <cfset objData.Name = Evaluate("pfol.#GObj.ObjectNameFieldName#")>
        <cfset objData.ID = Evaluate("pfol.#GObj.IDFieldName#")>
        <cfset objData.Icon = "#GObj.Icon#">
		<cfset objData.IconContext = "#GObj.IconContext#">
        
        #ArrayAppend(objList, objData)#
    
    </cfoutput>
    
	<cfreturn #objList#>      
</cffunction>

<!---pfCreateItem(null, URL.ContainingFolder, URL.ObjectTypeID, URL.ObjectID, URL.RefType, URL.calledByUser)--->
<cffunction name="pfCreateItem" returntype="void">
	<cfargument name="ItemName" required="yes" type="string">
    <cfargument name="ContainingFolder" required="yes" type="numeric">
    <cfargument name="ObjectTypeID" required="yes" type="numeric">
    <cfargument name="ObjectID" required="yes" type="numeric">
    <cfargument name="RefType" required="yes" type="string">
    <cfargument name="UserID" required="yes" type="numeric">
    <cfargument name="TargetFolderID" required="no" type="numeric">
    
    <cfparam name="pname" default="">
    <cfparam name="oi" default="">
    
	
    <cfif ItemName NEQ "">
    	<cfset pname = ItemName>
	<cfelse>
    	<cfset oi = pfGetObject(ObjectTypeID, ObjectID)>
    	<cfset pname = oi.Name>
	</cfif>
    
    <cfquery name="pfci" datasource="webwarecl">
    	INSERT INTO	folder_items 	(UserID,
        							ContainingFolder,
        							ItemType,
        							ItemName,
                                    ObjectTypeID,
                                    ObjectID
                                    <cfif RefType EQ "FOLDER">
                                    	, TargetFolderID
									</cfif>)
					values			(#UserID#,
                    				#ContainingFolder#,
                    				'#RefType#',
                    				'#pname#',
                                    #ObjectTypeID#,
                                    #ObjectID#
                                    <cfif RefType EQ "FOLDER">
                                    	, #TargetFolderID#
									</cfif>)
	</cfquery>    
    
    <cfoutput>
    	#pfSetObjectACL(UserID, ObjectTypeID, ObjectID, 1, 1, 1, 1)#
	</cfoutput>        
</cffunction>

<cffunction name="pfGetFolder" returntype="void" output="yes">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="FolderID" type="numeric" required="yes">
    <cfargument name="View" type="string" required="yes">
    <cfargument name="Theme" type="string" required="yes">
    
    <cfquery name="pfgf" datasource="webwarecl">
    	SELECT * FROM folder_items WHERE UserID=#UserID# AND ContainingFolder=#FolderID# ORDER BY ItemName
	</cfquery>
    
    <cfparam name="HTMLbase" default="">
	<cfparam name="HTMLImageTag" default="">
	<cfparam name="oRef" default="">
	<cfparam name="oInf" default="">
	<cfparam name="oAcl" default="">
    <cfset oAcl = StructNew()>
    
    <cfif pfgf.RecordCount EQ 0>
    	<h1 style="color:##666666; font-size:large;">Folder is empty</h3>
        
        <p style="color:##666666;">Click the <img src="http://www.prefiniti.com/graphics/AppIconResources/#URL.PDMDefaultTheme#/16x16/actions/agt_add-to-desktop.png"  align="absbottom" /> icon in the toolbar to upload files to this folder.</p>
        
        <p style="color:##666666;">You may also create documents in this folder with other Prefiniti applications.</p>
	</cfif>        
    <cfparam name="IconSize" default="">
    <cfif FolderID EQ 0>
    	<cfset IconSize = "48x48">
	<cfelse>
    	<cfset IconSize = "32x32">
	</cfif>                
    
    <cfparam name="xPos" default="">
    <cfset xPos = "5">
	<cfoutput query="pfgf">
    	<cfparam name="IconID" default="">
        <cfset IconID = "Icon_" & CreateUUID()>
        <cfset xPos = xPos + 50>
       
    	<cfswitch expression="#ItemType#">
            <cfcase value="SYSOBJ">
                <cfset oAcl = pfGetObjectACL(UserID, ObjectTypeID, ObjectID)>
                
                <cfif oAcl.View EQ 1>
					<cfset oRef = pfGetObject(ObjectTypeID, ObjectID)>
                    <cfset oInf = pfObjectInformation(ObjectTypeID)>
                    
                    
                    <cfswitch expression="#view#">
                        <cfcase value="VT_ICON">
                            <cfif ObjectTypeID EQ 4>
                                <cfparam name="fti" default="">
                                <cfset fti = cmsFileType(ObjectID, "user")>
                                
                                 <cfset HTMLImageTag='<div class="ObjectIcon" align="center" id="#IconID#" style="left:#xPos#px;"><img onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);" width="32"  src="#fti.icon#"  border="0" align="absmiddle"><br><a href="##" onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);">#ItemName#</a></div>'>
                                
                            <cfelseif ObjectTypeID EQ 5>
                                <cfparam name="fti" default="">
                                <cfset fti = cmsFileType(ObjectID, "user")>
                                
                                 <cfset HTMLImageTag='<div class="ObjectIcon" align="center" id="#IconID#"  style="left:#xPos#px;"><img onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);" width="32" src="#fti.icon#"  border="0" align="absmiddle"><br><a href="##" onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);">#ItemName#</a></div>'>
                            <cfelse>
                                <cfset HTMLbase="/graphics/AppIconResources/#Theme#/32x32/#oInf.IconContext#/#oInf.Icon#">
                                <cfset HTMLImageTag='<div class="ObjectIcon" align="center" id="#IconID#"  style="left:#xPos#px;"><img onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);"  src="#HTMLbase#"  border="0" align="absmiddle"><br><a href="##" onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);">#ItemName#</a></div>'>
                            </cfif>
                        </cfcase>
                        <cfcase value="VT_LIST">
                            <cfif ObjectTypeID EQ 4>
                                <cfparam name="fti" default="">
                                <cfset fti = cmsFileType(ObjectID, "user")>
                                
                                <cfset HTMLImageTag='<div class="ObjectListItem" align="left" id="#IconID#"  style="left:#xPos#px;"><label><img onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);" src="#fti.icon#" border="0" align="absmiddle"> <a href="##" onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);">#ItemName#</a></label><!---<br>#fti.description#---></div>'>
                            <cfelseif ObjectTypeID EQ 5> 
                                <cfparam name="fti" default="">
                                <cfset fti = cmsFileType(ObjectID, "site")>
                                
                                <cfset HTMLImageTag='<div class="ObjectListItem" align="left" id="#IconID#"  style="left:#xPos#px;"><label><img onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);" src="#fti.icon#" border="0" align="absmiddle"> <a href="##" onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);">#ItemName#</a></label><!---<br>#fti.description#---></div>'>
                            <cfelse>   
                                <cfset HTMLbase="/graphics/AppIconResources/#Theme#/32x32/#oInf.IconContext#/#oInf.Icon#">
                                <cfset HTMLImageTag='<div class="ObjectListItem" align="left" id="#IconID#"  style="left:#xPos#px;"><label><img onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null, ''#IconID#'', #id#);" src="#HTMLbase#" border="0" align="absmiddle"> <a href="##" onmousedown="PObjectClick(event, this, #ObjectTypeID#, #ObjectID#, RT_OBJECT, null,  ''#IconID#'', #id#);">#ItemName#</a></label></div>'>
                            </cfif>
                        </cfcase>
                    </cfswitch>
				</cfif>                    
                
            </cfcase>
            <cfcase value="FOLDER">
            	<cfswitch expression="#view#">
                    <cfcase value="VT_ICON">
                    	<cfif pfIsFolderTrash(TargetFolderID)>
                        	<cfset HTMLBase="/graphics/AppIconResources/#Theme#/32x32/filesystems/trashcan_empty.png">
						<cfelse>
							<cfset HTMLbase="/graphics/AppIconResources/#Theme#/32x32/filesystems/folder.png">
						</cfif>                            
                        <cfset HTMLImageTag='<div class="ObjectIcon" align="center" id="#IconID#"  style="left:#xPos#px;"><img onmousedown="PObjectClick(event, this, null, null, RT_FOLDER, #TargetFolderID#, ''#IconID#'', #id#);"  src="#HTMLbase#"  border="0" align="absmiddle"><br><a href="##" onmousedown="PObjectClick(event, this, null, null, RT_FOLDER, #TargetFolderID#, ''#IconID#'', #id#);">#ItemName#</a></div>'>
                    </cfcase>
                    <cfcase value="VT_LIST">
                       <cfif pfIsFolderTrash(TargetFolderID)>
                        	<cfset HTMLBase="/graphics/AppIconResources/#Theme#/32x32/filesystems/trashcan_empty.png">
						<cfelse>
							<cfset HTMLbase="/graphics/AppIconResources/#Theme#/32x32/filesystems/folder.png">
						</cfif> 
                        <cfset HTMLImageTag='<div class="ObjectListItem" align="left" id="#IconID#"  style="left:#xPos#px;"><label><img onmousedown="PObjectClick(event, this, null, null, RT_FOLDER, #TargetFolderID#, ''#IconID#'', #id#);" src="#HTMLbase#" border="0" align="absmiddle"> <a href="##" onmousedown="PObjectClick(event, this, null, null, RT_FOLDER, #TargetFolderID#, ''#IconID#'', #id#);">#ItemName#</a></label></div>'>
                    </cfcase>
                </cfswitch>
            </cfcase>
        </cfswitch>   
        #HTMLImageTag#  
	</cfoutput>
</cffunction>         



<cffunction name="pfGetFolderName" returntype="string">
	<cfargument name="FolderID" type="numeric" required="yes">
    
    <cfif FolderID EQ 0>
    	<cfreturn "Desktop">
	<cfelse>
    	
        <cfquery name="pfgfn" datasource="webwarecl">
        	SELECT FolderName FROM folders WHERE id=#FolderID#
		</cfquery>
        <cfreturn #pfgfn.FolderName#>            
        
	</cfif>                 
</cffunction>

<cffunction name="pfCreateFolder" returntype="void">
	<cfargument name="ContainingFolder" type="numeric" required="yes">
    <cfargument name="FolderName" type="string" required="yes">
    <cfargument name="UserID" type="string">    
    
    <cfparam name="gencode" default="">
    <cfset gencode = CreateUUID()>
    
    <cfquery name="pfcf" datasource="webwarecl">
    	INSERT INTO folders (ParentFolderID,
        					FolderName,
                            UserID,
                            GenCode)
					VALUES (#ContainingFolder#,
                    		'#FolderName#',
                            #UserID#,
                            '#gencode#')
	</cfquery>
    
    <cfquery name="pfcf_gi" datasource="webwarecl">
    	SELECT id FROM folders WHERE GenCode='#gencode#'
	</cfquery>        
    
    <cfoutput>#pfCreateItem(FolderName, ContainingFolder, 0, 0, "FOLDER", UserID, pfcf_gi.id)#</cfoutput>
</cffunction>    
    	        


<cffunction name="pfFolderPath" returntype="string" output="no">
	<cfargument name="FolderID" type="numeric" required="yes">
    
    <cfparam name="ParentFolder" default="">
    <cfset ParentFolder = FolderID>
    
    <cfparam name="tmp" default="">
    <cfset tmp = "">
    <cfparam name="ct" default="">
    <cfset ct = 0>
    
    <cfloop condition="ParentFolder NEQ 0">
    	<cfset ct = ct + 1>
        <cfquery name="gNP" datasource="webwarecl">
        	SELECT 	ParentFolderID, FolderName, id 
            FROM	folders
            WHERE	id=#ParentFolder#
		</cfquery>
        
        <cfset ParentFolder = gNP.ParentFolderID>
      
        <cfif ParentFolder NEQ 0>
        	<cfset tmp = '&gt; <a href="####" onclick="POpenFolder(#gNP.id#);">#gNP.FolderName#</a> #tmp#'>
        <cfelse>
        	<cfset tmp = '<a href="####" onclick="POpenFolder(#gNP.id#);">#gNP.FolderName#</a> #tmp#'>	
		</cfif>         
    </cfloop>
    
    <cfreturn '<span class="PBreadCrumb">Desktop &gt; #tmp#</span>'>
</cffunction>

<cffunction name="pfFolderPathPlain" returntype="string" output="no">
	<cfargument name="FolderID" type="numeric" required="yes">
    
    <cfparam name="ParentFolder" default="">
    <cfset ParentFolder = FolderID>
    
    <cfparam name="tmp" default="">
    <cfset tmp = "">
    <cfparam name="ct" default="">
    <cfset ct = 0>
    
    <cfloop condition="ParentFolder NEQ 0">
    	<cfset ct = ct + 1>
        <cfquery name="gNPP" datasource="webwarecl">
        	SELECT 	ParentFolderID, FolderName, id 
            FROM	folders
            WHERE	id=#ParentFolder#
		</cfquery>
        
        <cfset ParentFolder = gNPP.ParentFolderID>
      
      
        <cfset tmp = "#gNPP.FolderName#/#tmp#">
                
    </cfloop>
    <cfif tmp EQ "">
    	<cfreturn "Desktop">
	<cfelse>
    	<cfreturn #tmp#>
	</cfif>        
</cffunction>

<cffunction name="pfGetObjectReferences" returntype="query">
	<cfargument name="ObjectTypeID" type="numeric" required="yes">
    <cfargument name="ObjectID" type="numeric" required="yes">
    
    <cfquery name="pfgor" datasource="webwarecl">
    	SELECT * 
        FROM 	folder_items 
        WHERE 	ObjectTypeID=#ObjectTypeID#
        AND		ObjectID=#ObjectID#
	</cfquery>        
    
    <cfreturn #pfgor#>
</cffunction>    

<cffunction name="pfFolderTree" returntype="void" output="yes">
	<cfargument name="UserID" type="numeric" required="yes">
    <cfargument name="Filter" type="string" required="yes">
    <cfargument name="FolderToHighlight" type="numeric" required="yes">
    <cfargument name="OnFolderClick" type="string" required="yes">
    <cfargument name="OnObjectClick" type="string" required="yes">
        
    <cfquery name="pfft" datasource="webwarecl">
    	SELECT * FROM folders WHERE ParentFolderID=0 AND UserID=#UserID# ORDER BY FolderName
	</cfquery>
    <img src="/graphics/AppIconResources/crystal_project/16x16/filesystems/desktop.png" align="absmiddle" /> Desktop<br />
    
    
	<cfoutput query="pfft">
    <cfparam name="basename" default="">
    <cfif id EQ FolderToHighlight>
    	<cfset basename = "<strong>#FolderName#</strong>">
	<cfelse>
        <cfset basename = "#FolderName#">
	</cfif>
    <div class="PTreeBlock" style="border:none;">
    	<img onclick="PShowHideTreeBlock('PTreeF_#id#');" src="/graphics/AppIconResources/crystal_project/16x16/filesystems/folder.png" align="absmiddle" /> <a href="##" onclick="#OnFolderClick#(#id#)">#basename#</a><br />
    <div class="PTreeBlock" id="PTreeF_#id#">
        #pfFolderContents(id, Filter, FolderToHighlight, OnFolderClick, OnObjectClick)#
	
    </div>
    </div>

	</cfoutput>
</cffunction>

<cffunction name="pfFolderContents" returntype="void" output="yes">
	<cfargument name="FolderID" type="numeric" required="yes">
    <cfargument name="Filter" type="string" required="yes">
    <cfargument name="FolderToHighlight" type="numeric" required="yes">
    <cfargument name="OnFolderClick" type="string" required="yes">
    <cfargument name="OnObjectClick" type="string" required="yes">
    
    <cfquery name="pffc" datasource="webwarecl">
    	SELECT * FROM folder_items WHERE ContainingFolder=#FolderID# ORDER BY ItemName
	</cfquery>
    
    <cfoutput query="pffc">
    <cfswitch expression="#ItemType#">
    	<cfcase value="FOLDER">
        	<cfparam name="basename" default="">
            <cfif TargetFolderID EQ FolderToHighlight>
            	<cfset basename = "<strong>#ItemName#</strong>">
			<cfelse>
            	<cfset basename = "#ItemName#">
			</cfif>                                
	                
        	<img onclick="PShowHideTreeBlock('PTreeF_#TargetFolderID#');" src="/graphics/AppIconResources/crystal_project/16x16/filesystems/folder.png" align="absmiddle" /> <a href="##" onclick="#OnFolderClick#(#TargetFolderID#)">#basename#</a><br />
            <div id="PTreeF_#TargetFolderID#" style="display:block;" class="PTreeBlock">
        	 #pfFolderContents(TargetFolderID, Filter, FolderToHighlight, OnFolderClick, OnObjectClick)#
			</div>
		</cfcase>
        <cfcase value="SYSOBJ">
			<cfif Filter NEQ "FOLDERSONLY">
            #ItemName#<br />
            </cfif>
		</cfcase>
	</cfswitch>                    
	</cfoutput>
    
</cffunction>

<cffunction name="pfObjectEditor" returntype="void" output="yes">

</cffunction>

<cffunction name="pfObjectViewer" returntype="void" output="yes">

</cffunction>

<cffunction name="pfObjectCreator" returntype="void" output="yes">

</cffunction>

<cffunction name="pfGetRelatedObjects" returntype="array" output="no">
	<cfargument name="OTID" type="numeric" required="yes">
	<cfargument name="OIID" type="numeric" required="yes">
	
	<cfparam name="tLst" default="">
	<cfset tLst = ArrayNew(1)>
	
	
	<cfquery name="pfgro" datasource="webwarecl">
		SELECT * FROM object_relationships 
		WHERE 	(SourceOTID=#OTID# AND SourceOIID=#OIID#)
		OR		(DestOTID=#OTID# AND DestOIID=#OIID#)
	</cfquery>
	
	
	
	<cfparam name="tEnt" default="">
	<cfset tEnt = StructNew()>
	
	
	<cfoutput query="pfgro">
		<cfset tEnt.DestOTID=#DestOTID#>
		<cfset tEnt.DestOIID=#DestOIID#>
		<cfset tEnt.SourceOTID=#SourceOTID#>
		<cfset tEnt.SourceOIID=#SourceOIID#>
		<cfset tEnt.Description="#Description#">
		#ArrayAppend(tLst, tEnt)#
	</cfoutput>

	<cfreturn tLst>
</cffunction>

<!--- deletor is instantiated only through PAF javascript call --->

<cffunction name="pfSetObjectACL" returntype="void">
	<cfargument name="UserID" type="numeric" required="yes">
	<cfargument name="ObjectTypeID" type="numeric" required="yes">
    <cfargument name="ObjectID" type="numeric" required="yes">
    <cfargument name="View" type="numeric" required="yes">
    <cfargument name="Edit" type="numeric" required="yes">
    <cfargument name="Delete" type="numeric" required="yes">
    <cfargument name="Add" type="numeric" required="yes">
    
    <cfquery name="pfsoa_cx" datasource="webwarecl">
    	SELECT id
        FROM	object_acl
        WHERE	ObjectTypeID=#ObjectTypeID#
        AND		ObjectID=#ObjectID#
        AND		UserID=#UserID#
	</cfquery>
    
    <cfif pfsoa_cx.RecordCount EQ 0> 		
		<!--- the ACL does not exist; create it --->        
    	<cfquery name="pfsoa_create" datasource="webwarecl">
        	INSERT INTO object_acl(UserID,
            						ObjectTypeID,
                                    ObjectID,
                                    PView,
                                    PEdit,
                                    PDelete,
                                    PAdd)
			VALUES (#UserID#,
            		#ObjectTypeID#,
                    #ObjectID#,
                    #View#,
                    #Edit#,
                    #Delete#,
                    #Add#)
		</cfquery>
	<cfelse>
    	<!--- the ACL exists; update it --->
        <cfquery name="pfsoa_update" datasource="webwarecl">
        	UPDATE object_acl
            SET	PView=#View#,
            	PEdit=#Edit#,
                PDelete=#Delete#,
                PAdd=#Add#
			WHERE	UserID=#UserID#
            AND		ObjectTypeID=#ObjectTypeID#
            AND		ObjectID=#ObjectID#
		</cfquery>
	</cfif>
</cffunction>

<cffunction name="pfGetObjectACL" returntype="struct">
	<cfargument name="UserID" type="numeric" required="yes">
	<cfargument name="ObjectTypeID" type="numeric" required="yes">
    <cfargument name="ObjectID" type="numeric" required="yes">
    
    <cfparam name="tmp" default="">
    <cfset tmp = StructNew()>
	
    <cfquery name="gAcl" datasource="webwarecl">
    	SELECT * FROM object_acl 
        WHERE 	UserID=#UserID#
        AND		ObjectTypeID=#ObjectTypeID#
        AND		ObjectID=#ObjectID#
	</cfquery>
    
    <cfoutput query="gAcl">
    	<cfset tmp.View = PView>
        <cfset tmp.Edit = PEdit>
        <cfset tmp.Delete = PDelete>
        <cfset tmp.Add = PAdd>
    </cfoutput>        
    
    <cfif gAcl.RecordCount EQ 0>
    	<cfset tmp.View = 0>
        <cfset tmp.Edit = 0>
        <cfset tmp.Delete = 0>
        <cfset tmp.Add = 0>
	</cfif>
            
    <cfreturn #tmp#>
</cffunction>    

<cffunction name="pfFolderExists" returntype="boolean">
	<cfargument name="FolderID" type="numeric" required="yes">
    
    <cfquery name="pffe" datasource="webwarecl">
    	SELECT * FROM folders WHERE id=#FolderID#
	</cfquery>
    
    <cfif pffe.RecordCount EQ 0>
    	<cfreturn false>
	<cfelse>
    	<cfreturn true>
	</cfif>
</cffunction>

<cffunction name="pfObjectExists" returntype="boolean">
	<cfargument name="ObjectTypeID" type="numeric" required="yes">
    <cfargument name="ObjectID" type="numeric" required="yes">
    
    <cfparam name="oi" default="">
    <cfset oi = pfGetObject(ObjectTypeID, ObjectID)>
    
    <cfif oi.id NEQ 0>
    	<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>                
    
</cffunction>  

<cffunction name="pfDeleteObjectByID" returntype="void">
	<cfargument name="ID" type="numeric" required="yes">
    
    <cfquery name="pfdobi" datasource="webwarecl">
    	DELETE FROM folder_items WHERE id=#ID#
	</cfquery>
</cffunction> 

<cffunction name="pfIsFolderTrash" returntype="boolean">
	<cfargument name="TargetFolderID" type="numeric" required="yes">
    
    <cfquery name="IsTrash" datasource="webwarecl">
		SELECT id, IsBin FROM folders WHERE id=#TargetFolderID#
	</cfquery>
    
    <cfif IsTrash.IsBin EQ 1>
    	<cfreturn true>     
	<cfelse>
    	<cfreturn false>
	</cfif>
</cffunction>

<cffunction name="pfGetCartObject" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
	
	<cfquery name="ge" datasource="webwarecl">
		SELECT * FROM shopping_carts WHERE user_id=#user_id# AND submitted=0
	</cfquery>
	
	<cfif ge.RecordCount GT 0>
		<cfreturn #ge.id#>
	<cfelse>
		<cfparam name="uu" default="">
		<cfset uu = CreateUUID()>
		
		<cfparam name="on" default="">
		<cfset on = "PFO-" & uu>
		 
		<cfquery name="cnc" datasource="webwarecl">
			INSERT INTO shopping_carts
				(user_id,
				order_id,
				om_uuid,
				submitted,
				opened_date)
			VALUES
				(#user_id#,
				'#on#',
				'#uu#',
				0,
				#CreateODBCDateTime(Now())#)
		</cfquery>
				
		<cfquery name="cid" datasource="webwarecl">
			SELECT id FROM shopping_carts WHERE om_uuid='#uu#'
		</cfquery>
		
		<cfreturn #cid.id#>
	</cfif>
</cffunction>	

<cffunction name="FormatPrice" returntype="string">
	<cfargument name="InputPrice" required="yes" type="numeric">
	
	<cfreturn NumberFormat(InputPrice, ",$_.__")>
</cffunction>

<cffunction name="CartItemSubtotal" returntype="numeric">
	<cfargument name="item_id" required="yes" type="numeric">
	<cfargument name="quantity" required="yes" type="numeric">
	
	<cfquery name="cis" datasource="webwarecl">
		SELECT UnitPrice FROM Product_Catalog WHERE id=#item_id#
	</cfquery>
	
	<cfparam name="tp" default="">
	<cfset tp = cis.UnitPrice * quantity>

	<cfreturn #tp#>
</cffunction>	

<cffunction name="GetTax" returntype="numeric">
	<cfargument name="InputVal" type="numeric" required="yes">
	<cfargument name="SiteID" type="numeric" required="yes">
	
	<cfquery name="gtr" datasource="sites">
		SELECT salestax_rate FROM sites WHERE SiteID=#SiteID#
	</cfquery>
	
	<cfparam name="tr" default="">
	<cfset tr = gtr.salestax_rate / 100>
	
	<cfparam name="tax" default="">
	<cfset tax = InputVal * tr>
	
	<cfreturn #tax#>	
</cffunction>


<cffunction name="GetSiteName" returntype="string">
	<cfargument name="site_id" type="numeric" required="yes">
	
	<cfquery name="sn" datasource="sites">
		SELECT SiteName FROM sites WHERE SiteID=#site_id#
	</cfquery>
	
	<cfreturn #sn.SiteName#>
</cffunction>			

<cffunction name="GetSiteLogo" returntype="string">
	<cfargument name="site_id" type="numeric" required="yes">
	
	<cfquery name="sl" datasource="sites">
		SELECT logo FROM sites WHERE SiteID=#site_id#
	</cfquery>
	
	<cfparam name="logoBase" default="">
	<cfset logoBase = "/SiteContent/" & site_id & "/" & sl.logo>
	
	<cfreturn #logoBase#>
</cffunction>	

<cffunction name="CartToOrder" returntype="void">
	<cfargument name="CartID" type="numeric" required="yes">
	<cfargument name="Location" type="numeric" required="yes">
	<cfargument name="PayProfile" type="numeric" required="yes">
	<cfargument name="fulfillment_method" type="string" required="yes">
	
	
	<cfquery name="FullCart" datasource="webwarecl">
		SELECT 		cart_item.item_id,
					cart_item.quantity,
					catalog_item.ProductName,
					catalog_item.UnitPrice,
					catalog_item.site_id
		FROM		shopping_cart_items cart_item
		INNER JOIN	product_catalog catalog_item
		ON			cart_item.item_id = catalog_item.id
		WHERE		cart_item.cart_id = #CartID#
		ORDER BY	site_id, ProductName
		ASC
	</cfquery>

	<cfquery name="VendorsInCart" dbtype="query">
		SELECT DISTINCT site_id FROM FullCart
	</cfquery>
	
	<cfoutput query="VendorsInCart">
		#CreateOrder(CartID, site_id, Location, PayProfile, fulfillment_method)#
	</cfoutput>
		
</cffunction>

<cffunction name="CreateOrder" returntype="void">
	<cfargument name="CartID" type="numeric" required="yes">
	<cfargument name="VendorID" type="numeric" required="yes">
	<cfargument name="Location" type="numeric" required="yes">
	<cfargument name="PayProfile" type="numeric" required="yes">
	<cfargument name="fulfillment_method" type="string" required="yes">
	
	<cfparam name="ui" default="">
	<cfset ui = CreateUUID()>
	
	<!--- get the cart headers --->
	<cfquery name="COCart" datasource="webwarecl">
		SELECT * FROM shopping_carts WHERE id=#CartID#
	</cfquery>
	
	<!--- get the cart items --->
	<cfquery name="COCartItems" datasource="webwarecl">
		SELECT 		cart_item.item_id,
					cart_item.quantity,
					catalog_item.ProductName,
					catalog_item.ProductWeight,
					catalog_item.ItemNumber,
					catalog_item.UnitPrice,
					catalog_item.site_id,
					catalog_item.id
		FROM		shopping_cart_items cart_item
		INNER JOIN	product_catalog catalog_item
		ON			cart_item.item_id = catalog_item.id
		WHERE		cart_item.cart_id = #CartID#
		AND			catalog_item.site_id = #VendorID#
		ORDER BY	site_id, ProductName
		ASC
	</cfquery>
	
	<!--- create the empty order --->
	<cfquery name="COrder" datasource="webwarecl">
		INSERT INTO orders
			(vendor_id,
			customer_id,
			stage,
			fulfillment_method,
			fulfillment_location,
			payment_profile,
			om_uuid,
			order_date)
		VALUES
			(#VendorID#,
			#COCart.user_id#,
			0,   
			'#fulfillment_method#',
			#Location#,
			#PayProfile#,
			'#ui#',
			#CreateODBCDateTime(Now())#)
	</cfquery>
	
	<!--- get the id of the new order --->
	<cfquery name="GetOrderID" datasource="webwarecl">
		SELECT id FROM orders WHERE om_uuid='#ui#'
	</cfquery>

	<cfoutput><h1>Order #GetOrderID.id#</h1></cfoutput>

	<!--- set the cart's status to SUBMITTED --->
	<cfquery name="SubmitCart" datasource="webwarecl">
		UPDATE shopping_carts
		SET	submitted=1,
		submitted_date=#CreateODBCDateTime(Now())#
		WHERE id=#CartID#
	</cfquery>			

	<!--- make a deep copy of the catalog entries --->
	<cfoutput query="COCartItems">
		#CreateOrderItem(id,
						ProductName,
						ItemNumber,
						ProductWeight,
						quantity,
						UnitPrice,
						GetOrderID.id,
						COCart.user_id)#
	</cfoutput>
</cffunction>	

<cffunction name="CreateOrderItem" returntype="void">
	<cfargument name="OriginalCatalogID" type="numeric" required="yes">
	<cfargument name="ProductName" type="string" required="yes">
	<cfargument name="ItemNumber" type="string" required="yes">
	<cfargument name="ProductWeight" type="numeric" required="yes">
	<cfargument name="QuantityOrdered" type="numeric" required="yes">
	<cfargument name="UnitPrice" type="numeric" required="yes">
	<cfargument name="order_id" type="numeric" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
	
	<cfoutput>#QuantityOrdered# of '#ProductName#' (#FormatPrice(UnitPrice)#)<br /></cfoutput>
	
	<cfquery name="COI" datasource="webwarecl">
		INSERT INTO order_items
			(OriginalCatalogID,
			ProductName,
			ItemNumber,
			ProductWeight,
			QuantityOrdered,
			UnitPrice,
			order_id,
			om_uuid)
		VALUES
			(#OriginalCatalogID#,
			'#ProductName#',
			'#ItemNumber#',
			#ProductWeight#,
			#QuantityOrdered#,
			#UnitPrice#,
			#order_id#,
			'#CreateUUID()#')
	</cfquery>
	
	<cfquery name="gq" datasource="webwarecl">
		SELECT quantifiable FROM product_catalog WHERE id=#OriginalCatalogID#
	</cfquery>
	
	<cfif gq.quantifiable EQ 1>
		<cfoutput>#DecrementQOH(OriginalCatalogID, QuantityOrdered, order_id)#</cfoutput>
	</cfif>
</cffunction>							

<cffunction name="DecrementQOH" returntype="void" output="no">
	<cfargument name="ProductID" type="numeric" required="yes">
	<cfargument name="DecValue" type="numeric" required="yes">
	<cfargument name="OrderID" type="numeric" required="yes">
	
	<cfquery name="goqoh" datasource="webwarecl">
		SELECT QuantityOnHand FROM product_catalog WHERE id=#ProductID#
	</cfquery>
	
	<cfif DecValue GT goqoh.QuantityOnHand>
		<cfset DecValue = goqoh.QuantityOnHand>
		
		<cfparam name="et" default="">
		<cfset et = "Only #goqoh.QuantityOnHand# of '#Product(ProductID)#' was available. Your order was automatically adjusted.">
		
		
		<cfoutput>#AnnotateOrder(OrderID, 743, et)#</cfoutput>
	</cfif>
	<cfquery name="dqoh" datasource="webwarecl">
		UPDATE product_catalog SET QuantityOnHand = QuantityOnHand - #DecValue# WHERE id=#ProductID#
	</cfquery>
	<cfquery name="uoo" datasource="webwarecl">
		UPDATE order_items SET QuantityOrdered = #goqoh.QuantityOnHand# WHERE order_id = #OrderID#
	</cfquery>		
</cffunction>
	
<cffunction name="Bool2Num" returntype="numeric">
	<cfargument name="IVal" type="boolean" required="yes">
	
	<cfif IVal EQ true>
		<cfreturn 1>
	<cfelse>
		<cfreturn 0>
	</cfif>
</cffunction>

<cffunction name="ComparePrice" returntype="void" output="yes">
	<cfargument name="CatalogID" required="yes" type="numeric">
	<cfargument name="Price" required="yes" type="numeric">
	
	
	<cfquery name="SCCP" datasource="webwarecl">
		SELECT UnitPrice FROM product_catalog WHERE id=#CatalogID#
	</cfquery>
	
	<cfif SCCP.UnitPrice GT Price>
		<img src="/graphics/arrow_up.png" align="absmiddle"/>
		
		<cfoutput>
			#FormatPrice(SCCP.UnitPrice - Price)#
		</cfoutput>
	</cfif>
	
	<cfif SCCP.UnitPrice LT Price>
		<img src="/graphics/arrow_down.png" align="absmiddle"/>
		
		<cfoutput>
			#FormatPrice(Price - SCCP.UnitPrice)#
		</cfoutput>
	</cfif>
	
	<cfif SCCP.UnitPrice EQ Price>
		<strong style="color:green;">No Change</strong>
	</cfif>
</cffunction>

<cffunction name="Category" returntype="string" output="no">
	<cfargument name="CategoryID" required="yes" type="numeric">
	
	<cfquery name="c" datasource="webwarecl">
		SELECT category_name FROM product_categories WHERE id=#CategoryID#
	</cfquery>
	
	<cfreturn #c.category_name#>
</cffunction>

<cffunction name="Product" returntype="string" output="no">
	<cfargument name="ProductID" type="numeric" required="yes">
	
	<cfquery name="p" datasource="webwarecl">
		SELECT ProductName FROM product_catalog WHERE id=#ProductID#
	</cfquery>
	
	<cfreturn #p.ProductName#>
</cffunction>

<cffunction name="AnnotateOrder" returntype="void" output="no">
	<cfargument name="OrderID" type="numeric" required="yes">
	<cfargument name="UserID" type="numeric" required="yes">
	<cfargument name="Annotation" type="string" required="yes">
	
	<cfquery name="AO" datasource="webwarecl">
		INSERT INTO order_annotations
			(order_id,
			user_id,
			annotation_date,
			annotation)
		VALUES
			(#OrderID#,
			#UserID#,
			#CreateODBCDateTime(Now())#,
			'#Annotation#')
	</cfquery>
</cffunction>