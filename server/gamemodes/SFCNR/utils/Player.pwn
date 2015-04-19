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

IsPlayerInRangeOfPlayer(playerid, id, range)
{
	new
		Float:pos[3];
	GetPlayerPos(id, pos[0], pos[1], pos[2]);

	return IsPlayerInRangeOfPoint(playerid, range, pos[0], pos[1], pos[2]);
}

SendRadioToLaw(playerid, crimeid) 
{

	foreach(Player, i) 
	{

		if(gTeam[i] == POLICE || gTeam[i] == SWAT || gTeam[i] == STAT || gTeam[i] == ARMY) 
		{
			PlayCrimeReportForPlayer(i, playerid, crimeid);
		}
	}
}

IsPointInRangeOfPoint(Float:xp, Float:yp, Float:zp, Float:x2, Float:y2, Float:z2, Float:range)
{
    x2 -= xp;
    y2 -= yp;
    z2 -= zp;
    return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}

IsPlayerSpamming(playerid)
{
    if((gettime() - Time[playerid])  > 2) {
		Time[playerid] = gettime();
		return 1;
	} else return 0;
}

SetPrisonTime(playerid, time)
{
	PlayerInfo[playerid][PrisonTime] = time;
	CallLocalFunction("OnPlayerEnterPrison", "ddd", playerid, time, WantedLevel[playerid]);
	return 1;
}

stock UpdatePlayerJobLevel(playerid)
{

	Rand = random(3); // random

	if(Rand == 1)
	{

	    switch(gTeam[playerid])
		{

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

PlayerZone(playerid)
{
    new zone[28];
    GetPlayer2DZone(playerid, zone, 28);

    return zone;
}

SendMessageToClass(classid, color, message[])
{
	foreach(Player, i)
	{
	    if(gTeam[i] == classid) return SendClientMessage(i, color, message);
	}
	return 0;
}

Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ) {

	new Float:TGTDistance;

	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	new Float:tmpX, Float:tmpY, Float:tmpZ;

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

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

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) {
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:xa, Float:ya, Float:za, Float:radius) 
{
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