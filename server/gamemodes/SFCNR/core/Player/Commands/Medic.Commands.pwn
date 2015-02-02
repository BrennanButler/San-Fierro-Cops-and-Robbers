//sell injection
CMD:sellinjection(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != MEDIC) return SendClientMessage(playerid, COLOR_RED2, "You need to be a medic to use this command");
    if(Injections[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any injections left. Visit a hospital to buy more injections.");
	new id, string[2][128];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sellinjection <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to use this command.");
	if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot sell this player an injection while he is in a vehicle.");
	if(GetPlayerMoney(id) < 1500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to give him injections.");
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have sold an injection to %s and recieved $1500 as a reward.", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been sold a injection by %s at the price of $1500", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	GivePlayerMoney(playerid, 1500);
	GivePlayerMoney(id, -1500);
	Injections[playerid] --;
	Injections[id]++;
	UpdatePlayerJobLevel(playerid);

	return 1;
}

//heal
CMD:heal(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != MEDIC) return SendClientMessage(playerid, COLOR_RED2, "You need to be a medic to use this command");
	new id, string[2][128], Float:health;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /heal <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to use this command.");
	if(GetPlayerMoney(id) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money for healing");
	if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot heal this player while he is in a vehicle.");
	if(GetPlayerHealth(id, health) == 100.0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has already got full health.");
    format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have healed %s and have recieved $1000 as a reward", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been healed by %s at the price of $1000", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	SetPlayerHealth(id, 100.0);
	UpdatePlayerJobLevel(playerid);

	return 1;
}