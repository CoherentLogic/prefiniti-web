<!--- #attributes.turl# --->
<cfoutput>
	<img id="play_sound" src="/graphics/AppIconResources/crystal_project/32x32/actions/player_play.png" style="display:inherit;" onclick="ORMSPlaySound('#attributes.turl#'); hideDiv('play_sound'); showDiv('stop_sound');">
	<img id="stop_sound" src="/graphics/AppIconResources/crystal_project/32x32/actions/player_stop.png" style="display:none;" onclick="ORMSStopSound(); showDiv('play_sound'); hideDiv('stop_sound');">
</cfoutput>