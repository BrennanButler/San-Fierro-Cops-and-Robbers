CMD:moviemode(playerid, params[])
{
	if(PlayerVariables[playerid] & PLAYER_IN_MOVIE_MODE) {
		TextDrawShowForPlayer(playerid, URL);
		PlayerTextDrawShow(playerid, PlayerText:Zone[playerid]);
  		PlayerVariables[playerid] &= ~PLAYER_IN_MOVIE_MODE;
	} else {
		TextDrawHideForPlayer(playerid, URL);
		PlayerTextDrawHide(playerid, PlayerText:Zone[playerid]);
		TextDrawHideForPlayer(playerid, timetext);
		PlayerVariables[playerid] |= PLAYER_IN_MOVIE_MODE;
	}
	return 1;
}



CMD:creategroup(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerInfo[playerid][GroupID] == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} It seems you already own a group!"), SendClientMessage(playerid, COLOR_ORANGE, "You can delete your group via /leavegroup or invite players via /groupinvite");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");

    if(PlayerInfo[playerid][GroupID] != -1) {
        CallRemoteFunction("OnPlayerLeavePMGroup", "ii", playerid, PlayerInfo[playerid][GroupID]);
    }
    PlayerInfo[playerid][GroupID] = playerid;

    format(G_String, 128, "You have created your group! Use /groupinvite <id> to invite someone or tell them the group id : %d", PlayerInfo[playerid][GroupID]);
    SendClientMessage(playerid, COLOR_ORANGE, G_String);
	return 1;
}

CMD:groupmessage(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerInfo[playerid][GroupID] == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} It seems you haven't joined a group!"), SendClientMessage(playerid, COLOR_ORANGE, "You can join a group by using /groupjoin <id> after someone has invited you.");
    new message[128];
    if(sscanf(params, "s[128]", message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /groupmessage <message>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "~Group Message~ [%s]: {FFFFFF} %s", PlayerName(playerid), message);
    SendMessageToPMGroup(PlayerInfo[playerid][GroupID], COLOR_ORANGE, G_String);

	return 1;
}

CMD:gm(playerid, params[])
{
	return cmd_groupmessage(playerid, params);
}

CMD:groupleave(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][GroupID] == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} It seems you haven't joined a group!"), SendClientMessage(playerid, COLOR_ORANGE, "You can join a group by using /groupjoin <id> after someone has invited you.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");

    if(PlayerInfo[playerid][GroupID] != -1) {
        CallRemoteFunction("OnPlayerLeavePMGroup", "ii", playerid, PlayerInfo[playerid][GroupID]);
    }

    PlayerInfo[playerid][GroupID] = -1;

	return 1;
}

CMD:911(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /backup if you need to report a crime.");
	new message[128];
	if(sscanf(params, "s[128]", message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /911 <crime>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(strlen(message) < 2) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please make your input longer");
	format(G_String, 128, "[LAW] %s has reported crime \"%s\" at location %s", PlayerName(playerid), message, PlayerZone(playerid));
	SendMessageToLaw(COLOR_BLUE1, G_String);
	SendClientMessage(playerid, COLOR_GREEN, "Your crime report has been sent to any online law enforcments.");
	return 1;
}

	CMD:groupinvite(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][GroupID] != playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} It seems you haven't joined a group!"), SendClientMessage(playerid, COLOR_ORANGE, "You can create a group by using /groupcreate and invite people via /groupinvite");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /groupinvite <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "~Group Message~ : {FFFFFF} %s has invited %s", PlayerName(playerid), PlayerName(id));
    SendMessageToPMGroup(PlayerInfo[playerid][GroupID], COLOR_ORANGE, G_String);
    format(G_String, 128, "You have been invited to %s group! Use /groupjoin %d to join the group", PlayerName(playerid), PlayerInfo[playerid][GroupID]);
    SendClientMessage(id, COLOR_ORANGE, G_String);

 	return 1;
}

