	<LINK REL="SHORTCUT ICON" href="http://www.prefiniti.com/graphics/webware-16x16.ico">
<cfif IsDefined("URL.view")>
<cfoutput>	<link rel="alternate" type="application/rss+xml" title="Prefiniti RSS" href="#session.framework.URLBase#OpenHorizon/Storage/EventFeed/RSS.cfm?orms_id=#url.view#"></cfoutput>
</cfif>