//functions

//Connect to the database
Mysql_init() {
	Gconnection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);
	mysql_debug(1);
	return 1;
}

IsVehicleOccupied(vehicleid) {

	foreach(Player, i) {
		if(IsPlayerInVehicle(i, vehicleid)) return 1;
	}
	return 0;
}

WeedID() {

	for(new i = 0; i < MAX_WEED; i++)
	{
	    if(!IsValidDynamicObject(WeedInfo[i][WeedObject])) return i;
	}
 	return -1;

}

GenerateFireID() {

	for(new i = 0; i < MAX_FIRES; i++) {

		if(!FireCreated[i]) return i;
	}

	return -1;
}

IsMultipleOf(number, multiple, maxnum = 1000)
{
	for(new i = 0; i <= maxnum; ++i)
	{
		if((i * multiple) == number)
		{
			return 1;
		}
	}
	return 0;
}

GetCowNode(ObjID)
{
	if(!IsValidDynamicObject(cow)) return 0;
	new Float:pos[3];
	GetDynamicObjectPos(ObjID, pos[0], pos[1], pos[2]);

	for(new i = 0; i <= 67; ++i)
	{
		if(!floatcmp(pos[0], CowNodes[i][Xpos]) && !floatcmp(pos[1], CowNodes[i][Ypos]) && !floatcmp(pos[2], CowNodes[i][Zpos])) return i;
	}
	return -1;
}

GetCowCurrentFarm(ObjID)
{
	return CowNodes[GetCowNode(ObjID)][FarmID];
}

IsNodeTaken(node, cowid = -1)
{
	for(new i = 0; i < 60; ++i) {
		if(GetCowNode(i) == node && cowid == -1) return 1;
		else if(GetCowNode(i) == node && cowid != -1) return 2;
	}
	return 0;
}

CountNodesInFarm(farmid)
{
	new Nodes = 0;
	for(new i = 0; i <= 67; ++i)
	{
		if(CowNodes[i][FarmID] == farmid) ++Nodes;
	}
	return Nodes;
}

GetFirstNode(farmid)
{
	for(new i = 0; i <= 67; ++i)
	{
		if(CowNodes[i][FarmID] == farmid) 
		{
			return i;
		}
	}
	return 0;
}

PutCowOnNextNode(ObjID)
{
	new currentNode = GetCowNode(ObjID);
	new newNode = currentNode;
	if(currentNode > GetFirstNode(GetCowCurrentFarm(ObjID)) -1 && currentNode < CountNodesInFarm(GetCowCurrentFarm(ObjID))) 
	{
		while(IsNodeTaken(newNode, ObjID) == 2) 
		{
			++newNode;
		}
		
		if(newNode == currentNode) return 0;
		SetObjectFaceCoords3D(ObjID,  CowNodes[newNode][Xpos],  CowNodes[newNode][Ypos], CowNodes[newNode][Zpos]);
		MoveDynamicObject(ObjID, CowNodes[newNode][Xpos], CowNodes[newNode][Ypos], CowNodes[newNode][Zpos], 2.0);
		printf("Moving");
		return 1;
	}
	return -1;
}

CreateCow(farmid)
{
	new OID = CreateDynamicObject(16442, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	IsACow[OID] = true;
	SetDynamicObjectPos(OID, CowNodes[GetFirstNode(farmid)][Xpos], CowNodes[GetFirstNode(farmid)][Ypos], CowNodes[GetFirstNode(farmid)][Zpos]);
	PutCowOnNextNode(OID);
	printf("Create cow");

}

IsPlayerInAircraft(playerid) {

	switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case 417: return 1;
		case 460: return 1;
		case 469: return 1;
		case 487..488: return 1;
		case 511: return 1;
		case 553: return 1;
		case 563: return 1;
		case 592..593: return 1;
		default: return 0;		
	}
	return -1;//something went terribly wrong.
}

GenerateCenterID() {

	for(new i = 0; i < MAX_CENTERID; i++) {
		if(!CenterCreated[i]) return i;
	}
	return -1;
}

