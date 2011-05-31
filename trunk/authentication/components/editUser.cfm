

<cfquery name="gUI" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#url.id#
</cfquery>
<cfoutput>

<!--
<wwafcomponent>Make Changes to a User Account (#gUI.longName#)</wwafcomponent>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>accept.png</wwaficon>
-->

</cfoutput>
<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Make changes to a User Account</h3>

	<cfoutput><a href="javascript:editCompany('#gUI.company#');" style="padding-top:0px; margin-bottom:10px; font-family: 'Times New Roman', Times, serif; color:##3399CC; font-weight:lighter; font-size:x-small; font-style:italic;">Edit  <cfmodule template="/jobViews/components/companyByCompanyID.cfm" id="#gUI.company#"> Company Account</a></cfoutput><br /><br />
	<table width="100%"><tr><td style="background-color:#CCCCCC; margin-bottom:10px;">
	
	<cfoutput>
		<h4  align="right" style="font-family: 'Times New Roman', Times, serif; color:black; font-weight:lighter; font-size:18px; margin-top:3px;">#gUI.longName#</h4>
	</cfoutput>
	
	<h5  align="right" style="margin-top:-20px; margin-bottom:0px; font-family: 'Times New Roman', Times, serif; color:gray; font-style:italic; font-size:16px;">
		<cfswitch expression="#gUI.type#">
			<cfcase value="0">
				Customer from <cfmodule template="/jobViews/components/companyByCompanyID.cfm" id="#gUI.company#">
			</cfcase>
			<cfcase value="1">
				<cfif #gUI.title# EQ "">Employee of <cfelse><cfoutput>#gUI.title#, </cfoutput></cfif><cfmodule template="/jobViews/components/companyByCompanyID.cfm" id="#gUI.company#"> 
			</cfcase>
		</cfswitch>
		
	</h5>
	
	</td>
	</tr></table><br><br>
	
	<div align="left" style="float:left;">
	<cfoutput>
		
		<a href="javascript:changeAccountInfo('#gUI.id#')" style="padding:10px 10px 10px 20px;">Change basic information</a><br><br>
		<a href="javascript:changePassword('#gUI.id#')" style="padding:10px 10px 10px 20px;">Change user's password</a><br><br>
		<cfif #url.isAdmin# EQ true>
			<a href="javascript:changeAccountType('#gUI.id#')" style="padding:10px 10px 10px 20px;">Change account type</a><br><br>
		</cfif>
		<span id="changePictureLink"><a href="javascript:changePicture('#gUI.id#')" style="padding:10px 10px 10px 20px;">Change user's picture</a> <img src="/graphics/picture_add.png" align="absmiddle"></span>
	</cfoutput>
	
	</div>
	<div align="right" style="padding-right:20px;">
<cfoutput>
		<img src="/authentication/profile_images/#gUI.picture#" width="120" height="120">
	</cfoutput>
	</div>
	<div id="userActionTarget" style="width:100%; clear:both; margin-top:30px;">
	</div>
<br>


