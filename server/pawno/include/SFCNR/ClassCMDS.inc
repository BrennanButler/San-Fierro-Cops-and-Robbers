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

CMD:drugs(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] == DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot request drugs as a drug dealer.");
	new grams, drugtype[100];
	if(sscanf(params, "ds[100]", grams, drugtype)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /drugs <grams> <drug>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(grams < 4) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} The minimum ammount of grams you can request is 4.");

	if(!strcmp(drugtype, "cocain", true))
		format(G_String, 128, "%s has requested %d grams of cocain. %s is located at %s", PlayerName(playerid), grams, PlayerName(playerid), PlayerZone(playerid));
	else if(!strcmp(drugtype, "weed", true))
		format(G_String, 128, "%s has requested %d grams of weed. %s is located at %s", PlayerName(playerid), grams, PlayerName(playerid), PlayerZone(playerid));
	else if(!strcmp(drugtype, "heroin", true))
	    format(G_String, 128, "%s has requested %d grams of heroin. %s is located at %s", PlayerName(playerid), grams, PlayerName(playerid), PlayerZone(playerid));
	else return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Valid drugs: Heroin, Cocain, Weed");

	SendMessageToClass(DRUG, COLOR_GREEN, G_String);
	SendClientMessage(playerid, COLOR_GREEN, "Your request for drugs has been sent to all online drug dealers");
	return 1;
}

