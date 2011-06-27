<head>
	<cfif session.loggedin NEQ "yes">
		<cfif IsDefined("URL.View")>
			<cfif IsDefined("URL.Section")>
				<cfset sec = URL.Section>
			<cfelse>
				<cfset sec = "">
			</cfif>
			<cflocation url="/homeres/SignIn/SignIn.cfm?view=#URL.View#&section=#sec#" addtoken="no">
		</cfif>
	</cfif>

	<cfif IsDefined("URL.View")>
		<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.View)>
		<cfoutput>
			<title>#o.r_type# #o.r_name# - The Prefiniti Network</title>
		</cfoutput>
	<cfelse>
		<title>The Prefiniti Network</title>
	</cfif>


<style type="text/css">
	body {
		white;
		background-repeat:repeat-x;
	}
	#PrefinitiToolbar {
		width:100%;
		clear:left;
	}
	
	.LargeButton {
		font-size:16px;
		font-family:Tahoma, Verdana, Arial, Helvetica, sans-serif;
		
		margin-left:5px;
		margin-top:5px;
		
		
		
	}
	
	.TabBar {
		margin-top:0px;
		margin-left:10px;
		width:100%;
	}
	
	.ContentBar {
		
		width:900px;
		margin-left:auto;
		margin-right:auto;
		height:auto;
		clear:left;
		/*border-left:1px solid #efefef;
		border-right:1px solid #efefef;
		border-top:none;
		border-bottom:1px solid #efefef;*/
		
		
		
	}

	#LandingPage {		
		display:none;
		background-color:#efefef;
		text-align:left;
		margin-left:auto;
		margin-right:auto;
		width:550px;
		height:auto;
		padding:10px;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:12px;
		
		-moz-border-radius:4px;
	}
	
	#LandingPage td {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:12px;
		background-color:transparent;
	}
	
	#LandingPageShadow {
		-moz-border-radius:5px;
		display:none;
		z-index:1800;
		background-color:gray;
		border:1px solid gray;
		position:absolute;
		left:85px;
		top:95px;
		width:550px;
		height:450px;
		padding:10px;
	}
	
	#SiteStatsDiv {
		width:100%;
		padding:0px;
		margin:0px;
		height:20px;
		
	}
	
	#tcTarget {
		
		border-bottom:none;
		border-left:none;
		border-right:none;
	}
	
	.PNotifyText {
		font-family:Verdana;
		font-size:10px;
		font-weight:normal;
		color:#3300CC;
		text-transform:uppercase;
	}
	
	.bigBox {
		width:792px;
		height:289px;
		background-image:url(/homeres/back_01.jpg);
		background-repeat:no-repeat;
		margin-top:20px;
	}
	
	.iPrefinitiToolbar {		
		padding:12px;
		margin-bottom:0px;
		margin-top:0px;
		
		repeat:no-repeat;
		width:900px;
		background-color:#efefef;
	}
	
	.hdr_tools {
		display:block;
		float:left;
		border-left:1px solid #c0c0c0;		
		font-size:14px;
		padding:8px;
		color:#999999;
	}
	
	.hdr_tools_wrapper a:hover {
		text-decoration:none;
		color:#3399cc;
		
	}
</style>
</head>
<body onLoad="LoadHandler15();">
<a name="top"></a>

<script src="/framework/UI/wz_tooltip.js" type="text/javascript"></script>

<cfmodule template="/sm2/demo/jsAMP-preview/musicplayer.cfm" playlist="__library" user_id="#session.userid#">

<center>
<div style="width:100%; background-color:#efefef; border-bottom:1px solid #c0c0c0;">
<div id="tb" class="iPrefinitiToolbar" align="right">
	
	<div style="width:auto; float:left; padding-top:8px;"><img src="/graphics/prefiniti-small.png"></div>
	<input 	type="text" 
			id="searchBox" 
			name="searchBox" 
			class="search_inactive" 
			value="Type your search terms and press Enter"
			onkeypress="ORMSSearchKeyPress(event);"
			onclick="ORMSSearchClick();">		
	<!---<a style="float:right; margin-left:8px;" class="button" href="##" onclick="ORMSSearch(GetValue('searchBox'))"><span>Go</span></a>--->
		
	
	<table width="900" style="margin-top:8px;">
	<tr>
	<td align="left" width="50%" style="background-color:transparent;">
	
	<span id="file_action" style="display:none;">
    <input type="hidden" name="selected_file_id" id="selected_file_id" value="">
    <input type="hidden" name="current_mode" id="current_mode" value="" />
    <span id="cms_send_file"><img src="/graphics/email_attach.png" border="0" align="absmiddle"> <a href="javascript:mailWithAttachments(GetValue('selected_file_id'))">Send File</a> |&nbsp;</span>
    <span id="cms_delete_file"><img src="/graphics/bin.png" border="0" align="absmiddle"> <a href="javascript:cmsDeleteFile(GetValue('selected_file_id'), GetValue('current_mode'));">Delete File</a> |&nbsp;</span>
    <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:cmsViewFile(GetValue('selected_file_id'), GetValue('current_mode'));">View File</a>
	</span>  
	<div id="Sidebars" style="float:left;"></div>  
	</td>
	<td align="right" width="50%" style="background-color:transparent;">
		
		<div class="hdr_tools_wrapper" style="width:auto; float:right;">
		<a class="hdr_tools" style="border-left:none;" href="##" onClick="OpenLanding('Shop.cfm')">Shop</a>
		<a class="hdr_tools" href="##" onClick="OpenLanding('Work.cfm')">Work</a>
		<a class="hdr_tools" href="##" onClick="OpenLanding('Socialize.cfm')">Socialize</a>
		<a class="hdr_tools" href="##" onClick="OpenLanding('Organize.cfm')">Organize</a>
		<a class="hdr_tools" href="##" onClick="OpenLanding('UploadAndStore.cfm')">Upload &amp; Store</a>
		<a class="hdr_tools" href="##" onClick="OpenLanding('Customize.cfm')">Customize</a>
		</div>
		<!--- <input type="button" class="normalButton" value="Go" onclick="ORMSSearch(GetValue('searchBox'))"> --->
	</td>
	</tr>
	</table>
</div>
</div>

	

</center>
	

<!--- END TOOLBAR --->
<div id="sbTarget" class="ContentBar" style="height:40px; background-color:white; -moz-box-shadow:none; -moz-border-radius:0px;"></div>
<div class="ContentBar" style="background-color:white;">	
	<div id="SiteStatsDiv" style="width:100%; height:0px; color:black; font-weight:normal; background-color:white; "></div>
	<div id="tcTarget"></div>
</div>


<script type="text/javascript">
	function LoadHandler15 () {
		hideDiv('ClassicSiteSelect');
		hideDiv('ClassicMenus');
		
		hideSplash();
		PrefinitiLegacyInit();
		fwRegisterAutoUpdate("/framework/components/sitestats_widget.cfm", "SiteStatsDiv");
		if(glob_AutoCatalog.toString() != '') {
			try {
				ViewCatalog(glob_AutoCatalog);
			}
			catch (ex) {}
		}
		<cfif IsDefined("URL.view")>
			<cfoutput>
			ORMSLoad('#URL.view#', '#URL.section#');
			</cfoutput>
		<cfelse>
			loadHomeView();
		</cfif>
	}
</script>



<div class="OH_DIALOG_BG" id="oh_dialog_background" style="display:none;">
	<div id="orms_dialog_container"></div>
</div>

