// TODO: Cleanup

CMD:drugs(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] == DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot request drugs as a drug dealer.");
	new grams, drugtype[100];
	if(sscanf(params, "ds[100]", grams, drugtype)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /drugs <grams> <drug>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(grams < 4) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} The minimum ammount of grams you can request is 4.");

	if(!strcmp(drugtype, "cocain", true))
		format(G_String, 128, "%s has requested %d grams of cocain. %s is located at %s", PlayerName[playerid], grams, PlayerName[playerid], PlayerZone(playerid));
	else if(!strcmp(drugtype, "weed", true))
		format(G_String, 128, "%s has requested %d grams of weed. %s is located at %s", PlayerName[playerid], grams, PlayerName[playerid], PlayerZone(playerid));
	else if(!strcmp(drugtype, "heroin", true))
	    format(G_String, 128, "%s has requested %d grams of heroin. %s is located at %s", PlayerName[playerid], grams, PlayerName[playerid], PlayerZone(playerid));
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
	format(G_String, 128, "%s Weed", PlayerName[playerid]);
	WeedInfo[ID][WeedLabel] = CreateDynamic3DTextLabel(G_String, COLOR_GREEN, pos[0], pos[1], pos[2], 30.0);
	WeedPlanted[playerid]++;
	format(WeedInfo[ID][Owner], 24, "%s", PlayerName[playerid]);
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
	if(strcmp(WeedInfo[Oid][Owner], PlayerName[playerid], false) != 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not own this weed");
	if(WeedInfo[Oid][WeedWatered]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} That weed has already been watered.");
	new Float:pos[3];
	WeedInfo[Oid][WeedWatered] = true;
 	GetDynamicObjectPos(WeedInfo[Oid][WeedObject], pos[0], pos[1], pos[2]);
	MoveDynamicObject(WeedInfo[Oid][WeedObject], pos[0], pos[1], pos[2]+3.9, 0.5);
	WeedInfo[Oid][Xpos] = pos[0];
	WeedInfo[Oid][Ypos] = pos[1];
	WeedInfo[Oid][Zpos] = pos[2]+3.9;
	WeedInfo[Oid][ForHarvest] = false;
	new Htime = (Hour += 03);
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
	if(strcmp(PlayerName[playerid], WeedInfo[Oid][Owner]) != 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be the owner of the weed in order to harvest it.");
	if(!WeedInfo[Oid][WeedWatered]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to water this weed first.");
	format(G_String, 128, "[ERROR] :{FFFFFF} You need to wait until %02d:%02d to harvest your weed.", WeedInfo[Oid][HHour], WeedInfo[Oid][HMin]);
	if(!WeedInfo[Oid][ForHarvest]) return SendClientMessage(playerid, COLOR_RED2, G_String);
	WeedPlanted[playerid]--;
	GetDynamicObjectPos(WeedInfo[Oid][WeedObject], pos[0], pos[1], pos[2]);
	WeedInfo[Oid][Pickup] = CreateDynamicPickup(2901, 1, pos[0], pos[1], pos[2]+1.1, -1, -1, -1, 100.0);
	DestroyDynamicObject(WeedInfo[Oid][WeedObject]);
	return 1;
}
