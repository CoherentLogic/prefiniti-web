<!--- ISystemObject.cfc $Revision: 1.4 $ --->
<cfinterface displayname="ISystemObject" hint="System objects must implement this interface.">

		<cffunction name="OpenByDBKey" access="public" returntype="OpenHorizon.Datatypes.ReturnValue" output="false">
			<cfargument name="DBKey" type="numeric" required="yes">     
		</cffunction>

	     <cffunction name="Save" access="public" output="false" returntype="OpenHorizon.Datatypes.ReturnValue">
	     </cffunction>

	     <cffunction name="Delete" access="public" output="false" returntype="OpenHorizon.Datatypes.ReturnValue">
	     </cffunction>

</cfinterface>