CMD:groupjoin(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /groupinvite <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");


    if(PlayerInfo[playerid][GroupID] != -1) {
        CallRemoteFunction("OnPlayerLeavePMGroup", "ii", playerid, PlayerInfo[playerid][GroupID]);
    }

    PlayerInfo[playerid][GroupID] = id;

	format(G_String, 128, "~Group Message~ : {FFFFFF} %s has joined the group", PlayerName(playerid));
    SendMessageToPMGroup(id, COLOR_ORANGE, G_String);

	return 1;
}

CMD:groupmembers(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(PlayerInfo[playerid][GroupID] == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} It seems you haven't joined a group!"), SendClientMessage(playerid, COLOR_ORANGE, "You can join a group by using /groupjoin <id> after someone has invited you.");
    format(G_String, 128, "Group %d | Members", PlayerInfo[playerid][GroupID]);
    SendClientMessage(playerid, COLOR_ORANGE, G_String);
    SendClientMessage(playerid, -1, "");

    foreach(Player, i) {

        if(PlayerInfo[playerid][GroupID] == PlayerInfo[i][GroupID]) {
            if(PlayerInfo[i][GroupID] == i) {
				format(G_String, 128, "%s - Group Owner", PlayerName(i));
				SendClientMessage(playerid, COLOR_ORANGE, G_String);
			} else {
			    format(G_String, 128, "%s", PlayerName(i));
				SendClientMessage(playerid, COLOR_ORANGE, G_String);
			}
        }
    }

	return 1;
}

CMD:groupkick(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][GroupID] != playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} It seems you haven't joined a group!"), SendClientMessage(playerid, COLOR_ORANGE, "You can create a group by using /groupcreate and invite people via /groupinvite");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /groupinvite <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[id][GroupID] != playerid) return SendClientMessage(playerid, COLOR_ORANGE, "[ERROR] :{FFFFFF} This player is not in your group.");
    if(playerid == id) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /groupleave to leave your group.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
	format(G_String, 128, "~Group Message~ : {FFFFFF} %s has been kicked from the group", PlayerName(id));
    SendMessageToPMGroup(id, COLOR_ORANGE, G_String);

    PlayerInfo[id][GroupID] = -1;

	return 1;
}

CMD:eject(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle to use this command.");
	RemovePlayerFromVehicle(playerid);
	return 1;
}

CMD:ejectall(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle to use this command.");
	foreach(Player, i) {
	    if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid))) RemovePlayerFromVehicle(i);
	}
	return 1;
}

