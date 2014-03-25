public OnPlayerEnterDynamicArea(playerid, areaid)
{
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	SendDebugMessage("OnPlayerPickUpDynamicPickup()", "OnPlayerPickUpDynamicPickup Start");

	timing[0] = GetTickCount();

	if(pickupid == pickups[0] && gTeam[playerid] != DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] You have to be in the drug class to use this command.");
	else if(gTeam[playerid] == DRUG && pickupid == pickups[0]) return ShowPlayerDialog(playerid, DIALOG_DRUG, DIALOG_STYLE_LIST, "{FFFFFF} Drug Store", "Cocaine (500g)      {00FFFF}$50000\nHeroin (500g)      {00FFFF}$35000\nWeed (500g)      {00FFFF}$50000\nWeed Seeds (10 Seeds)      {00FFFF}$3000", "Purcahse", "Cancel");
	if(!IsPlayerInAnyVehicle(playerid)) {
		for(new i = 0; i < MAX_HOUSES; i++)
	    {
	    	//thanks tom.
	        if(IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][Xpos], HouseInfo[i][Ypos], HouseInfo[i][Zpos]) && !(PlayerVariables[playerid] & PLAYER_EDITING_HOUSE))
	        {
	            if(PlayerInfo[playerid][Padmin] < ADMIN) {
	          		format(G_String, 128, "{FFFFFF}%s House [%d]", HouseInfo[i][Howner], HouseInfo[i][SqlID]);
	           		HouseStanding[playerid] = i;
	           		ShowPlayerDialog(playerid, DIALOG_HOUSE, DIALOG_STYLE_LIST, G_String, "{FFFFFF}Enter\n{FFFFFF}Rob", "Select", "Close");
				} else {
				    format(G_String, 128, "{FFFFFF}%s House [%d]", HouseInfo[i][Howner], HouseInfo[i][SqlID]);
	           		HouseStanding[playerid] = i;
	           		ShowPlayerDialog(playerid, DIALOG_HOUSE, DIALOG_STYLE_LIST, G_String, "{FFFFFF}Enter\n{FFFFFF}Rob\n{FFFFFF}Edit", "Select", "Close");
				}
			}
	    }
	}

	for(new i = 0; i < MAX_WEED; i++) {

	    if(pickupid == WeedInfo[i][Pickup] && !strcmp(WeedInfo[i][Owner], PlayerName(playerid), false)) {
	        Rand = randomEx(1, 10);
	        Weed[playerid] += Rand;
	        format(G_String, 128, "You have harvested %d grams of weed!", Rand);
	        SendClientMessage(playerid, COLOR_GREEN, G_String);
	        DestroyDynamicPickup(WeedInfo[i][Pickup]);
	        DestroyDynamic3DTextLabel(WeedInfo[i][WeedLabel]);
	    }
	}

    if(pickupid == pickups[1])
	{
	    if(GetPlayerVirtualWorld(playerid) == 4 || GetPlayerVirtualWorld(playerid) == 2 && !(PlayerVariables[playerid] & PLAYER_ON_PICKUP))
	    {
	        ShowPlayerDialog(playerid, DIALOG_BUYSTUFF, DIALOG_STYLE_LIST, "{FFFFFF}Hippy Shopper", "", "Purchase", "Close");
	        PlayerVariables[playerid] |= PLAYER_ON_PICKUP;
 		}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerPickUpDynamicPickup() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerPickUpDynamicPickup()", debug_String);

    #endif

	SendDebugMessage("OnPlayerPickUpDynamicPickup()", "OnPlayerPickUpDynamicPickup End");

	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	SendDebugMessage("OnPlayerEnterDynamicCP()", "OnPlayerEnterDynamicCP Start");

	timing[0] = GetTickCount();

	if(checkpointid == checkpoints[0]) return ShowPlayerDialog(playerid, DIALOG_LESURE, DIALOG_STYLE_LIST, "Leisure Center", "Fight Club\nRace Track\nBlood Bowl", "Select", "Close");
	if(checkpointid == checkpoints[1])
	{
	    if(!IsPlayerInAnyVehicle(playerid)) {
			if(!IsPlayerCivilian(playerid))
			{
				ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a law enforcement to use this.");
			}
		}
  	}
  	foreach(Player, i) {
  		if(checkpointid == PlayerFoodSale[i] && i != playerid) {
  			format(G_String, 128, "Do you wish to buy a %s at the price of $%d?", ((FoodSelling[i]) == 1 ? ("hotdog") : ("icecream")), FoodPrice[i]);
  			ShowPlayerDialog(playerid, DIALOG_BUY_FOOD, DIALOG_STYLE_MSGBOX, "Purchase food", G_String, "Yes", "No");
  		}
  	}
  	if(checkpointid == checkpoints[7]) {
  	    ShowPlayerDialog(playerid, DIALOG_BUYCAR, DIALOG_STYLE_LIST, "{FFFFFF}Manage Vehicles", "Purcahse\nManage", "Select", "Cancel");

  	}

  	if(checkpointid == checkpoints[2])
  	{
  	    if(!IsPlayerInAnyVehicle(playerid)) {
	  	    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
	  	    SetPlayerInterior(playerid, 17);
	  	    SetPlayerVirtualWorld(playerid, 1);
	  	    SetPlayerFacingAngle(playerid, 356.1240);
		}
	}
	if(checkpointid == checkpoints[3])
	{
        if(!IsPlayerInAnyVehicle(playerid)) {
		    SetPlayerPos(playerid, 6.091179,-29.271898,1003.549438);
		    SetPlayerInterior(playerid, 10);
		    SetPlayerVirtualWorld(playerid, 2);
		    SetPlayerFacingAngle(playerid, 356.1240);
		}
	}
	if(checkpointid == checkpoints[4])
	{
	    if(!IsPlayerInAnyVehicle(playerid)) {
		    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
		    SetPlayerVirtualWorld(playerid, 3);
		    SetPlayerInterior(playerid, 17);
		    SetPlayerFacingAngle(playerid, 356.1240);
		}
 	}
 	if(checkpointid == checkpoints[6])
 	{
 	    if(!IsPlayerInAnyVehicle(playerid)) {
	 	    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
		    SetPlayerVirtualWorld(playerid, 4);
		    SetPlayerInterior(playerid, 17);
		    SetPlayerFacingAngle(playerid, 356.1240);
		}
	}
 	if(checkpointid == checkpoints[5])
 	{
 	    if(!IsPlayerInAnyVehicle(playerid)) {
	 		if(GetPlayerVirtualWorld(playerid) == 1)
	 	    {
	 	        SetPlayerPos(playerid, -1674.0250,429.9817,7.1797);
	 	        SetPlayerInterior(playerid, 0);
	 	        SetPlayerVirtualWorld(playerid, 0);
	 	        SetCameraBehindPlayer(playerid);
			}
			if(GetPlayerVirtualWorld(playerid) == 2)
			{
			    SetPlayerPos(playerid, -2590.9658,60.0634,4.3359);
			    SetPlayerInterior(playerid, 0);
			    SetPlayerVirtualWorld(playerid, 0);
			    SetCameraBehindPlayer(playerid);
			}
			if(GetPlayerVirtualWorld(playerid) == 3)
			{
			    SetPlayerPos(playerid, -2442.5439,750.7072,35.1786);
			    SetPlayerInterior(playerid, 0);
			    SetPlayerVirtualWorld(playerid, 0);
			    SetCameraBehindPlayer(playerid);
			}
			if(GetPlayerVirtualWorld(playerid) == 4)
			{
			    SetPlayerPos(playerid, -2507.9702,-49.8341,25.6841);
			    SetPlayerInterior(playerid, 0);
			    SetPlayerVirtualWorld(playerid, 0);
			    SetCameraBehindPlayer(playerid);
			}
		}
	}
	if(checkpointid == checkpoints[8])
	{
	    if(!IsPlayerInAnyVehicle(playerid)) {
   	 		SetPlayerPos(playerid, 384.808624,173.804992,1008.382812);
	    	SetPlayerInterior(playerid, 3);
		}
	}
	if(checkpointid == checkpoints[9]) {
	    if(!IsPlayerInAnyVehicle(playerid)) {
			SetPlayerFacingAngle(playerid, 274.7602);
   	 		SetPlayerPos(playerid, 2310.3022,-15.9175,26.7496);
		 	SetCameraBehindPlayer(playerid);
		}
	}
	if(checkpointid == checkpoints[10]) {
		SetPlayerFacingAngle(playerid, 319.4032);
	    SetPlayerPos(playerid, -2047.2037,460.8828,35.1719);
	    SetCameraBehindPlayer(playerid);

	}

	if(checkpointid == checkpoints[11]) {//bank menu
	    ShowPlayerDialog(playerid, DIALOG_BANKMENU, DIALOG_STYLE_LIST, "{FFFFFF}Bank Menu", "{FFFFFF}Withdraw\n{FFFFFF}Deposit\n{FFFFFF}Bank Statement\n{FFFFFF}Perform wire transfer\nRob Bank", "Select", "Cancel");
	}

	if(checkpointid == JobCheckpoint[playerid]) {

	    if(JobStatus[playerid] == 1) {
	    	ItemBarValue[playerid] = 1;
	    	SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
	    	TogglePlayerControllable(playerid, 0);
		} else if(JobStatus[playerid] == 2) {
		    ItemBarValue[playerid] = 1;
		    SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
		    TogglePlayerControllable(playerid, 0);
		}
	}

	if(checkpointid == checkpoints[27]) {
		if(!IsPlayerCivilian(playerid)) return 0;
		SetPlayerPos(playerid, 316.524993,-167.706985,999.593750);
		SetPlayerInterior(playerid, 6);
		InCriminalBase[playerid] = true;
		SetPlayerVirtualWorld(playerid, 2);
	}

	if(checkpointid == checkpoints[28]) {
		SetPlayerInterior(playerid, 15);
		SetPlayerPos(playerid, 2215.454833,-1147.475585,1025.796875);
		SetPlayerVirtualWorld(playerid, 1);
		PlayerVariables[playerid] |= IN_HOTEL;
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerEnterDynamicCP() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerEnterDynamicCP()", debug_String);

    #endif

	SendDebugMessage("OnPlayerEnterDynamicCP()", "OnPlayerEnterDynamicCP End");

	return 1;
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	SendDebugMessage("OnPlayerLeaveDynamicCP()", "OnPlayerLeaveDynamicCP Start");

	timing[0] = GetTickCount();

	if(StoreRobbing[playerid] != -1) {
		for(new i = 12; i <= 25;i++) {
		    if(checkpointid == checkpoints[i]) {
				StoreRobbing[playerid] = -1;
				PlayerTextDrawHide(playerid, RobberyText[playerid]);//go away textdraw
            	RobberyTime[playerid] = 16;
            	GameTextForPlayer(playerid, "~r~Robbery Failed!~n~You failed to stay in the checkpoint!", 4000, 4);
		    }
		}
	}

	if(checkpointid == checkpoints[7]) {
	    PlayerTextDrawHide(playerid, VehicleBuy[playerid][0]);
  	    TextDrawHideForPlayer(playerid,VehButtons[1]);
  	    TextDrawHideForPlayer(playerid,VehButtons[0]);
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerLeaveDynamicCP() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerLeaveDynamicCP()", debug_String);

    #endif

	SendDebugMessage("OnPlayerLeaveDynamicCP()", "OnPlayerLeaveDynamicCP End");

	return 1;
}