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

<cfcomponent displayname="file" hint="Represents an ORMS-managed file.">

	<cfset this.r_pk = 0>
	<cfset this.target_uuid = "">
    <cfset this.file_uuid = "">
    <cfset this.original_filename = "">
    <cfset this.file_extension = "">
    <cfset this.mime_type = "">
    <cfset this.mime_subtype = "">
    <cfset this.file_size = 0>
    <cfset this.post_date = "">
    <cfset this.poster_id = 0>    
    <cfset this.new_filename = "">
    <cfset this.keywords = "">
    
    <cfset this.written = false>
        
	<cffunction name="Create" access="public" returntype="cms.file">
		<cfargument name="target_uuid" type="string" required="yes">
        <cfargument name="original_filename" type="string" required="yes">
        <cfargument name="new_filename" type="string" required="yes">
        <cfargument name="file_extension" type="string" required="yes">
        <cfargument name="mime_type" type="string" required="yes">
        <cfargument name="mime_subtype" type="string" required="yes">
        <cfargument name="file_size" type="numeric" required="yes">
        <cfargument name="poster" type="authentication.user" required="yes">
        <cfargument name="keywords" type="string" required="yes">
        
        <cfset this.file_uuid = CreateUUID()>
        <cfset this.target_uuid = target_uuid>
        <cfset this.original_filename = original_filename>
        <cfset this.file_extension = file_extension>
        <cfset this.mime_type = mime_type>
        <cfset this.mime_subtype = mime_subtype>
		<cfset this.file_size = file_size>        
    	<cfset this.poster_id = poster.r_pk>    
        <cfset this.post_date = CreateODBCDateTime(Now())>
        <cfset this.new_filename = new_filename>
        <cfset this.keywords = keywords>
        		
		<cfreturn #this#>
	</cffunction>
    
    <cffunction name="Save" access="public" output="no" returntype="void">
    	<cfif this.written>
      		<cfset this.UpdateExistingRecord()>
    	<cfelse>
      		<cfset this.WriteAsNewRecord()>
    	</cfif>
    	<!--- <cfmodule template="/authentication/Users/orms_do.cfm" id="#this.r_pk#"> --->
        <cfset this.written = true>
  	</cffunction>
    
    <cffunction name="UpdateExistingRecord" access="public" output="no" returntype="void">
    	<cfquery name="uer" datasource="webwarecl">
        
        </cfquery>       
	</cffunction>
    
    <cffunction name="WriteAsNewRecord" access="public" output="no" returntype="void">
    	<cfquery name="wanr" datasource="webwarecl">
        	INSERT INTO orms_files
            			(om_uuid,
                        poster_id,
                        post_date,
                        original_filename,
                        new_filename,
                        file_uuid,
						mime_type,
                        mime_subtype,
                        file_size,
                        keywords)
			VALUES		('#this.target_uuid#',
            			#this.poster_id#,
                        #this.post_date#,
                        '#this.original_filename#',
                        '#this.new_filename#',
                        '#this.file_uuid#',
                        '#this.mime_type#',
                        '#this.mime_subtype#',
                        #this.file_size#,
                        '#this.keywords#')                                                                       
        </cfquery>
        
        <cfquery name="wanr_id" datasource="webwarecl">
        	SELECT id FROM orms_files WHERE file_uuid='#this.file_uuid#'
        </cfquery>
        
        <cfset this.r_pk = wanr_id.id>                        
    </cffunction>
    
</cfcomponent>