#include <YSI\y_hooks>

enum weedI
{
    WeedObject,
    Text3D:WeedLabel,
    bool:WeedWatered,
    Pickup,
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	Owner[24],
	bool:Burnt,
	burnttime,
	HHour,
	HMin,
	bool:ForHarvest
}

new WeedInfo[MAX_WEED][weedI];

WeedID() {

	for(new i = 0; i < MAX_WEED; i++)
	{
	    if(!IsValidDynamicObject(WeedInfo[i][WeedObject])) return i;
	}
 	return -1;
}

GetNearestWeedToPlayer(playerid)
{
    new Float:pos[3];
	for(new i = 0; i < MAX_WEED; i++)
	{
	    GetDynamicObjectPos(WeedInfo[i][WeedObject], pos[0], pos[1], pos[2]);
	    if(IsPlayerInRangeOfPoint(playerid, 6.0, pos[0], pos[1], pos[2])) return i;
	}
	return -1;
}

forward OnWeedBurnt(weedid, burner);

public OnWeedBurnt(weedid, burner)
{

    if(gTeam[burner] == POLICE && !WeedInfo[weedid][Burnt])
	{
        GivePlayerMoney(burner, 50);
        SetPlayerScore(burner, GetPlayerScore(burner)+1);
        SendClientMessage(burner, COLOR_GREEN, "You have destroyed illegal weed and earned yourself $50 and +1 score");
    }

    WeedInfo[weedid][Burnt] = true;
    WeedInfo[weedid][burnttime] = gettime();

	foreach(Player, j)
	{
		if(!strcmp(WeedInfo[weedid][Owner], PlayerName[j], false) && SeenWeedMessage[j] != true)
	 	{
			format(G_String, 128, "Attention! %s is burning your weed!", PlayerName[burner]);
   			SendClientMessage(j, COLOR_RED2, G_String);
   			SeenWeedMessage[j] = true;
		}
		
		new totalBurnt;
		
		//loop through all weed
		for(new i = 0; i < MAX_WEED; i++)
		{
			
			//if the weed is owned by our player
		    if(!strcmp(WeedInfo[i][Owner], PlayerName[j], false))
			{
				//if the weed is burnt
				if(WeedInfo[i][Burnt] == true)
				{
				    totalBurnt++;//count it up
					//if the count is equal to the ammount planted (allweed == burnt)
				    if(totalBurnt == WeedPlanted[j])
					{
				        SeenWeedMessage[j] = false;
				        SendClientMessage(j, COLOR_RED2, "Attention! All your weed has been burnt!");
				    }
				}
		    }
		}
	}


	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (HOLDING( KEY_FIRE ) && GetPlayerWeapon(playerid) == 37 || HOLDING( KEY_FIRE | KEY_HANDBRAKE ) && GetPlayerWeapon(playerid) == 37)
	{
		new Oid = GetNearestWeedToPlayer(playerid);
		if(Oid != -1)
		{
  			if(IsPlayerAimingAt(playerid, WeedInfo[Oid][Xpos], WeedInfo[Oid][Ypos], WeedInfo[Oid][Zpos], 6.0))
    			CallLocalFunction("OnWeedBurnt", "ii", Oid, playerid);
		}
	}
	return 1;
}
