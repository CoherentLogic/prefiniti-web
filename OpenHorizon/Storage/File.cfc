<cfcomponent displayname="File" hint="Represents an Open Horizon File" extends="OpenHorizon.Framework" implements="OpenHorizon.ISystemObject">
	<cfset this.file_id = "">
	<cfset this.orms_id = "">
	<cfset this.poster = "">
	<cfset this.post_date = "">
	<cfset this.post_name = "">
	<cfset this.post_edited = 0>
	<cfset this.written = false>
	
	<cffunction name="Create" access="public" returntype="OpenHorizon.Storage.File" output="false">
		<cfargument name="file_id" type="string" required="yes">
		<cfargument name="orms_id" type="string" required="yes">
		<cfargument name="poster" type="OpenHorizon.Identity.User" required="yes">
		<cfargument name="post_name" type="string" required="yes">
		
		<cfif this.written>
			<cfreturn #this#>
		</cfif>
		
		<cfset pd = this.PathDelimiter>
		<cfset sr = this.StorageRoot>
		
		<cfset this.file_id = file_id>
		<cfset this.orms_id = orms_id>
		<cfset this.poster = poster>
		<cfset this.post_name = post_name>
		<cfset this.post_edited = 0>
		<cfset this.post_date = CreateODBCDateTime(Now())>
		<cfset this.written = false>
		
		<cfreturn #this#>
	</cffunction>
	
	<cffunction name="Open" access="public" returntype="OpenHorizon.Storage.File" output="false">
		<cfargument name="file_id" type="string" required="yes">
		
		<cfquery name="qryOpen" datasource="#this.BaseDatasource#">
			SELECT * FROM orms_files WHERE file_id='#file_id#'
		</cfquery>

		<cfset this.file_id = qryOpen.file_id>
		<cfset this.orms_id = qryOpen.orms_id>
		<cfset t_poster = CreateObject("component", "OpenHorizon.Identity.User")>
		<cfset t_poster.OpenByDBKey(qryOpen.poster_id)>
		<cfset this.poster = t_poster>
		<cfset this.post_name = qryOpen.post_name>
		<cfset this.post_edited = qryOpen.post_edited>
		<cfset this.post_date = qryOpen.post_date>
		<cfset this.written = true>
		
		<cfreturn #this#>
	</cffunction>
	
	<cffunction name="Stage" access="public" returntype="boolean" output="false" hint="Copy this file to ToUser's staging area">
		<cfargument name="ToUser" type="OpenHorizon.Identity.User" required="yes">
		
		<cfset source_file = this.poster.StorageArea() & this.PathDelimiter & this.post_name>
		<cfset target_dir = ToUser.StagingArea() & this.PathDelimiter>
		
		<cfset task_name = "orms_destage_" & this.file_id>
		<cfset task_date = DateAdd("d", 30, Now())>
		

		<cfschedule action="update"
        task = "#task_name#" 
        operation = "HTTPRequest"
        url = "http://#this.URLBase#/orms/orms_file_destage.cfm?file_id=#this.file_id#"
        startDate = "#DateFormat(task_date, "mm/dd/yyyy")#"
        startTime = "12:00 AM"
        interval = "once"
        resolveURL = "Yes">
		
		<cffile action="copy" source="#source_file#" destination="#target_dir#">
		<cfreturn true>
	</cffunction>
	
	<cffunction name="Destage" access="public" returntype="boolean" output="false" hint="Remove this file from ToUser's staging area">
		<cfargument name="ToUser" type="OpenHorizon.Identity.User" required="yes">
		
		<cfset target_file = ToUser.StagingArea() & this.PathDelimiter & this.post_name>
		
		<cffile action="delete" file="#target_file#">
	</cffunction>
		
	<cffunction name="OpenByDBKey" access="public" returntype="OpenHorizon.Datatypes.ReturnValue" output="false">
		<cfargument name="DBKey" type="numeric" required="yes">     
	
		<cfset retVal = createObject("component", "OpenHorizon.Datatypes.ReturnValue").Create(true, "", "", this)>
		<cfreturn #retVal#>
	</cffunction>

    
	<cffunction name="WriteAsNewRecord" displayname="WriteAsNewRecord" hint="Write this file object to the database" access="public" output="no" returntype="boolean">
    	<cfquery name="qwanr" datasource="#this.BaseDatasource#">
			INSERT INTO orms_files
				(file_id,
				orms_id,
				poster_id,
				post_date,
				post_name,
				post_edited)
			VALUES
				('#this.file_id#',
				'#this.orms_id#',
				#this.poster.DBKey#,
				#this.post_date#,
				'#this.post_name#',
				#this.post_edited#)
		</cfquery>
		
		<cfset this.written = true>
		<cfreturn true>						
	</cffunction>
	
	<cffunction name="UpdateExistingRecord" displayname="UpdateExistingRecord" hint="Update this file object in the database" returntype="boolean" access="public">
    
    	<cfif NOT this.written>
        	<cfreturn false>
        </cfif>
		
		<cfset this.post_edited = 1>
		
		<cfquery name="quer" datasource="#this.BaseDatasource#">	
			UPDATE 	orms_files
			SET		file_id='#this.file_id#',
					orms_id='#this.orms_id#',
					poster_id=#this.poster.DBKey#,
					post_name='#this.post_name#',
					post_edited=#this.post_edited#
			WHERE	file_id='#this.file_id#'
		</cfquery>
		
		<cfset this.written = true>
		<cfreturn true>
	</cffunction>
	
	
	<cffunction name="Save" access="public" output="false" returntype="OpenHorizon.Datatypes.ReturnValue">
    	<cfparam name="retVal" default="">
       	<cfif NOT this.written>
        	<cfset retVal = this.WriteAsNewRecord()>
		<cfelse>
        	<cfset retVal = this.UpdateExistingRecord()>
		</cfif>                        
        
		<cfset retVal = createObject("component", "OpenHorizon.Datatypes.ReturnValue").Create(true, "", "", this)>
		<cfreturn #retVal#>
	</cffunction>

    <cffunction name="Delete" access="public" output="false" returntype="OpenHorizon.Datatypes.ReturnValue">
    
		<cfset retVal = createObject("component", "OpenHorizon.Datatypes.ReturnValue").Create(true, "", "", this)>
		<cfreturn #retVal#>
	</cffunction>
	
	<cffunction name="RecentUploads" access="public" output="false" hint="Returns a query containing the most recent uploads for poster" returntype="query">
		<cfargument name="poster" hint="The User object for the posting user for whom to obtain recent uploads" type="OpenHorizon.Identity.User" required="yes">
		
		<cfquery name="qryRecentUploads" datasource="#this.BaseDatasource#">
			SELECT * FROM orms_files WHERE poster_id=#poster.DBKey# AND post_edited=0
		</cfquery>
		
		<cfquery name="qrySetEdited" datasource="#this.BaseDatasource#">
			UPDATE orms_files SET post_edited=1 WHERE poster_id=#poster.DBKey#
		</cfquery>
		
		<cfreturn #qryRecentUploads#>
	</cffunction>
	
	
	
</cfcomponent>