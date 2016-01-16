CMD:sellweapons(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != WEP) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a weapon dealer to use this command.");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sellweapons <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!(PlayerVariables[playerid] & PLAYER_REQUESTED_WEAPONS)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has not requested a weapon dealer with /weapons.");
	if(WepStock[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any weapon stocks left. Visit an amunation to refill your stock");
	Rand = random(6);
	if(Rand == 1) {
		format(G_String, 128, "[WEP] :{FFFFFF} You have sold %s some weapons", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	    PlayerInfo[playerid][Pwep]++;
	    format(G_String, 128, "You have leveled up on your weapon dealing level! You are now level %d", PlayerInfo[playerid][Pwep]);
	    SendClientMessage(playerid, COLOR_ORANGE, G_String);
	} else {
	    format(G_String, 128, "[WEP] :{FFFFFF} You have sold %s some weapons", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	}
	WepStock[playerid]--;
	UpdatePlayerJobLevel(playerid);

	return 1;
}