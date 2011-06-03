<cfquery name="write_comment" datasource="webwarecl">
	INSERT INTO orms_comments
		(r_id,
		user_id,
		comment_body,
		rating)
	VALUES
		('#url.r_id#',
		#url.user_id#,
		'#url.comment_body#',
		#url.rating#)
</cfquery>

<strong>Your comment has been posted.</strong>