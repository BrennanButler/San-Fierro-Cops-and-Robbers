CMD:reqpizza(playerid, params[]) 
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] == PIZZABOY) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot request pizza's as a pizza boy.");
	format(G_String, 128, "[ALERT] :{FFFFFF} %s is requesting a pizza at the location %s", PlayerName(playerid), PlayerZone(playerid));
	SendMessageToClass(PIZZABOY, COLOR_GREEN, G_String);
	PlayerVariables[playerid] |= PLAYER_REQUESTED_PIZZA;
	PizzaRequestTime[playerid] = gettime();
	return 1;
}


CMD:sellpizza(playerid, params[]) 
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != PIZZABOY) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a pizza boy to use this command.");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "ERROR: Usage: /sellpizza <id>");
	if(id == playerid) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You cannot sell yourself pizza.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "ERROR: This player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You have to be near the player in order to sell him pizza.");
	if(GetPlayerMoney(id) < 15) return SendClientMessage(playerid, COLOR_GREY, "ERROR: This player does not have enough money for you to sell him a pizza.");
	GivePlayerMoney(playerid, 15);
	GivePlayerMoney(id, -15);
	return 1;
}
