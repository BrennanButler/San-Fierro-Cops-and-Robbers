CMD:taxirate(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != TAXI) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a taxi driver to use this command.");
	new money;
	if(sscanf(params,"d", money)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /taxirate <money>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(money < 1 || money > 100) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum: $1 Maximum: $99");
	SendClientMessage(playerid, COLOR_RED2, "[TAXI] :{FFFFFF} You have set your new taxi rate");
	PlayerInfo[playerid][Ptaxirate] = money;
	return 1;
}

CMD:privatedriver(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != TAXI) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a taxi driver to use this command.");
	new id;
	if(sscanf(params,"d", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /privatedriver <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot be a private driver for yourself!");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
	if(PlayerVariables[id] & PLAYER_HAS_PRIVATE_DRIVER) return SendClientMessage(playerid, COLOR_GREY, "ERROR: This player already has a private driver.");
	format(G_String, 128, "[TAXI] :{FFFFFF} %s has offered to be a private driver. Use /acceptprivate to confirm this.", PlayerName(playerid));
	SendClientMessage(id, COLOR_GREEN, G_String);
	SendClientMessage(playerid, COLOR_GREEN, "[TAXI] :{FFFFFF} You have sent a private driver request to this player.");
	RequestedDriver[id] = playerid;
	RequestedDriverCoolDown[id] = gettime();
	return 1;
}