new RoadSpikes[3][MAX_PLAYERS];

CMD:spike(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a special class to use this command.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be onfoot to use this command.");
	//if(RoadSpikes[2][playerid] != -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have reached max road spikes! Go back to one and use /delspike");
	new Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
	GetPointZPos(pos[0], pos[1], pos[2]);
	Stinger_Create(2892, pos[0], pos[1], pos[2], pos[3]);
	return 1;
}