SweeperID() {

	for(new i = 0; i < MAX_SWEEPS; i++) {
		if(!SweepCreated[i]) return i;
	}
	return -1;
}

GetNearestWeedToPlayer(playerid) {
    new Float:pos[3];
	for(new i = 0; i < MAX_WEED; i++) {
	    GetDynamicObjectPos(WeedInfo[i][WeedObject], pos[0], pos[1], pos[2]);
	    if(IsPlayerInRangeOfPoint(playerid, 6.0, pos[0], pos[1], pos[2])) return i;
	}
	return -1;
}

GetNearestFireToPlayer(playerid) {
    new Float:pos[3];
	for(new i = 0; i < MAX_FIRES; i++) {
	    GetDynamicObjectPos(FireInfo[i][object], pos[0], pos[1], pos[2]);
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, pos[0], pos[1], pos[2])) return i;
	}
	return -1;
}

SendDebugMessage(callback[], msg[]) {

	#if defined __DEBUG

		SendClientMessageToAll(-1, msg);
		printf("[DEBUG :: %s] %s", callback, msg);
		new day, month, year;
		getdate(year, month, day);
		format(G_String, 128, "sfcnr/debug/debug_%02d_%02d_%02d.log", day, month, year);
		new File:debug_ = FileOpen(G_String);
		F_String(debug_, callback, msg);
		F_Close(debug_);

	#endif
	#if !defined __DEBUG

		#pragma unused callback
		#pragma unused msg

	#endif
}

Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

  new Float:DX, Float:DY;
  new Float:angle;

  DX = floatabs(floatsub(x2,X));
  DY = floatabs(floatsub(y2,Y));

  if (DY == 0.0 || DX == 0.0) {
    if(DY == 0 && DX > 0) angle = 0.0;
    else if(DY == 0 && DX < 0) angle = 180.0;
    else if(DY > 0 && DX == 0) angle = 90.0;
    else if(DY < 0 && DX == 0) angle = 270.0;
    else if(DY == 0 && DX == 0) angle = 0.0;
  }
  else {
    angle = atan(DX/DY);

    if(X > x2 && Y <= y2) angle += 90.0;
    else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    else if(X < x2 && Y >= y2) angle -= 90.0;
    else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
  }

  return floatadd(angle, 90.0);
}

stock Float: GetPointZPos(const Float: fX, const Float: fY, &Float: fZ = 0.0) {
        if(!((-3000.0 < fX < 3000.0) && (-3000.0 < fY < 3000.0))) {
                return 0.0;
        }
        static
                File: s_hMap
        ;
        if(!s_hMap) {
                s_hMap = fopen("SAfull.hmap", io_read);
               
                if(!s_hMap) {
                        return 0.0;
                }
        }
        new
                afZ[1]
        ;
        fseek(s_hMap, ((6000 * (-floatround(fY, floatround_tozero) + 3000) + (floatround(fX, floatround_tozero) + 3000)) << 1));
        fblockread(s_hMap, afZ);
       
        return (fZ = ((afZ[0] >>> 16) * 0.01));
}

CreateVehicleFire(vehicleid, numfires) {
	
	new Float:pos[3], radius, Float:ground, center = GenerateCenterID();

	for(new i = 0; i < numfires; i++) {

		GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
		GetPointZPos(pos[0], pos[1], ground);

		if((ground + 50.0) < pos[2]) {
			return 0;
		} 

		Rand = randomEx(1, 360);
		radius = randomEx(1, 10);
		

		pos[0] += (radius * floatcos(-Rand, degrees));
		pos[1] += (radius * floatsin(-Rand, degrees));

		new id = GenerateFireID();

		FireInfo[id][object] = CreateDynamicObject(18688, pos[0], pos[1], ground-2.0, 0.0, 0.0, 0.0);
		FireInfo[id][icon] = CreateDynamicMapIcon(pos[0], pos[1], ground-2.0, 0, 0x00FF00);
		printf("numfires=%d", numfires);
		if(id != -1) {
			FireInfo[id][pos1] = pos[0];
			FireInfo[id][pos2] = pos[1];
			FireInfo[id][pos3] = ground - 2.0;
			FireInfo[id][Ftime] = gettime();
			FireInfo[id][Ftype] = 1;
			FireInfo[id][centerid] = center;
			FireInfo[id][area] = id;
			FireInfo[id][total] = numfires;
			CenterCreated[center] = true;
			FireCreated[id] = true;
			

		} else printf("ERROR~ There wasn't any fire slots left.");
	}
	return 1;
}

