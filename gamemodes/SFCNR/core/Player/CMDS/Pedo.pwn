CMD:fiddle(playerid, params[]) 
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerCivilian(playerid) || gTeam[playerid] != PEDO) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a pedo to use this command.");
    new id;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /fiddle <id>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(playerid == id) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
    if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You must be close to the player in order to use this command");
    if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot fiddle with this player while he is in a vehicle.");
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot fiddle with someone while in a vehicle.");
    WantedLevel[playerid] += 3;
    CallLocalFunction("OnPlayerCommitCrime", "iisi", playerid, WantedLevel[playerid], "kiddie fiddling", id);
    ApplyAnimation(id, "BD_FIRE", "BD_FIRE", 4.1, 0, 1, 1, 0, 1, 1);
    format(G_String, 128, "%s has fiddled with your private areas!", PlayerName(playerid));
    SendClientMessage(id, COLOR_ORANGE, G_String);
    format(G_String, 128, "You have fiddled with %s private areas!", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_ORANGE, G_String);

    new Float:H;
    GetPlayerHealth(id, H);

    SetPlayerHealth(id, H-20);

	return 1;
}