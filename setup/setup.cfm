<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Prefiniti Setup</title>
	<link rel="stylesheet" type="text/css" href="../css/gecko.css" />
	<style type="text/css">
		.setup_box {
			text-align:center; 
			width:500px; 
			height:auto; 
			margin-left:auto; 
			margin-right:auto; 
			margin-top:40px; 
			border:1px solid #c0c0c0;
			padding:40px;
			font-family:"Segoe UI", Tahoma, Verdana, Arial, Helvetica, sans-serif;
		}
		input {
			border:1px solid #c0c0c0;
			margin:5px;
			padding:5px;
			font-family:"Segoe UI", Verdana, Arial, Helvetica, sans-serif;
		}
		
		select {
			border:1px solid #c0c0c0;
			margin:5px;
			padding:5px;
			font-family:"Segoe UI", Verdana, Arial, Helvetica, sans-serif;
		}
		td {
			font-size:14px;
			font-weight:lighter;
			color:#2957a2;
			font-family:"Segoe UI", Verdana, Arial, Helvetica, sans-serif;
			
		}
		table {
			width: 350px;
			margin:auto;
		}
	</style>
</head>

<cfset base_url = "http://" & CGI.HTTP_HOST & "/">
<cfset root_path_endpos = Find(CGI.SCRIPT_NAME, CGI.CF_TEMPLATE_PATH)>
<cfset root_path = Left(CGI.CF_TEMPLATE_PATH, root_path_endpos - 1)>

<cfif Left(CGI.CF_TEMPLATE_PATH, 1) EQ "/">
	<cfset path_delim = "/">
<cfelse>
	<cfset path_delim = "\">
</cfif>
<cfset oh_path = root_path & path_delim & "OpenHorizon">
<cfif path_delim EQ "/">
	<cfset os = "Linux">
<cfelse>
	<cfset os = "Windows">
</cfif>
<cfset staging = root_path & path_delim & "orms_staging">
<cfset storage_path = root_path & path_delim & "prefiniti_cms">
<cfset storage_url = base_url & "prefiniti_cms">
<body>

	<div class="setup_box">
		<img src="../graphics/prenew-small.png">
		<p class="LandingHeaderText" style="font-size:12px;">
			This instance of Prefiniti has not yet been configured.
			After you fill in and submit the following form, Prefiniti will be configured,
			and you will be able to create the first user and then log in.
		</p>
		<p class="LandingHeaderText" style="font-size:12px;border-bottom:1px solid #c0c0c0; padding-bottom:6px;">
			We have attempted to fill out some of the fields for you.<br /> Please make sure they are correct.
		</p>
		<form name="Setup" id="Setup" method="POST" action="generate-setup.cfm">
		<table>
			<tr>
				<td align="right"><strong>Instance name</strong></td>
				<td align="left"><input type="text" name="name"/></td>
			</tr>
			<tr>
				<td align="right"><strong>Configuration Type</strong></td>
				<td align="left">
					<select name="mode">
						<option value="Reconfigure">Reconfigure Instance</option>
						<option value="Development">Development</option>
						<option value="Maintenance">Undergoing Maintenance</option>
						<option value="InternalTest" selected>Internal Testing</option>
						<option value="ExternalTest">External Testing</option>
						<option value="Production">Full Production Use</option>
					</select>						
						
				</td>
			</tr>
			<tr>
				<td align="right"><strong>Installation Path</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="rootpath" value="#root_path#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td align="right"><strong>OpenHorizon Path</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="ohrootdir" value="#oh_path#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td align="right"><strong>Base URL</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="rooturl" value="#base_url#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td align="right"><strong>Server Platform</strong></td>
				<td align="left">
					<select name="platform">
						<option value="Linux" <cfif os EQ "Linux">selected</cfif>>Linux</option>
						<option value="Windows" <cfif os EQ "Windows">selected</cfif>>Windows</option>												
					</select>	
				</td>
			</tr>
			<tr>
				<td align="right"><strong>Path Delimiter</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="pathdelimiter" value="#path_delim#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td align="right"><strong>Content Staging Path</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="staging" value="#staging#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td align="right"><strong>ColdFusion Datasource</strong></td>
				<td align="left"><input type="text" name="datasource" value="prefiniti"/></td>
			</tr>
			<tr>
				<td align="right"><strong>File Storage Path</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="filestorage" value="#storage_path#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td align="right"><strong>File Storage Base URL</strong></td>
				<td align="left">
					<cfoutput>
					<input type="text" name="cmsurl" value="#storage_url#"/>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="right" style="padding:5px;">
					<a href="##" onclick="document.Setup.submit();" class="button"><span>Save Configuration</span></a>
				</td>
			</tr>
		</table>	
		</form>		 
	</div>

</body>
</html>