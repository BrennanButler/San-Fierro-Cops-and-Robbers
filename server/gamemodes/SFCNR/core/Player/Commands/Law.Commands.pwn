#include <YSI\y_hooks>

new gunPoint;

hook OnGameModeInit()
{
	gunPoint = CreateDynamicCP(-1615.9908,686.2200,7.1875, 2, -1, -1, -1, 100.0); // cop gun point
	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//Pressed enter
	if(newkeys == KEY_SECONDARY_ATTACK)
	{
		if(IsPlayerInDynamicCP(playerid, gunPoint) && !IsPlayerCivilian(playerid))
		{
			inline GunPoint(pid, dialogid, response, listitem, string:inputtext[])
			{
				#pragma unused pid, dialogid, inputtext
				if(!response) return 0;
				switch(listitem)
				{
				    case 0:
					{
					    SetPlayerArmour(playerid, 100.0);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given armour.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 1:
					{
					    GivePlayerWeapon(playerid, 22, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a 9mm.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 2:
					{
					    GivePlayerWeapon(playerid, 23, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Silenced 9mm.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 3:
					{
					    GivePlayerWeapon(playerid, 24, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Desert Eagle.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 4:
					{
					    GivePlayerWeapon(playerid, 27, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Combat Shotgun.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 5:
					{
	                    GivePlayerWeapon(playerid, 29, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a MP5.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 6:
					{
					    GivePlayerWeapon(playerid, 32, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Tec 9.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 7:
					{
					    GivePlayerWeapon(playerid, 30, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a AK47.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 8:
					{
					    GivePlayerWeapon(playerid, 31, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a M4.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
					case 9:
					{
					    GivePlayerWeapon(playerid, 34, 500);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Sniper Rifle.");
					    Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
					}
				}
			}
			Dialog_ShowCallback(playerid, using inline GunPoint, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
		}
	}
	return 1;
}

CMD:clamp(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a law enforcment to use this command.");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /clamp <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You must be on foot to use this command.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} The player needs to be in a vehicle in order for you to use this command.");
	if(Clamped[GetPlayerVehicleID(id)]) {
	    Clamped[GetPlayerVehicleID(id)] = false;
	    SendClientMessage(playerid, COLOR_GREEN, "You have removed this players vehicle clamp.");
	    SendClientMessage(id, COLOR_RED2, "[CLAMP] :{FFFFFF} Your vehicles clamp has been removed.");
	    SetVehicleEngineState(GetPlayerVehicleID(id), 1);
	} else {
		Clamped[GetPlayerVehicleID(id)] = true;
		SetVehicleEngineState(GetPlayerVehicleID(id), 0);
		SetVehicleVelocity(GetPlayerVehicleID(id), 0.0, 0.0, 0.0);
	    SendClientMessage(playerid, COLOR_GREEN, "You have installed a clamp on this players vehicle.");
	    SendClientMessage(id, COLOR_RED2, "[CLAMP] :{FFFFFF} Your vehicle has been clamped and can no longer move.");
	}
	return 1;
}

CMD:arrest(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be an law enforcer to use this command.");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /arrest <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!IsPlayerCivilian(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is an law enforcement. You can only arrest civilians.");
	if(WantedLevel[id] < 4) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You can only arrest civilians with a wanted level higher than 3.");
	Rand = random(sizeof(PrisonSpawns));
	SetPlayerPos(id, PrisonSpawns[Rand][0], PrisonSpawns[Rand][1], PrisonSpawns[Rand][2]);
	SetPlayerFacingAngle(id, PrisonSpawns[Rand][3]);
	SetPlayerWantedLevel(id, 0);

	if(WantedLevel[id] > 3 && WantedLevel[id] < 11) {
	    SetPrisonTime(id, 2 * 60);
	} else if(WantedLevel[id] > 10 && WantedLevel[id] < 21) {
	    SetPrisonTime(id, 3 * 60);
	} else if(WantedLevel[id] > 20 && WantedLevel[id] < 31) {
	    SetPrisonTime(id, 4 * 60);
	} else if(WantedLevel[id] > 30 && WantedLevel[id] < 51) {
	    SetPrisonTime(id, 6 * 60);
	} else if(WantedLevel[id] > 50) {
	    SetPrisonTime(id, 8 * 60);
	}

    PlayerVariables[id] |= PLAYER_IN_JAIL;
    PlayerVariables[id] &= ~PLAYER_CUFFED;
	UpdatePlayerJobLevel(playerid);
	SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
	GivePlayerMoney(playerid, 500);
    SetPlayerTeam(id, 0);
	return 1;
}

/*CMD:ar(playerid, params[])
{
	return cmd_arrest(playerid, params);
}
*/
CMD:search(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be an law enforcer to use this command.");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /search <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!IsPlayerCivilian(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is an law enforcement. You can only arrest civilians.");
	new Pwanted = 0;

	if(Weed[id] != 0) {

		if(Weed[id] >= 1 && Weed[id] < 50) {
			Pwanted +=1;
		} else if(Weed[id] > 50 && Weed[id] < 150) {
			Pwanted +=3;
		} else if(Weed[id] > 150 && Weed[id] < 250) {
			Pwanted += 4;
		} else {
			Pwanted += 5;
		}
	}
	if(Heroin[id] != 0) {

		if(Heroin[id] >= 1 && Heroin[id] < 50) {
			Pwanted +=2;
		} else if(Heroin[id] > 50 && Heroin[id] < 150) {
			Pwanted +=4;
		} else if(Heroin[id] > 150 && Heroin[id] < 250) {
			Pwanted += 5;
		} else {
			Pwanted += 6;
		}
	}
	if(Cocaine[id] != 0) {

		if(Cocaine[id] >= 1 && Cocaine[id] < 50) {
			Pwanted +=2;
		} else if(Cocaine[id] > 50 && Cocaine[id] < 150) {
			Pwanted +=4;
		} else if(Cocaine[id] > 150 && Cocaine[id] < 250) {
			Pwanted += 5;
		} else {
			Pwanted += 6;
		}
	}

	if(Pwanted > 0) {
		WantedLevel[id] += Pwanted;
		CallLocalFunction("OnPlayerCommitCrime", "iis", id, WantedLevel[id], "Carrying drugs", -1);
		SendClientMessage(playerid, COLOR_GREEN, "[SEARCH] :{FFFFFF} This player is carrying drugs! Use /taze to tazer him and /arrest to then arrest the criminal.");
	} else {
		SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has no drugs on him.");
	}
 	return 1;
}

/*CMD:spike(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a special class to use this command.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be onfoot to use this command.");
	if(RoadSpikes[playerid] == 3) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have reached max road spikes! Go back to one and use /delspike");
	new ID = GetSpikeID(), Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
	SpikeInfo[ID][SpikeX] = pos[0];
	SpikeInfo[ID][SpikeY] = pos[1];
	SpikeInfo[ID][SpikeZ] = pos[2]-1.0;
	SpikeInfo[ID][Spikeid] = CreateDynamicObject(2892, pos[0], pos[1], pos[2]-1.0, 0.0, 0.0, pos[3]-90.0, -1, -1, -1, 300.0);
	RoadSpikes[playerid]++;
	SpikeCreated[ID] = true;
	return 1;
}

CMD:roadblock(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a special class to use this command.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be onfoot to use this command.");
	if(RoadBlocks[playerid] == 3) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have reached max road spikes! Go back to one and use /delspike");
	new ID = GetRoadBlockID(), Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
	RoadBlock[ID][RBX] = pos[0];
	RoadBlock[ID][RBY] = pos[1];
	RoadBlock[ID][RBZ] = pos[2]+2.0;
	RoadBlock[ID][BlockID] = CreateDynamicObject(978, pos[0], pos[1], pos[2]-1.0, 0.0, 0.0, pos[3]-90.0, -1, -1, -1, 300.0);
	RoadBlocks[playerid]++;
	RBCreated[ID] = true;
	return 1;
}

CMD:delspike(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a special class to use this command.");
	for(new i = 0; i < MAX_SPIKES; i++) {
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, SpikeInfo[i][SpikeX], SpikeInfo[i][SpikeY], SpikeInfo[i][SpikeZ])) {
	        DestroyDynamicObject(SpikeInfo[i][Spikeid]);
	        SpikeCreated[i] = false;
	        RoadSpikes[playerid]--;
	    }
	}
	return 1;
}

CMD:delrb(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a special class to use this command.");
	for(new i = 0; i < MAX_ROADBLOCKS; i++) {
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, RoadBlock[i][RBX], RoadBlock[i][RBY], RoadBlock[i][RBZ])) {
	        DestroyDynamicObject(RoadBlock[i][BlockID]);
       		RBCreated[i] =  false;
        	RoadBlocks[playerid]--;
	    }
	}
	return 1;
}*/

CMD:taze(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be an law enforcer to use this command.");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /taze <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!IsPlayerCivilian(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is an law enforcement. You can only arrest civilians.");
	if(WantedLevel[id] < 4) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You can only taze civilians with a wanted level higher than 3.");
	PlayerVariables[playerid] |= PLAYER_TAZED;
	PlayerPlaySound(id, 1190, 0, 0, 0);
	ClearAnimations(id);
	ApplyAnimation(id, "FINALE", "FIN_Land_Die", 4.1, 0, 1, 1, 0, 0, 1);

	return 1;
}

CMD:grab(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(gTeam[playerid] != SWAT && gTeam[playerid] != STAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be swat or stat to use this command");
	if(lastveh[playerid] == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to enter a car first.");
	new id, Float:pos[3];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /grab <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(WantedLevel[id] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not wanted.");
	GetVehiclePos(lastveh[playerid], pos[0], pos[1], pos[2]);
	if(!IsPlayerInRangeOfPoint(playerid, 50, pos[0], pos[1], pos[2])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to your vehicle.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close enough to grab this player");
	PutPlayerInVehicle(id, lastveh[playerid], 1);
	MsgP(playerid, COLOR_DARKGREY, "* "EMBED_WHITE"You have grabed "EMBED_RED2"%s "EMBED_WHITE"into your vehicle.", PlayerName[id]);
	MsgP(id, COLOR_DARKGREY, "* "EMBED_WHITE"You have been "EMBED_RED2"grabbed"EMBED_WHITE" and placed into "EMBED_RED2"%s "EMBED_WHITE"vehicle", PlayerName[playerid]);
	return 1;
}

CMD:cuff(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a law enforcement to use this command");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /cudd <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerVariables[id] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already cuffed.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerCivilian(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is an law enforcement. You can only cuff civilians.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close enough to cuff this player.");
	SetPlayerCuffed(id, 1);
	PlayerVariables[id] |= PLAYER_CUFFED;
	SendClientMessage(playerid, COLOR_GREEN, "[CUFFS] :{FFFFFF} You have cuffed this player");
	SendClientMessage(playerid, COLOR_ORANGE, "You can use /search to search this player or /ar if this player is wanted.");
	SendClientMessage(id, COLOR_GREEN, "[CUFFS] :{FFFFFF} You have been cuffed by an law enforcement");
	SendClientMessage(id, COLOR_ORANGE, "You have been cuffed by a law enforcement, use /breakcuffs to break out your cuffs.");

	return 1;
}

CMD:uncuff(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a law enforcement to use this command");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /cudd <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(!(PlayerVariables[id] & PLAYER_CUFFED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not cuffed.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerCivilian(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is an law enforcement. You can only cuff civilians.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close enough to cuff this player.");
	SetPlayerCuffed(id, 0);
	PlayerVariables[id] &= ~PLAYER_CUFFED;
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have uncuffed this player");
	SendClientMessage(id, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been uncuffed by an law enforcement");

	return 1;
}

CMD:laser(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(gTeam[playerid] != STAT && gTeam[playerid] != ARMY && gTeam[playerid] != SWAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is only for special classes");
	Laser[playerid] =1;
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Laser enabled");

	return 1;
}

CMD:plantbomb(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != SWAT && gTeam[playerid] != STAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be apart of the S.W.A.T or S.T.A.T team to use this command.");
	if(!(PlayerVariables[playerid] & PLAYER_HAS_BOMB)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need a bomb in order to use this command.");
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	Bomb[playerid] = CreateDynamicObject(1252, pos[0], pos[1], pos[2], 0.0, 0.0, 0.0);
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerVariables[playerid] &= ~PLAYER_HAS_BOMB;
	return 1;
}

CMD:detonate(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != SWAT && gTeam[playerid] != STAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be apart of the S.W.A.T or S.T.A.T team to use this command.");
	if(PlayerVariables[playerid] & PLAYER_HAS_BOMB || Bomb[playerid] == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to place your bomb in order to use this command.");
	new Float:pos[3];
	GetObjectPos(Bomb[playerid], pos[0], pos[1], pos[2]);
	CreateExplosion(pos[0], pos[1], pos[2], 0, 2.0);
	DestroyDynamicObject(Bomb[playerid]);
	Bomb[playerid] = -1;
	PlayerVariables[playerid] &= ~PLAYER_HAS_BOMB;
	return 1;
}

