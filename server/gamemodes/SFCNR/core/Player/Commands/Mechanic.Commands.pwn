//fixme command
CMD:fixme(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(IsPlayerWanted(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command while wanted.");
    if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and driving to use this command.");
    SetVehicleHealth(GetPlayerVehicleID(playerid), 100.0);
    RepairVehicle(GetPlayerVehicleID(playerid));
    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have fixed your car");
    return 1;
}

CMD:destroy(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /destroy <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(playerid == id) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(playerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 5.0)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in range of the player to use this command.");
	if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not in any vehicle.");
	WantedLevel[playerid] +=3;
	CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel, "Destroying vehicles");
	VehicleDestroy[GetPlayerVehicleID(id)] = true;
	return 1;
}

//place bulletproof on cars
CMD:placevarmour(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    if(IsPlayerWanted(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command while wanted.");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /placevarmour <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(playerid == id) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(playerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 5.0)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in range of the player to use this command.");
	if(PlayerVariables[id] & PLAYER_HAS_VEHICLE_ARMOUR) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player already has bulletproof armour");
	if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not in any vehicle.");
	if(GetPlayerMoney(id) < 800) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money for you to sell them bulletproof armour.");
	PlayerVariables[playerid] |= PLAYER_HAS_VEHICLE_ARMOUR;
	SendClientMessage(playerid, COLOR_GREEN, "You have successfully installed bulletproof armour on this players car");
	format(G_String, 128, "%s has installed bulletproof armour on your vehicle for a charge of $800", PlayerName(playerid));
	SendClientMessage(id, COLOR_GREEN, G_String);
	GivePlayerMoney(playerid, 800);
	GivePlayerMoney(id, -800);
 	return 1;
}

//fix command
CMD:fix(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    new id, string[2][128], Float:health;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /fix <id>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
   	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
    if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to fix his vehicle.");
    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player needs to be in a vehicle to fix it.");
    GetVehicleHealth(GetPlayerVehicleID(id), health);
    if(health > 430) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This players vehicle does not need to be repaired.");
    if(GetPlayerMoney(id) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to be fixed.");
    RepairVehicle(GetPlayerVehicleID(id));
    format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have fixed %s vehicle and recieved $1000 as a reward.", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} Your car has been fixed by %s at the price of $1000", PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(id, COLOR_RED2, string[1]);
	GivePlayerMoney(playerid, 1000);
	GivePlayerMoney(id, -1000);
	UpdatePlayerJobLevel(playerid);

	return 1;
}

// add nitro
CMD:addnitro(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    new id, string[2][128], component;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /addnitro <id>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
    if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to add nitro to his vehicle.");
    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player needs to be in a vehicle to add nitro to it.");
    if(GetPlayerMoney(id) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to add nitro to his vehicle.");
    component = GetVehicleComponentInSlot(GetPlayerVehicleID(id), CARMODTYPE_NITRO);
    if(component == 1010) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has already got nitro installed on his vehicle.");
    format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have added ntiro to %s vehicle and recieved $1000 as a reward.", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} Your car has been added nitro by %s at the price of $1000", PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	GivePlayerMoney(playerid, 1000);
	GivePlayerMoney(id, -1000);
	AddVehicleComponent(GetPlayerVehicleID(id), 1010);
	UpdatePlayerJobLevel(playerid);

	return 1;
}

//flip command
CMD:flip(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle to use this command");
    new veh = GetPlayerVehicleID(playerid), Float:Angle;
    GetVehicleZAngle(veh, Angle);
    SetVehicleZAngle(veh, Angle);
    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have fliped your vehicle");

	return 1;
}