CMD:pilot(playerid, params[])
{
	Rand = randomEx(0, 10);
	JobCheckpoint[playerid] = CreateDynamicCP(PilotJobs[Rand][FromX], PilotJobs[Rand][FromY], PilotJobs[Rand][FromZ], 5.0, -1, -1, playerid, 100.0);
	SendClientMessage(playerid, -1, PilotJobs[Rand][JobText]);
	JobIcon[playerid] = SetPlayerMapIcon(playerid, 54, PilotJobs[Rand][FromX], PilotJobs[Rand][FromY], PilotJobs[Rand][FromZ], 0, COLOR_YELLOW, MAPICON_GLOBAL);
	CurrentJobID[playerid] = Rand;
	JobStatus[playerid] = 1;
	return 1;
}

CMD:setstd(playerid, params[])
{
	new std[120];
	if(sscanf(params, "s[120]", std)) return 0;
	format(PlayerInfo[playerid][STD], 100, "%s", std);
	return 1;
}

CMD:getstd(playerid, params[])
{
	format(G_String, 128, "you have %s", PlayerInfo[playerid][STD]);
	SendClientMessage(playerid, -1, G_String);
	return 1;
}

CMD:die(playerid, params[])
{
	SetPlayerHealth(playerid, 0.0);
	return 1;
}

CMD:opendoor(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0,1849.32995605,-1714.31005859,5201.54003906))
 	{
  		MoveObject(doors[0],1849.32995605-1.25,-1714.31005859,5201.54003906,0.50);
    	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 1 has been opened");
     	return 1;
   	}
    else if(IsPlayerInRangeOfPoint(playerid, 2.0,1847.31994629,-1722.56994629,5201.54003906))
    {
  		MoveObject(doors[1],1847.31994629,-1722.56994629-1.25,5201.54003906,0.50);
    	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 2 has been opened");
     	return 1;
   	}
    else if(IsPlayerInRangeOfPoint(playerid, 2.0,1854.01953125,-1726.27343750,5201.54003906))
    {
  		MoveObject(doors[2],1854.01953125,-1726.27343750-1.25,5201.54003906,0.50);
  		SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 3 has been opened");
    	return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.0,1862.02246094,-1710.91992188,5201.54003906))
    {
    	MoveObject(doors[3],1862.02246094-1.25,-1710.91992188,5201.54003906,0.50);
     	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 4 has been opened");
      	return 1;
   	}
    else SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not near any door");

    return 1;
}

CMD:closedoor(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0,1849.32995605,-1714.31005859,5201.54003906))
 	{
  		MoveObject(doors[0],1849.32995605,-1714.31005859,5201.54003906,0.50);
	 	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF}: door 1 has been closed");
  		return 1;
   	}
   	else if(IsPlayerInRangeOfPoint(playerid, 2.0,1847.31994629,-1722.56994629,5201.54003906))
    {
    	MoveObject(doors[1],1847.31994629,-1722.56994629,5201.54003906,0.50);
     	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 2 has been closed");
      	return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.0,1854.01953125,-1726.27343750,5201.54003906))
    {
    	MoveObject(doors[2],1854.01953125,-1726.27343750,5201.54003906,0.50);
     	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 3 has been closed");
      	return 1;
    }
   	else if(IsPlayerInRangeOfPoint(playerid, 2.0,1862.02246094,-1710.91992188,5201.54003906))
    {
    	MoveObject(doors[3],1862.02246094,-1710.91992188,5201.54003906,0.50);
     	SendClientMessage(playerid, COLOR_RED2, "[DOOR] :{FFFFFF} door 4 has been closed");
      	return 1;
  	}
   	else SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not near any door");

    return 1;
}

CMD:shopinfo(playerid, params[])
{
	new Shop[2][100];
	for(new i =0; i < sizeof(RobberyPlaces); ++i) {
	    if(RobberyPlaces[i][RobberyID] == PlayerRobberyID[playerid]) {
	        format(Shop[0], 100, RobberyPlaces[i][RobberyZone]);
	        format(Shop[1], 100, RobberyPlaces[i][RobberyType]);
	    }
	}
	format(G_String, 128, "In shop %s the shop is located at %s and has an id of %d", Shop[1], Shop[0], PlayerRobberyID[playerid]);
	SendClientMessage(playerid, -1, G_String);
	return 1;
}

CMD:newclass(playerid, params[])
{
    TogglePlayerSpectating(playerid, 1);
    InterpolateCameraPos(playerid, -1965.5610,1120.5383,87.8233, -1748.7079,-580.4182,49.5950, 20000, CAMERA_MOVE);
    return 1;
}

CMD:createobject(playerid, params[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    CreateDynamicObject(strval(params[0]), pos[0], pos[1], pos[2]-0.75, 0.0, 0.0, 0.0);
	return 1;
}

CMD:circle(playerid, params[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

	for(new Float:i = 0.0; i < 360.0; i += 1.0) {
		pos[1] += (1 * floatsin(-i, degrees));
		pos[0] += (1 * floatcos(-i, degrees));
		CreateDynamicObject(1598, pos[0], pos[1], pos[2], 0.0, 0.0, 0.0);
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	}
	return 1;
}

CMD:clothing(playerid, params[])
{
	ShowMenuForPlayer(clothingtype, playerid);
	TogglePlayerControllable(playerid, 0);
	return 1;
}

CMD:testfires(playerid, params[]) 
{
	CreateVehicleFire(GetPlayerVehicleID(playerid), 2);
	return 1;
}

CMD:checkpoint(playerid, params[])
{
	new Float:pos[3];
	GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);

	CreateDynamicCP(pos[0], pos[1]+2.0, pos[2], 2.0);
	return 1;
}

CMD:cow(playerid, params[])
{
    new Float:pos[3];
    GetDynamicObjectPos(cow, pos[0], pos[1], pos[2]);
    SetPlayerPos(playerid, pos[0], pos[1], pos[2]+10);
    return 1;
}

CMD:nextnode(playerid, params[])
{
    static node = 0;
    static farm = 1;
    SetDynamicObjectPos(cow, CowNodes[node][Xpos], CowNodes[node][Ypos], CowNodes[node][Zpos]);
    printf("current node = %d", node);
    if(farm != CowNodes[node][FarmID]) {
        SendClientMessage(playerid, -1, "new farm");
        farm = CowNodes[node][FarmID];
    }
    ++node;
    return 1;
}

CMD:nextnode2(playerid, params[])
{
    static node = 0;
    static farm = 1;
    SetDynamicObjectPos(cow2, CowNodes[node][Xpos], CowNodes[node][Ypos], CowNodes[node][Zpos]);
    printf("current node = %d", node);
    if(farm != CowNodes[node][FarmID]) {
        SendClientMessage(playerid, -1, "new farm");
        farm = CowNodes[node][FarmID];
    }
    ++node;
    return 1;
}


CMD:nodepls(playerid, params[])
{
    PutCowOnNextNode(cow);
    return 1;
}

CMD:nodepls2(playerid, params[])
{
    PutCowOnNextNode(cow2);
    return 1;
}

CMD:cowinfo(playerid, params[])
{
    format(G_String, 128, "Current farm = %d", GetCowCurrentFarm(cow));
    SendClientMessage(playerid, -1, G_String);
    format(G_String, 128, "Current node = %d", GetCowNode(cow));
    SendClientMessage(playerid, -1, G_String);
    return 1;
}