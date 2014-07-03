public OnPlayerPM(playerid, pmto, message[])
{
	return 1;
}

/*public OnPlayerLeavePMGroup(playerid, groupid)
{

	format(G_String, 128, "%s" EMBED_ORANGE " has left the pm group.", PlayerName[playerid]);
	SendMessageToPMGroup(groupid, COLOR_WHITE, G_String);

	if(groupid == PlayerInfo[playerid][GroupID]) {
	    SendMessageToPMGroup(groupid, COLOR_ORANGE, "The leader of the group has left and therefore the group messaging session is over.");
	    for(new i = 0; i < MAX_PLAYERS; ++i) {
			if(PlayerInfo[i][GroupID] == PlayerInfo[playerid][GroupID]) {
			    PlayerInfo[i][GroupID] = -1;
			}
	    }
	}

	return 1;
}
*/