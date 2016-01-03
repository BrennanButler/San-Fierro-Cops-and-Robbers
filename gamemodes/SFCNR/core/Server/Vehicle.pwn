#include <YSI\y_hooks>

hook OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if(WantedLevel[playerid] > 0) 
	{
	    if(ResprayWanted[playerid] != 1) 
	    {
	        foreach(new i : Player)
	        {
	            if(IsPlayerCivilian(i)) 
	            {
	                if(!IsPlayerInRangeOfPlayer(i, playerid, 150)) 
	                {
	                    WantedLevel[playerid]--;
	                    SetPlayerWantedLevel(playerid, WantedLevel[playerid]);
	                    ResprayWanted[playerid] = 1;
					}
				}
	        }
		}
	}

	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{

	if(CreatedVehicle[vehicleid]) 
	{
	    DestroyVehicle(vehicleid);
	    CreatedVehicle[vehicleid] = false;
	} 
	else 
	{
		new 
			Float:pos[3];

		GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
		if(!IsPointInRangeOfPoint(pos[0], pos[1], pos[2], pos[0], pos[1], -0.0974, 15.0)) //Check if the vehicle is in water
		{
			/*if(CreateVehicleFire(vehicleid, randomEx(10, 20))) 
			{	
				format(G_String, 128, "[FIRE] :{FFFFFF} there is a vehicle fire at %s! Dispatch and put out the fire", Location(pos[0], pos[1]));
				SendMessageToClass(FIREFIGHTER, COLOR_FIRE, G_String);
			}*/
		}
	}

	return 1;
}