stock GetXYInFrontOfPoint(&Float:xp, &Float:yp, Float:angle, Float:distance) {
	xp += (distance * floatsin(-angle, degrees));
	yp += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:xa, Float:ya, Float:za, Float:radius) {
	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
 	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
  	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

	new Float:vertical, Float:horizontal;

	switch (GetPlayerWeapon(playerid)) {
	  case 34,35,36: {
	  if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, xa, ya, za, vector_x, vector_y, vector_z) < radius) return true;
	  return false;
	  }
	  case 30,31: {vertical = 4.0; horizontal = -1.6;}
	  case 33: {vertical = 2.7; horizontal = -1.0;}
	  default: {vertical = 6.0; horizontal = -2.2;}
	}

  	new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
  	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
  	GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

  	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, xa, ya, za, resize_x, resize_y, resize_z) < radius) return true;
  	return false;
}

randomEx(minnum = cellmin, maxnum = cellmax) return random(maxnum - minnum + 1) + minnum;

HasPlayerPlacedHit(playerid) {

	foreach(Player, i) {
	    if(Hitter[i] == playerid) return 1;
	}
	return 0;
}

ToggleRulesTextDraw(playerid) {

	if(PlayerVariables[playerid] & PLAYER_READING_RULES && !(PlayerVariables[playerid] & PLAYER_FORCED_READ_RULES)) {
	    for(new i = 0; i < 14; i++) {
	        TextDrawHideForPlayer(playerid, RulesTextDraw[i]);
	    }
	    PlayerVariables[playerid] &= ~PLAYER_READING_RULES;
	} else if(!(PlayerVariables[playerid] & PLAYER_READING_RULES) && !(PlayerVariables[playerid] & PLAYER_FORCED_READ_RULES)) {
	    for(new i = 0; i < 14; i++) {
	        TextDrawShowForPlayer(playerid, RulesTextDraw[i]);
	    }
	    PlayerVariables[playerid] |= PLAYER_READING_RULES;
	}
}

ShowDialog(playerid, title[], content[], button1[], button2[], onebutton = false) {

	TextDrawShowForPlayer(playerid, DialogBoxes[0]);
	TextDrawShowForPlayer(playerid, DialogBoxes[1]);

	PlayerTextDrawSetString(playerid, DialogTitle[playerid], title);
	PlayerTextDrawShow(playerid, DialogTitle[playerid]);

	if(!onebutton) {
		PlayerTextDrawSetString(playerid, DialogButtonText[playerid][0], button1);
		PlayerTextDrawShow(playerid, DialogButtonText[playerid][0]);
		PlayerTextDrawSetString(playerid, DialogButtonText[playerid][1], button2);
		PlayerTextDrawShow(playerid, DialogButtonText[playerid][1]);
		TextDrawShowForPlayer(playerid, DialogButtons[0]);
		TextDrawShowForPlayer(playerid, DialogButtons[1]);
	} else {
		TextDrawShowForPlayer(playerid, DialogButtons[2]);
		PlayerTextDrawSetString(playerid, DialogButtonText[playerid][2], button1);
		PlayerTextDrawShow(playerid, DialogButtonText[playerid][2]);
	}
	new temp[4][100];
	if(strlen(content) > 55) {
		strmid(temp[0], content, 0, 61);
		strmid(temp[1], content, 61, 121);
		strmid(temp[2], content, 121, 182);
		strmid(temp[3], content, 182, 233);

		PlayerTextDrawSetString(playerid, DialogContent[playerid][0], temp[0]);

		PlayerTextDrawShow(playerid, DialogContent[playerid][0]);

		PlayerTextDrawSetString(playerid, DialogContent[playerid][1], temp[1]);

		PlayerTextDrawShow(playerid, DialogContent[playerid][1]);

		PlayerTextDrawSetString(playerid, DialogContent[playerid][2], temp[2]);

		PlayerTextDrawShow(playerid, DialogContent[playerid][2]);

		PlayerTextDrawSetString(playerid, DialogContent[playerid][3], temp[3]);

		PlayerTextDrawShow(playerid, DialogContent[playerid][3]);


	} else {
		PlayerTextDrawSetString(playerid, DialogContent[playerid][0], content);
		PlayerTextDrawShow(playerid, DialogContent[playerid][0]);
	}

	SelectTextDraw(playerid, COLOR_RED2);
	return 1;
}