CMD:ejectplayer(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle to use this command.");
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ejectplayer <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(playerid == id) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /eject to eject yourself from the vehicle.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
	if(!IsPlayerInVehicle(id, GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not in your vehicle.");
	RemovePlayerFromVehicle(id);
	return 1;
}

CMD:quitjob(playerid, params[]) 
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Only a civilian can have jobs.");
    if(!(PlayerVariables[playerid] & PLAYER_IN_JOB)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a job in order to quit it.");
	GivePlayerMoney(playerid, SweeperCash[playerid]);
	SetPlayerScore(playerid, GetPlayerScore(playerid)+TotalSweeps);
	format(G_String, 128, "~g~$%d Earned!", SweeperCash[playerid]);
	GameTextForPlayer(playerid, G_String, 3000, 4);
	SweeperCash[playerid] = 0;
	SweeperWeight[playerid] = 0;
	Sweeped[playerid] = 0;
	TimeSinceSweep[playerid] = gettime();
	PlayerVariables[playerid] &= ~PLAYER_IN_JOB;
	for(new i = 0; i < MAX_SWEEPS; i++) {
		if(SweeperInfo[i][Player] == playerid) {
			DestroyDynamicMapIcon(SweeperInfo[i][MapIcon]);
			DestroyDynamicObject(SweeperInfo[i][Obj]);
		}
	}
	return 1;
}

CMD:robstore(playerid, params[])
{
	if(!IsPlayerCivilian(playerid) && gTeam[playerid] != MECHANIC && gTeam[playerid] != HITMAN && gTeam[playerid] != TRUCKER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Law enforcements are not allowed to rob stores.");
	if(!IsPlayerInRobberyCheckpoint(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the store and in the checkpoint to use this command.");
	new rob = CommenceRobbery(playerid, PlayerRobberyID[playerid]);
	if(rob == -2) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This store has already been robbed.");
	if(rob == -3) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot rob this store while it's being robbed.");
	return 1;
}



CMD:rape(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Law enforcements are not allowed to use criminal commands.");
    new id, string[4][128];
    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /rape <id>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(playerid == id) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
    if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You must be close to the player in order to use this command");
    if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot rape this player while he is in a vehicle.");
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot rob someone while in a vehicle.");
    if(AntiRape[id] == true) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has an anti rape device. You cannot rape them.");
	if(!HasPlayerRecentlyBeenRaped(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has recently been raped.");
	WantedLevel[playerid] +=4;
	RapeTime[id] = gettime();
	format(string[0], 128, "[CRIME] {FFFFFF}You have raped %s", PlayerName(id));
	format(string[1], 128, "[CRIME] {FFFFFF}You have commited a crime and your wanted level now stands at: %i", WantedLevel[playerid]);
	format(string[2], 128, "[CRIME] {FFFFFF}%s has been raped by %s",PlayerName(id),  PlayerName(playerid));
	format(string[3], 128, "[CRIME COMMITED] %s has raped a civilian. All law enforcers dispatch at his location: %s", PlayerName(playerid), PlayerZone(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	SendClientMessageToAll(COLOR_RED2, string[2]);
	SendMessageToLaw(COLOR_BLUE1, string[3]);
	SendMessageToLaw(COLOR_BLUE1, "[DISPATCH] ALL OFFICERS PLEASE RESPOND TO THIS CRIME");
	if(gTeam[playerid] == RAPIST || gTeam[playerid] == PEDO) {
		format(G_String, 128, "%s has been infected with %s", PlayerName(id), PlayerInfo[playerid][STD]);
		SendClientMessageToAll(COLOR_ORANGE, G_String);
		format(PlayerInfo[id][STD], 100, PlayerInfo[playerid][STD]);
		PlayerVariables[id] |= PLAYER_RAPED;
	} else if(gTeam[id] == RAPIST || gTeam[id] == PEDO) {
	    format(G_String, 128, "%s has been infected with %s", PlayerName(playerid), PlayerInfo[id][STD]);
		SendClientMessageToAll(COLOR_ORANGE, G_String);
		format(PlayerInfo[playerid][STD], 100, PlayerInfo[id][STD]);
		PlayerVariables[playerid] |= PLAYER_RAPED;
	}
	CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel[playerid], "Raping another player", -1);
	SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
	return 1;
}

CMD:exithouse(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new HouseI = House[playerid];
	if(HouseI == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not in a house.");
    SetPlayerPos(playerid, HouseInfo[HouseI][Xpos], HouseInfo[HouseI][Ypos], HouseInfo[HouseI][Zpos]);
    SetPlayerInterior(playerid, 0);
    HouseI = -1;
    return 1;
}

CMD:stats(playerid, params[])
{
	new string[3][200], Master[600];
	format(string[0], 200, "{FFFFFF}Admin Level            %d\n{FFFFFF}Cop Level           %d\nArrest Level            %d\n{FFFFFF}Rob Level           %d\n{FFFFFF}Rape Level          %d\n{FFFFFF}Medic Level         %d\n{FFFFFF}Hitman Level            %d\n", PlayerInfo[playerid][Padmin], PlayerInfo[playerid][Pcop], PlayerInfo[playerid][Parrest], PlayerInfo[playerid][Prob], PlayerInfo[playerid][Prape], PlayerInfo[playerid][Pheal], PlayerInfo[playerid][Phitman]);
	format(string[1], 200, "{FFFFFF}VIP Level           %d\n{FFFFFF}Money           %d\n{FFFFFF}Salesman Level          %d\n{FFFFFF}Weapon Sales Level          %d\n", PlayerInfo[playerid][Pvip], GetPlayerMoney(playerid), PlayerInfo[playerid][Psales], PlayerInfo[playerid][Pwep]);
	format(string[2], 200, "{FFFFFF}Drug Dealer Level           %d\n{FFFFFF}Trucker Level           %d\n{FFFFFF}Stat Level          %d\n{FFFFFF}Army Level          %d", PlayerInfo[playerid][Pdrug], PlayerInfo[playerid][Ptruck], PlayerInfo[playerid][Pstat], PlayerInfo[playerid][Parmy]);
	strcat(Master, string[0]);
	strcat(Master, string[1]);
	strcat(Master, string[2]);
	ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Statistics", Master, "Ok", "Close");

	// this needs to be re-done as well as the dialogs as before I never knew about \t (tab)
	return 1;
}

CMD:chatc(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new color;
    if(sscanf(params,"i",color)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /chatc <0-4>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    switch(color)
	{
	    case 0:
	    {
	        pChat_Color[playerid] = 1;
	        SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {00FF00}Green {FFFFFF}text");
		}
		case 1:
		{
		    pChat_Color[playerid] = 2;
		    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {FF0000}Red {FFFFFF}text");
		}
		case 2:
		{
		    pChat_Color[playerid] = 3;
		   	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {00FFFF}Cyan {FFFFFF}text");
		}
		case 3:
		{
		    pChat_Color[playerid] = 4;
		   	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {0000FF}Blue {FFFFFF}text");
		}
		case 4:
		{
		    pChat_Color[playerid] = 5;
		   	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {800080}Purple {FFFFFF}text");
		}
		case 5:
		{
		    pChat_Color[playerid] = 0;
		   	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have returned to your default chat colour.");
		}
		default:
		{
		    SendClientMessage(playerid, COLOR_RED2, "[ERROR] Use numbers 0-4 for different colours. 5 to go back to default.");
		}
  	}

	return 1;
}

CMD:exitleisure(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(!(PlayerVariables[playerid] & PLAYER_IN_LEISURE)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the leisure center before exiting it!");
	SetPlayerPos(playerid, -2110.3142,-445.6071,38.7344);
	SetPlayerInterior(playerid, 0);
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have exited the leisure center");

	return 1;
}

//rob command
CMD:rob(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] == STAT || gTeam[playerid] == ARMY || gTeam[playerid] == SWAT || gTeam[playerid] == POLICE) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Law enforcements are not allowed to use criminal commands.");
	new string[4][128], id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /rob <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
 	//if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You must be close to the player in order to use this command");
	if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot rob this player while he is in a vehicle.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot rob someone while in a vehicle.");
	if(Wallet[id] == true) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has a wallet. You cannot rob them.");
	if(!HasPlayerRecentlyBeenRobed(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has recently been robbed.");
	if(GetPlayerMoney(id) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to be robbed");
	new Money = randomEx(1, GetPlayerMoney(id));
	GivePlayerMoney(playerid, Money);
	GivePlayerMoney(id, -Money);
	format(G_String, 128, "~g~$%d Stolen!", Money);
	GameTextForPlayer(playerid, G_String, 3000, 4);
	RobTime[id] = gettime();
	WantedLevel[playerid] += 4;
	SetPlayerWantedLevel(playerid, WantedLevel[playerid]);
	format(string[0], 128, "[CRIME] {FFFFFF}You have robbed $%i from %s", Money, PlayerName(id));
	format(string[1], 128, "[CRIME] {FFFFFF}You have commited a crime and your wanted level now stands at: %i", WantedLevel[playerid]);
	format(string[2], 128, "[CRIME] {FFFFFF}You have been robed $%i from %s", Money, PlayerName(playerid));
	format(string[3], 128, "[CRIME COMMITED] %s has robbed a civilian. All law enforcers dispatch at his location: %s", PlayerName(playerid), PlayerZone(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	SendClientMessage(id, COLOR_RED2, string[2]);
	SendMessageToLaw(COLOR_BLUE1, string[3]);
	SendMessageToLaw(COLOR_BLUE1, "[DISPATCH] ALL OFFICERS PLEASE RESPOND TO THIS CRIME");
	CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel[playerid], "Robbing another player", id);
	SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
	return 1;
}

//whisper command
CMD:whisper(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new message[2][128];
    if(sscanf(params,"s[128]", message[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /whisper <message>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(message[1], 128, "[WHISPER] %s :{FFFF00} %s", PlayerName(playerid), message[0]);
    ProxDetector(10, playerid, message[1], COLOR_LIGHTBLUE);
    SetPlayerChatBubble(playerid, message[0], COLOR_YELLOW, 10, 10000);

    return 1;
}

CMD:w(playerid, params[])
{
	return cmd_whisper(playerid, params[0]);
}

//give money command
CMD:gc(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new id, ammount, string[2][128];
    if(sscanf(params,"ui",id,ammount)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /gm <ammount>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(GetPlayerMoney(playerid) < ammount) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have this ammount of money");
	if(ammount < 0 || ammount > 200000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Min: $1 Max: $200000");
	GivePlayerMoney(playerid, -ammount);
	GivePlayerMoney(id, ammount);
	format(string[0], 128, "You have given %s $%i", PlayerName(id), ammount);
	format(string[1], 128, "You have been given $%i by %s", ammount, PlayerName(playerid));
	SendClientMessage(playerid, COLOR_LIGHTGREEN, string[0]);
	SendClientMessage(id, COLOR_LIGHTGREEN, string[1]);

	return 1;
}

// me command
CMD:me(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_MUTED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command while muted");
    new text[128];
    if(sscanf(params,"s[128]",text)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /me <text>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "** %s %s", PlayerName(playerid), text);
    SendClientMessageToAll(COLOR_PINK, G_String);

	return 1;
}
//report command
CMD:report(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new id, reason[128];
    if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /report <id> <reason>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
    format(G_String, 128, "[Report] :{FFFFFF} %s  -  %s", reason, PlayerName(playerid));
    SendMessageToAdmins(COLOR_RED2, G_String);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "Report submitted to admins");

	return 1;
}

//ask command
CMD:ask(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new message[128], string[2][128];
    if(sscanf(params,"s[128]", message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ask <question>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(string[0], 128, "[Question] {FFFFFF} %s  -  %s", PlayerName(playerid), message);
    format(string[1], 128, "Use /apm %i <answer> to answer the players question", playerid);
    SendMessageToAdmins(COLOR_RED2, string[0]);
    SendMessageToAdmins(COLOR_LIGHTGREEN, string[1]);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "Question submitted to admins");

	return 1;
}

	
//------------------------------------------------
// Private message system

// PM command
CMD:pm(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	new id, message[128], string[2][128];
	if(sscanf(params,"us[128]",id,message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /pm <id> <message>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerVariables[id] & PLAYER_PM_OFF) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has his private messages turned off.");
	if(Ignore[id][playerid] == true) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is ignoreing you! You cannot send pms to this player.");
	format(string[0], 128, "** {FFFF00}PM From %s : %s {008000}**", PlayerName(playerid), message);
	format(string[1], 128, "** {FFFF00}PM To %s : %s {008000}**", PlayerName(id), message);
	SendClientMessage(playerid, COLOR_GREEN, string[1]);
	SendClientMessage(id, COLOR_GREEN, string[0]);
	LastPM[id] = playerid;
	CallLocalFunction("OnPlayerPM", "iis", playerid, id, message);
	return 1;
}

//ignore someone
CMD:ignore(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ignore <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(Ignore[playerid][id] == true) {
		format(G_String, 128, "[PM] :{FFFFFF} You have un ignored %s", PlayerName(id));
		SendClientMessage(playerid, COLOR_RED2, G_String);
		SendClientMessage(playerid, COLOR_ORANGE, "You have unignored a player. To ignore this player use this command again");
		Ignore[playerid][id] = false;
	} else {
		format(G_String, 128, "[PM] :{FFFFFF} You have ignored %s he can no longer send you private messages", PlayerName(id));
		SendClientMessage(playerid, COLOR_RED2, G_String);
		SendClientMessage(playerid, COLOR_ORANGE, "You have ignored a player. To unignore this player use this command again.");
		Ignore[playerid][id] = true;
	}

	return 1;
}

//pm toggle
CMD:pmtoggle(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerVariables[playerid] & PLAYER_PM_OFF) {
		SendClientMessage(playerid, COLOR_ORANGE, "You have turned off your private messages.");
		PlayerVariables[playerid] &= ~PLAYER_PM_OFF;
	} else {
		SendClientMessage(playerid, COLOR_ORANGE, "You have turned on your private messages.");
		PlayerVariables[playerid] |= PLAYER_PM_OFF;
	}

	return 1;
}

// Reply command
CMD:r(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
    if(LastPM[playerid] == -1) return SendClientMessage(playerid, -1, "No one has pm'ed you since you joined the server");
    if(LastPM[playerid] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "The player that last pm'ed you has left the server");
	if(Ignore[LastPM[playerid]][playerid] == true) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is ignoreing you! You cannot send pms to this player.");
	if(PlayerVariables[LastPM[playerid]] & PLAYER_PM_OFF) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has his private messages turned off.");
	new string[2][128], message[128];
    if(sscanf(params,"s[128]",message)) return SendClientMessage(playerid, -1, "Syntax: /r <message>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(string[0], 128, "** {FFFF00}PM To %s : %s {008000}**", PlayerName(LastPM[playerid]), message);
    format(string[1], 128, "** {FFFF00}PM From %s : %s {008000}**", PlayerName(playerid), message);
    SendClientMessage(playerid, COLOR_GREEN, string[0]);
    SendClientMessage(LastPM[playerid], COLOR_GREEN, string[1]);
    LastPM[LastPM[playerid]] = playerid;
   	CallLocalFunction("OnPlayerPM", "iis", playerid, LastPM[playerid], message);
    return 1;
}

// Bug report command
CMD:bug(playerid, params[])
{
	new File:file=fopen(BugPath(playerid), io_append);
	new Bug[128], formatted[128];
	if(sscanf(params,"s[128]",Bug)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /rbug <Bug>");
	if(file)
	{
		format(formatted, 128, "%s\r\n", Bug);
	    fwrite(file, formatted);
	    fclose(file);
	    SendClientMessage(playerid, COLOR_GREEN, "Bug reported.");
	}

	return 1;
}

//place hit
CMD:hit(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new id, price;
    if(sscanf(params,"ui",id,price)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /hit <id> <price>");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(price < 10000 || price > 500000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} The hit price needs to be lower than $500000 and higher than $10000");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot place a hit on yourself.");
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
    if(Hit[id] == 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has already got a hit placed on him.");
    if(GetPlayerMoney(playerid) < price) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have this ammount of money.");
    SendClientMessage(playerid, COLOR_RED2, "[HIT] :{FFFFFF} You have successfully placed a hit on this player.");
    SendClientMessage(playerid, COLOR_ORANGE, "Any online hitmen have been informed about this hit and will deal with the player shortly.");
    Hit[id] = 1;
    Hitter[id] = playerid;
    HitPrice[id] = price;
    SendMessageToClass(HITMAN, COLOR_RED2, "[HIT] :{FFFFFF} A hit has recently been placed on someone.");
    format(G_String, 128, "%s has placed a hit on %s for a price of $%d", PlayerName(playerid), PlayerName(id), price);
    SendMessageToClass(HITMAN, COLOR_ORANGE, G_String);
    format(G_String, 128, "[HIT] :{FFFFFF} You have had a hit placed on your head for $%d", price);
    SendClientMessage(id, COLOR_RED2, G_String);
    SendClientMessage(id, COLOR_ORANGE, "Keep a gun at hand and watch out for hitmen!");

	return 1;
}




//use injections
CMD:useinjection(playerid, params[])
{
	new Float:health;
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(Injections[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any injections left. Visit a hospital or call a medic to buy more injections.");
    GetPlayerHealth(playerid, health);
    if(health == 100.0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have full health, there is no need to refill it.");
	SetPlayerHealth(playerid, health+50);
	Injections[playerid]--;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} +50 health! You now have %i injections left.", Injections[playerid]);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

//give injection
CMD:giveinjection(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(Injections[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any injections left. Visit a hospital or call a medic to buy more injections.");
	new id, string[2][128];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /giveinjection <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to use this command.");
	if(IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot give this player injections while he is in a vehicle.");
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have given an injection to %s", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been given a injection by %s ", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(id, COLOR_RED2, string[1]);
	Injections[playerid] --;
	Injections[id]++;

	return 1;
}

// injections
CMD:injections(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have %i injections left.", Injections[playerid]);
    SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

CMD:radio(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and the driver to use this command.");
    ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_LIST, "{FFFFFF}Vehicle Radio", "Rap\nRock\nRnB\nPOP\nReggae\nElectronic\nCountry\nStop Music", "Select", "Close");

	return 1;
}

CMD:acceptprivate(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerVariables[playerid] & PLAYER_HAS_PRIVATE_DRIVER) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You already have a private driver.");
	if(RequestedDriver[playerid] == -1 || RequestedDriver[playerid] == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You have not recieved a private driver offer or the player is not online.");
	PlayerVariables[playerid] |= PLAYER_HAS_PRIVATE_DRIVER;
	format(G_String, 128, "[TAXI] :{FFFFFF} %s has accepted your private driver offer.", PlayerName(playerid));
	SendClientMessage(RequestedDriver[playerid], COLOR_GREEN, G_String);
	SendClientMessage(playerid, COLOR_GREEN, "[TAXI] :{FFFFFF} You have accepted the offer and the driver is now private to you.");
	return 1;
}

CMD:items(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "[ITEM] :{FFFFFF} %s has requested some items", PlayerName(playerid));
    SendMessageToClass(ITEMS, COLOR_RED2, G_String);
    format(G_String, 128, "%s current location is %s", PlayerName(playerid), PlayerZone(playerid));
    SendMessageToClass(ITEMS, COLOR_ORANGE, G_String);
	PlayerVariables[playerid] |= PLAYER_REQUESTED_ITEMS;
    SendClientMessage(playerid, COLOR_GREEN, "Your request for items has been sent to all item dealers online.");
	return 1;
}
CMD:sextoys(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "[ITEM] :{FFFFFF} %s has requested some items", PlayerName(playerid));
    SendMessageToClass(ITEMS, COLOR_RED2, G_String);
    format(G_String, 128, "%s current location is %s", PlayerName(playerid), PlayerZone(playerid));
    SendMessageToClass(ITEMS, COLOR_ORANGE, G_String);
	PlayerVariables[playerid] |= PLAYER_REQUESTED_TOYS;
	SendClientMessage(playerid, COLOR_GREEN, "Your request for sex toys has been sent to all whores online.");

	return 1;
}

CMD:weapons(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    format(G_String, 128, "[WEP] :{FFFFFF} %s has requested some weapons", PlayerName(playerid));
    SendMessageToClass(ITEMS, COLOR_RED2, G_String);
    format(G_String, 128, "%s current location is %s", PlayerName(playerid), PlayerZone(playerid));
    SendMessageToClass(ITEMS, COLOR_ORANGE, G_String);
    PlayerVariables[playerid] |= PLAYER_REQUESTED_WEAPONS;
    SendClientMessage(playerid, COLOR_GREEN, "Your request for weapons has been sent to all weapon dealers online.");

	return 1;
}

CMD:breakcuffs(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(!(PlayerVariables[playerid] & PLAYER_CUFFED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You're not cuffed.");
	if((gettime() - LastCuffAttempt[playerid]) < 60) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to wait before attempting to break your cuffs again.");

	Rand = random(3);

	if(Rand == 1) {
		PlayerVariables[playerid] &= ~PLAYER_CUFFED;
		SetPlayerCuffed(playerid, 0);
		LastCuffAttempt[playerid] = gettime();
	} else {
		SendClientMessage(playerid, COLOR_RED2, "[CUFFS] :{FFFFFF} You failed to break your cuffs and have gained an additional wanted level for doing so.");
		WantedLevel[playerid]++;
		CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel[playerid], "Attempted cuffs escape");
		LastCuffAttempt[playerid] = gettime();
	}
	return 1;
}

CMD:trunk(playerid, params[])
{
	params[0] = !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ? SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and the driver to use this command") : ToggleVehicleTrunk(GetPlayerVehicleID(playerid));
	#pragma unused params
	return 1;
}

CMD:hood(playerid, params[])
{
	params[0] = !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ? SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and the driver to use this command") : ToggleVehicleHood(GetPlayerVehicleID(playerid));
	#pragma unused params
	return 1;
}

CMD:lights(playerid, params[])
{
	params[0] = !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ? SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and the driver to use this command") : ToggleVehicleLights(GetPlayerVehicleID(playerid));
	#pragma unused params
	return 1;
}

CMD:engine(playerid, params[])
{
	if(Clamped[GetPlayerVehicleID(playerid)]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command while your vehicle is clamped.");
	params[0] = !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ? SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and the driver to use this command") : ToggleVehicleEngine(GetPlayerVehicleID(playerid));
	#pragma unused params
	return 1;
}

CMD:lock(playerid, params[])
{
	params[0] = !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER ? SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle and the driver to use this command") : ToggleVehicleDoorsLocked(GetPlayerVehicleID(playerid)), VehicleLocked[GetPlayerVehicleID(playerid)] = true, SendClientMessage(playerid, COLOR_GREEN, "Vehicle locked.");
	#pragma unused params
	return 1;
}

//commands command
CMD:commands(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");

    if(PlayerInfo[playerid][Padmin] >= MOD)
		ShowPlayerDialog(playerid, DIALOG_CMDS, DIALOG_STYLE_LIST, "{FFFFFF}In-Game Commands", "{FFFFFF}Job Commands\n{FFFFFF}General Commands\n{FFFFFF}Admin Commands\n{FFFFFF}Vehicle Commands", "Select", "Close");
	else
	    ShowPlayerDialog(playerid, DIALOG_CMDS, DIALOG_STYLE_LIST, "{FFFFFF}In-Game Commands", "{FFFFFF}Job Commands\n{FFFFFF}General Commands\n{FFFFFF}Vehicle Commands", "Select", "Close");
	return 1;
}

CMD:sell(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You need to spawn before you use any commands.");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 588 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 423) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You must bee in a hotdog van or an icecream truck in order to use this command.");
	if(!SellingFood[playerid]) {
		new Float:pos[3];

		GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);

		PlayerFoodSale[playerid] = CreateDynamicCP(pos[0], pos[1]+2.0, pos[2], 2.0);
		TogglePlayerControllable(playerid, false);
		SellingFood[playerid] = true;
		FoodSelling[playerid] = 1;
		SendClientMessage(playerid, COLOR_GREEN, "[ALERT] :{FFFFFF} You're now selling food!");
		SendClientMessage(playerid, COLOR_GREY, "Use /sell again to stop selling food.");

	} else {
		SendClientMessage(playerid, COLOR_GREY, "You have stopped selling food");
		TogglePlayerControllable(playerid, true);
		SellingFood[playerid] = false;
		DestroyDynamicCP(PlayerFoodSale[playerid]);
		FoodSelling[playerid] = 0;
		FoodPrice[playerid] = -1;
	}
	return 1;
}

CMD:setfoodprice(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_GREY, "ERROR: You need to spawn before you use any commands.");
	if(!IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_GREY, "ERROR: This command is tailored to a civilian job");
	if(!IsNumeric(params[0]) || params[0] == '\0' || strval(params[0]) < 1 || strval(params[0]) >= 80) return SendClientMessage(playerid, COLOR_GREY, "SYNTAX: /setfoodprice <1-79>");
	format(G_String, 128, "[ALERT] :{FFFFFF} You have set your food selling price to $%d", strval(params[0]));
	FoodPrice[playerid] = strval(params[0]);
	SendClientMessage(playerid, COLOR_GREEN, G_String); 
	return 1;
}