CMD:plantweed(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a drug dealer to use this command.");
	if(WeedSeeds[playerid] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to have weed seeds in order to plant them");
    new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	new ID = WeedID();
	WeedInfo[ID][WeedObject] = CreateDynamicObject(3409, pos[0], pos[1], pos[2]-5.0, 0.0, 0.0, 0.0);
	WeedInfo[ID][Xpos] = pos[0];
	WeedInfo[ID][Ypos] = pos[1];
	WeedInfo[ID][Zpos] = pos[2]-5.0;
	format(G_String, 128, "%s Weed", PlayerName(playerid));
	WeedInfo[ID][WeedLabel] = CreateDynamic3DTextLabel(G_String, COLOR_GREEN, pos[0], pos[1], pos[2], 30.0);
	WeedPlanted[playerid]++;
	format(WeedInfo[ID][Owner], 24, "%s", PlayerName(playerid));
	WeedInfo[ID][Burnt] = false;
	WeedInfo[ID][WeedWatered] = false;
	WeedInfo[ID][ForHarvest] = false;
	WeedSeeds[playerid]--;
	SendClientMessage(playerid, COLOR_GREEN, "You have planted your weed seed. Use /water to water the weed in order for it to grow.");
	return 1;
}

CMD:water(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a drug dealer to use this command.");
    if(WeedPlanted[playerid] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to plant some weed before using this command.");
	new Oid;
	if((Oid = GetNearestWeedToPlayer(playerid)) == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You're not close to any weed");
	if(strcmp(WeedInfo[Oid][Owner], PlayerName(playerid), false) != 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not own this weed");
	if(WeedInfo[Oid][WeedWatered]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} That weed has already been watered.");
	new Float:pos[3];
	WeedInfo[Oid][WeedWatered] = true;
 	GetDynamicObjectPos(WeedInfo[Oid][WeedObject], pos[0], pos[1], pos[2]);
	MoveDynamicObject(WeedInfo[Oid][WeedObject], pos[0], pos[1], pos[2]+3.9, 0.5);
	WeedInfo[Oid][Xpos] = pos[0];
	WeedInfo[Oid][Ypos] = pos[1];
	WeedInfo[Oid][Zpos] = pos[2]+3.9;
	new Htime = (Hour + 03);
	switch(Htime)
	{
	    case 23:
	    {
	        Htime = 02;
		}
		case 22:
		{
		    Htime = 01;
		}
		case 21:
		{
		    Htime = 00;
		}
	}
	WeedInfo[Oid][HHour] = Htime;
	WeedInfo[Oid][HMin] = Minute;
	format(G_String, 128, "You have watered your weed and now have to wait a total of 3 ingame hours till you can harvest the weed.", Htime, Minute);
	SendClientMessage(playerid, COLOR_GREEN, G_String);
	return 1;
}

CMD:harvest(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a drug dealer to use this command.");
    if(WeedPlanted[playerid] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to plant some weed before using this command.");
	new Oid, Float:pos[3];
	if((Oid = GetNearestWeedToPlayer(playerid)) == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You're not close to any weed");
	if(strcmp(PlayerName(playerid), WeedInfo[Oid][Owner]) != 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be the owner of the weed in order to harvest it.");
	if(!WeedInfo[Oid][WeedWatered]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to water this weed first.");
	format(G_String, 128, "[ERROR] :{FFFFFF} You need to wait until %i to harvest your weed.", WeedInfo[Oid][HHour], WeedInfo[Oid][HMin]);
	if(!WeedInfo[Oid][ForHarvest]) return SendClientMessage(playerid, COLOR_RED2, G_String);
	WeedPlanted[playerid]--;
	GetDynamicObjectPos(WeedInfo[Oid][WeedObject], pos[0], pos[1], pos[2]);
	WeedInfo[Oid][Pickup] = CreateDynamicPickup(2901, 1, pos[0], pos[1], pos[2]+1.1, -1, -1, -1, 100.0);
	DestroyDynamicObject(WeedInfo[Oid][WeedObject]);
	return 1;
}

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

CMD:sellweapons(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != WEP) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a weapon dealer to use this command.");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sellweapons <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!(PlayerVariables[playerid] & PLAYER_REQUESTED_WEAPONS)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has not requested a weapon dealer with /weapons.");
	if(WepStock[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any weapon stocks left. Visit an amunation to refill your stock");
	Rand = random(6);
	if(Rand == 1) {
		format(G_String, 128, "[WEP] :{FFFFFF} You have sold %s some weapons", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	    PlayerInfo[playerid][Pwep]++;
	    format(G_String, 128, "You have leveled up on your weapon dealing level! You are now level %d", PlayerInfo[playerid][Pwep]);
	    SendClientMessage(playerid, COLOR_ORANGE, G_String);
	} else {
	    format(G_String, 128, "[WEP] :{FFFFFF} You have sold %s some weapons", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	}
	WepStock[playerid]--;
	UpdatePlayerJobLevel(playerid);

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
		format(G_String, 128, "[ITEM] :{FFFFFF} You have sold %s some items", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	    PlayerInfo[playerid][Psales]++;
	    format(G_String, 128, "You have leveled up on your item dealing level! You are now level %d", PlayerInfo[playerid][Pwep]);
	    SendClientMessage(playerid, COLOR_ORANGE, G_String);
	} else {
	    format(G_String, 128, "[ITEM] :{FFFFFF} You have sold %s some items", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	}
	ItemStock[playerid]--;
    UpdatePlayerJobLevel(playerid);

	return 1;
}

CMD:sellsextoys(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != WHORE) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a whore to use this command.");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sellitems <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid id or the player is not connected.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close to the player in order to use this command.");
	if(!(PlayerVariables[playerid] & PLAYER_REQUESTED_TOYS)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has not requested a items dealer with /items.");
	if(ToyStock[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any item stocks left. Visit an 24/7 to refill your stock");
	Rand = random(6);
	if(Rand == 1) {
		format(G_String, 128, "[SEX] :{FFFFFF} You have sold %s some sex toys", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	    PlayerInfo[playerid][Psales]++;
	    format(G_String, 128, "You have leveled up on your sales level! You are now level %d", PlayerInfo[playerid][Pwep]);
	    SendClientMessage(playerid, COLOR_ORANGE, G_String);
	} else {
	    format(G_String, 128, "[SEX] :{FFFFFF} You have sold %s some sex toys", PlayerName(id));
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	}
	ToyStock[playerid]--;
    UpdatePlayerJobLevel(playerid);

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

CMD:ar(playerid, params[])
{
	return cmd_arrest(playerid, params);
}

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

CMD:spike(playerid, params[])
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
}

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
	new id, Float:pos[3], string[2][128];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /grab <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(WantedLevel[id] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not wanted.");
	GetVehiclePos(lastveh[playerid], pos[0], pos[1], pos[2]);
	if(!IsPlayerInRangeOfPoint(playerid, 50, pos[0], pos[1], pos[2])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to your vehicle.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close enough to grab this player");
	PutPlayerInVehicle(id, lastveh[playerid], 1);
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have grabed %s into your vehicle.", PlayerName(id));
	format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been grabed and placed into %s vehicle", PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);

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
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been uncuffed by an law enforcement");

	return 1;
}

//hits
CMD:hits(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(gTeam[playerid] != HITMAN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a hitman to use this command.");
    new count;
    foreach(Player, i)
    {
        if(Hit[i] == 1)
        {
            format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} %s | Price: $%i | Location: %s", PlayerName(i), HitPrice[i], PlayerZone(i));
            SendClientMessage(playerid, COLOR_RED2, G_String);
            count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} There are no online players with hits");

	return 1;
}



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

//laser command
CMD:laser(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(gTeam[playerid] != STAT && gTeam[playerid] != ARMY && gTeam[playerid] != SWAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is only for special classes");
	Laser[playerid] =1;
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Laser enabled");

	return 1;
}