SetObjectFaceCoords3D(iObject, Float: fX, Float: fY, Float: fZ, Float: fRollOffset = 0.0, Float: fPitchOffset = 0.0, Float: fYawOffset = 0.0) {
    new
        Float: fOX,
        Float: fOY,
        Float: fOZ,
        Float: fPitch
    ;
    GetObjectPos(iObject, fOX, fOY, fOZ);

    fPitch = floatsqroot(floatpower(fX - fOX, 2.0) + floatpower(fY - fOY, 2.0));
    fPitch = floatabs(atan2(fPitch, fZ - fOZ));

    fZ = atan2(fY - fOY, fX - fOX) - 90.0; // Yaw

    SetObjectRot(iObject, fRollOffset, fPitch + fPitchOffset, fZ + fYawOffset);
}

GetTimeToPosition(playerid, Float:xpos, Float:ypos, Float:zpos) {

	new Float:distance = GetPlayerDistanceFromPoint(playerid, xpos, ypos, zpos);

	new time = floatround( distance / GetVehicleSpeed(GetPlayerVehicleID(playerid)) );
	return time;
}

IsPlayerWanted(playerid) {
	if(WantedLevel[playerid] > 0) return 1;
	return 0;
}

SetPlayerLangRoom(playerid, roomid) {

	if(playerid == INVALID_PLAYER_ID) return -1;
	return PlayerInfo[playerid][LangRoom] = roomid;

}

stock GetDistance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
    return floatround(floatsqroot(((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2)) + ((z1 - z2) * (z1 - z2))));
}

SendMessageToLangRoom(playerid, roomid, message[]) {

	if(roomid == -1) return -1;

	foreach(Player, i) {

	    if(GetPlayerLangRoom(i) == roomid) {
	        SendClientMessage(i, GetPlayerColor(playerid), message);
	    }
	}

	return 1;
}

GetPlayerLangRoom(playerid) {

	if(playerid == INVALID_PLAYER_ID) return -1;
	return PlayerInfo[playerid][LangRoom];

}

bool:IsPlayerInBusiness(playerid)
{
	if(PlayerInfo[playerid][BizID] != -1)
		return true;
	else
		return false;
}

GivePlayerBankMoney(playerid, money)
{
	return PlayerInfo[playerid][Pbank] += money;
}

TakePlayerBankMoney(playerid, money)
{
	return PlayerInfo[playerid][Pbank] -= money;
}

IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
    new Float:X, Float:Y, Float:Z;

    GetPlayerPos(playerid, X, Y, Z);
    if(X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY) {
        return 1;
    }
    return 0;
}

//credits to ryder
RandomString(strDest[], strLen = 10) {
	while(strLen--)
		strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
}

SendMessageToPMGroup(groupid, color, const message[])
{
	for(new i = 0; i < MAX_PLAYERS; ++i) {
	    if(PlayerInfo[i][GroupID] == groupid) {
	        SendClientMessage(i, color, message);
	    }
	}

	return 1;
}

