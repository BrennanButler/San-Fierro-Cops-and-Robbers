CMD:sellitems(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != ITEMS) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a items dealer to use this command.");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sellitems <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!(PlayerVariables[playerid] & PLAYER_REQUESTED_ITEMS)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has not requested a items dealer with /items.");
	if(ItemStock[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any item stocks left. Visit an 24/7 to refill your stock");
	Rand = random(6);
	if(Rand == 1) {
	//	format(G_String, 128, "[ITEM] :{FFFFFF} You have sold %s some items", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	    PlayerInfo[playerid][Psales]++;
	    //format(G_String, 128, "You have leveled up on your item dealing level! You are now level %d", PlayerInfo[playerid][Pwep]);
	    SendClientMessage(playerid, COLOR_ORANGE, G_String);
	} else {
	    //format(G_String, 128, "[ITEM] :{FFFFFF} You have sold %s some items", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	}
	ItemStock[playerid]--;
    UpdatePlayerJobLevel(playerid);

	return 1;
}
