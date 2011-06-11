<cfset o = CreateObject("component", "OpenHorizon.Storage.ObjectRecord")>
<cfset o.GetByTypeAndPK(attributes.r_type, attributes.r_pk)>

<cfset kw = o.GetKeys()>

<style>
	.keyword_poop td {
		border-bottom:1px solid #c0c0c0;
	}
</style>


<div class="keyword_poop" style="margin-left:30px; margin-bottom:30px; width:250px; height:100px; overflow:auto; text-align:left; border:1px solid #efefef">
	<table width="100%" cellpadding="2" cellspacing="0" border="0">
		<cfloop array=#kw# index="key">
			<cfset kval = o.GetPair(key)>
			<tr>
				<td nowrap><cfoutput>#key#</cfoutput></td>
				<td nowrap>
					<cfoutput>
						<cfif kval EQ "[not set]">
							<em style="color:##c0c0c0;">[not set]</em>
						<cfelse>
							#kval#
						</cfif>
					</cfoutput>
				</td>
			</tr>
		</cfloop>
	
	</table>
</div>