IsPlayerInRobberyCheckpoint(playerid) {

	for(new i = 12; i <= 25; i++) {
	    if(IsPlayerInDynamicCP(playerid, checkpoints[i])) return true;
	}

	return false;
}

GetSpikeID()
{
	for(new i = 0; i < MAX_SPIKES; i++)
	{
	    if(SpikeCreated[i] == false) return i;
	}
	return -1;
}

stock VehicleCollision(vehicle1, vehicle2) {
	new Float:pos[6], Float:dist[3], Float:distance;
	GetVehiclePos(vehicle1, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicle2, pos[3], pos[4], pos[5]);

	dist[0] = pos[0]-pos[3];
	dist[1] = pos[1]-pos[4];
	dist[2] = pos[2]-pos[5];
	distance = floatsqroot(dist[0]*dist[0] + dist[1]*dist[1] + dist[2] * dist[2]);

	if(distance <= (2.89 + 2.89)) {
		SendClientMessageToAll(-1, "chicken");
		pos[0] += -dist[0] * 0.075;
		pos[1] += -dist[1] * 0.075;
		pos[2] += -dist[2] * 0.075;

		pos[3] += -dist[0] * 0.075;
		pos[4] += -dist[1] * 0.075;
		pos[5] += -dist[2] * 0.075;

		SetVehiclePos(vehicle1, pos[0], pos[1], pos[2]);
		SetVehiclePos(vehicle2, pos[3], pos[4], pos[5]);
	}
}

GetVehID()
{
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
     if(VehCreated[i] == false) return i;
	}
	return -1;
}

SettingsPath(playerid) {
	format(G_String, 128, "sfcnr/settings/%s", PlayerName(playerid));
	return G_String;
}

CreateSettingsFile(playerid) {

	new File:settings = FileOpen(SettingsPath(playerid));
 	F_Bool(settings, "PLAYER_SEEN_BANK", false);
	F_Close(settings);
}

GetRoadBlockID()
{
	for(new i = 0; i < MAX_ROADBLOCKS; i++)
	{
	    if(RBCreated[i] == false) return i;
	}
	return -1;
}

LawMSG(playerid, reason[])
{
	format(G_String, 128, "[LAW] %s has %s please go out and catch him", PlayerName(playerid), reason);
	return G_String;
}

CloseDialog(playerid)
{
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");
	return 1;
}

SetPrisonTime(playerid, time)
{
	PlayerInfo[playerid][PrisonTime] = time;
	CallLocalFunction("OnPlayerEnterPrison", "ddd", playerid, time, WantedLevel[playerid]);
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:XP, &Float:YP, Float:distance)
{	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, XP, YP, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	XP += (distance * floatsin(-a, degrees));
	YP += (distance * floatcos(-a, degrees));
}

//return a players name
PlayerName(playerid) {
	new name[24];
	GetPlayerName(playerid, name, 24);

	return name;
}

//Get a players name from thier ip
PlayeridFromIP(ip[]) {
	foreach(Player, i) { // Loop through everyone
	    if(!strcmp(PlayerInfo[i][Pip], ip, false)) { // Is their ip same as the given ip?
	        return i;//return their ip
	    } else {
	        return -1; // No ip was found
	    }

	}

	return 0;
}


