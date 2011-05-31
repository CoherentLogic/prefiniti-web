<!---
	$Id$
--->

<cfquery name="record_hit" datasource="webwarecl">
	INSERT INTO hits
    	(hit_page,
        hit_date,
        hit_ip)
    VALUES
    	('registration',
        #CreateODBCDateTime(Now())#,
        '#cgi.REMOTE_ADDR#')
</cfquery>


<link href="../../css/gecko.css" rel="stylesheet" type="text/css">
<cfparam name="captcha" default="">
<cfset captcha="#Left(CreateUUID(), 6)#">

	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Register New Prefiniti Account</h3>
        </div>
    </div>
    <br />
    <br />

	<form name="regAcct">
		<div class="homeHeader"><img src="/graphics/user.png" align="absmiddle" /> My Name</div>
        <div style="width:780px; padding:20px;">
        <table width="100%" cellspacing="0" cellpadding="3px">
        	<tr>
            	<td colspan="2" style="color:red;">Fields marked with an asterisk (*) are required.</td>
			</tr>                
                	
			<tr>
				<td>Your name:</td>
				<td>
                	<label>First: <input type="text" name="firstName" id="firstName" maxlength="255" /><strong style="color:red;">*</strong></label>
                    <label>Middle Initial: <input name="middleInitial" type="text" id="middleInitial" size="2" maxlength="1"/>
                    </label>
                    <label>Last: <input type="text" name="lastName" id="lastName" maxlength="255"/><strong style="color:red;">*</strong></label>                </td>
			</tr>

			
			<tr>
			  <td>Your e-mail address:</td>
			  <td>
			  	<input type="text" name="email" id="email" onKeyUp="companyNameChanged();" maxlength="255"><strong style="color:red;">*</strong><br />
				<label><input type="checkbox" name="email_billing" id="email_billing" checked/>I would like to be billed at this e-mail address</label>			  </td>
		  </tr>
			<tr>
			  <td>Gender:</td>
			  <td><p>
			    <label>
			      <input type="radio" name="gender" value="M" checked>
			      Male</label>
			    <br>
			    <label>
			      <input type="radio" name="gender" value="F">
			      Female</label>
			    <br>
			    </p>			  </td>
		  </tr>
			<tr>
			  <td>Mobile phone number: </td>
			  <td><input type="text" name="smsnumber" id="smsnumber" maxlength="45"></td>
		  </tr>
			<tr>
			  <td>Phone number:</td>
			  <td><input type="text" name="phone" id="phone" maxlength="45" /><strong style="color:red;">*</strong></td>
		  </tr>
			<tr>
			  <td>Fax number:</td>
			  <td><input type="text" name="fax" id="fax" maxlength="45" /></td>
		  </tr>
			<tr>
			  <td>Birthday:</td>
			  <td><cfmodule template="/controls/date_picker.cfm" ctlname="birthday" startdate="#Now()#"></td>
		  </tr>
          </table>
          </div>
          
          <div class="homeHeader"><img src="/graphics/map.png" align="absmiddle" /> My Locations</div>
          <div style="width:780px; padding:20px;">
          <table width="100%" cellspacing="0" cellpadding="3px">

			<tr>
			<td>Physical Address:</td>
			<td>
				<table>
					<tr>
						<td>Street:</td>
						<td><input type="text" name="mailing_address" id="mailing_address" maxlength="255" ><strong style="color:red;">*</strong></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="mailing_city" id="mailing_city" maxlength="255" ><strong style="color:red;">*</strong></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="mailing_state" id="mailing_state" maxlength="2" ><strong style="color:red;">*</strong></td>
					</tr>
					<tr>
						<td>ZIP Code:</td>
						<td><input type="text" name="mailing_zip" id="mailing_zip" maxlength="255" ><strong style="color:red;">*</strong></td>
					</tr>
				</table>			</td>
		</tr>
				<tr>
			<td>Billing Address:<br />
            
            </td>
			<td>
            <p style="color:red;">Please Note: Prefiniti is a free service. You will not be charged for your account. The billing address entered here is only for purchases made through our affiliates.</p>
				
				<label>
				<input type="checkbox" name="chkCopyAddress" id="chkCopyAddress" value="checkbox" onClick="copyAddress();">
				My billing address is the same as my physical address</label>
				<table>
					<tr>
						<td>Street:</td>
						<td><input type="text" name="billing_address" id="billing_address" maxlength="255" ><strong style="color:red;">*</strong></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="billing_city" id="billing_city" maxlength="255" ><strong style="color:red;">*</strong></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="billing_state" id="billing_state" maxlength="2" ><strong style="color:red;">*</strong></td>
					</tr>
					<tr>
						<td>ZIP Code:</td>
						<td><input type="text" name="billing_zip" id="billing_zip" maxlength="255"><strong style="color:red;">*</strong></td>
					</tr>
				</table>			</td>
		</tr>
        </table>
        </div>
        <div class="homeHeader"><img src="/graphics/shield.png" align="absmiddle" /> Login Information</div>
        <div style="width:780px; padding:20px;">
        <table width="100%" cellspacing="0" cellpadding="3px">
	
				 <tr>
				 	<td>Login Name:</td>
					<td>
						<input type="text" name="username" id="username" maxlength="45" onKeyPress="SetInnerHTML('availability', '');"/><strong style="color:red;">*</strong>
						<input type="button" name="checkAvailabilityx" id="checkAvailabilityx" class="normalButton" onClick="checkAvailability(GetValue('username'));" value="Check Availability" /> <span style="color:red">You must click "Check Availability" before registering your account.</span><br />
						<span id="availability"></span>					</td>
				 </tr>
				 <tr>
				   <td>Privacy:</td>
				   <td><label><input type="checkbox" name="allowSearch" id="allowSearch" />Allow users to search for me</label></td>
	      </tr>
		  <tr>
		  	<td>Referral Code:</td>
			<td><input type="text" name="ReferralCode" id="ReferralCode"></td>
		</tr>
          		<tr>
                	<td>Verification:</td>
                    <td><p style="color:red;">The image below is used to prevent computers from creating accounts and spamming our users.</p>
                    	<cfimage action="captcha"  width="200" height="60" text="#captcha#"
    fonts="Arial,Verdana,Courier New"><br />
    					<label style="color:red;">Please enter the text found in the image above (case sensitive): <input type="text" name="captcha" id="captcha" /><strong style="color:red;">*</strong></label> <span id="captcha_status"></span>
                    </td>
                    
    			
                </tr>
                <tr>
                	<td>Terms of Use and Privacy Policy:</td>
                    <td>
                    	<div style="width:500px; height:250px; overflow:auto;">
                        	
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<title>Terms of Use Agreement</title>
<style>
<!--
a:link, span.MsoHyperlink {
	color:blue;
	text-decoration:underline;
}
a:visited, span.MsoHyperlinkFollowed {
	color:purple;
	text-decoration:underline;
}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate {
	font-size:8.0pt;
	font-family:"Tahoma", "sans-serif";
}
span.msoIns {
	text-decoration:underline;
	color:teal;
}
span.msoDel {
	text-decoration:line-through;
	color:red;
}
div.Section1 {
	page:Section1;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" link=blue vlink=purple lang=EN-US>
<div class=Section1>
  <p><b><span style='font-size:14.0pt'>Terms of Use Agreement </span></b></p>
  <p><b>Read These Terms of Use Agreement Before Accessing
    Website.</b></p>
  <p>Effective Date:  This Terms of Use Agreement was last
    updated on January 14, 2008</p>
  <p>This Terms of Use Agreement sets forth the standards of use
    of the Prefiniti, Inc Online Service for Registered Members. By using <a
href="http://www.prefiniti.com/"><span style='color:windowtext'>www.prefiniti.com</span></a>,
    www.prefiniti.net, <a href="http://www.prefinit.mobi/"><span style='color:windowtext'>www.prefinit.mobi</span></a> (here after collectively called the “Website”). You (the “Member”) agree to
    these terms and conditions. If you do not agree to the terms and conditions of
    this agreement, you should immediately cease all usage of this website. We
    reserve the right, at any time, to modify, alter, or update the terms and
    conditions of this agreement without prior notice.  Modifications shall become
    effective immediately upon being posted at www.prefiniti.com website.  Your
    continued use of the Service after amendments are posted constitutes an
    acknowledgement and acceptance of the Agreement and its modifications. Except
    as provided in this paragraph, this Agreement may not be amended.</p>
  <p>1.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Description
    of Service</p>
  <p>Prefiniti, Inc. is providing Member with a social networking
    and business management service.  Customer level accounts have social
    networking, purchasing, scheduling and advanced notifications via email, sms
    text messaging and site mail.   Business level accounts have access to all
    features available in customer level accounts with the addition of components
    specifically tailored to fit the specific needs of the industry in which the
    business account resides.  Member must provide (1) all equipment necessary for
    their own Internet connection, including computer and modem and (2) provide for
    Member’s access to the Internet, and (3) pay any fees related with such
    connection.  </p>
  <p>2.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Disclaimer
    of Warranties.</p>
  <p>The site is provided by Prefiniti, Inc on an “as is” and on
    an “as available” basis.  To the fullest extent permitted by applicable law,
    Prefiniti, Inc makes no representations or warranties of any kind, express or
    implied, regarding the use or the results of this web site in terms of its
    correctness, accuracy, reliability, or otherwise.  Prefiniti, Inc shall have no
    liability for any interruptions in the use of this Website.  Prefiniti, Inc
    disclaims all warranties with regard to the information provided, including the
    implied warranties of merchantability and fitness for a particular purpose, and
    non-infringement.  Some jurisdictions do not allow the exclusion of implied
    warranties; therefore the above-referenced exclusion is inapplicable.</p>
  <p>3.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Limitation
    of Liability</p>
  <p>PREFINITI, INC. SHALL NOT <span style='text-transform:uppercase'>be
    liable for any damages whatsoever, and in particular </span>PREFINITI, INC. <span
style='text-transform:uppercase'>shall not be liable for any special, indirect,
    consequential, or incidental damages, or damages for lost profits, loss of
    revenue, or loss of use, arising out of or related to this web site or the
    information contained in it, whether such damages arise in contract,
    negligence, tort, under statute, in equity, at law, or otherwise, even if </span>PREFINITI,
    INC. <span style='text-transform:uppercase'>has been advised of the possibility
    of such damages. SOME JURISDICTIONS DO NOT ALLOW FOR THE LIMITATION OR
    EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, THEREFORE SOME
    OF THE ABOVE LIMITATIONS IS INAPPLICABLE. </span></p>
  <p>4.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Indemnification</p>
  <p>Member agrees to indemnify and hold Prefiniti, Inc. its
    parents, subsidiaries, affiliates, officers and employees, harmless from any
    claim or demand, including reasonable attorneys’ fees and costs, made by any
    third party due to or arising out of Member’s use of the Service, the violation
    of this Agreement, or infringement by Member, or other user of the Service
    using Member’s computer, of any intellectual property or any other right of any
    person or entity. </p>
  <p>5.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Members
    Account</p>
  <p>All Members of the Service shall receive a password and an
    account.  Members are entirely responsible for any and all activities which
    occur under their account whether authorized or not authorized. Member agrees
    to notify Prefiniti, Inc. of any unauthorized use of Member’s account or any
    other breach of security known or should be known to the Member. Member’s right
    to use the Service is personal to the Member. Member agrees not to resell or
    make any commercial use of the Service without the express written consent of
    Prefiniti, Inc.</p>
  <p>6.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Modifications
    and Interruption to Service</p>
  <p>Prefiniti, Inc. reserves the right to modify or discontinue
    the Service with or without notice to the Member. Prefiniti, Inc. shall not be
    liable to Member or any third party should Prefiniti, Inc. exercises its right
    to modify or discontinue the Service. Member acknowledges and accepts that
    Prefiniti, Inc. does not guarantee continuous, uninterrupted or secure access
    to our website and operation of our website may be interfered with or adversely
    affected by numerous factors or circumstances outside of our control. </p>
  <p>7.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Third-Party
    Sites</p>
  <p>Our website may include links to other sites on the Internet
    that are owned and operated by online merchants and other third parties.  You
    acknowledge that we are not responsible for the availability of, or the content
    located on or through, any third-party site.  You should contact the site
    administrator or webmaster for those third-party sites if you have any concerns
    regarding such links or the content located on such sites.  Your use of those
    third-party sites is subject to the terms of use and privacy policies of each
    site, and we are not responsible therein. We encourage all Members to review
    said privacy policies of third-parties’ sites.</p>
  <p>8.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Disclaimer
    Regarding Accuracy of Vendor Information</p>
  <p>Product specifications and other information have either
    been provided by the Vendors or collected from publicly available sources. 
    While Prefiniti, Inc. makes every effort to ensure that the information on this
    website is accurate, we can make no representations or warranties as to the
    accuracy or reliability of any information provided on this website.</p>
  <p>Prefiniti, Inc. makes no warranties or representations
    whatsoever with regard to any product provided or offered by any Vendor, and
    you acknowledge that any reliance on representations and warranties provided by
    any Vendor shall be at your own risk.</p>
  <p>9.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Governing
    Jurisdiction of the Courts of New Mexico</p>
  <p>Our website is operated and provided in the State of New Mexico. As such, we are subject to the laws of the State New Mexico and such laws will
    govern this Terms of Use, without giving effect to any choice of law rules.  We
    make no representation that our website or other services are appropriate,
    legal or available for use in other locations.  Accordingly, if you choose to
    access our site you agree to do so subject to the internal laws of the State of
    New Mexico.  </p>
  <p>10.<span
style='font:7.0pt "Times New Roman"'>&nbsp; </span>Compliance with Laws.</p>
  <p>Member assumes all knowledge of applicable law and is
    responsible for compliance with any such laws.  Member may not use the Service
    in any way that violates applicable state, federal, or international laws,
    regulations or other government requirements. Member further agrees not to
    transmit any material that encourages conduct that could constitute a criminal
    offense, give rise to civil liability or otherwise violate any applicable
    local, state, national, or international law or regulation. </p>
  <p>11.<span
style='font:7.0pt "Times New Roman"'>&nbsp; </span>Copyright and Trademark
    Information </p>
  <p>All content included or available on this site, including
    site design, text, graphics, interfaces, and the selection and arrangements
    thereof is the property of Prefiniti, Inc. and<span class=msoIns><ins
cite="mailto:JJackson" datetime="2008-01-14T16:17"> </ins></span>/or third
    parties and is protected by intellectual property rights, including but not
    limited to trademarks, copyrights, and patents pending.    Any use of materials
    on the website, including reproduction for purposes other than those noted
    above, modification, distribution, or replication, any form of data extraction
    or data mining, or other commercial exploitation of any kind, without prior
    written permission of an authorized officer of Prefiniti, Inc. is strictly
    prohibited.  Members agree that they will not use any robot, spider, or other
    automatic device, or manual process to monitor or copy any portion of the
    Website or the content contained therein without prior written permission of an
    authorized officer of Prefiniti, Inc.</p>
  <p>Prefiniti™ is a proprietary mark of Prefiniti, Inc.<span
class=msoIns><ins cite="mailto:JJackson" datetime="2008-01-14T16:24"> </ins></span>and
    may not be used in connection with any product or service that is not provided
    by Prefiniti, Inc., in any manner that is likely to cause confusion among
    customers, or in any manner that disparages or discredits Prefiniti, Inc. or
    otherwise dilutes the mark.  </p>
  <p>All other trademarks displayed on Prefiniti, Inc.’s website
    are the trademarks of their respective owners, and constitute neither an
    endorsement nor a recommendation of those Vendors.  In addition, such use of
    trademarks or links to the web sites of Vendors is not intended to imply,
    directly or indirectly, that those Vendors endorse or have any affiliation with
    Prefiniti, Inc.</p>
  <p>12.<span
style='font:7.0pt "Times New Roman"'>&nbsp; </span>Notification of Claimed
    Copyright Infringement</p>
  <p>Pursuant to Section 512(c) of the Copyright Revision Act, as
    enacted through the Digital Millennium Copyright Act, www.prefiniti.com
    designates the following individual as its agent for receipt of notifications
    of claimed copyright infringement.</p>
  <p>By Mail</p>
  <p>3265 Arrowhead Rd, Ste 200</p>
  <p>Las Cruces, NM 88011-4786</p>
  <p>By Telephone: (575) 522-3763 </p>
  <p>By Email: </p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>General Information: <a href="mailto:info@prefiniti.com"><span
style='color:windowtext'>info@prefiniti.com</span></a></p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>Account Information: <a href="mailto:accounts@prefiniti.com"><span
style='color:windowtext'>accounts@prefiniti.com</span></a></p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>Privacy Information: <a href="mailto:privacy@prefiniti.com"><span
style='color:windowtext'>privacy@prefiniti.com</span></a></p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>Support Information: <a href="mailto:support@prefiniti.com"><span
style='color:windowtext'>support@prefiniti.com</span></a></p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>Billing Information: <a href="mailto:billing@prefiniti.com"><span
style='color:windowtext'>billing@prefiniti.com</span></a></p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>Terminate Account: <a href="mailto:terminate@prefiniti.com"><span
style='color:windowtext'>terminate@prefiniti.com</span></a></p>
  <p><span
style='font-family:Symbol'>·<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span>Contact Prefiniti: contact@prefiniti.com</p>
  <p>13.<span
style='font:7.0pt "Times New Roman"'>&nbsp; </span>Botnets </p>
  <p>Prefiniti, Inc. retains the right, at our sole discretion,
    to terminate any accounts involved with Botnets and related activities. If any
    hostnames are used as command and control points for Botnets, Prefiniti, Inc.
    reserves the right to direct the involved hostnames to a honeypot, loopback
    address, logging facility, or any other destination at our discretion. </p>
  <p>14.<span
style='font:7.0pt "Times New Roman"'>&nbsp; </span>Other Terms </p>
  <p>If any provision of this Terms of Use Agreement shall be
    unlawful, void or unenforceable for any reason, the other provisions (and any
    partially-enforceable provision) shall not be affected thereby and shall remain
    valid and enforceable to the maximum possible extent.  You agree that this
    Terms of Use Agreement and any other agreements referenced herein may be
    assigned by Prefiniti, Inc. in our sole discretion, to a third party in the
    event of a merger or acquisition.  This Terms of Use Agreement shall apply in
    addition to, and shall not be superseded by, any other written agreement
    between us in relation to your participation as a Member.  Member agrees that
    by accepting this Terms of Use Agreement, Member is consenting to the use and
    disclosure of their personally identifiable information and other practices
    described in our Privacy Policy Statement.</p>
  <p style='line-height:150%'>15.       Trade
    Secrets</p>
  <p style='line-height:150%'>The website accessed by password
    holds the technology used in the licensed activity by the member as a trade
    secret and you shall maintain any information learned about that technology as
    a trade secret and shall not disclose such information or permit such
    information to be disclosed to any person or entity; however, this shall not
    preclude the training of employees in the ordinary use of the website.</p>
  <p style='line-height:150%'>16.       Reverse
    Engineering</p>
  <p style='line-height:150%'>You shall not reverse engineer,
    decompile or disassemble any part of the online services or permit any other
    person to do so.</p>
  <p style='line-height:150%'>17.       Survival</p>
  <p style='line-height:150%'>The terms of this Agreement shall
    survive any termination of your membership agreement and you agree to maintain
    any information learned about the technology used in the program as a trade
    secret and not disclose or cause it to be disclosed to any person or entity.</p>
  <p style='line-height:150%'>18.       Charges</p>
  <p style='line-height:150%'>If you elect to subscribe to these
    online services, you shall pay for all use of the online services accessed
    through your identification number in accordance with the following fee
    schedule:</p>
  <p style='line-height:
150%'>Personal or Customer Users – Free unlimited worldwide access with 50
    megabytes of storage.</p>
  <p style='line-height:150%'>Additional services
    may be purchased from time to time as agreed to between the member and
    Prefiniti, Inc. as listed in the rate table at <a
href="http://www.prefiniti.com/"><span style='color:windowtext'>http://www.prefiniti.com</span></a><span
class=msoIns><ins cite="mailto:Loren%20S.%20Kuehne" datetime="2008-01-29T15:08">.</ins></span></p>
  <p style='line-height:
150%'>Business Users – Pricing is subject to the rate table found at <a
href="http://www.prefiniti.com/"><span style='color:windowtext'>http://www.prefiniti.com</span></a> under ‘Business Account Information.’  This rate table is subject to change
    without notice. All changes will become effective upon the member’s next
    billing cycle.</p>
  <p style='line-height:150%'><span
class=msoIns><ins cite="mailto:Anthony%20Gutierrez" datetime="2008-01-29T11:49">I</ins></span>f
    you believe that any of your identification numbers are being used by someone
    who is not authorized, you shall immediately notify us.</p>
  <p style='line-height:150%'>19.       Payment</p>
  <p style='line-height:150%'>All monthly subscription charges
    are due on the same date every month as your original subscription date.  All
    charges for online services incurred<span class=msoIns><ins
cite="mailto:Loren%20S.%20Kuehne" datetime="2008-01-28T12:05"> </ins></span>on
    a per transaction basis shall be paid by you and shall be paid within fifteen
    (15) days following our invoice to you.</p>
  <p style='line-height:150%'>20.       Collection
    Costs.</p>
  <p style='line-height:150%'>Member is liable for all costs of
    collection incurred by Prefiniti, Inc. including, without limitation,
    collection agency fees, reasonable attorney fees, and court costs if you fail
    to comply with your payment obligation under this Agreement.</p>
  <p style='line-height:150%'>21. 
         Alternate Exclusive Remedy</p>
  <p style='line-height:150%'>In the event the use of the website
    owned by Prefiniti, Inc. is found by a court of competent jurisdiction to fail
    in its essential purpose, the alternate exclusive remedy shall be a refund of
    the member’s current charges incurred in relation to that particular use of the
    online services that result in any such liability.</p>
  <p style='line-height:150%'>22.       Termination</p>
  <p style='line-height:150%'>This Agreement shall continue in
    effect until terminated.  Either Prefiniti, Inc. or a member may terminate by
    written notice to the other party at the above address for Prefiniti, Inc. and
    at the address provided in the member application for the member.  Except as
    otherwise provided herein, the effective date of termination shall be twenty
    (20) days after the giving of such notification.  Prefiniti, Inc. may suspend
    or discontinue providing the online service without notice and pursue other
    remedies if Prefiniti, Inc. has reason to believe that member has failed to
    comply with the terms and obligations of this Agreement.</p>
  <p style='line-height:150%'>23.       Assignment</p>
  <p style='line-height:150%'>Member is prohibited from assigning
    any rights to or delegate member duties under this Agreement without prior
    written consent by Prefiniti, Inc.</p>
  <p style='line-height:150%'>24.       Failure
    to Enforce</p>
  <p style='line-height:150%'>The failure of either party to
    enforce any provision of this Agreement shall not constitute or be construed as
    a waiver of any provision or the right to enforce such at a later time.</p>
  <p style='line-height:150%'>25.       Severability</p>
  <p style='line-height:150%'>If any provision of this Agreement
    shall be determined by a court of competent jurisdiction to be overly broad in
    duration of substantive scope, such provision shall be deemed removed to the
    broadest term or extent permitted by applicable law.  If at any provision of
    this Agreement shall be determined by a court of competent jurisdiction, to be
    unlawful, void or for any reason unenforceable and such provision cannot be
    deemed narrowed to make it lawful and enforceable, it shall be deemed stricken
    from and shall in no way offset the validity or enforceability of the remaining
    provisions of this Agreement.</p>
</div>
</body>
</html>
                        
                        </div>
                        <br /><br />
                        <strong style="color:red;">By clicking &quot;Create Account&quot;, you agree to be bound by the above terms of use and privacy policy.</strong>
					</td>
				</tr>                                            
                    	
				<tr>
					<td colspan="2" align="right">
					<!--function registerAccount(firstName, middleInitial, lastName, email, email_billing, gender, smsnumber, phone, fax, mailEqualsBill,
						 mailing_address, mailing_city, mailing_state, mailing_zip,
						 billing_address, billing_city, billing_state, billing_zip, username, availability)-->
						<cfoutput><input type="button" name="submit" class="normalButton" value="Create Account" onClick="registerAccount(GetValue('firstName'), GetValue('middleInitial'), GetValue('lastName'), GetValue('email'), IsChecked('email_billing'), AjaxGetCheckedValue('gender'), GetValue('smsnumber'), GetValue('phone'), GetValue('fax'), IsChecked('chkCopyAddress'), GetValue('mailing_address'), GetValue('mailing_city'), GetValue('mailing_state'), GetValue('mailing_zip'), GetValue('billing_address'), GetValue('billing_city'), GetValue('billing_state'), GetValue('billing_zip'), GetValue('username'), GetInnerHTML('availability'), IsChecked('allowSearch'), GetValue('birthday'), GetValue('captcha'), '#captcha#', GetValue('ReferralCode'));"/></cfoutput>					</td>
				</tr>
		</table>
        </div>
	</form>
