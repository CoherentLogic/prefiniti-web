<cfmodule template="/LandingPages/LandingHeader.cfm">

<cfquery name="get_mail" datasource="webwarecl">
			SELECT 		messageInbox.id AS msgid, 
            			messageInbox.tbody, 
                    	messageInbox.tsubject, 
                    	messageInbox.tdate, 
                    	messageInbox.tread, 
                    	Users.id AS sender_id, 
                    	Users.username, 
                    	Users.firstName 
			FROM 		messageInbox 
            INNER JOIN 	Users 
            ON 			Users.id=messageInbox.fromuser 
            WHERE 		messageInbox.touser=#url.calledByUser# 
            AND 		messageInbox.deleted_inbox=0 
            AND			messageInbox.tread='no'
            ORDER BY 	messageInbox.tdate 
            DESC
</cfquery>		

<h3>Prefiniti Mail</h3>
<p style="margin-left:5px;">
<a href="javascript:writeMessage();">Write a new mail message</a><br />
<a href="javascript:viewMailFolder('inbox', 1);">View messages that have been sent to me</a><br />
<a href="javascript:viewMailFolder('sent messages', 1);">View messages I have sent</a>
</p>

<cfif get_mail.RecordCount NEQ 0>
	<h3>Recent Mail</h3>
    <p style="margin-left:5px;">
	<table cellspacing="0" width="100%">
    <tr>
    	<td><strong>From</strong></td>
        <td><strong>Subject</strong></td>
    </tr>
	<cfoutput query="get_mail" startrow="1" maxrows="5">
    	<tr>
        <td style="border-bottom:1px solid ##EFEFEF;">
        <a href="javascript:viewMessage(#msgid#)">#firstName#</a>
        </td>
        <td style="border-bottom:1px solid ##EFEFEF;">
        <a href="javascript:viewMessage(#msgid#)">#tsubject#</a>
        </td>
        </tr>
    </cfoutput>
    </table>
	</p>
</cfif>