stock UpdatePlayerJobLevel(playerid) {

	Rand = random(3); // random

	if(Rand == 1) {

	    switch(gTeam[playerid]) {

	        case HITMAN: PlayerInfo[playerid][Phitman]+=1;
	        case TERRORIST: PlayerInfo[playerid][PTERRORIST]+=1;
	        case STAT: PlayerInfo[playerid][Pstat]+=1;
	        case ARMY: PlayerInfo[playerid][Parmy]+=1;
	        case POLICE: PlayerInfo[playerid][Pcop]+=1;
	        case RAPIST: PlayerInfo[playerid][Prape]+=1;
	        case MECHANIC: PlayerInfo[playerid][Pfix]+=1;
	        case MEDIC: PlayerInfo[playerid][Pheal]+=1;
	        case DRUG: PlayerInfo[playerid][Pdrug]+=1;
	        case ROB: PlayerInfo[playerid][Prob]+=1;
	        case WEP: PlayerInfo[playerid][Pwep]+=1;
	        case ITEMS: PlayerInfo[playerid][Psales]+=1;
	        case KIDNAPPER: PlayerInfo[playerid][Pkidnapper]+=1;
	        case PEDO: PlayerInfo[playerid][Ppedo]+=1;
	        case TRUCKER: PlayerInfo[playerid][Ptruck]+=1;
	        case TAXI: PlayerInfo[playerid][Ptaxi]+=1;
	        case SWAT: PlayerInfo[playerid][Pswat]+=1;
	        case PILOT: PlayerInfo[playerid][Ppilot]+=1;
	        case PIZZABOY: PlayerInfo[playerid][Ppizza]+=1;
	        case FARMER: PlayerInfo[playerid][Pfarmer]+=1;
	        case MINER: PlayerInfo[playerid][Pminer]+=1;

	    }

	}
	return 0;
}

//Show a casual textdraw
ShowCasualTextdraw(playerid, NewText[])
{
	PlayerTextDrawSetString(playerid, Casual[playerid], NewText);
    PlayerTextDrawShow(playerid, Casual[playerid]);
    return 1;
}

PlayAudioForEveryoneInVeh(vehid, stream[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(GetPlayerVehicleID(i) == vehid)
	    {
	        PlayAudioStreamForPlayer(i, stream);
		}
	}
}

IsNumeric(str[])
{
	for(new i = 0; i < strlen(str); i++) {
	    if(str[i] > '9' || str[i] < '0') return 0;
	}

	return 1;
}

IsPlayerInRangeOfPlayer(playerid, otherid, Float:distance)
{
	new Float:pos[3];
	GetPlayerPos(otherid, pos[0], pos[1], pos[2]);
	if(IsPlayerInRangeOfPoint(playerid, distance, pos[0], pos[1], pos[2])) return 1;

	return 0;
}

PlayerZone(playerid)
{
    new zone[28];
    GetPlayer2DZone(playerid, zone, 28);

    return zone;
}

IsPlayerCivilianClass(playerid)
{
	if(gTeam[playerid] == CIVILIAN || gTeam[playerid] == TERRORIST || gTeam[playerid] == RAPIST || gTeam[playerid] == DRUG || gTeam[playerid] == ROB || gTeam[playerid] == WEP || gTeam[playerid] == ITEMS || gTeam[playerid] == KIDNAPPER || gTeam[playerid] == PEDO || gTeam[playerid] == CARJACKER || gTeam[playerid] == WHORE) return 1;
	return 0;
}

IsPlayerCivilian(playerid)
{
	if(gTeam[playerid] == CIVILIAN || gTeam[playerid] == TERRORIST || gTeam[playerid] == RAPIST || gTeam[playerid] == DRUG || gTeam[playerid] == ROB || gTeam[playerid] == WEP || gTeam[playerid] == ITEMS || gTeam[playerid] == KIDNAPPER || gTeam[playerid] == PEDO || gTeam[playerid] == CARJACKER
	|| gTeam[playerid] == HITMAN || gTeam[playerid] == MECHANIC || gTeam[playerid] == TRUCKER || gTeam[playerid] == TAXI || gTeam[playerid] == PILOT || gTeam[playerid] == PIZZABOY || gTeam[playerid] == FARMER || gTeam[playerid] == MINER || gTeam[playerid] == CARJACKER || gTeam[playerid] == WHORE) return 1;
	return 0;
}

IsPlayerAiming(playerid)
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) || (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
	return 0;
}

SendMessageToLaw(color, message[])
{
	foreach(Player, i)
	{
	    if(gTeam[i] == STAT || gTeam[i] == ARMY || gTeam[i] == SWAT || gTeam[i] == POLICE) return SendClientMessage(i, color, message);
	}
	return 0;
}

