//------------------------------------------------
//Admin Commands

// Set admins level
CMD:setlvl(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return 0;
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	new id, lvl;
	if(sscanf(params,"ui",id,lvl)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /setlvl <id> <level>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(lvl < 0 || lvl > 4) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Available levels: 1-4");
	if(PlayerInfo[id][Padmin] == lvl) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already that admin level.");
	if(lvl < PlayerInfo[id][Padmin]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Use /demote to lower someones admin level");
	PlayerInfo[id][Padmin] = lvl;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin Has promoted %s to admin level: %i", PlayerName(id), lvl);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

CMD:ban(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, bandate[100], reason[50];
	if(sscanf(params,"us[100]s[50]", id, bandate, reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ban <id> <unbandate> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(strlen(bandate) < 10) return SendClientMessage(playerid, COLOR_GREY, "ERROR: Bandate needs to look like the following: day/month/year");
	new day, month, year, ip[16];
	GetPlayerIp(id, ip, 16);
	getdate(year, month, day);
	format(BanInfo[id][issued], 50, "%02d/%02d/%d", day, month, year);
	format(BanInfo[id][BanReason], 50, reason);
	format(BanInfo[id][UnbanDate], 50, bandate);
	format(BanInfo[id][BanAdmin], 24, PlayerName(playerid));
	format(BanInfo[id][BanIP], 24, ip);
	PlayerVariables[id] |= PLAYER_BANNED;
	format(G_String, 128, "Admin has banned %s for %s", PlayerName(playerid), reason);
	SendClientMessageToAll(COLOR_GREY, G_String);
	return 1;
}

CMD:csweeper(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new Float:weight, Float:pos[3];
	if(sscanf(params,"f",weight)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /csweeper <weight>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(weight < 10.0 || weight > 200.0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum weight is 10 Maximum weight is 200");
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	format(G_String, 128, "You have successfully created a rubbish spawn for the sweeper job totalling at %fkg !", weight);
	SendClientMessage(playerid, COLOR_GREEN, G_String);
	new Query[500];
	format(Query, 500, "INSERT INTO `sweeper` (`weight`, `Xpos`, `Ypos`, `Zpos`) VALUES ('%f', '%f', '%f', '%f')", weight, pos[0], pos[1], pos[2]-0.75);
	mysql_function_query (Gconnection, Query, false, "", "");
	return 1;
}

CMD:chouse(playerid, params[])
{
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
    new owner[24], interiorName[100], Float:pos[3], Query[400], create;
    if(sscanf(params,"s[24]s[100]",owner, interiorName)) return SendClientMessage(playerid, -1, "Usage: /chouse <owner> <interior name>");
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	create = HouseCreate(owner, interiorName, pos[0], pos[1], pos[2]);
    if(create) {

	 	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} House created.");
	 	format(Query, 500, "INSERT INTO `house`(`id`, `owner`, `owned`, `interiorname`, `pass`, `Xpos`, `Ypos`, `Zpos`, `price`) VALUES (null,'%s','1','%s','','%f','%f','%f', '%d')", owner, HouseInfo[create][Interiorname], HouseInfo[create][Xpos], HouseInfo[create][Ypos], HouseInfo[create][Zpos], HouseInfo[create][Hsaleprice]);
    	mysql_function_query (Gconnection, Query, false, "OnHouseCreated", "d", create);
	}
    else SendClientMessage(playerid, COLOR_RED2, "[ERROR] Something went wrong. Make sure you enter the correct interior name, or input the whole interior name");
    return 1;
}

// demote admin command
CMD:demote(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return 0;
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	new id, lvl;
	if(sscanf(params,"ui",id,lvl)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /demote <id> <level>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(lvl > PlayerInfo[id][Padmin]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot set this players admin level higher with this command. Use /setlvl for that.");
	PlayerInfo[id][Padmin] = lvl;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin Has demoted %s to admin level: %i", PlayerName(id), lvl);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

CMD:setlang(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, room[100];
	if(sscanf(params,"us[100]", id, room)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setlang <id> <room name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot admin private message yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");

	if(!strcmp(room, "german", true) || !strcmp(room, "Deutsch", true))
	    SetPlayerLangRoom(id, 1);
	else if(!strcmp(room, "Spanish", true))
	    SetPlayerLangRoom(id, 2);
	else if(!strcmp(room, "French", true))
	    SetPlayerLangRoom(id, 3);
	else if(!strcmp(room, "Croatian", true))
	    SetPlayerLangRoom(id, 4);


	return 1;
}

// Admin Pm
CMD:apm(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, message[128];
	if(sscanf(params,"us[128]", id, message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /apm <id> <message>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot admin private message yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "Admin PM : %s", message);
	SendClientMessage(id, COLOR_BLUE1, G_String);
	SendClientMessage(playerid, COLOR_BLUE1, G_String);

	return 1;
}

// slap command
CMD:slap(playerid, params[])
{
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any command.");
	new id, Float:pos[3], reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /slap <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	SetPlayerPos(id, pos[0], pos[1], pos[2]+10);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has slaped %s for reason: %s",PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

CMD:ajail(playerid, params[])
{
   // if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, time, reason[100];
	if(sscanf(params,"uis[100]",id,time,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ajail <id> <time (minutes)> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
	SetPrisonTime(id, time*60 );
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has jailed %s for %d minutes for reason: %s", PlayerName(id), time, reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	PlayerVariables[playerid] |= PLAYER_IN_JAIL;
	Rand = random(sizeof(PrisonSpawns));
	SetPlayerPos(id, PrisonSpawns[Rand][0], PrisonSpawns[Rand][1], PrisonSpawns[Rand][2]);
	SetPlayerFacingAngle(id, PrisonSpawns[Rand][3]);
	SetPlayerWantedLevel(id, 0);
	WantedLevel[id] = 0;

	return 1;
}

CMD:unjail(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unjail <id>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	SetPrisonTime(id, 0);
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has unjailed %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);
	PlayerVariables[playerid] &= ~PLAYER_IN_JAIL;
	PlayerTextDrawHide(playerid, PlayerText:PrisonTextdraw[playerid]);
	return 1;
}

// explode command
CMD:explode(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, Float:pos[3], reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /explode <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	CreateExplosion(pos[0], pos[1], pos[2], 0, 2.0);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has exploded %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// mute command
CMD:mute(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /mute <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(PlayerVariables[playerid] & PLAYER_MUTED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already muted.");
	PlayerVariables[playerid] |= PLAYER_MUTED;
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has muted %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// unmute command
CMD:unmute(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unmute <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]);
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!(PlayerVariables[playerid] & PLAYER_MUTED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already unmuted.");
	PlayerVariables[playerid] &= ~PLAYER_MUTED;
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has unmuted %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

//announce command
CMD:ann(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new message[128];
	if(sscanf(params,"s[128]",message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ann <message>");
	GameTextForAll(message, 3000, 6);

	return 1;
}

//kick command
CMD:kick(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /kick <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	//if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has kicked %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	KickLog(playerid, id, reason);
	PlayerVariables[playerid] |= PLAYER_KICKED;

	return 1;
}

//disarm command
CMD:disarm(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /disarm <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]);
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has disarmed %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);
	ResetPlayerWeapons(id);

	return 1;
}

//freeze command
CMD:freeze(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /freeze <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(PlayerVariables[playerid] & PLAYER_FROZEN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already frozen.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has frozen %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	PlayerVariables[playerid] |= PLAYER_FROZEN;
	TogglePlayerControllable(id, false);

	return 1;
}

//unfreeze command
CMD:unfreeze(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unfreeze <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]);
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!(PlayerVariables[playerid] & PLAYER_FROZEN)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already unfrozen.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has unfrozen %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);
	PlayerVariables[playerid] &= ~PLAYER_FROZEN;
	TogglePlayerControllable(id, true);

	return 1;
}

// bring command
CMD:bring(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /bring <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]), Float:pos[3];
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerPos(id, pos[0], pos[1], pos[2]);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} You have been teleported to %s", PlayerName(playerid));
	SendClientMessage(id, COLOR_LIGHTGREEN, G_String);

	return 1;
}

//goto command
CMD:goto(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, Float:pos[3];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /goto <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} You have been teleported to %s", PlayerName(id));
	SendClientMessage(playerid, COLOR_LIGHTGREEN, G_String);

	return 1;
}

//skin command
CMD:skin(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id;
	if(sscanf(params,"i",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /skin <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(299 > id < 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Skin id's range from 0 to 299");
	SetPlayerSkin(playerid, id);
	format(G_String, 128, "[SKIN] :{FFFFFF} You have changed your skin to id %d", id);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

//set skin command
CMD:setskin(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, skin;
	if(sscanf(params,"ui",id, skin)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setskin <id> <skin>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(299 > skin < 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Skin id's range from 0 to 299");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /skin to set your own skin.");
	SetPlayerSkin(id, skin);
	format(G_String, 128, "[SKIN] :{FFFFFF} You have changed %s skin to id %d", PlayerName(id), skin);
	SendClientMessage(playerid, COLOR_RED2, G_String);
    format(G_String, 128, "[SKIN] :{FFFFFF} Admin has set your skin to id %d", skin);
	SendClientMessage(id, COLOR_RED2, G_String);

	return 1;
}


//give cash command
CMD:givecash(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, ammount, string[2][128];
	if(sscanf(params,"ui",id,ammount)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /givecash <id> <ammount>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(ammount < 0 || ammount > 1000000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Min: 0 Max: 1 million");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /cash to give yourself money.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have given %s $%i cash", PlayerName(id), ammount);
	format(string[1], 128,  "[SERVER MESSAGE] :{FFFFFF} You have been given $%i cash by Admin", ammount);
	SendClientMessage(playerid, COLOR_RED2,  string[0]);
	SendClientMessage(id, COLOR_RED2, string[1]);
	GivePlayerMoney(id, ammount);

	return 1;
}

CMD:cash(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new money;
	if(sscanf(params,"i",money)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /cash <ammount>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(5000000 > money) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} The maximum you can give yourself is 5000000.");
	GivePlayerMoney(playerid, money);
	format(G_String, 128, "[CASH] :{FFFFFF} You have given youself $%d", money);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

// dveh command
CMD:dveh(playerid, params[])
{
 	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
 	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehicle = GetPlayerVehicleID(playerid);
		format(G_String, 128, "Vehicle id %i deleted", vehicle);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, G_String);
	    DestroyVehicle(vehicle);
	}
	else
	{
	    for(new i = 0; i < MAX_VEHICLES;i++)
	    {
			new Float:pos[3];
			GetVehiclePos(i, pos[0], pos[1], pos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 20, pos[0], pos[1], pos[2]))
			{
			    DestroyVehicle(i);
			}
		}
	}

	return 1;
}

//Get all command
CMD:getall(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	foreach(Player, i)
	{
	    SetPlayerPos(i, pos[0], pos[1], pos[2]);
 	}

	return 1;
}

// respawn all vehicles command
CMD:respawnv(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	for(new i = 0; i < MAX_VEHICLES;i++) {
		SetVehicleToRespawn(i);
	}
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Admin has respawned all vehicles");

	return 1;
}

CMD:time(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(strlen(params[0]) < 1 || strlen(params[1]) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /time <hour> <minute>");
	Hour = strval(params[0]);
	Minute = strval(params[3]);
	return 1;
}

//warn command
CMD:warn(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params, "us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /warn <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	Warns[id]++;
	if(Warns[id] >= MAX_WARNS) {
	    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF}%s has been kicked for reaching maximum ammount of warnings", PlayerName(id));
	    SendClientMessageToAll(COLOR_RED2, G_String);
	    KickLog(playerid, id, "Maximum ammount of warnings");
	    PlayerVariables[playerid] |= PLAYER_KICKED;
	} else {
	    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has warned %s for reason: %s [%i/3]", PlayerName(id), reason, Warns[id]);
	    SendClientMessageToAll(COLOR_RED2, G_String);
  	}

	return 1;
}

// reset warnings command
CMD:resetwarnings(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /resetwarnings <id>");
	new id = strval(params[0]);
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(Warns[id] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has not had any warnings");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has reset %s warnings from %i to 0", PlayerName(id), Warns[id]);
	SendClientMessageToAll(COLOR_RED2, G_String);
	Warns[id] = 0;

	return 1;
}

//admins command
CMD:admins(playerid, params[])
{
	new count;
	SendClientMessage(playerid, COLOR_GREEN, "••  San Fierro Cops And Robbers Staff ••");
	foreach(Player, i) {
		switch(PlayerInfo[i][Padmin]) {
			case HELPER: {
			    format(G_String, 128, "•  %s {FF0000} Helper  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
				count++;
			}
			case MOD: {
			    format(G_String, 128, "•  %s {FF0000} Moderator  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
			case ADMIN: {
			    format(G_String, 128, "•  %s {FF0000} Admin  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
			case SENIOR_ADMIN: {
			    format(G_String, 128, "•  %s {FF0000} Senior Admin  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_WHITE, "[SERVER MESSAGE] {FFFFFF} There are no admins online");

	return 1;
}

//Rich list command
//Usefull to see if a player is money hacking
CMD:richlist(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessage(playerid, COLOR_YELLOW, "[RICH LIST] Players who have over one million cash");
	new count;
	foreach(Player, i) {
	    if(GetPlayerMoney(i) >= 1000000) {
	        format(G_String, 128, "%s || Money: %i || Score %i", PlayerName(i), GetPlayerMoney(i), GetPlayerScore(i));
	        SendClientMessage(playerid, COLOR_WHITE, G_String);
	        count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_WHITE, "[SERVER MESSAGE] {FFFFFF} There are no players online with 1 million or more");

	return 1;
}

//Kill player command
CMD:akill(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /akill <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has killed %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerHealth(id, 0.0);

	return 1;
}

//warned people
CMD:warnlist(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessage(playerid, COLOR_YELLOW, "[WARNED LIST] Players who have been warned");
	new count;
	foreach(Player, i) {
	    if(Warns[i] >= 1) {
	        format(G_String, 128, "%s || Warns %i", PlayerName(i), Warns[i]);
	        SendClientMessage(playerid, COLOR_WHITE, G_String);
	        count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF} There are no players online with warnings");

	return 1;
}

//clear chat command
CMD:clearchat(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	for(new i = 0;i < 15;i++)
	{
	    SendClientMessageToAll(COLOR_WHITE, "");
	}
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] {FFFFFF} Admin has cleared the chat");

	return 1;
}

//wanted level command
CMD:setwanted(playerid, params[])
{
   // if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, level;
	if(sscanf(params,"ui",id,level)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setwanted <id> <level>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s wanted level to %i", PlayerName(id), level);
	SendClientMessageToAll(COLOR_RED2, G_String);
	WantedLevel[id] = level;
	CallLocalFunction("OnPlayerCommitCrime", "iis", id, WantedLevel[id], "Admin set wanted.");

	return 1;
}

CMD:createatm(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /createatm <robbery amount>");

	return 1;
}

//set health command
CMD:sethealth(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, health;
	if(sscanf(params,"ui",id,health)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sethealth <id> <health>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s health to %i", PlayerName(id), health);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerHealth(id, health);

	return 1;
}

//set armour command
CMD:setarmour(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, armour;
	if(sscanf(params,"ui",id,armour)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setarmour <id> <armour>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s armour to %i", PlayerName(id), armour);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerArmour(id, armour);

	return 1;
}

//restart command
CMD:restart(playerid, params[])
{
   // if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < SENIOR_ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] {FFFFFF} Admin is restarting the server");
	GameTextForAll("~r~Restarting..", 6000, 6);
	SendRconCommand("gmx");

	return 1;
}

//v command
CMD:v(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[212], idx, Float:pos[4];
	if(sscanf(params,"s[212]",name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /v <name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    idx = GetVehicleModelIDFromName(name);
    if( idx == -1 ) {
		idx = strval(name);

		if ( idx < 400 || idx > 611 )
			return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetXYInFrontOfPlayer(playerid, pos[0], pos[1], 5);
	GetPlayerFacingAngle(playerid, pos[3]);
	idx = CreateVehicle(idx, pos[0], pos[1], pos[2]+2, pos[3]-90, random(255), random(255), -1);
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have spawned a %s | Model %i | Vehicleid %i", VehicleNames[GetVehicleModel(idx) - 400], GetVehicleModel(idx), idx);
	SendClientMessage(playerid, COLOR_RED2, G_String);
	LinkVehicleToInterior(idx, GetPlayerInterior(playerid));
	CreatedVehicle[idx] = true;
	return 1;
}

//weapon command
CMD:weapon(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[17], idx;
	if(sscanf(params,"s[212]",name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /weapon <name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	idx = GetWeaponModelIDFromName(name);
	if(idx == -1) {
	    idx = strval(name);
	    if(idx < 0 || idx > 47 )
	        return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GivePlayerWeapon(playerid, idx, 500);
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have spawned a %s with 500 amo", WeaponNames[idx]);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

//giveweapon command
CMD:giveweapon(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[17], idx, id, string[2][128];
	if(sscanf(params,"is[212]",id, name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /giveweapon <id> <name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	idx = GetWeaponModelIDFromName(name);
	if(idx == -1) {
	    idx = strval(name);
	    if(idx < 0 || idx > 47 )
	        return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GivePlayerWeapon(id, idx, 500);
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have given %s a %s with 500 amo", PlayerName(id), WeaponNames[idx]);
	format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been given a %s with 500 amo by admin", WeaponNames[idx], PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(id, COLOR_RED2, string[1]);

	return 1;
}

// set tax command
CMD:settax(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new tax;
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /settax <number>");
	tax = strval(params[0]);
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(tax < 0 || tax > 200000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum: 1 Max: 200000");
	G_TAX = tax;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} The tax of the server has been changed to $%i", tax);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

CMD:setmayor(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setmayor <id>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[id][Mayor] == true) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already mayor.");
	foreach(Player, i) {
	    PlayerInfo[i][Mayor] = false;
	}
	PlayerInfo[id][Mayor] = true;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has apointed %s as the new mayor of san fierro", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

CMD:demotemayor(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /demotemayor <id>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[id][Mayor] == false) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not a mayor.");
	PlayerInfo[id][Mayor] = false;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has demoted %s from the mayor of san fierro", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);
	return 1;
}

CMD:respawnuv(playerid, params[]) 
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	for(new i = 0; i < MAX_VEHICLES;i++) {
		if(!IsVehicleOccupied(i)) SetVehicleToRespawn(i);
	}
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Admin has respawned all un-occupied vehicles");
	return 1;
}

CMD:setvw(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new id, vw;
	if(sscanf(params,"ui",id,vw)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setvw <id> <virtual world>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has set %s virtual world to %d", PlayerName(id), vw);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerVirtualWorld(playerid, vw);

	return 1;
}

CMD:setinterior(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new id, interior;
	if(sscanf(params,"ui",id,interior)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setinterior <id> <interiorid>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has set %s interior id to %d", PlayerName(id), interior);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerInterior(playerid, interior);
	return 1;
}

CMD:weather(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	if(strlen(params[0]) < 1 || !IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /weather <id>");
	if(strval(params[0]) < 0 || strval(params[0]) > 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Valid weather's are from 0-20.");
	SetWeather(strval(params[0]));
	format(G_String, 128, "You have set the world's weather to ID %d", strval(params[0]));
	SendClientMessage(playerid, COLOR_GREEN, G_String);
	return 1;
}

CMD:lockserver(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < SENIOR_ADMIN && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new password[2][128];
	if(sscanf(params,"s[128]", password[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /lockserver <password");
	format(password[1], 128, "password %s", password[0]);
	SendRconCommand(password[1]);
	format(password[1], 128, "[LOCK] :{FFFFFF} You have set the password to the server to %s", password[0]);
	SendClientMessage(playerid, COLOR_RED2, password[1]);

	return 1;
}

CMD:gettax(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has raked in the tax. A total of $%d has been taxed out of your money", G_TAX);
	SendClientMessageToAll(COLOR_RED2, G_String);

	foreach(Player, i)
		GivePlayerMoney(i, -G_TAX);

	return 1;
}