ProxDetector(Float:radi, playerid, string[],color)
{
    new Float:position[3];
    GetPlayerPos(playerid,position[0],position[1],position[2]);
    foreach(Player, i)
	{
        if(IsPlayerInRangeOfPoint(i,radi,position[0],position[1],position[2]))
		{
            SendClientMessage(i,color,string);
        }
    }
}

SendMessageToAdmins(color, message[])
{
	foreach(Player, i)
	{
	    if(PlayerInfo[i][Padmin] >= ADMIN) return SendClientMessage(i, color, message);
	}
	return 0;
}

SendMessageToClass(classid, color, message[])
{
	foreach(Player, i)
	{
	    if(gTeam[i] == classid) return SendClientMessage(i, color, message);
	}
	return 0;
}

IsPointInRangeOfPoint(Float:xp, Float:yp, Float:zp, Float:x2, Float:y2, Float:z2, Float:range)
{
    x2 -= xp;
    y2 -= yp;
    z2 -= zp;
    return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}

GetInteriorID(Float:Xp, Float:Yp, Float:Zp)
{
	for(new i = 0; i < sizeof(RobberyPlaces); i++) {
	    if(IsPointInRangeOfPoint(Xp, Yp, Zp, RobberyPlaces[i][Xpos], RobberyPlaces[i][Ypos], RobberyPlaces[i][Zpos], 2.0)) {
	        return RobberyPlaces[i][RobberyID];
	    }
	}
	return -1;
}

BugPath(playerid)
{
	new path[100];
	format(path, 100, "sfcnr/BugReport_%s.ini", PlayerName(playerid));
	return path;
}

KickLog(playerid, kickedid, reason[])
{
	new year, month, day, Query[300];
	getdate(year, month, day);
	format(Query, 300, "INSERT INTO `kicks` (Kicked, Kicker, Reason, Date) VALUES('%s', '%s', '%s', '%02d/%02d/%d')", PlayerName(kickedid), PlayerName(playerid), reason, day, month, year);
	mysql_function_query (Gconnection, Query, false, "", "");
	return 1;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if (strfind(VehicleNames[i], vname, true) != -1)
			return i + 400;
	}
	return -1;
}

GetWeaponModelIDFromName(wname[])
{
	for(new i = 0;i < 47;i++)
	{
	    if(strfind(WeaponNames[i], wname, true) != -1)
	        return i;
	}
	return -1;
}

IsPlayerSpamming(playerid)
{
    if((gettime() - Time[playerid])  > 2) {
		Time[playerid] = gettime();
		return 1;
	} else return 0;
}

HasPlayerRecentlyBeenRaped(playerid)
{
    if((gettime() - RapeTime[playerid])  > 120) {
		return 1;
	} else return 0;
}

HasPlayerRecentlyBeenRobed(playerid)
{
    if((gettime() - RobTime[playerid])  > 120) {
		return 1;
	} else return 0;
}

HouseGetFreeSlot()
{
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(!HCreated[i]) return i;
    }

    return -1;
}

GetInteriorName(intname[])
{
    new name[128];
    for(new i = 0;i < 47;i++)
    {
        if(strfind(Interiors[i][InteriorName], intname, true) != -1) {
            format(name,128,"%s", Interiors[i][InteriorName]);
            break;
        }
    }
    return name;
}

SendRadioToLaw(playerid, crimeid) {

	foreach(Player, i) {

		if(gTeam[i] == POLICE || gTeam[i] == SWAT || gTeam[i] == STAT || gTeam[i] == ARMY) {
			PlayCrimeReportForPlayer(i, playerid, crimeid);
		}
	}
}

GetInteriorNameRow(intname[])
{
    for(new i = 0;i < 47;i++)
    {
        if(strfind(Interiors[i][InteriorName], intname, true) != -1) {
            return i;
        }
    }
    return -1;
}

SetJobStartTime(playerid, team =0, time) {

	if(team > 24) return 0;
	JobTime[playerid][team] = time;
	return 1;
}

/*GetPlayerInteriorID(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	for(new i = 0; i < sizeof(Interiors); i++) {
	    if(IsPointInRangeOfPoint(pos[0], pos[1], pos[2], Interiors[i][InteriorX], Interiors[i][InteriorY], Interiors[i][InteriorZ], 2.0)) {
	        return Interiors[i][UID];
	    }
	}
	return -1;
}
*/
HouseCreate(owner[], interiorname[], Float:X, Float:Y, Float:Z)
{
    new HouseID = HouseGetFreeSlot();
    new row = GetInteriorNameRow(interiorname);
	new doortext[200];
    HouseInfo[HouseID][Xpos] = X;
    HouseInfo[HouseID][Ypos] = Y;
    HouseInfo[HouseID][Zpos] = Z;
    format(HouseInfo[HouseID][Howner], 24, "%s", owner);
    HouseInfo[HouseID][Howned] = true;
    HCreated[HouseID] = true;
    HouseInfo[HouseID][HID] = CreateDynamicPickup(1273, 1, X, Y, Z, -1, -1, -1, 100.0);
    format(HouseInfo[HouseID][Interiorname], 100, "%s", GetInteriorName(interiorname));
	HouseInfo[HouseID][IntXpos] = Interiors[row][InteriorX];
	HouseInfo[HouseID][IntYpos] = Interiors[row][InteriorY];
	HouseInfo[HouseID][IntZpos] = Interiors[row][InteriorZ];
	HouseInfo[HouseID][interiorid] = Interiors[row][InteriorID];
	format(doortext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} No\n{FFFFFF}For sale: {FF0000}No", HouseInfo[HouseID][Howner]);
	HouseInfo[HouseID][Doortext] = CreateDynamic3DTextLabel(doortext, -1, X, Y, Z, 30.0);
    return HouseID;
}

CommenceRobbery(playerid, storeid)
{
	if(storeid == -1) return -1;//the player isn't in a store
	if(StoreRobbed[storeid] == true) return -2;//store robbed

	foreach(Player, i) {
	    if(StoreRobbing[i] == storeid) return -3;//being robbed
	}

	StoreRobbing[playerid] = storeid;

	SendClientMessage(playerid, COLOR_ORANGE, "You are now robbing a store. Watch out for any criminals or cops!");
	return 1;
}

ShowJobTextdraw(playerid, text[]) {

	PlayerTextDrawSetString(playerid, JobTextdraw[playerid], text);
	PlayerTextDrawShow(playerid, JobTextdraw[playerid]);
}

//Vehicle functions.

ToggleVehicleEngine(vid)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(engine == VEHICLE_PARAMS_UNSET || engine == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,door,bonnet,boot,objective);
	 else SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,door,bonnet,boot,objective);
}

ToggleVehicleLights(vid)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(lights == VEHICLE_PARAMS_UNSET || lights == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_ON,alarm,door,bonnet,boot,objective);
	 else SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_OFF,alarm,door,bonnet,boot,objective);
}

ToggleVehicleDoorsLocked(vid)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(door == VEHICLE_PARAMS_UNSET || door == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,engine,lights,alarm,VEHICLE_PARAMS_ON,bonnet,boot,objective);
	 else SetVehicleParamsEx(vid,engine,lights,alarm,VEHICLE_PARAMS_OFF,bonnet,boot,objective);
}

ToggleVehicleHood(vid)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(bonnet == VEHICLE_PARAMS_UNSET || bonnet == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,engine,lights,alarm,door,VEHICLE_PARAMS_ON,boot,objective);
	 else SetVehicleParamsEx(vid,engine,lights,alarm,door,VEHICLE_PARAMS_OFF,boot,objective);
}

ToggleVehicleTrunk(vid)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(boot == VEHICLE_PARAMS_UNSET || boot == VEHICLE_PARAMS_OFF) SetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,VEHICLE_PARAMS_ON,objective);
	 else SetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,VEHICLE_PARAMS_OFF,objective);
}

SetVehicleEngineState(vid, setstate)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(setstate) SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,door,bonnet,boot,objective);
	 else SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,door,bonnet,boot,objective);
}

//------------------------------------------------