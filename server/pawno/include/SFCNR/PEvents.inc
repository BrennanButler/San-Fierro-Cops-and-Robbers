public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	SendDebugMessage("OnPlayerClickPlayerTextDraw()", "OnPlayerClickPlayerTextDraw Start");

	timing[0] = GetTickCount();

	if(playertextid == DialogButtonText[playerid][1] || playertextid == DialogButtonText[playerid][0] || playertextid == DialogButtonText[playerid][2]) {

		TextDrawHideForPlayer(playerid, DialogBoxes[0]);
		TextDrawHideForPlayer(playerid, DialogBoxes[1]);
		PlayerTextDrawHide(playerid, DialogTitle[playerid]);
		PlayerTextDrawHide(playerid, DialogButtonText[playerid][0]);
		PlayerTextDrawHide(playerid, DialogButtonText[playerid][1]);
		TextDrawHideForPlayer(playerid, DialogButtons[0]);
		TextDrawHideForPlayer(playerid, DialogButtons[1]);
		TextDrawHideForPlayer(playerid, DialogButtons[2]);
		PlayerTextDrawHide(playerid, DialogButtonText[playerid][2]);
		PlayerTextDrawHide(playerid, DialogContent[playerid][0]);
		PlayerTextDrawHide(playerid, DialogContent[playerid][1]);
		PlayerTextDrawHide(playerid, DialogContent[playerid][2]);
		PlayerTextDrawHide(playerid, DialogContent[playerid][3]);
		CancelSelectTextDraw(playerid);
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerClickPlayerTextDraw() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerClickPlayerTextDraw()", debug_String);

    #endif

	SendDebugMessage("OnPlayerClickPlayerTextDraw()", "OnPlayerClickPlayerTextDraw End");

	return 1;
}

public OnFirePutOut(fireid, playerid)
{
	SendDebugMessage("OnFirePutOut()", "OnFirePutOut Start");

	timing[0] = GetTickCount();

	if(!IsValidDynamicObject(FireInfo[fireid][object]))
		return 1;

	printf("destroyed object");

	PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);

	DestroyDynamicObject(FireInfo[fireid][object]);
	DestroyDynamicMapIcon(FireInfo[fireid][icon]);

	g_PlayerFires[playerid]++;

	GivePlayerMoney(playerid, 80);
	//new bool:half = false;
	if(IsMultipleOf(g_PlayerFires[playerid], 4))
	{
		SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
	}
	FireInfo[fireid][isout] = true;
	/*Rand = randomEx(100, 500);
	//new totalputout;
	for(new i = 0; i < MAX_FIRES; ++i) {

		if(FireInfo[fireid][centerid] == FireInfo[i][centerid] && fireid != i && FireCreated[i] == true) {
			printf("found fires in the same center");
			if(FireInfo[i][isout]) {
				printf("the fire is out");
				totalputout++;
				printf("Total = %d Saved total = %d", totalputout, FireInfo[fireid][total]);
				if(totalputout == (floatround(FireInfo[fireid][total]/2)) && !half) {
					format(G_String, 128, "[ALERT] :{FFFFFF} You've put out half of all the fires and earned yourself $%d", Rand/2);
					SendClientMessage(playerid, COLOR_GREEN, G_String);
					GivePlayerMoney(playerid, Rand/2);
					FireCreated[i] = false;
					half = true;
				} 
			}
		}
	}*/
	
	#if defined __DEBUG
   
    format(debug_String, 128, "OnFirePutOut() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnFirePutOut()", debug_String);

    #endif

	SendDebugMessage("OnFirePutOut()", "OnFirePutOut End");

	return 1;
}

public OnWeedBurnt(weedid, burner)
{
	SendDebugMessage("OnWeedBurnt()", "OnWeedBurnt Start");

	timing[0] = GetTickCount();

    if(gTeam[burner] == POLICE && !WeedInfo[weedid][Burnt]) {
        GivePlayerMoney(burner, 50);
        SetPlayerScore(burner, GetPlayerScore(burner)+1);
        SendClientMessage(burner, COLOR_GREEN, "You have destroyed illegal weed and earned yourself $50 and +1 score");
    }

    WeedInfo[weedid][Burnt] = true;
    WeedInfo[weedid][burnttime] = gettime();

	foreach(Player, j) {
		if(!strcmp(WeedInfo[weedid][Owner], PlayerName(j), false) && SeenWeedMessage[j] != true) {
			format(G_String, 128, "Attention! %s is burning your weed!", PlayerName(burner));
   			SendClientMessage(j, COLOR_RED2, G_String);
   			SeenWeedMessage[j] = true;
		}
		new totalBurnt;
		for(new i = 0; i < MAX_WEED; i++) {//loop through all weed
		    if(!strcmp(WeedInfo[i][Owner], PlayerName(j), false)) {//if the weed is owned by our player
				if(WeedInfo[i][Burnt] == true) {//if the weed is burnt
				    totalBurnt++;//count it up
				    if(totalBurnt == WeedPlanted[j]) {//if the count is equal to the ammount planted (allweed == burnt)
				        SeenWeedMessage[j] = false;
				        SendClientMessage(j, COLOR_RED2, "Attention! All your weed has been burnt!");
				    }
				}
		    }
		}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerStartSweeperJob() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerStartSweeperJob()", debug_String);

    #endif

	SendDebugMessage("OnWeedBurnt()", "OnWeedBurnt End");

	return 1;
}

public OnPlayerRecieveJobWage(playerid, jobid, wage)
{
	switch(jobid)
	{
		case SWAT:
		{
			if(PlayerInfo[playerid][Parrests] > 0) {
				wage = wage * PlayerInfo[playerid][Parrests] / 2;
				GivePlayerMoney(playerid, wage);
			} else {
				GivePlayerMoney(playerid,wage);

			}
		}
		case POLICE:
		{
			if(PlayerInfo[playerid][Parrests] > 0) {
				wage = wage * PlayerInfo[playerid][Parrests] / 2;
				GivePlayerMoney(playerid, wage);
			} else {
				GivePlayerMoney(playerid,wage);

			}
		}
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid,cmdtext[],success)
{
	if(!success) return format(G_String, 128, "[ERROR] :{FFFFFF} %s is not a valid command, use /commands for a list of commands", cmdtext), SendClientMessage(playerid, COLOR_RED2, G_String);
	return 1;
}

public OnPlayerCommitCrime(playerid, wantedlevel, crime[], extraid)
{
	SendDebugMessage("OnPlayerCommitCrime()", "OnPlayerCommitCrime Start");

	timing[0] = GetTickCount();

	if(0 < wantedlevel < 4) {
	    SetPlayerColor(playerid, COLOR_YELLOW);
	}
	if(4 <= wantedlevel < 6) {
	    SetPlayerColor(playerid, COLOR_ORANGE);
	}
	if(wantedlevel >= 6) {
		SetPlayerColor(playerid, COLOR_RED2);
	}

	foreach(Player, i) {

	    if(wantedlevel > WantedLevel[i]) {
	        SetPlayerColor(playerid, COLOR_FIRE);
	    }
	}

	SetPlayerWantedLevel(playerid, wantedlevel);
	SetPlayerTeam(playerid, NO_TEAM);

	if(extraid != -1) {

		if(strcmp(crime, "Murder", true) != 0) {
			format(G_String, 128, "[DISPATCH] {FFFFFF}Attention all units! %s has robbed %s, all units respond to %s! Over.", PlayerName(playerid), PlayerName(extraid), PlayerZone(playerid));
			SendMessageToLaw(COLOR_SKYBLUE, G_String);
			SendRadioToLaw(playerid, 16);
		} else {
			format(G_String, 128, "[DISPATCH] {FFFFFF}Attention all units! %s has murdered %s, proceed with extreme caution, suspect is armed and dangerous, 10-20 %s! Over.", PlayerName(playerid), PlayerName(extraid), PlayerZone(playerid));
			SendMessageToLaw(COLOR_SKYBLUE, G_String);
			SendRadioToLaw(playerid, 16);
		}
	} else if(!strcmp(crime, "Attempted Robbery", true) || !strcmp(crime, "Robbed a store", true)) {
		format(G_String, 128, "[DISPATCH] {FFFFFF}Attention all units! We have 10-31 in progress, all units respond to %s! Over.", PlayerZone(playerid));
		SendMessageToLaw(COLOR_SKYBLUE, G_String);
		SendRadioToLaw(playerid, 16);
	} else {
		format(G_String, 128, "[DISPATCH] {FFFFFF}Attention all units! A crime has been commited, all units respond to %s! Over.", PlayerZone(playerid));
		SendMessageToLaw(COLOR_SKYBLUE, G_String);
		SendRadioToLaw(playerid, 16);
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerStartSweeperJob() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerStartSweeperJob()", debug_String);

    #endif

	SendDebugMessage("OnPlayerCommitCrime()", "OnPlayerCommitCrime End");

	return 1;
}

public OnPlayerEnterPrison(playerid, time, oldwanted)
{
	SendDebugMessage("OnPlayerEnterPrison()", "OnPlayerEnterPrison Start");

	timing[0] = GetTickCount();

	format(G_String, 128, "You have been sent to jail for %d seconds. You managed to retain a wanted level of %d", time, oldwanted);
	SendClientMessage(playerid, COLOR_GREEN, G_String);
	WantedLevel[playerid] = 0;
	ResetPlayerWeapons(playerid);
	SetPlayerCuffed(playerid, 0);
	SetPlayerColor(playerid, -1);

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerEnterPrison() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerEnterPrison()", debug_String);

    #endif

	SendDebugMessage("OnPlayerEnterPrison()", "OnPlayerEnterPrison End");

	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	SendDebugMessage("OnPlayerInteriorChange()", "OnPlayerInteriorChange Start");

	timing[0] = GetTickCount();

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	new id = GetInteriorID(pos[0], pos[1], pos[2]);
	if(PlayerRobberyID[playerid] == -1) {
		PlayerRobberyID[playerid] = id;
	} else {
	    PlayerRobberyID[playerid] = -1;
	}

	if(PlayerVariables[playerid] & IN_HOTEL) {
		printf("in hoten and interior change");
		switch(GetPlayerVirtualWorld(playerid))
		{
			case 1:
			{
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][0], COLOR_WHITE, "Hotel room #1");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][1], COLOR_WHITE, "Hotel room #2");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][2], COLOR_WHITE, "Hotel room #3");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][3], COLOR_WHITE, "Hotel room #4");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][4], COLOR_WHITE, "Hotel room #5");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][5], COLOR_WHITE, "Hotel room #6");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][6], COLOR_WHITE, "Hotel room #7");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][7], COLOR_WHITE, "Hotel room #8");
			}
			case 2:
			{
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][0], COLOR_WHITE, "Hotel room #9");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][1], COLOR_WHITE, "Hotel room #10");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][2], COLOR_WHITE, "Hotel room #11");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][3], COLOR_WHITE, "Hotel room #12");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][4], COLOR_WHITE, "Hotel room #13");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][5], COLOR_WHITE, "Hotel room #14");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][6], COLOR_WHITE, "Hotel room #15");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][7], COLOR_WHITE, "Hotel room #16");
			}
			case 3:
			{
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][0], COLOR_WHITE, "Hotel room #17");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][1], COLOR_WHITE, "Hotel room #18");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][2], COLOR_WHITE, "Hotel room #19");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][3], COLOR_WHITE, "Hotel room #20");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][4], COLOR_WHITE, "Hotel room #21");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][5], COLOR_WHITE, "Hotel room #22");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][6], COLOR_WHITE, "Hotel room #23");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][7], COLOR_WHITE, "Hotel room #24");
			}
			case 4:
			{
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][0], COLOR_WHITE, "Hotel room #25");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][1], COLOR_WHITE, "Hotel room #26");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][2], COLOR_WHITE, "Hotel room #27");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][3], COLOR_WHITE, "Hotel room #28");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][4], COLOR_WHITE, "Hotel room #29");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][5], COLOR_WHITE, "Hotel room #30");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][6], COLOR_WHITE, "Hotel room #31");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][7], COLOR_WHITE, "Hotel room #32");
			}
			case 5:
			{
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][0], COLOR_WHITE, "Hotel room #33");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][1], COLOR_WHITE, "Hotel room #34");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][2], COLOR_WHITE, "Hotel room #35");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][3], COLOR_WHITE, "Hotel room #36");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][4], COLOR_WHITE, "Hotel room #37");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][5], COLOR_WHITE, "Hotel room #38");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][6], COLOR_WHITE, "Hotel room #39");
				UpdateDynamic3DTextLabelText(HotelRooms[playerid][7], COLOR_WHITE, "Hotel room #38");
			}
		}
	}

	if(IsPlayerInBusiness(playerid) == false)
		for(new i = 0; i < 100; i++) RestoreBuilding(i);

	/*if(IsPlayerInBusiness(playerid) == true) {

		if(!strcmp(BizInteriors[0][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(2358, 298.3359, -41.5469, 1001.6406, 0.25);
			RemoveBuilding(2358, 297.5234, -41.5938, 1001.6406, 0.25);
			RemoveBuilding(2358, 284.2344, -39.0547, 1002.7344, 0.25);
			RemoveBuilding(2047, 283.9375, -38.6172, 1003.7109, 0.25);
			RemoveBuilding(2358, 284.2578, -37.6016, 1003.2266, 0.25);
			RemoveBuilding(2358, 284.2578, -37.5938, 1002.7344, 0.25);
			RemoveBuilding(2358, 284.2656, -37.5469, 1002.9844, 0.25);
			RemoveBuilding(18035, 292.2344, -35.9531, 1002.2344, 0.25);
			RemoveBuilding(2048, 283.9375, -35.1484, 1003.7656, 0.25);
			RemoveBuilding(2358, 284.2578, -34.8438, 1002.7344, 0.25);
			RemoveBuilding(18034, 294.9609, -29.8906, 1003.3438, 0.25);

		} else if(!strcmp(BizInteriors[1][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(18041, 296.9297, -84.8984, 1002.3672, 0.25);
			RemoveBuilding(2068, 288.1797, -81.5781, 1004.4219, 0.25);
			RemoveBuilding(1885, 291.7422, -81.6953, 1000.5078, 0.25);
			RemoveBuilding(1886, 291.6563, -75.7656, 1004.9844, 0.25);
			RemoveBuilding(2619, 293.3984, -76.3516, 1003.0469, 0.25);
			RemoveBuilding(1886, 302.8359, -76.9766, 1004.9844, 0.25);
			RemoveBuilding(2047, 283.7188, -73.9531, 1003.3281, 0.25);
			RemoveBuilding(2048, 283.7188, -70.6953, 1003.5547, 0.25);
			RemoveBuilding(2358, 284.1328, -68.2266, 1003.0391, 0.25);
			RemoveBuilding(18104, 289.7656, -71.2969, 1001.6172, 0.25);
			RemoveBuilding(18043, 293.5234, -71.5547, 1003.1406, 0.25);
			RemoveBuilding(2358, 284.1328, -67.1719, 1003.0391, 0.25);
			RemoveBuilding(2358, 284.1328, -66.3281, 1003.0391, 0.25);
			RemoveBuilding(2358, 284.1328, -66.8281, 1003.2969, 0.25);
			RemoveBuilding(2060, 291.7969, -65.9297, 1000.6797, 0.25);
			RemoveBuilding(2060, 291.8203, -65.3203, 1000.9141, 0.25);
			RemoveBuilding(2358, 284.1328, -65.2813, 1003.0391, 0.25);
			RemoveBuilding(2060, 291.7500, -64.7266, 1000.6797, 0.25);
			RemoveBuilding(2060, 291.8438, -64.7266, 1001.1328, 0.25);
			RemoveBuilding(2068, 288.1797, -64.7266, 1004.4219, 0.25);
			RemoveBuilding(2060, 291.7969, -62.3203, 1000.6797, 0.25);
			RemoveBuilding(2060, 291.7969, -63.5234, 1000.6797, 0.25);
			RemoveBuilding(2060, 291.8203, -64.1172, 1000.9141, 0.25);
			RemoveBuilding(2060, 291.8203, -62.9141, 1000.9141, 0.25);
			RemoveBuilding(2060, 291.8203, -63.5234, 1001.1328, 0.25);
			RemoveBuilding(1886, 284.1250, -57.0547, 1004.9844, 0.25);
			RemoveBuilding(2358, 284.1328, -60.7031, 1003.0391, 0.25);
			RemoveBuilding(1886, 291.3047, -57.0547, 1004.9844, 0.25);
			RemoveBuilding(2048, 289.5938, -56.3359, 1003.5625, 0.25);

		} else if(!strcmp(BizInteriors[2][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(2125, 290.0156, -112.2500, 1000.8359, 0.25);
			RemoveBuilding(18044, 287.8672, -109.9922, 1002.2344, 0.25);
			RemoveBuilding(1885, 293.9688, -110.7969, 1000.5078, 0.25);
			RemoveBuilding(18048, 290.2266, -105.3203, 1000.9922, 0.25);
			RemoveBuilding(1885, 298.1797, -106.4688, 1000.5078, 0.25);

		} else if(!strcmp(BizInteriors[3][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(1886, 303.0781, -144.1016, 1002.5859, 0.25);
			RemoveBuilding(1886, 303.0781, -126.2578, 1002.5859, 0.25);
			RemoveBuilding(18052, 309.2109, -137.4766, 1000.3203, 0.25);
			RemoveBuilding(18109, 311.0703, -137.4453, 1005.0078, 0.25);
			RemoveBuilding(18053, 311.3750, -137.4219, 1004.8047, 0.25);
			RemoveBuilding(18054, 311.3750, -134.7578, 1003.2188, 0.25);
			RemoveBuilding(1977, 316.8750, -140.3516, 998.5859, 0.25);
			RemoveBuilding(1886, 317.0078, -143.4766, 1006.8906, 0.25);
			RemoveBuilding(2619, 317.3750, -137.1250, 1005.6953, 0.25);
			RemoveBuilding(1886, 316.9609, -130.7188, 1002.5859, 0.25);

		} else if(!strcmp(BizInteriors[4][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(2619, 307.8672, -170.2188, 1000.1875, 0.25);
			RemoveBuilding(2038, 310.0313, -166.8359, 999.7266, 0.25);
			RemoveBuilding(2038, 310.0313, -166.7031, 999.7266, 0.25);
			RemoveBuilding(2038, 310.3516, -166.8359, 999.7266, 0.25);
			RemoveBuilding(2038, 310.3516, -166.7031, 999.7266, 0.25);
			RemoveBuilding(2038, 310.0313, -166.5703, 999.7266, 0.25);
			RemoveBuilding(2038, 310.3516, -166.5703, 999.7266, 0.25);
			RemoveBuilding(2038, 310.0313, -166.4141, 999.7266, 0.25);
			RemoveBuilding(2038, 310.3516, -166.4141, 999.7266, 0.25);
			RemoveBuilding(1885, 310.1250, -166.2109, 998.5547, 0.25);
			RemoveBuilding(18063, 309.2891, -164.3281, 1000.7266, 0.25);
			RemoveBuilding(2061, 310.6016, -162.6641, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.6016, -162.5000, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.6016, -162.3281, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.6016, -162.1328, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.9297, -162.6641, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.9297, -162.5000, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.9297, -162.3281, 1000.8203, 0.25);
			RemoveBuilding(2061, 310.9297, -162.1328, 1000.8203, 0.25);
			RemoveBuilding(1885, 315.2422, -169.8984, 998.5547, 0.25);
			RemoveBuilding(2039, 313.3594, -166.8047, 999.6953, 0.25);
			RemoveBuilding(2039, 313.3594, -166.6875, 999.6953, 0.25);
			RemoveBuilding(2043, 314.3750, -166.4688, 999.7734, 0.25);
			RemoveBuilding(2043, 314.1406, -166.4688, 999.7734, 0.25);
			RemoveBuilding(2043, 313.8828, -166.4688, 999.7734, 0.25);
			RemoveBuilding(2039, 313.3594, -166.5703, 999.6953, 0.25);
			RemoveBuilding(18062, 314.8906, -164.2188, 1000.3203, 0.25);
			RemoveBuilding(18105, 312.9844, -163.2500, 1000.5547, 0.25);
			RemoveBuilding(2068, 312.6484, -162.2969, 1002.5469, 0.25);
			RemoveBuilding(2358, 315.0938, -162.5781, 1000.6563, 0.25);
			RemoveBuilding(2359, 315.1016, -162.0391, 1000.7344, 0.25);

		} else if(!strcmp(BizInteriors[5][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(14507, 2207.7500, -1196.3438, 1030.5313, 0.25);
			RemoveBuilding(2675, 2211.1719, -1194.6563, 1028.8672, 0.25);
			RemoveBuilding(14519, 2240.7891, -1194.6797, 1030.1484, 0.25);
			RemoveBuilding(14516, 2192.1641, -1191.8359, 1030.1406, 0.25);
			RemoveBuilding(14511, 2219.7031, -1189.8438, 1029.2969, 0.25);
			RemoveBuilding(14497, 2244.8203, -1189.5469, 1029.2969, 0.25);
			RemoveBuilding(2672, 2186.0859, -1185.5469, 1029.0859, 0.25);
			RemoveBuilding(14524, 2192.1250, -1187.3438, 1029.2969, 0.25);
			RemoveBuilding(2677, 2200.3438, -1176.7500, 1029.0781, 0.25);
			RemoveBuilding(2671, 2225.3594, -1179.2422, 1028.8047, 0.25);
			RemoveBuilding(14505, 2227.4609, -1180.9531, 1030.5313, 0.25);
			RemoveBuilding(14503, 2200.8750, -1174.9141, 1030.5313, 0.25);
			RemoveBuilding(14504, 2185.5000, -1155.1719, 1030.5313, 0.25);
			RemoveBuilding(2670, 2198.6563, -1160.1250, 1028.8906, 0.25);
			RemoveBuilding(2676, 2198.8359, -1156.5313, 1028.9375, 0.25);
			RemoveBuilding(14502, 2200.8750, -1158.8906, 1030.5313, 0.25);
			RemoveBuilding(14518, 2195.8672, -1143.0156, 1030.1484, 0.25);
			RemoveBuilding(14517, 2221.8750, -1148.0938, 1026.1484, 0.25);
			RemoveBuilding(1775, 2225.2031, -1153.4219, 1025.9063, 0.25);
			RemoveBuilding(14508, 2233.5078, -1168.8672, 1030.5313, 0.25);
			RemoveBuilding(14509, 2233.5078, -1157.9375, 1030.5313, 0.25);
			RemoveBuilding(14520, 2233.9453, -1163.2500, 1029.1328, 0.25);
			RemoveBuilding(14521, 2247.1641, -1162.1094, 1029.0156, 0.25);
			RemoveBuilding(14510, 2248.9453, -1161.6328, 1030.5313, 0.25);

		} else if(!strcmp(BizInteriors[6][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(14800, 819.8047, 11.7578, 1003.8906, 0.25);
			RemoveBuilding(2771, 820.9375, 2.3672, 1004.3984, 0.25);
			RemoveBuilding(2754, 830.6563, -1.0781, 1004.0703, 0.25);
			RemoveBuilding(2754, 834.3984, 3.2266, 1004.0703, 0.25);
			RemoveBuilding(2110, 822.1953, 8.5313, 1003.1719, 0.25);
			RemoveBuilding(2075, 822.1563, 9.9453, 1007.0000, 0.25);
			RemoveBuilding(1810, 822.5703, 9.0547, 1003.1875, 0.25);
			RemoveBuilding(1778, 823.9453, 9.0859, 1003.1875, 0.25);
			RemoveBuilding(1744, 822.3672, 12.1172, 1004.1250, 0.25);
			RemoveBuilding(1744, 822.3672, 12.1172, 1004.9141, 0.25);

		} else if(!strcmp(BizInteriors[7][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding( 2578, -108.5391, -21.6719, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2579, -108.5313, -20.5938, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2585, -108.5313, -19.4688, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2579, -108.5313, -17.2266, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2585, -108.5313, -16.1016, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2578, -108.5391, -18.3047, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2578, -108.5391, -14.9766, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2579, -108.5313, -13.8984, 1000.7813, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2581, -108.4922, -24.0938, 1000.8438, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2582, -104.9297, -18.2891, 1000.5938, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2582, -101.3125, -18.2891, 1000.5938, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2582, -101.3125, -16.7578, 1000.5938, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2582, -104.9297, -16.7578, 1000.5938, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2582, -101.3125, -15.2422, 1000.5938, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2582, -104.9297, -15.2422, 1000.5938, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2596, -104.9688, -16.0000, 1002.5156, 0.25, 0.0, 0.0, 90.0);
			RemoveBuilding( 2596, -101.3516, -16.0078, 1002.5156, 0.25, 0.0, 0.0, 90.0);

			RemoveBuilding( 2583, -106.3828, -18.2813, 1000.5938, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2583, -102.7344, -18.2813, 1000.5938, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2583, -102.7344, -16.7500, 1000.5938, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2583, -106.3828, -16.7500, 1000.5938, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2583, -102.7344, -15.2344, 1000.5938, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2583, -106.3828, -15.2344, 1000.5938, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2578, -98.9922, -20.8281, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2579, -99.0000, -21.9063, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2585, -99.0156, -19.7031, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2579, -99.0000, -18.5781, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2578, -98.9922, -17.5000, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2585, -99.0156, -16.3359, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2579, -99.0000, -15.2109, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2578, -98.9922, -14.1328, 1000.7813, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2596, -102.7031, -15.9531, 1002.5156, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2596, -106.3047, -15.9531, 1002.5156, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2587, -98.9609, -14.8359, 1002.5156, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2588, -98.9531, -21.0781, 1002.5156, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2580, -98.9766, -16.7422, 1002.5078, 0.25, 0.0, 0.0, -90);
			RemoveBuilding( 2681, -99.3281, -13.1250, 999.7422, 0.25, 0.0, 0.0, -90);


			RemoveBuilding( 2577, -102.3203, -24.1328, 1000.4297, 0.25);
			RemoveBuilding( 2362, -104.7344, -23.8516, 1000.7344, 0.25);
			RemoveBuilding( 2365, -105.2031, -23.2266, 999.7031, 0.25);
			RemoveBuilding( 2412, -98.7422, -24.6875, 999.7188, 0.25);
			RemoveBuilding( 2412, -101.1875, -24.6875, 999.7188, 0.25);
			RemoveBuilding( 2584, -105.6016, -23.4375, 1000.5703, 0.25);
			RemoveBuilding( 2581, -107.6094, -7.4922, 1000.8750, 0.25);
			RemoveBuilding( 2581, -102.9375, -7.4922, 1000.8750, 0.25);
			RemoveBuilding( 2362, -108.1641, -9.6719, 1000.8125, 0.25);
			RemoveBuilding( 2369, -104.5703, -9.4922, 1000.8125, 0.25);
			RemoveBuilding( 2584, -99.4141, -10.7969, 1000.5703, 0.25);
			RemoveBuilding( 14666, -101.9688, -8.8984, 1002.0078, 0.25);
			RemoveBuilding( 2596, -107.6641, -7.5859, 1002.5156, 0.25);
			RemoveBuilding( 2596, -106.4922, -7.5859, 1002.5156, 0.25);
			RemoveBuilding( 2595, -108.1563, -9.6172, 1001.1719, 0.25);
			RemoveBuilding( 2595, -102.2813, -24.6875, 1001.4922, 0.25);
			RemoveBuilding( 2599, -101.3984, -10.8047, 1000.1719, 0.25);
			RemoveBuilding( 2599, -108.0078, -22.6797, 1000.1719, 0.25);
			RemoveBuilding( 2580, -105.1406, -7.4453, 1002.3203, 0.25);
			RemoveBuilding( 14673, -102.7031, -7.5078, 1002.0547, 0.25);
			RemoveBuilding( 2586, -103.9219, -23.4219, 1000.2344, 0.25);
			RemoveBuilding( 2670, -102.1719, -22.6406, 999.8516, 0.25);
			RemoveBuilding( 2673, -107.8438, -23.0781, 999.8516, 0.25);
			RemoveBuilding( 2674, -113.9453, -10.9453, 999.7734, 0.25);
			RemoveBuilding( 2674, -100.8750, -18.0313, 999.7734, 0.25);
			RemoveBuilding( 2674, -107.6563, -8.9844, 999.7734, 0.25);
			RemoveBuilding( 2673, -103.8203, -24.2266, 999.8516, 0.25);
			RemoveBuilding( 2670, -115.7891, -12.5391, 999.8516, 0.25);
			RemoveBuilding( 2670, -104.3828, -16.1016, 999.8516, 0.25);
			RemoveBuilding( 2670, -108.5000, -14.7734, 999.8516, 0.25);
			RemoveBuilding( 2670, -99.5938, -11.3672, 999.8516, 0.25);


		} else if(!strcmp(BizInteriors[8][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(1722, 961.4453, 2097.3594, 1010.0078, 0.25);
			RemoveBuilding(2008, 960.4609, 2098.1094, 1009.9844, 0.25);
			RemoveBuilding(1722, 963.1094, 2099.2813, 1010.0078, 0.25);
			RemoveBuilding(1722, 963.1094, 2100.2891, 1010.0078, 0.25);
			RemoveBuilding(14613, 942.1406, 2142.2578, 1012.5000, 0.25);
			RemoveBuilding(14585, 939.5938, 2144.1406, 1016.1797, 0.25);
			RemoveBuilding(14584, 942.3203, 2145.5156, 1011.8203, 0.25);
			RemoveBuilding(14589, 945.6094, 2139.4766, 1013.2266, 0.25);
			RemoveBuilding(14586, 946.1953, 2141.1875, 1016.4453, 0.25);
			RemoveBuilding(14587, 948.7969, 2146.4688, 1015.4453, 0.25);
			RemoveBuilding(14612, 961.1719, 2166.5781, 1012.7344, 0.25);

		} else if(!strcmp(BizInteriors[9][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(2412, -2240.5859, 127.1328, 1034.4063, 0.25);
			RemoveBuilding(2489, -2237.6328, 127.5547, 1035.6875, 0.25);
			RemoveBuilding(2481, -2237.6328, 127.5781, 1036.7969, 0.25);
			RemoveBuilding(2490, -2237.6406, 127.5547, 1036.3984, 0.25);
			RemoveBuilding(2495, -2237.6406, 127.5547, 1036.0391, 0.25);
			RemoveBuilding(2488, -2237.6328, 127.5547, 1035.3281, 0.25);
			RemoveBuilding(2483, -2236.5078, 127.5625, 1036.6094, 0.25);
			RemoveBuilding(2504, -2235.0859, 127.6406, 1035.8516, 0.25);
			RemoveBuilding(2503, -2235.5703, 127.6406, 1035.8516, 0.25);
			RemoveBuilding(2501, -2234.6328, 127.6406, 1035.8516, 0.25);
			RemoveBuilding(2513, -2236.5313, 127.6641, 1035.5703, 0.25);
			RemoveBuilding(2490, -2229.7188, 127.5547, 1036.5391, 0.25);
			RemoveBuilding(2495, -2229.0938, 127.5547, 1036.5313, 0.25);
			RemoveBuilding(2412, -2240.5859, 128.8516, 1034.4063, 0.25);
			RemoveBuilding(2190, -2239.2266, 127.8203, 1035.4844, 0.25);
			RemoveBuilding(2477, -2223.5703, 128.2422, 1036.4922, 0.25);
			RemoveBuilding(928, -2225.1406, 128.2969, 1034.6719, 0.25);
			RemoveBuilding(926, -2224.2500, 128.4141, 1034.6563, 0.25);
			RemoveBuilding(14558, -2223.3438, 128.4219, 1035.2031, 0.25);
			RemoveBuilding(2484, -2240.8125, 131.0781, 1036.3047, 0.25);
			RemoveBuilding(2362, -2238.3281, 129.2656, 1035.4453, 0.25);
			RemoveBuilding(1514, -2238.0781, 129.2266, 1035.6875, 0.25);
			RemoveBuilding(1885, -2238.1172, 130.0781, 1034.3984, 0.25);
			RemoveBuilding(1893, -2236.7656, 130.2656, 1038.3125, 0.25);
			RemoveBuilding(2497, -2237.2266, 131.1328, 1037.6875, 0.25);
			RemoveBuilding(2510, -2233.6406, 129.2344, 1037.8906, 0.25);
			RemoveBuilding(2494, -2233.6094, 129.5234, 1035.4063, 0.25);
			RemoveBuilding(2492, -2233.1016, 129.5234, 1035.4063, 0.25);
			RemoveBuilding(2496, -2233.3516, 129.7734, 1035.4063, 0.25);
			RemoveBuilding(2484, -2233.9922, 132.1016, 1036.8281, 0.25);
			RemoveBuilding(2487, -2226.1641, 129.7500, 1037.5469, 0.25);
			RemoveBuilding(1893, -2228.6016, 130.2656, 1038.3125, 0.25);
			RemoveBuilding(2499, -2231.4766, 130.3203, 1037.6953, 0.25);
			RemoveBuilding(2470, -2227.4141, 130.6875, 1036.0391, 0.25);
			RemoveBuilding(2469, -2228.4688, 130.7188, 1036.0391, 0.25);
			RemoveBuilding(2503, -2223.5391, 131.0703, 1035.8438, 0.25);
			RemoveBuilding(2501, -2223.5391, 131.6406, 1035.8438, 0.25);
			RemoveBuilding(2412, -2240.5859, 136.1094, 1034.4063, 0.25);
			RemoveBuilding(1885, -2240.1719, 136.2031, 1034.3984, 0.25);
			RemoveBuilding(2412, -2240.5859, 137.6719, 1034.4063, 0.25);
			RemoveBuilding(2469, -2237.9063, 133.1953, 1036.0391, 0.25);
			RemoveBuilding(2470, -2237.8750, 134.2500, 1036.0391, 0.25);
			RemoveBuilding(1893, -2236.7656, 135.2344, 1038.3125, 0.25);
			RemoveBuilding(2487, -2238.1719, 135.7969, 1037.5469, 0.25);
			RemoveBuilding(2504, -2236.8516, 137.8906, 1035.8516, 0.25);
			RemoveBuilding(2501, -2237.3047, 137.8906, 1035.8516, 0.25);
			RemoveBuilding(2498, -2231.9453, 132.8125, 1037.5703, 0.25);
			RemoveBuilding(2512, -2235.9922, 133.4375, 1037.8438, 0.25);
			RemoveBuilding(2464, -2233.9844, 135.1641, 1036.1953, 0.25);
			RemoveBuilding(2498, -2232.3281, 136.2422, 1037.5703, 0.25);
			RemoveBuilding(2503, -2236.3672, 137.8906, 1035.8516, 0.25);
			RemoveBuilding(2466, -2235.2969, 137.9609, 1036.5547, 0.25);
			RemoveBuilding(2511, -2229.2734, 132.2813, 1037.8594, 0.25);
			RemoveBuilding(2503, -2223.5391, 132.4375, 1035.8438, 0.25);
			RemoveBuilding(2190, -2218.7031, 132.7031, 1035.5000, 0.25);
			RemoveBuilding(2501, -2223.5391, 133.0078, 1035.8438, 0.25);
			RemoveBuilding(1885, -2220.2656, 133.1719, 1034.6406, 0.25);
			RemoveBuilding(14556, -2221.6016, 133.6406, 1036.1563, 0.25);
			RemoveBuilding(2484, -2228.0938, 133.7734, 1036.8281, 0.25);
			RemoveBuilding(2512, -2226.4922, 134.0156, 1037.8438, 0.25);
			RemoveBuilding(1893, -2228.6016, 135.2344, 1038.3125, 0.25);
			RemoveBuilding(2499, -2230.1563, 135.2578, 1037.6953, 0.25);
			RemoveBuilding(2103, -2218.4063, 135.3047, 1037.0547, 0.25);
			RemoveBuilding(2063, -2218.5859, 135.9844, 1035.5234, 0.25);
			RemoveBuilding(1749, -2218.3906, 136.6250, 1036.3047, 0.25);
			RemoveBuilding(2202, -2221.3984, 136.8047, 1034.6250, 0.25);
			RemoveBuilding(2478, -2226.3750, 136.9922, 1034.8281, 0.25);
			RemoveBuilding(2465, -2227.9219, 137.0234, 1036.8594, 0.25);
			RemoveBuilding(2480, -2226.3672, 137.0781, 1036.4922, 0.25);

		} else if(!strcmp(BizInteriors[10][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(1823, 482.0625, -25.0938, 1002.0781, 0.25);
			RemoveBuilding(1544, 482.3906, -24.8672, 1002.5625, 0.25);
			RemoveBuilding(1754, 482.0469, -23.2891, 1002.0938, 0.25);
			RemoveBuilding(1544, 482.8906, -24.5547, 1002.5625, 0.25);
			RemoveBuilding(2290, 483.5156, -26.3516, 1002.0859, 0.25);
			RemoveBuilding(1754, 484.1250, -24.6172, 1002.0938, 0.25);
			RemoveBuilding(2596, 482.4453, -20.5938, 1002.2969, 0.25);
			RemoveBuilding(2125, 482.2656, -20.5078, 1000.0000, 0.25);
			RemoveBuilding(2125, 484.8359, -20.5000, 1000.0000, 0.25);
			RemoveBuilding(2670, 479.5078, -20.3828, 999.7813, 0.25);
			RemoveBuilding(1754, 485.4531, -24.7031, 1002.0938, 0.25);
			RemoveBuilding(1823, 486.3906, -25.2891, 1002.0781, 0.25);
			RemoveBuilding(1544, 486.6797, -24.6406, 1002.5625, 0.25);
			RemoveBuilding(1544, 486.8125, -24.7500, 1002.5625, 0.25);
			RemoveBuilding(2596, 485.7422, -20.5938, 1002.2969, 0.25);
			RemoveBuilding(2125, 486.0859, -20.5625, 1000.0000, 0.25);
			RemoveBuilding(2290, 487.8203, -26.3516, 1002.0859, 0.25);
			RemoveBuilding(1544, 487.2031, -24.5859, 1002.5625, 0.25);
			RemoveBuilding(1544, 487.1797, -25.1094, 1002.5625, 0.25);
			RemoveBuilding(1517, 487.2266, -20.5391, 1000.3438, 0.25);
			RemoveBuilding(1754, 488.4219, -25.1719, 1002.0938, 0.25);
			RemoveBuilding(1754, 488.0313, -23.3906, 1002.0938, 0.25);
			RemoveBuilding(2125, 488.2266, -20.5000, 1000.0000, 0.25);
			RemoveBuilding(2670, 490.6328, -24.3906, 999.7813, 0.25);
			RemoveBuilding(1775, 495.9688, -24.3203, 1000.7344, 0.25);
			RemoveBuilding(2350, 499.8359, -23.3359, 1000.0391, 0.25);
			RemoveBuilding(2350, 499.8594, -21.6328, 1000.0391, 0.25);
			RemoveBuilding(2596, 502.8281, -22.1094, 1002.2969, 0.25);
			RemoveBuilding(2670, 478.2188, -19.4141, 999.7813, 0.25);
			RemoveBuilding(2125, 482.6094, -19.5156, 1000.0000, 0.25);
			RemoveBuilding(1520, 483.3359, -20.1094, 1000.2031, 0.25);
			RemoveBuilding(1520, 483.6797, -20.1016, 1000.2031, 0.25);
			RemoveBuilding(2125, 484.2266, -19.5547, 1000.0000, 0.25);
			RemoveBuilding(1823, 484.1094, -19.9141, 999.6563, 0.25);
			RemoveBuilding(2125, 486.0938, -19.5938, 1000.0000, 0.25);
			RemoveBuilding(1520, 487.3359, -20.1484, 1000.2031, 0.25);
			RemoveBuilding(2125, 488.3281, -19.6094, 1000.0000, 0.25);
			RemoveBuilding(1823, 487.6250, -19.9141, 999.6563, 0.25);
			RemoveBuilding(18089, 488.3828, -13.4063, 1000.7813, 0.25);
			RemoveBuilding(1823, 493.3750, -18.1250, 999.6563, 0.25);
			RemoveBuilding(2125, 493.3516, -18.6641, 1000.0000, 0.25);
			RemoveBuilding(2125, 494.3906, -18.6563, 1000.0000, 0.25);
			RemoveBuilding(1517, 494.1797, -17.6016, 1000.3438, 0.25);
			RemoveBuilding(2125, 494.3281, -16.5234, 1000.0000, 0.25);
			RemoveBuilding(2125, 493.5391, -16.4219, 1000.0000, 0.25);
			RemoveBuilding(1823, 495.9844, -17.4844, 999.6563, 0.25);
			RemoveBuilding(2125, 495.9922, -16.0000, 1000.0000, 0.25);
			RemoveBuilding(2125, 495.9219, -18.1719, 1000.0000, 0.25);
			RemoveBuilding(2125, 496.0156, -14.9688, 1000.0000, 0.25);
			RemoveBuilding(1823, 495.6484, -14.5703, 999.6563, 0.25);
			RemoveBuilding(2125, 495.7891, -13.1797, 1000.0000, 0.25);
			RemoveBuilding(1520, 496.1484, -13.8672, 1000.2031, 0.25);
			RemoveBuilding(1517, 496.7656, -16.8359, 1000.3438, 0.25);
			RemoveBuilding(1517, 496.4297, -16.7734, 1000.3438, 0.25);
			RemoveBuilding(2125, 496.9375, -15.8828, 1000.0000, 0.25);
			RemoveBuilding(2125, 497.0859, -17.9922, 1000.0000, 0.25);
			RemoveBuilding(2125, 497.2813, -13.7422, 1000.0000, 0.25);
			RemoveBuilding(2350, 499.8359, -19.6875, 1000.0391, 0.25);
			RemoveBuilding(2350, 499.8594, -17.9844, 1000.0391, 0.25);
			RemoveBuilding(2350, 499.8516, -16.1484, 1000.0391, 0.25);
			RemoveBuilding(2596, 502.8281, -18.4375, 1002.2969, 0.25);
			RemoveBuilding(2670, 478.1953, -7.1719, 999.7813, 0.25);
			RemoveBuilding(2670, 478.6016, -7.6953, 999.7813, 0.25);
			RemoveBuilding(1436, 479.5938, -8.9922, 1001.2188, 0.25);
			RemoveBuilding(2232, 478.3359, -5.5859, 1001.6797, 0.25);
			RemoveBuilding(2670, 479.2891, -5.4063, 1001.1797, 0.25);
			RemoveBuilding(2670, 479.8203, -5.8125, 1001.1797, 0.25);
			RemoveBuilding(2232, 480.7969, -5.1016, 1001.6797, 0.25);
			RemoveBuilding(1544, 480.8594, -5.0156, 1002.2656, 0.25);
			RemoveBuilding(1436, 479.5938, -4.2969, 1002.6328, 0.25);
			RemoveBuilding(2232, 482.5781, -3.2188, 1001.6797, 0.25);
			RemoveBuilding(2125, 493.2266, -12.3906, 1000.0000, 0.25);
			RemoveBuilding(2125, 494.3672, -12.3984, 1000.0000, 0.25);
			RemoveBuilding(1823, 493.3750, -11.9688, 999.6563, 0.25);
			RemoveBuilding(2125, 494.3281, -10.3672, 1000.0000, 0.25);
			RemoveBuilding(2125, 493.2266, -10.2656, 1000.0000, 0.25);
			RemoveBuilding(2125, 495.9531, -9.3828, 1000.0000, 0.25);
			RemoveBuilding(2125, 495.9531, -11.5078, 1000.0000, 0.25);
			RemoveBuilding(1823, 496.1016, -11.0859, 999.6563, 0.25);
			RemoveBuilding(2125, 497.1172, -11.6172, 1000.0000, 0.25);
			RemoveBuilding(2125, 497.0547, -9.4844, 1000.0000, 0.25);
			RemoveBuilding(1517, 496.8906, -10.4063, 1000.3438, 0.25);
			RemoveBuilding(2670, 501.4141, -7.5547, 999.7813, 0.25);
			RemoveBuilding(2779, 501.4688, -10.3672, 999.6797, 0.25);
			RemoveBuilding(2778, 502.4063, -7.5313, 999.6797, 0.25);
			RemoveBuilding(2681, 503.6484, -7.5156, 999.6797, 0.25);
			RemoveBuilding(2232, 495.0391, -5.4063, 1001.6797, 0.25);
			RemoveBuilding(1544, 495.0078, -5.4453, 1002.2656, 0.25);
			RemoveBuilding(1544, 495.2031, -5.3828, 1002.2656, 0.25);
			RemoveBuilding(2670, 497.1563, -7.1094, 999.7813, 0.25);
			RemoveBuilding(2232, 496.3750, -5.6953, 1001.6797, 0.25);
			RemoveBuilding(2670, 505.6797, -7.0156, 999.7813, 0.25);
			RemoveBuilding(2232, 494.0625, -2.5156, 1001.6797, 0.25);
			RemoveBuilding(2670, 502.1641, -1.8906, 999.7813, 0.25);
			RemoveBuilding(2670, 499.8438, -1.6172, 999.7813, 0.25);
			RemoveBuilding(2670, 505.8125, -1.5625, 999.7813, 0.25);
			RemoveBuilding(1776, 500.5625, -1.3672, 1000.7344, 0.25);
			RemoveBuilding(1775, 501.8281, -1.4297, 1000.7344, 0.25);

		} else if(!strcmp(BizInteriors[11][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(1544, 505.7188, -69.5781, 998.6250, 0.25);
			RemoveBuilding(2112, 506.1875, -69.7734, 998.1953, 0.25);
			RemoveBuilding(1543, 506.5469, -69.3906, 998.6250, 0.25);
			RemoveBuilding(1805, 507.1641, -69.0938, 998.0078, 0.25);
			RemoveBuilding(1805, 509.1875, -69.7266, 998.0078, 0.25);
			RemoveBuilding(2112, 509.9531, -69.7734, 998.1953, 0.25);
			RemoveBuilding(1543, 510.0703, -69.3828, 998.6250, 0.25);
			RemoveBuilding(1544, 510.3438, -69.5703, 998.6250, 0.25);
			RemoveBuilding(2964, 489.7500, -80.2109, 997.7344, 0.25);
			RemoveBuilding(18091, 491.8750, -81.8438, 995.8438, 0.25);
			RemoveBuilding(2350, 492.0547, -81.1563, 998.1328, 0.25);
			RemoveBuilding(2350, 492.0547, -78.9531, 998.1328, 0.25);
			RemoveBuilding(2778, 504.8203, -79.9297, 997.9609, 0.25);
			RemoveBuilding(2681, 504.8359, -81.1719, 997.9609, 0.25);
			RemoveBuilding(2670, 505.2344, -78.8281, 998.0703, 0.25);
			RemoveBuilding(2670, 505.4922, -81.2969, 998.0703, 0.25);
			RemoveBuilding(2670, 506.1484, -87.9688, 998.0703, 0.25);
			RemoveBuilding(2964, 506.4844, -84.8359, 997.9375, 0.25);
			RemoveBuilding(2232, 507.1797, -88.3906, 998.5391, 0.25);
			RemoveBuilding(2670, 508.4141, -88.9844, 998.0703, 0.25);
			RemoveBuilding(2964, 510.1016, -84.8359, 997.9375, 0.25);
			RemoveBuilding(2232, 510.5234, -88.2578, 998.5391, 0.25);
			RemoveBuilding(2670, 510.8984, -84.8906, 998.0703, 0.25);
			RemoveBuilding(2670, 511.1484, -87.3672, 998.0703, 0.25);
			RemoveBuilding(2112, 489.0469, -75.0938, 998.1953, 0.25);
			RemoveBuilding(1543, 489.3047, -75.4297, 998.6250, 0.25);
			RemoveBuilding(1805, 488.9375, -75.8047, 998.0078, 0.25);
			RemoveBuilding(2350, 491.9141, -77.8828, 998.1328, 0.25);
			RemoveBuilding(2670, 492.6797, -76.0156, 997.8516, 0.25);
			RemoveBuilding(2670, 504.8672, -77.1797, 997.8516, 0.25);
			RemoveBuilding(1544, 489.5625, -74.8438, 998.6250, 0.25);
			RemoveBuilding(1543, 489.4688, -74.6563, 998.6250, 0.25);
			RemoveBuilding(1805, 489.6797, -74.3828, 998.0078, 0.25);
			RemoveBuilding(2112, 491.5156, -73.2109, 998.1953, 0.25);
			RemoveBuilding(1544, 491.1406, -73.6719, 998.6250, 0.25);
			RemoveBuilding(1544, 491.3516, -73.3125, 998.6250, 0.25);
			RemoveBuilding(1805, 492.1797, -73.6641, 998.0078, 0.25);
			RemoveBuilding(2112, 493.9766, -73.2109, 998.1953, 0.25);
			RemoveBuilding(1543, 494.1406, -73.1328, 998.6250, 0.25);
			RemoveBuilding(1544, 493.9844, -73.7500, 998.6250, 0.25);
			RemoveBuilding(1543, 493.6563, -73.3906, 998.6250, 0.25);
			RemoveBuilding(2112, 496.5469, -73.2109, 998.1953, 0.25);
			RemoveBuilding(1543, 496.2578, -72.9531, 998.6250, 0.25);
			RemoveBuilding(1805, 495.7891, -73.4531, 998.0078, 0.25);
			RemoveBuilding(1543, 496.9219, -73.2891, 998.6250, 0.25);
			RemoveBuilding(1544, 497.0156, -73.4766, 998.6250, 0.25);
			RemoveBuilding(1805, 497.2188, -73.7422, 998.0078, 0.25);
			RemoveBuilding(2112, 499.1094, -73.2109, 998.1953, 0.25);
			RemoveBuilding(1805, 500.2031, -72.9219, 998.0078, 0.25);
			RemoveBuilding(2670, 501.8438, -71.7734, 997.8516, 0.25);
			RemoveBuilding(1805, 507.0469, -70.5938, 998.0078, 0.25);
			RemoveBuilding(1805, 510.1484, -70.6953, 998.0078, 0.25);
			RemoveBuilding(1543, 506.3906, -70.1563, 998.6250, 0.25);
			RemoveBuilding(1543, 510.3594, -70.2344, 998.6250, 0.25);
			RemoveBuilding(1805, 505.4297, -70.0781, 998.0078, 0.25);
			RemoveBuilding(1544, 506.7109, -70.0547, 998.6250, 0.25);

		} else if(!strcmp(BizInteriors[12][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(16151, -223.1250, 1405.2734, 27.1016, 0.25);
			RemoveBuilding(16152, -228.5234, 1406.7266, 26.7656, 0.25);
			RemoveBuilding(16153, -225.7500, 1406.6953, 26.7656, 0.25);
			RemoveBuilding(16154, -219.4375, 1407.3828, 26.7656, 0.25);
			RemoveBuilding(16155, -218.4219, 1407.4141, 28.3438, 0.25);

		} else if(!strcmp(BizInteriors[13][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(2304, 2555.6953, -1305.8750, 1059.9766, 0.25);
			RemoveBuilding(2129, 2556.7031, -1305.8672, 1059.9766, 0.25);
			RemoveBuilding(2129, 2555.7031, -1304.9063, 1059.9766, 0.25);
			RemoveBuilding(2129, 2555.7031, -1303.9219, 1059.9766, 0.25);
			RemoveBuilding(2129, 2555.7031, -1302.9297, 1059.9766, 0.25);
			RemoveBuilding(2671, 2549.0391, -1300.3359, 1053.6563, 0.25);
			RemoveBuilding(2681, 2548.9375, -1298.2734, 1059.9844, 0.25);
			RemoveBuilding(2128, 2555.6953, -1298.9609, 1059.9766, 0.25);
			RemoveBuilding(2130, 2555.6953, -1301.9219, 1059.9766, 0.25);
			RemoveBuilding(2129, 2555.7031, -1299.9531, 1059.9766, 0.25);
			RemoveBuilding(2294, 2558.6641, -1305.8750, 1059.9766, 0.25);
			RemoveBuilding(2294, 2559.6563, -1305.8750, 1059.9766, 0.25);
			RemoveBuilding(2129, 2557.6953, -1305.8672, 1059.9766, 0.25);
			RemoveBuilding(2127, 2555.7031, -1297.9688, 1059.9766, 0.25);
			RemoveBuilding(2681, 2548.9375, -1297.4531, 1059.9844, 0.25);
			RemoveBuilding(14449, 2567.6172, -1294.6328, 1061.2500, 0.25);
			RemoveBuilding(2681, 2546.7031, -1289.9063, 1060.0000, 0.25);
			RemoveBuilding(2606, 2546.1563, -1286.0469, 1062.1953, 0.25);
			RemoveBuilding(2606, 2546.1563, -1286.0469, 1061.7266, 0.25);
			RemoveBuilding(2606, 2546.1563, -1286.0469, 1061.2656, 0.25);
			RemoveBuilding(2606, 2546.1563, -1286.0469, 1060.8047, 0.25);
			RemoveBuilding(1829, 2546.7813, -1280.6719, 1060.4609, 0.25);
			RemoveBuilding(1788, 2546.3359, -1282.8984, 1060.2266, 0.25);
			RemoveBuilding(1788, 2546.3359, -1282.8984, 1060.0625, 0.25);
			RemoveBuilding(1703, 2550.1406, -1286.6016, 1059.9766, 0.25);
			RemoveBuilding(2028, 2549.0938, -1283.2188, 1060.1094, 0.25);
			RemoveBuilding(2104, 2549.4375, -1279.8438, 1060.0156, 0.25);
			RemoveBuilding(2229, 2548.0156, -1279.8750, 1060.0156, 0.25);
			RemoveBuilding(2229, 2551.0156, -1280.1250, 1060.0156, 0.25);
			RemoveBuilding(1703, 2551.2813, -1283.6875, 1059.9766, 0.25);
			RemoveBuilding(1704, 2551.5000, -1280.3984, 1059.9766, 0.25);
			RemoveBuilding(2672, 2557.0078, -1283.8438, 1060.3047, 0.25);
			RemoveBuilding(14446, 2573.1641, -1281.7031, 1064.9609, 0.25);
			RemoveBuilding(1775, 2576.7031, -1284.4297, 1061.0938, 0.25);
			RemoveBuilding(2525, 2579.5391, -1286.6484, 1064.3750, 0.25);
			RemoveBuilding(2527, 2581.1172, -1283.1563, 1064.3672, 0.25);
			RemoveBuilding(2524, 2582.9922, -1284.1172, 1064.3750, 0.25);
			RemoveBuilding(2526, 2581.7656, -1286.6797, 1064.3594, 0.25);

		} else if(!strcmp(BizInteriors[14][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(14828, 1206.0625, -43.9453, 1001.3203, 0.25);
			RemoveBuilding(2776, 1208.4219, -29.2656, 1000.4141, 0.25);
			RemoveBuilding(14810, 1211.2500, -32.5156, 1001.4219, 0.25);
			RemoveBuilding(14811, 1211.2734, -32.5469, 1001.7891, 0.25);
			RemoveBuilding(2776, 1214.2422, -37.7266, 1000.4141, 0.25);
			RemoveBuilding(14809, 1212.4453, -36.7344, 1001.3594, 0.25);
			RemoveBuilding(2776, 1214.0625, -36.6016, 1000.4141, 0.25);
			RemoveBuilding(2776, 1209.4063, -29.6797, 1000.4141, 0.25);
			RemoveBuilding(2776, 1212.3984, -31.8594, 1000.4141, 0.25);
			RemoveBuilding(2776, 1211.9063, -30.8906, 1000.4141, 0.25);
			RemoveBuilding(2776, 1214.7422, -28.8438, 1000.4141, 0.25);
			RemoveBuilding(2776, 1215.8359, -29.0313, 1000.4141, 0.25);

		} else if(!strcmp(BizInteriors[15][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(2573, 948.2500, -41.5391, 1000.1016, 0.25);
			RemoveBuilding(1725, 951.9844, -46.2813, 1000.1250, 0.25);
			RemoveBuilding(1803, 952.9609, -57.4375, 1000.0938, 0.25);
			RemoveBuilding(2576, 955.1953, -55.4531, 1000.1016, 0.25);
			RemoveBuilding(2573, 955.3281, -43.5547, 1000.1016, 0.25);
			RemoveBuilding(2276, 956.5469, -55.8672, 1001.5313, 0.25);
			RemoveBuilding(1792, 957.5078, -61.6641, 1000.9219, 0.25);
			RemoveBuilding(14816, 957.6875, -52.4766, 1001.6406, 0.25);
			RemoveBuilding(2024, 960.2500, -58.0625, 1000.3984, 0.25);
			RemoveBuilding(2248, 963.7578, -61.7188, 1000.5000, 0.25);
			RemoveBuilding(1828, 961.3984, -54.0469, 1000.1484, 0.25);
			RemoveBuilding(1736, 964.4531, -55.4688, 1002.0469, 0.25);
			RemoveBuilding(2242, 964.2734, -51.5781, 1000.3359, 0.25);
			RemoveBuilding(2255, 956.5703, -46.4453, 1001.9531, 0.25);
			RemoveBuilding(2618, 956.7109, -48.7266, 1000.1172, 0.25);
			RemoveBuilding(2240, 957.1172, -43.4609, 1000.7188, 0.25);
			RemoveBuilding(2118, 960.8672, -45.6484, 1000.5234, 0.25);
			RemoveBuilding(2776, 967.8984, -48.4688, 1000.5703, 0.25);
			RemoveBuilding(2776, 967.5234, -47.2578, 1000.5703, 0.25);
			RemoveBuilding(2776, 967.1094, -44.3203, 1000.5703, 0.25);
			RemoveBuilding(2776, 967.8047, -45.0781, 1000.5703, 0.25);

		} else if(!strcmp(BizInteriors[16][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(14539, -2656.9766, 1417.4063, 913.1406, 0.25);
			RemoveBuilding(14540, -2650.6094, 1414.9922, 905.8828, 0.25);

		} else if(!strcmp(BizInteriors[17][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(3922, -792.2500, 500.3828, 1370.6484, 0.25);
			RemoveBuilding(3946, -785.9922, 497.1641, 1373.9609, 0.25);
			RemoveBuilding(3966, -788.5234, 491.5938, 1375.9141, 0.25);
			RemoveBuilding(1972, -787.8203, 499.2500, 1372.1172, 0.25);
			RemoveBuilding(3965, -787.3828, 497.5859, 1372.1719, 0.25);
			RemoveBuilding(1432, -787.2500, 497.7656, 1375.2891, 0.25);
			RemoveBuilding(1432, -787.4766, 504.5938, 1370.8594, 0.25);
			RemoveBuilding(3944, -787.4922, 505.8750, 1374.7188, 0.25);
			RemoveBuilding(1432, -790.6016, 509.0391, 1370.8594, 0.25);
			RemoveBuilding(1432, -787.8203, 509.0469, 1370.8594, 0.25);
			RemoveBuilding(1514, -782.3594, 499.0547, 1372.1250, 0.25);
			RemoveBuilding(1432, -783.0078, 509.0156, 1370.8594, 0.25);
			RemoveBuilding(1432, -779.8750, 509.0547, 1370.8594, 0.25);

		} else if(!strcmp(BizInteriors[18][InteriorName], BizInfo[strval(PlayerInfo[playerid][BizID])][InteriorName])) {

			RemoveBuilding(3935, -1097.7422, 1037.8750, 1343.0781, 0.25);
			RemoveBuilding(2060, -1124.9766, 1053.9375, 1345.0234, 0.25);
			RemoveBuilding(2060, -1124.9766, 1053.9375, 1344.7578, 0.25);
			RemoveBuilding(2060, -1124.9766, 1054.5313, 1345.2734, 0.25);
			RemoveBuilding(2060, -1124.9766, 1055.0781, 1345.0234, 0.25);
			RemoveBuilding(2060, -1124.9766, 1055.0781, 1344.7578, 0.25);
			RemoveBuilding(2060, -1124.9766, 1060.4766, 1344.7578, 0.25);
			RemoveBuilding(2060, -1124.9766, 1060.4766, 1345.0234, 0.25);
			RemoveBuilding(2060, -1124.9766, 1061.0781, 1345.2734, 0.25);
			RemoveBuilding(2060, -1124.9766, 1061.6250, 1344.7578, 0.25);
			RemoveBuilding(2060, -1124.9766, 1061.6250, 1345.0234, 0.25);
			RemoveBuilding(1596, -1132.6953, 1073.9922, 1354.7500, 0.25);
			RemoveBuilding(1596, -973.5625, 1046.0703, 1353.9688, 0.25);
			RemoveBuilding(2060, -980.4297, 1057.4141, 1344.0625, 0.25);
			RemoveBuilding(2060, -980.4297, 1057.4141, 1344.3359, 0.25);
			RemoveBuilding(2060, -980.4297, 1058.0156, 1344.5781, 0.25);
			RemoveBuilding(2060, -980.4297, 1058.5625, 1344.3359, 0.25);
			RemoveBuilding(2060, -980.4297, 1058.5625, 1344.0625, 0.25);
			RemoveBuilding(2060, -980.4297, 1063.6953, 1344.0625, 0.25);
			RemoveBuilding(2060, -980.4297, 1063.6953, 1344.3359, 0.25);
			RemoveBuilding(2060, -980.4297, 1064.2891, 1344.5781, 0.25);
			RemoveBuilding(2060, -980.4297, 1064.8438, 1344.0625, 0.25);
			RemoveBuilding(2060, -980.4297, 1064.8438, 1344.3359, 0.25);

		}

	}*/

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerInteriorChange() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerInteriorChange()", debug_String);

    #endif

	SendDebugMessage("OnPlayerInteriorChange()", "OnPlayerInteriorChange End");

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	SendDebugMessage("OnPlayerStateChange()", "OnPlayerStateChange Start");

	timing[0] = GetTickCount();

	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
	    if(Laser[playerid] == 1)
	    {
	        RemovePlayerAttachedObject(playerid, 0);
	        TLaser[playerid] = 1;
	        Laser[playerid] = 0;
 		}
 		new vehicle = GetPlayerVehicleID(playerid);
 		if(IsPlayerCivilian(playerid)) {
		 	if(GetVehicleModel(vehicle) == 416 || GetVehicleModel(vehicle) == 433 || GetVehicleModel(vehicle) == 523 || GetVehicleModel(vehicle) == 427 || GetVehicleModel(vehicle) == 490 || GetVehicleModel(vehicle) == 528 || GetVehicleModel(vehicle) == 407 || GetVehicleModel(vehicle) == 544 || GetVehicleModel(vehicle) == 596 || GetVehicleModel(vehicle) == 598 || GetVehicleModel(vehicle) == 597 || GetVehicleModel(vehicle) == 599 || GetVehicleModel(vehicle) == 432 || GetVehicleModel(vehicle) == 601) {
		 		if(PlayerStolenVeh[playerid][vehicle] == -1) {
	 		    	WantedLevel[playerid] += 4;
	 		    	PlayerStolenVeh[playerid][vehicle] = vehicle;
	 		    	format(G_String, 128, "%s has stolen a government vehicle | Location: %s | Wanted Level %i", PlayerName(playerid), PlayerZone(playerid), WantedLevel[playerid]);
	 		    	SendClientMessageToAll(COLOR_SKYBLUE, G_String);
	 		    	CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel[playerid], "Stolen a government vehicle", -1);
 		    	}
 		    }

 		    if(GetVehicleModel(vehicle) == 574) {

 		    	if(!(PlayerVariables[playerid] & PLAYER_IN_JOB)) {
 		    		ShowJobTextdraw(playerid, "Press ~g~CAPSLOCK~w~ to start the sweeper job");
 		    	}
 		    }
 		}

 		for(new i = 0; i < MAX_VEHICLES; i++)
 		{
 		    if(VehicleInfo[i][VID] == GetPlayerVehicleID(playerid)) {
				if(!strcmp(VehicleInfo[i][Owner], PlayerName(playerid), false))
				    SendClientMessage(playerid, COLOR_WHITE, "You own this vehicle");
				else {
				    SendClientMessage(playerid, COLOR_RED2, "This is not your vehicle. Get out!");
				    RemovePlayerFromVehicle(playerid);
				}
 		    }
		}

	}
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
	    if(TLaser[playerid] == 1)
	    {
	        Laser[playerid] = 1;
		}
		PlayerTextDrawHide(playerid, JobTextdraw[playerid]);
	}
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_PASSENGER) {
	    new vehicle = GetPlayerVehicleID(playerid);

	    foreach(Player, i) {
  		 	new taxistate = GetPlayerState(i);
	        if(GetPlayerVehicleID(playerid) == vehicle && taxistate == PLAYER_STATE_DRIVER) {
	            if(gTeam[i] == TAXI) {
	                SendClientMessage(playerid, COLOR_GREEN, "[TAXI] :{FFFFFF} You have entered a taxi driver's vehicle.");
	                format(G_String, 128, "{FFFFFF}%s is a taxi driver and his pay per second is set at the following\n%d\n\nFor five minutes of this taxi service it will cost %d", PlayerName(i), PlayerInfo[i][Ptaxirate], (PlayerInfo[i][Ptaxirate] * 60 * 5));
	                ShowPlayerDialog(playerid, DIALOG_TAXIPAY, DIALOG_STYLE_MSGBOX, "Taxi pay per second", G_String, "Use taxi", "Eject");
	                TaxiDriver[playerid] = i;
	            }
	        }
	        
	    }
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerStateChange() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerStateChange()", debug_String);

    #endif

	SendDebugMessage("OnPlayerStateChange()", "OnPlayerStateChange End");

	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(VehicleLocked[vehicleid]) {
	    VehicleLocked[vehicleid] = false;
	    ToggleVehicleDoorsLocked(vehicleid);
	    SendClientMessage(playerid, COLOR_GREEN, "Vehicle unlocked.");
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	SendDebugMessage("OnPlayerText()", "OnPlayerText Start");

	timing[0] = GetTickCount();

	if(GetPlayerLangRoom(playerid) != -1) {

	    if((gettime() - CTime[playerid])  > 1) {
		CTime[playerid] = gettime();
		format(G_String, 128, "%s(%i): {FFFFFF}%s", PlayerName(playerid), playerid, text);
		SendMessageToLangRoom(playerid, GetPlayerLangRoom(playerid), G_String);
		} else if((gettime() - CTime[playerid])  < 1){
		    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming the chat.");
		    return 0;
		}

	}


    if(pChat_Color[playerid] == 1) {
	    format(G_String, 128, "%s(%i): {00FF00}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}

	if(pChat_Color[playerid] == 2) {
	    format(G_String, 128, "%s(%i): {FF0000}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}

	if(pChat_Color[playerid] == 3) {
	    format(G_String, 128, "%s(%i): {00FFFF}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}

	if(pChat_Color[playerid] == 4) {
	    format(G_String, 128, "%s(%i): {0000FF}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}

	if(pChat_Color[playerid] == 5) {
	    format(G_String, 128, "%s(%i): {800080}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}

	if(strfind(text, "How to be admin", true) != -1 || strfind(text, "can i be admin", true) != -1) {
	    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Please don't ask to be an admin. We will choose who will be admin");
	    return 0;
	}

	if(strfind(text, "how to get weapons", true) != -1) {
	    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} To obtain weapons, visit a local amunation or call a weapons dealer.");
	    return 0;
	}

	if(PlayerVariables[playerid] & PLAYER_MUTED) {
	    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are currently muted and can not speak in the chat.");
	    return 0;
	}

	if(!strcmp(text, "jetpackpls", true) && PlayerInfo[playerid][Padmin] > 2)
	{
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	    return 0;
	}

	if(strfind(text, "!a", true) == 0 && PlayerInfo[playerid][Padmin] > 0) {
		strdel(text, 0, 2);
		format(G_String, 128, "[A CHAT] {FFFFFF}%s(%i): %s", PlayerName(playerid), playerid, text);
	    SendMessageToAdmins(COLOR_RED2, G_String);
	    return 0;
	}

	if((gettime() - CTime[playerid])  > 0.5) {
		CTime[playerid] = gettime();
		new irc[128];
		format(G_String, 128, "%s(%i): {FFFFFF}%s", PlayerName(playerid), playerid, text);
		format(irc, 128, "** FROM INGAME : %s: %s", PlayerName(playerid), text);
		IRC_GroupSay(BGroupID, IRC_CHANNEL, irc);
		SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	} else if((gettime() - CTime[playerid])  <= 0.5){
	    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming the chat.");
	    return 0;
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerText() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerText()", debug_String);

    #endif

	SendDebugMessage("OnPlayerText()", "OnPlayerText End");

	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	SendDebugMessage("OnPlayerKeyStateChange()", "OnPlayerKeyStateChange Start");

	timing[0] = GetTickCount();

	if (HOLDING( KEY_FIRE | KEY_HANDBRAKE ) && GetPlayerWeapon(playerid) == 41 && gTeam[playerid] == MECHANIC)
	{
		new Float:pos[3];
		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			GetVehiclePos(i, pos[0], pos[1], pos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 3.0, pos[0], pos[1], pos[2])) {

				switch(VehicleSprayColor[playerid])
				{
					case 0: ChangeVehicleColor(i, 136, 1);
					case 1:	ChangeVehicleColor(i, 175, 1);
					case 2:	ChangeVehicleColor(i, 243, 1);
					case 3:	ChangeVehicleColor(i, 155, 1);
					case 4:	ChangeVehicleColor(i, 194, 1);
					case 5: ChangeVehicleColor(i, 167, 1);
				}
			}
		}
	}
	if (HOLDING( KEY_FIRE ) && GetPlayerWeapon(playerid) == 37 || HOLDING( KEY_FIRE | KEY_HANDBRAKE ) && GetPlayerWeapon(playerid) == 37) {
		new Oid = GetNearestWeedToPlayer(playerid);
		if(Oid != -1) {
  			if(IsPlayerAimingAt(playerid, WeedInfo[Oid][Xpos], WeedInfo[Oid][Ypos], WeedInfo[Oid][Zpos], 6.0))
    			CallLocalFunction("OnWeedBurnt", "ii", Oid, playerid);
		}
	}
	if (HOLDING( KEY_FIRE ) && GetPlayerWeapon(playerid) == 42 || HOLDING( KEY_FIRE | KEY_HANDBRAKE ) && GetPlayerWeapon(playerid) == 42 && gTeam[playerid] == FIREFIGHTER) {
		printf("Is firing");
		new Oid = GetNearestFireToPlayer(playerid);
		if(Oid != -1) {
			printf("a close fire has been located");
  			if(IsPlayerAimingAt(playerid, FireInfo[Oid][pos1], FireInfo[Oid][pos2], FireInfo[Oid][pos3], 5.0)) {
    			CallLocalFunction("OnFirePutOut", "ii", Oid, playerid);
    			printf("Player is aiming and firing at fire");
    		}
		}
	}
	if(PRESSED(KEY_CROUCH) && !(PlayerVariables[playerid] & PLAYER_IN_JOB)) {

		if(IsPlayerInAnyVehicle(playerid)) {

			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 574) {

				if(gettime() - TimeSinceSweep[playerid] < 360) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to wait a while before attempting this job again.");
				PlayerVariables[playerid] |= PLAYER_IN_JOB;
				PlayerTextDrawHide(playerid, JobTextdraw[playerid]);
				//load all the rubbish piles.
				SendClientMessage(playerid, COLOR_GREEN, "[ALERT] :{FFFFFF} Pickup all trash from the street to earn money and score.");
				SendClientMessage(playerid, COLOR_GREEN, "[ALERT] :{FFFFFF} Rubish is representated as {FFFF00}yellow{FFFFFF} squares on your minimap.");
				SendClientMessage(playerid, COLOR_GREEN, "[ALERT] :{FFFFFF} You many /quitjob at any time.");
				mysql_function_query (Gconnection, "SELECT * FROM `sweeper`", true, "OnPlayerStartSweeperJob", "i", playerid);
			} else if(IsPlayerInAircraft(playerid)) {

				Rand = randomEx(0, 10);
				JobCheckpoint[playerid] = CreateDynamicCP(PilotJobs[Rand][FromX], PilotJobs[Rand][FromY], PilotJobs[Rand][FromZ], 5.0, -1, -1, playerid, 100.0);
				format(G_String, 128, "[JOB] :{FFFFFF} %s", PilotJobs[Rand][JobText]);
				SendClientMessage(playerid, COLOR_GREEN, G_String);
				JobIcon[playerid] = SetPlayerMapIcon(playerid, 54, PilotJobs[Rand][FromX], PilotJobs[Rand][FromY], PilotJobs[Rand][FromZ], 0, COLOR_YELLOW, MAPICON_GLOBAL);
				CurrentJobID[playerid] = Rand;
				JobStatus[playerid] = 1;
				PlayerVariables[playerid] |= PLAYER_IN_JOB;
				PlayerTextDrawSetString(playerid, JobTextdraw[playerid], PilotJobs[Rand][JobText]);
				PlayerTextDrawShow(playerid, JobTextdraw[playerid]);
			}
		}
	} 
	if(PRESSED(KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 1.0,311.9479,-169.7130,999.5938) && GetPlayerVirtualWorld(playerid) == 2) {
		ShowPlayerDialog(playerid, DIALOG_CRIM_WEP, DIALOG_STYLE_LIST, "Criminal Weapons", "Grenade\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff Shotgun\nCombat Shotgun\nMicro SMG/Uzi\nMP5\nAK-47\nM4\nTec-9\nSniper Rifle", "Purchase", "Cancel");
	}
	if(PRESSED(KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 1.0,315.0459,-160.9110,999.5938) || IsPlayerInRangeOfPoint(playerid, 1.0, 313.6811,-162.4501,999.5938) || IsPlayerInRangeOfPoint(playerid, 1.0, 315.0622,-163.7775,999.5938) || IsPlayerInRangeOfPoint(playerid, 1.0, 316.5235,-162.2851,999.5938) && GetPlayerVirtualWorld(playerid) == 2) {
		ShowPlayerDialog(playerid, DIALOG_CRIM_AMO, DIALOG_STYLE_LIST, "Criminal Ammunition", "Grenade Ammo\n9mm Ammo\nSilenced 9mm Ammo\nDesert Eagle Ammo\nShotgun Ammo\nSawnoff Shotgun Ammo\nCombat Shotgun Ammo\nMicro SMG/Uzi Ammo\nMP5 Ammo\nAK-47 Ammo\nM4 Ammo\nTec-9 Ammo\nSniper Rifle Ammo", "Purchase", "Cancel");
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerKeyStateChange() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerKeyStateChange()", debug_String);

    #endif

    SendDebugMessage("OnPlayerKeyStateChange()", "OnPlayerKeyStateChange End");

	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{

	SendDebugMessage("OnPlayerRequestClass()", "OnPlayerRequestClass Start");

	timing[0] = GetTickCount();

	SetPlayerPos(playerid, 510.4452,-85.3122,999.8295);
	SetPlayerFacingAngle(playerid, 275.6374-190);
	SetPlayerCameraPos(playerid, 506.8546,-82.0858,998.9609);
	SetPlayerCameraLookAt(playerid, 510.4452,-85.3122,999.8295);
	SetPlayerInterior(playerid, 11);

	for(new i = 0; i < 14; i++) {
 		TextDrawHideForPlayer(playerid, RulesTextDraw[i]);
 	}
  	PlayerVariables[playerid] &= ~PLAYER_READING_RULES;
	PlayerVariables[playerid] |= PLAYER_IN_CLASS_SELECTION;

	//mysql
	if(!(PlayerVariables[playerid] & PLAYER_LOGGED_IN)) {
	    new Query[100];
		format(Query, 100, "SELECT `username` FROM `users` WHERE `username`='%s'", PlayerName(playerid));
		mysql_function_query (Gconnection, Query, true, "OnPlayerRequestLoginRegister", "d", playerid);

	}

	//Lets tell the player the name of the class
	switch(classid)
	{
	    case 0..1:
	    {
	        ShowCasualTextdraw(playerid, "S.T.A.T");
			gTeam[playerid] = STAT;
		}
		case 2..3:
		{
		    ShowCasualTextdraw(playerid, "ARMY");
		    gTeam[playerid] = ARMY;
		}
		case 4:
		{
            ShowCasualTextdraw(playerid, "S.W.A.T");
			gTeam[playerid] = SWAT;
		}
		case 5:
		{
			ShowCasualTextdraw(playerid, "FIREFIGHTER");
			gTeam[playerid] = FIREFIGHTER;
		}
		case 6:
		{
		    ShowCasualTextdraw(playerid, "MAYOR");
		    gTeam[playerid] = MAYOR;
		}
		case 7:
		{
		    ShowCasualTextdraw(playerid, "PIZZA BOY");
		    gTeam[playerid] = PIZZABOY;
		}
		case 8..16:
		{
			ShowCasualTextdraw(playerid, "POLICE OFFICER");
			gTeam[playerid] = POLICE;
		}
		case 17:
		{
		    ShowCasualTextdraw(playerid, "PILOT");
			gTeam[playerid] = PILOT;
		}
		case 18:
		{
		    ShowCasualTextdraw(playerid, "TAXI DRIVER");
		    gTeam[playerid] = TAXI;
		}
		case 19..125:
		{
		    ShowCasualTextdraw(playerid, "CIVILIAN~n~Choose a job");
		    gTeam[playerid] = CIVILIAN;
		}
		case 126:
		{
		    ShowCasualTextdraw(playerid, "MEDIC");
		    gTeam[playerid] = MEDIC;
		}
		case 127:
		{
		    ShowCasualTextdraw(playerid, "TRUCKER");
		    gTeam[playerid] = TRUCKER;
		}
		case 128:
		{
		    ShowCasualTextdraw(playerid, "MECHANIC");
		    gTeam[playerid] = MECHANIC;
		}
		case 129:
		{
		    ShowCasualTextdraw(playerid, "HITMAN");
		    gTeam[playerid] = HITMAN;
		}
		case 130:
		{
		    ShowCasualTextdraw(playerid, "FARMER");
		    gTeam[playerid] = FARMER;
		}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerRequestClass() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerRequestClass()", debug_String);

    #endif

	SendDebugMessage("OnPlayerRequestClass()", "OnPlayerRequestClass End");

	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	SendDebugMessage("OnPlayerRequestSpawn()", "OnPlayerRequestSpawn Start");

	timing[0] = GetTickCount();

	if(!(PlayerVariables[playerid] & PLAYER_LOGGED_IN)) {
	    SendClientMessage(playerid, COLOR_RED2, "You must be logged in to spawn!");
		ForceClassSelection(playerid);
    	TogglePlayerSpectating(playerid, true);
    	TogglePlayerSpectating(playerid, false);
	} else {

	    if(gTeam[playerid] == STAT && !(PlayerVariables[playerid] & PLAYER_IN_STAT)) {
	        SendClientMessage(playerid, COLOR_RED2, "You need to apply on the forums to be able to spawn as stat");
	        ForceClassSelection(playerid);
	    	TogglePlayerSpectating(playerid, true);
	    	TogglePlayerSpectating(playerid, false);
	    } else if(gTeam[playerid] == HITMAN && HasPlayerPlacedHit(playerid)) {
            SendClientMessage(playerid, COLOR_RED2, "You cannot play as a hitman while you have a hit on someone.");
	        ForceClassSelection(playerid);
	    	TogglePlayerSpectating(playerid, true);
	    	TogglePlayerSpectating(playerid, false);
		} else if(gTeam[playerid] == MAYOR) {
            SendClientMessage(playerid, COLOR_RED2, "This class is not ready yet.");
	        ForceClassSelection(playerid);
	    	TogglePlayerSpectating(playerid, true);
	    	TogglePlayerSpectating(playerid, false);
		}else if(gTeam[playerid] == CIVILIAN) {
			/*new Text:JobSelection[18];//the job textdraw
			new PlayerText:JobSelectionTextdraw[7];//the job textdraws for player

			PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[0], GetPlayerSkin(playerid));
			PlayerTextDrawShow(playerid, JobSelectionTextdraw[0]);
			PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[1], 346);
			PlayerTextDrawShow(playerid, JobSelectionTextdraw[1]);

			TextDrawShowForPlayer(playerid, JobSelection[0]);
			TextDrawShowForPlayer(playerid, JobSelection[1]);
			TextDrawShowForPlayer(playerid, JobSelection[2]);
			TextDrawShowForPlayer(playerid, JobSelection[3]);
			TextDrawShowForPlayer(playerid, JobSelection[4]);
			TextDrawShowForPlayer(playerid, JobSelection[5]);
			TextDrawShowForPlayer(playerid, JobSelection[6]);
			TextDrawShowForPlayer(playerid, JobSelection[7]);
			TextDrawShowForPlayer(playerid, JobSelection[8]);
			TextDrawShowForPlayer(playerid, JobSelection[9]);
			TextDrawShowForPlayer(playerid, JobSelection[10]);
			TextDrawShowForPlayer(playerid, JobSelection[11]);
			TextDrawShowForPlayer(playerid, JobSelection[12]);
			TextDrawShowForPlayer(playerid, JobSelection[13]);
			TextDrawShowForPlayer(playerid, JobSelection[14]);
			TextDrawShowForPlayer(playerid, JobSelection[15]);
			TextDrawShowForPlayer(playerid, JobSelection[16]);
			TextDrawShowForPlayer(playerid, JobSelection[17]);*/
			SpawnPlayer(playerid);
	    } else {
	    	SpawnPlayer(playerid);
	    	SetJobStartTime(playerid, gTeam[playerid], gettime());
	    }
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerRequestSpawn() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerRequestSpawn()", debug_String);

    #endif

	SendDebugMessage("OnPlayerRequestSpawn()", "OnPlayerRequestSpawn Start");

	return 1;
}


public OnPlayerConnect(playerid)
{
	//Player textdraws

	SendDebugMessage("OnPlayerConnect()", "OnPlayerConnect Start");

	timing[0] = GetTickCount();

	VehicleBuy[playerid][0] = CreatePlayerTextDraw(playerid, 151.000000, 29.000000, "~w~red");
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][0], 0x888888AA);
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][0], 65535);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][0], 325.000000, 363.000000);
	PlayerTextDrawSetPreviewModel(playerid, VehicleBuy[playerid][0], 411);
	PlayerTextDrawSetPreviewRot(playerid, VehicleBuy[playerid][0], -16.000000, 0.000000, 22.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][0], 1);

	VehicleBuy[playerid][1] = CreatePlayerTextDraw(playerid, 311.000000, 36.000000, "Infernus");
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][1], 0);
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][1], 3);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][1], 1.010000, 1.600000);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, VehicleBuy[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, VehicleBuy[playerid][1], 255);
	PlayerTextDrawTextSize(playerid, VehicleBuy[playerid][1], 30.000000, 30.000000);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][1], 0);

	VehicleBuy[playerid][2] = CreatePlayerTextDraw(playerid, 310.000000, 360.000000, "~g~$~w~20000");
	PlayerTextDrawAlignment(playerid, VehicleBuy[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid, VehicleBuy[playerid][2], 255);
	PlayerTextDrawFont(playerid, VehicleBuy[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, VehicleBuy[playerid][2], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, VehicleBuy[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, VehicleBuy[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, VehicleBuy[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, VehicleBuy[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleBuy[playerid][2], 0);

	Casual[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 82.000000, "Textdraw");
	PlayerTextDrawBackgroundColor(playerid, Casual[playerid], 255);
	PlayerTextDrawFont(playerid, Casual[playerid], 3);
	PlayerTextDrawAlignment(playerid, Casual[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Casual[playerid], 0.699998, 2.499999);
	PlayerTextDrawColor(playerid, Casual[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Casual[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Casual[playerid], 1);

	Zone[playerid] = CreatePlayerTextDraw(playerid, 85.000000, 329.000000, "Idlewood");
	PlayerTextDrawAlignment(playerid, Zone[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, Zone[playerid], 255);
	PlayerTextDrawFont(playerid, Zone[playerid], 0);
	PlayerTextDrawLetterSize(playerid, Zone[playerid], 0.569998, 1.600000);
	PlayerTextDrawColor(playerid, Zone[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Zone[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Zone[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Zone[playerid], 0);

	PrisonTextdraw[playerid] = CreatePlayerTextDraw(playerid, 200.000000, 433.000000, "Time Left: 480 seconds");
	PlayerTextDrawBackgroundColor(playerid, PrisonTextdraw[playerid], 255);
	PlayerTextDrawFont(playerid, PrisonTextdraw[playerid], 3);
	PlayerTextDrawLetterSize(playerid, PrisonTextdraw[playerid], 0.579999, 1.500000);
	PlayerTextDrawColor(playerid, PrisonTextdraw[playerid], -1);
	PlayerTextDrawSetOutline(playerid, PrisonTextdraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PrisonTextdraw[playerid], 1);

	RobberyText[playerid] = CreatePlayerTextDraw(playerid, 322.000000, 143.000000, "Attempting robbery stay in the checkpoint!~n~Time Left: 10");
	PlayerTextDrawAlignment(playerid, RobberyText[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, RobberyText[playerid], 255);
	PlayerTextDrawFont(playerid, RobberyText[playerid], 3);
	PlayerTextDrawLetterSize(playerid, RobberyText[playerid], 0.649999, 3.299998);
	PlayerTextDrawColor(playerid, RobberyText[playerid], -1);
	PlayerTextDrawSetOutline(playerid, RobberyText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RobberyText[playerid], 1);


	Spedo[playerid][0] = CreatePlayerTextDraw(playerid, 608.000000, 353.000000, "        ");
	PlayerTextDrawBackgroundColor(playerid, Spedo[playerid][0], 255);
	PlayerTextDrawFont(playerid, Spedo[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Spedo[playerid][0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, Spedo[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, Spedo[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Spedo[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Spedo[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, Spedo[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, Spedo[playerid][0], 112);
	PlayerTextDrawTextSize(playerid, Spedo[playerid][0], 428.000000, -20.000000);
	PlayerTextDrawSetSelectable(playerid, Spedo[playerid][0], 0);

	Spedo[playerid][1] = CreatePlayerTextDraw(playerid, 504.000000, 355.000000, "60 KPH");
	PlayerTextDrawAlignment(playerid, Spedo[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, Spedo[playerid][1], 255);
	PlayerTextDrawFont(playerid, Spedo[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, Spedo[playerid][1], 0.509999, 1.500000);
	PlayerTextDrawColor(playerid, Spedo[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, Spedo[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Spedo[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Spedo[playerid][1], 0);

	Spedo[playerid][2] = CreatePlayerTextDraw(playerid, 509.000000, 399.000000, "ETA : 120 seconds");
	PlayerTextDrawAlignment(playerid, Spedo[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid, Spedo[playerid][2], 255);
	PlayerTextDrawFont(playerid, Spedo[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, Spedo[playerid][2], 0.270000, 1.000000);
	PlayerTextDrawColor(playerid, Spedo[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, Spedo[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Spedo[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Spedo[playerid][2], 0);

	JobTextdraw[playerid] = CreatePlayerTextDraw(playerid, 15.000000, 434.000000, "Press ~g~CAPSLOCK ~w~to start the sweeper job");
	PlayerTextDrawBackgroundColor(playerid, JobTextdraw[playerid], 255);
	PlayerTextDrawFont(playerid, JobTextdraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, JobTextdraw[playerid], 0.270000, 1.200000);
	PlayerTextDrawColor(playerid, JobTextdraw[playerid], -1);
	PlayerTextDrawSetOutline(playerid, JobTextdraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JobTextdraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, JobTextdraw[playerid], 0);

	DialogTitle[playerid] = CreatePlayerTextDraw(playerid, 175.000000, 133.000000, "DIALOG TITLE");
	PlayerTextDrawBackgroundColor(playerid, DialogTitle[playerid], 255);
	PlayerTextDrawFont(playerid, DialogTitle[playerid], 2);
	PlayerTextDrawLetterSize(playerid, DialogTitle[playerid], 0.270000, 1.300000);
	PlayerTextDrawColor(playerid, DialogTitle[playerid], -1);
	PlayerTextDrawSetOutline(playerid, DialogTitle[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DialogTitle[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DialogTitle[playerid], 0);

	DialogContent[playerid][0] = CreatePlayerTextDraw(playerid, 175.000000, 158.000000, "thefatshizmsthefatshizmsthefatshizmsthefatshizmszzzzzzz");
	PlayerTextDrawBackgroundColor(playerid, DialogContent[playerid][0], 255);
	PlayerTextDrawFont(playerid, DialogContent[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, DialogContent[playerid][0], 0.190000, 1.000000);
	PlayerTextDrawColor(playerid, DialogContent[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, DialogContent[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DialogContent[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, DialogContent[playerid][0], 0);

	DialogContent[playerid][1] = CreatePlayerTextDraw(playerid, 175.000000, 169.000000, "thefatshizmsthefatshizmsthefatshizmsthefatshizmszzzzzzz");
	PlayerTextDrawBackgroundColor(playerid, DialogContent[playerid][1], 255);
	PlayerTextDrawFont(playerid, DialogContent[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, DialogContent[playerid][1], 0.190000, 1.000000);
	PlayerTextDrawColor(playerid, DialogContent[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, DialogContent[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, DialogContent[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, DialogContent[playerid][1], 0);

	DialogContent[playerid][2] = CreatePlayerTextDraw(playerid, 175.000000, 180.000000, "thefatshizmsthefatshizmsthefatshizmsthefatshizmszzzzzzz");
	PlayerTextDrawBackgroundColor(playerid, DialogContent[playerid][2], 255);
	PlayerTextDrawFont(playerid, DialogContent[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, DialogContent[playerid][2], 0.190000, 1.000000);
	PlayerTextDrawColor(playerid, DialogContent[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, DialogContent[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, DialogContent[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, DialogContent[playerid][2], 0);

	DialogContent[playerid][3] = CreatePlayerTextDraw(playerid, 175.000000, 190.000000, "thefatshizmsthefatshizmsthefatshizmsthefatshizmszzzzzzz");
	PlayerTextDrawBackgroundColor(playerid, DialogContent[playerid][3], 255);
	PlayerTextDrawFont(playerid, DialogContent[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, DialogContent[playerid][3], 0.189999, 1.000000);
	PlayerTextDrawColor(playerid, DialogContent[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid, DialogContent[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, DialogContent[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, DialogContent[playerid][3], 0);

	//button left - 2 buttons
	DialogButtonText[playerid][0] = CreatePlayerTextDraw(playerid, 250.000000, 211.000000, "Button1");
	PlayerTextDrawAlignment(playerid, DialogButtonText[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, DialogButtonText[playerid][0], 255);
	PlayerTextDrawFont(playerid, DialogButtonText[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, DialogButtonText[playerid][0], 0.280000, 1.400000);
	PlayerTextDrawColor(playerid, DialogButtonText[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, DialogButtonText[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DialogButtonText[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, DialogButtonText[playerid][0], 1);

	//button right - 2 buttons
	DialogButtonText[playerid][1] = CreatePlayerTextDraw(playerid, 382.000000, 211.000000, "Button1");
	PlayerTextDrawAlignment(playerid, DialogButtonText[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, DialogButtonText[playerid][1], 255);
	PlayerTextDrawFont(playerid, DialogButtonText[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, DialogButtonText[playerid][1], 0.280000, 1.400000);
	PlayerTextDrawColor(playerid, DialogButtonText[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, DialogButtonText[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, DialogButtonText[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, DialogButtonText[playerid][1], 1);

	//button centre
	DialogButtonText[playerid][2] = CreatePlayerTextDraw(playerid, 318.000000, 211.000000, "Button1");
	PlayerTextDrawAlignment(playerid, DialogButtonText[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid, DialogButtonText[playerid][2], 255);
	PlayerTextDrawFont(playerid, DialogButtonText[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, DialogButtonText[playerid][2], 0.280000, 1.400000);
	PlayerTextDrawColor(playerid, DialogButtonText[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, DialogButtonText[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, DialogButtonText[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, DialogButtonText[playerid][2], 1);

	JobSelectionTextdraw[0] = CreatePlayerTextDraw(playerid, 198.000000, 119.000000, "CJ SKIN");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[0], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[0], 5);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[0], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[0], 0);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[0], 1);
	PlayerTextDrawSetShadow(playerid, JobSelectionTextdraw[0], 1);
	PlayerTextDrawUseBox(playerid, JobSelectionTextdraw[0], 1);
	PlayerTextDrawBoxColor(playerid, JobSelectionTextdraw[0], -256);
	PlayerTextDrawTextSize(playerid, JobSelectionTextdraw[0], 97.000000, 96.000000);
	PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, JobSelectionTextdraw[0], 0.000000, 0.000000, 1.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[0], 0);


	JobSelectionTextdraw[1] = CreatePlayerTextDraw(playerid, 198.000000, 223.000000, "wep");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[1], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[1], 5);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[1], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[1], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[1], 0);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[1], 1);
	PlayerTextDrawSetShadow(playerid, JobSelectionTextdraw[1], 1);
	PlayerTextDrawUseBox(playerid, JobSelectionTextdraw[1], 1);
	PlayerTextDrawBoxColor(playerid, JobSelectionTextdraw[1], 255);
	PlayerTextDrawTextSize(playerid, JobSelectionTextdraw[1], 74.000000, 63.000000);
	PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[1], 346);
	PlayerTextDrawSetPreviewRot(playerid, JobSelectionTextdraw[1], -16.000000, 0.000000, -55.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[1], 0);

	JobSelectionTextdraw[2] = CreatePlayerTextDraw(playerid, 469.000000, 90.000000, "Drug Dealer - what class are they on");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[2], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[2], 2);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[2], 0.370000, 1.299999);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[2], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[2], 1);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[2], 1);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[2], 0);

	JobSelectionTextdraw[3] = CreatePlayerTextDraw(playerid, 272.000000, 223.000000, "wep");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[3], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[3], 5);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[3], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[3], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[3], 0);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[3], 1);
	PlayerTextDrawSetShadow(playerid, JobSelectionTextdraw[3], 1);
	PlayerTextDrawUseBox(playerid, JobSelectionTextdraw[3], 1);
	PlayerTextDrawBoxColor(playerid, JobSelectionTextdraw[3], -1);
	PlayerTextDrawTextSize(playerid, JobSelectionTextdraw[3], 74.000000, 63.000000);
	PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[3], 352);
	PlayerTextDrawSetPreviewRot(playerid, JobSelectionTextdraw[3], -16.000000, 0.000000, -55.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[3], 0);

	JobSelectionTextdraw[4] = CreatePlayerTextDraw(playerid, 346.000000, 223.000000, "wep");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[4], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[4], 5);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[4], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[4], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[4], 0);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[4], 1);
	PlayerTextDrawSetShadow(playerid, JobSelectionTextdraw[4], 1);
	PlayerTextDrawUseBox(playerid, JobSelectionTextdraw[4], 1);
	PlayerTextDrawBoxColor(playerid, JobSelectionTextdraw[4], -1);
	PlayerTextDrawTextSize(playerid, JobSelectionTextdraw[4], 74.000000, 63.000000);
	PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[4], 355);
	PlayerTextDrawSetPreviewRot(playerid, JobSelectionTextdraw[4], -16.000000, 0.000000, -55.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[4], 0);

	JobSelectionTextdraw[5] = CreatePlayerTextDraw(playerid, 420.000000, 223.000000, "wep");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[5], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[5], 5);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[5], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[5], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[5], 0);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[5], 1);
	PlayerTextDrawSetShadow(playerid, JobSelectionTextdraw[5], 1);
	PlayerTextDrawUseBox(playerid, JobSelectionTextdraw[5], 1);
	PlayerTextDrawBoxColor(playerid, JobSelectionTextdraw[5], -1);
	PlayerTextDrawTextSize(playerid, JobSelectionTextdraw[5], 74.000000, 63.000000);
	PlayerTextDrawSetPreviewModel(playerid, JobSelectionTextdraw[5], 349);
	PlayerTextDrawSetPreviewRot(playerid, JobSelectionTextdraw[5], -16.000000, 0.000000, -55.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[5], 0);

	JobSelectionTextdraw[6] = CreatePlayerTextDraw(playerid, 310.000000, 145.000000, "Drug Dealers spawn with a 9mm, uzi, ak47 and a shotgun.~n~They also spawn with 5 weed seeds and 100 grams of all ~n~drugs.");
	PlayerTextDrawBackgroundColor(playerid, JobSelectionTextdraw[6], 255);
	PlayerTextDrawFont(playerid, JobSelectionTextdraw[6], 2);
	PlayerTextDrawLetterSize(playerid, JobSelectionTextdraw[6], 0.189999, 1.100000);
	PlayerTextDrawColor(playerid, JobSelectionTextdraw[6], -1);
	PlayerTextDrawSetOutline(playerid, JobSelectionTextdraw[6], 1);
	PlayerTextDrawSetProportional(playerid, JobSelectionTextdraw[6], 1);
	PlayerTextDrawSetSelectable(playerid, JobSelectionTextdraw[6], 0);

	
	HotelRooms[playerid][0] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2243.1216,-1159.8878,1029.8043, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][1] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2239.1067,-1159.7394,1029.7969, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][2] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2239.0142,-1170.7346,1029.7969, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][3] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2225.5005,-1186.7206,1029.7969, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][4] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2209.5693,-1190.6279,1029.7969, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][5] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2194.9663,-1172.9978,1029.7969, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][6] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2191.3313,-1157.0275,1029.8043, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);
	HotelRooms[playerid][7] = CreateDynamic3DTextLabel("hotel room", COLOR_WHITE, 2195.2419,-1156.9309,1029.7969, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, 15, playerid, 100.0);


	new ip[16];
	GetPlayerIp(playerid, ip, 16);
	PlayerInfo[playerid][Pip] = ip;
	lastveh[playerid] = -1;
	Warns[playerid] = 0;
	LastPM[playerid] = -1;
	CurrentJobID[playerid] = -1;
	SweeperCash[playerid] = 0;
	SweeperWeight[playerid] = 0;
	Sweeped[playerid] = 0;
	Laser[playerid] = 0;
	Injections[playerid] = 0;
	PlayerInfo[playerid][Padmin] = 0;
	HasSpod[playerid] = false;
	CancelSelectTextDraw(playerid);
	Krose[playerid] = false;
	PlayerInfo[playerid][Padmin] = 0;
	LastCuffAttempt[playerid] = 0;
	SetPlayerColor(playerid, COLOR_GREY);
	Kdst[playerid] = false;
	Aindex[playerid] = 0;
	SetPlayerLangRoom(playerid, -1);
	Rap[playerid] = false;
	Rock[playerid] = false;
	PlayerRobberyID[playerid] = -1;
	City[playerid] = 0;
	WantedLevel[playerid] = 0;
	ItemBatch[playerid] = CreateProgressBar(283.0, 380.0, 100.0, 6.0, COLOR_GREEN, 100.0);
	ItemBarValue[playerid] = -1;
	ArmyGangZoneTimer[playerid] = 25;
	Time[playerid] = 0;
	PizzaRequestTime[playerid] = 0;
	RapeTime[playerid] = 0;
	RobTime[playerid] = 0;
	CheckingBan[playerid] = 0;
	TimeSinceSweep[playerid] = 0;
	StoreRobbing[playerid] = -1;
	BannedP[playerid]=0;
	House[playerid] =0;
	new Hours, Mins;
	PlayerInfo[playerid][BizID] = 1;
	InCriminalBase[playerid] = false;
	gettime(Hours, Mins);
	TimeOnline[playerid] = Hours;
	Minutes[playerid] = Mins;
	PlayerInfo[playerid][GroupID] = -1;
	RobberyTime[playerid] = 16;
	AFKSec[playerid] = 0;
	Hitter[playerid] = -1;
    ToggleRulesTextDraw(playerid);

    PlayerVariables[playerid] = PlayerVars:0;

	Rand = random(3);

	switch(Rand)
	{
	    case 1:
	    {
	        PlayAudioStreamForPlayer(playerid, "http://sf-cnr.co.uk/intro1.mp3");
		}
		case 2:
		{
		    PlayAudioStreamForPlayer(playerid, "http://sf-cnr.co.uk/intro2.mp3");
		}
		default:
		{
		    PlayAudioStreamForPlayer(playerid, "http://sf-cnr.co.uk/intro1.mp3");
		}
	}

	format(G_String, 128, "%s has joined San Fierro Cops And Robbers %s", PlayerName(playerid), SERVER_VERSION);
	IRC_GroupSay(BGroupID, IRC_CHANNEL, G_String);
	SendClientMessageToAll(COLOR_GREY, G_String);

	//Map icons.
	for(new i = 0;i <sizeof(MapIcons);i++) SetPlayerMapIcon(playerid, MapIcons[i][iconid], MapIcons[i][x], MapIcons[i][y], MapIcons[i][z], MapIcons[i][type], MapIcons[i][colour], MAPICON_LOCAL);


 	PlayerVariables[playerid] &= ~PLAYER_IN_BUSINESS;

 	for(new i = 0; i < MAX_VEHICLES; i++) {
 		PlayerStolenVeh[playerid][i] = -1;
 	}

 	new Query[300];
 	format(Query, 300, "SELECT `username`, `time`, `reason`, `admin`, `ip`, `id`, `issued`, `active` FROM `bans` WHERE `ip` = '%s'", ip);
 	mysql_function_query (Gconnection, Query, true, "OnBanChecked", "i", playerid);

	RemoveBuildingForPlayer(playerid, 1232, -2916.6172, 419.7344, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2880.3828, 419.7344, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, -2911.4219, 422.3516, 4.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, -2886.5859, 422.3516, 4.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2993.8125, 457.8672, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2938.4531, 457.5313, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2961.8906, 484.0156, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2916.8984, 506.8203, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2863.3438, 506.8203, 6.5000, 0.25);

	RemoveBuildingForPlayer(playerid, 10983, -2076.6484, 222.8516, 31.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 11143, -2076.6484, 222.8516, 31.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 11279, -2038.7500, 150.7109, 31.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 11339, -2079.9531, 159.2031, 30.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 11340, -2079.9531, 159.2031, 30.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 11387, -2038.7500, 150.7109, 31.1953, 0.25);


    building[0] = CreatePlayerObject(playerid,11340, -2079.95, 159.20, 30.87,    0.00, 0.00, 0.00, 500.0);
	building[1] = CreatePlayerObject(playerid,10983, -2076.65, 222.85, 31.22,   0.00, 0.00, 0.00, 500.0);
	SetPlayerObjectMaterial(playerid,building[0], 0, 10972, "groundbit_sfse", "desgreengrass", 0);
	SetPlayerObjectMaterial(playerid,building[1], 1, 10972, "groundbit_sfse", "desgreengrass", 0);

	building[2] = CreatePlayerObject(playerid,11387, -2038.75, 150.71, 31.20,   0.00, 0.00, 0.00, 500.0);
	SetPlayerObjectMaterial(playerid,building[2], 12, 3845, "boxhses_sfsx", "shingles1", 0);
	SetPlayerObjectMaterial(playerid,building[2], 0, 3845, "boxhses_sfsx", "shingles1", 0);
	SetPlayerObjectMaterial(playerid,building[2], 6, 11139, "firehouse_sfse", "ws_tunnelwall2", 0);
	SetPlayerObjectMaterial(playerid,building[2], 11, 5848, "mainlcawn", "fakestone1_LA", 0);


	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerConnect() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerConnect()", debug_String);

    #endif

	SendDebugMessage("OnPlayerConnect()", "OnPlayerConnect End");

	return 1;
}

//------------------------------------------------

public OnPlayerDisconnect(playerid, reason)
{

	SendDebugMessage("OnPlayerDisconnect()", "OnPlayerDisconnect Start");

	timing[0] = GetTickCount();

	LastPM[playerid] = -1;
	Warns[playerid] = 0;
	WantedLevel[playerid] = 0;
	Laser[playerid] = 0;
	Injections[playerid] = 0;
	RemovePlayerAttachedObject(playerid, 0);
	TextDrawHideForPlayer(playerid, URL);
	Hitter[playerid] = -1;
    new Query[300];

    switch(reason)//How did they leave?
	{
	    case 0: format(G_String, 128, "%s Has left the server. (Timeout)", PlayerName(playerid));
	    case 1: format(G_String, 128, "%s Has left the server. (Leaving)", PlayerName(playerid));
	    case 2: format(G_String, 128, "%s Has left the server. (Kicked/Banned)", PlayerName(playerid));
	}

	SendClientMessageToAll(COLOR_GREY, G_String);//Lets inform everyone

	for(new i = 0; i < MAX_SWEEPS; i++) {
		if(SweeperInfo[i][Player] == playerid) {
			DestroyDynamicMapIcon(SweeperInfo[i][MapIcon]);
			DestroyDynamicObject(SweeperInfo[i][Obj]);
		}
	}

	for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {

		RemovePlayerAttachedObject(playerid, i);
	}
	foreach(Player, i) {

	    if(Hitter[i] == playerid) {
	        Hitter[i] = -1;
	        Hit[i] = 0;
	        HitPrice[i] = -1;
	    }
	}

	if(PlayerVariables[playerid] & PLAYER_IS_REGISTERED) {

	    format(Query, 300, "UPDATE `users` SET `score`='%d', `admin`='%d', `money`='%d', `bank`=%d WHERE `username`='%s'", GetPlayerScore(playerid), PlayerInfo[playerid][Padmin], GetPlayerMoney(playerid), PlayerInfo[playerid][Pbank], PlayerName(playerid));
	    mysql_function_query (Gconnection, Query, false, "", "");
	}


	for(new i = 0; i < MAX_VEHICLES; i++)
	{
    	if(VehCreated[i] == true)
    	{
	   	 	if(!strcmp(VehicleInfo[i][Owner], PlayerName(playerid), false))
	        {
	            format(Query, 300, "UPDATE `vehicle` SET `x_pos`=%f, `y_pos`=%f, `z_pos`=%f, `rotation`=%f, `pannel_damage`=%d, `door_damage`=%d, `light_damage`=%d, `tire_damage`=%d, `vehicle_health`=%f, `color1`=%d, `color2`=%d WHERE `id`=%d", VehicleInfo[i][X_pos], VehicleInfo[i][Y_pos], VehicleInfo[i][Z_pos], VehicleInfo[i][Rotation],
	            VehicleInfo[i][PannelDamage], VehicleInfo[i][DoorDamage], VehicleInfo[i][LightDamage], VehicleInfo[i][TireDamage], VehicleInfo[i][VehicleHealth], VehicleInfo[i][Vcolor1], VehicleInfo[i][Vcolor2], i+1);
	            mysql_function_query (Gconnection, Query, false, "", "");

	            DestroyVehicle(VehicleInfo[i][VID]);
	            VehCreated[i] = false;
	        }
    	}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerDisconnect() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerDisconnect()", debug_String);

    #endif

    SendDebugMessage("OnPlayerDisconnect()", "OnPlayerDisconnect End");

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SendDebugMessage("OnPlayerDeath()", "OnPlayerDeath Start");

	timing[0] = GetTickCount();

    if(IsPlayerCivilianClass(playerid)) {//so he can see the dialogs again
	    gTeam[playerid] = CIVILIAN;
 	}
    SendDeathMessage(killerid, playerid, reason);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	PlayerVariables[playerid] &= ~PLAYER_RAPED;
    WantedLevel[playerid] = 0;
    SetPlayerWantedLevel(playerid, 0);
    StoreRobbing[playerid] = -1;
    RobberyTime[playerid] = 16;

   	if(killerid != INVALID_PLAYER_ID) {
   		if(IsPlayerCivilian(killerid)) {
	        WantedLevel[killerid]+=4;
			CallLocalFunction("OnPlayerCommitCrime", "iis", killerid, WantedLevel[killerid], "Killed a player", playerid);
	        format(G_String, 128, "[CRIME] %s has killed %s", PlayerName(killerid), PlayerName(playerid));
	        SendClientMessageToAll(COLOR_SKYBLUE, G_String);
	        format(G_String, 128, "[CRIME COMMITED] %s has murdered %s Location: %s Wanted Level: %d", PlayerName(killerid), PlayerName(playerid), PlayerZone(killerid), WantedLevel[killerid]);
	        SendMessageToLaw(COLOR_BLUE1, G_String);
        }


	    if(Hit[playerid] == 1) { // this player had a hit on his head
	        if(gTeam[killerid] == HITMAN) {//this player is a hitman
	            Hit[playerid] = 0;
	            GivePlayerMoney(killerid, HitPrice[playerid]);
	            GivePlayerMoney(Hitter[playerid], -HitPrice[playerid]);
	            SendClientMessage(playerid, COLOR_RED2, "[HIT] :{FFFFFF} You have been killed by a hitman, your hit is now off.");
	            SendClientMessage(killerid, COLOR_RED2, "[HIT] :{FFFFFF} You have killed a hit, the hit contract price has now been paid directly to you.");
	            SendClientMessage(Hitter[playerid], COLOR_RED2, "[HIT] :{FFFFFF} A hit contract you placed has been fulfilled and you have been charged the hit contract price.");
	            Hitter[playerid] = -1;
			}
		}

		if(!IsPlayerCivilian(killerid) && WantedLevel[playerid] >= 4) {
		    format(G_String, 128, "%s has killed %s with deadly force.", PlayerName(killerid), PlayerName(playerid));
		    SendClientMessageToAll(COLOR_GREEN, G_String);
		    SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
		    GivePlayerMoney(killerid, 250);
		    SendClientMessage(killerid, COLOR_GREEN, "You have taken down a criminal and earned yourself $250");
		}

	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerDeath() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerDeath()", debug_String);

    #endif

    SendDebugMessage("OnPlayerDeath()", "OnPlayerDeath End");

	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendDebugMessage("OnPlayerSpawn()", "OnPlayerSpawn Start");

	timing[0] = GetTickCount();

	SetPlayerInterior(playerid, 0);
   	PlayerTextDrawHide(playerid, Casual[playerid]);
   	SetCameraBehindPlayer(playerid);
   	StopAudioStreamForPlayer(playerid);
	TextDrawShowForPlayer(playerid, URL);
	SetPlayerTeam(playerid, 0);
	PlayerVariables[playerid] |= PLAYER_SPAWNED;
	PlayerVariables[playerid] &= ~PLAYER_IN_CLASS_SELECTION;

	GangZoneShowForPlayer(playerid, ArmyGangzone[0], 0x6300BF90);
	GangZoneShowForPlayer(playerid, ArmyGangzone[1], 0x6300BF90);
	GangZoneShowForPlayer(playerid, ArmyGangzone[2], 0x6300BF90);
	GangZoneShowForPlayer(playerid, ArmyGangzone[3], 0x6300BF90);
	GangZoneShowForPlayer(playerid, ArmyGangzone[4], 0x6300BF90);
	GangZoneShowForPlayer(playerid, ArmyGangzone[5], 0x6300BF90);
	GangZoneShowForPlayer(playerid, SwatGangzone, 0x21A6CF90);
	GangZoneShowForPlayer(playerid, StatGangzone, 0x4D4D4D90);

	if(ao[playerid][0][amodel] != -1) {

		for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
			SetPlayerAttachedObject(playerid, i, ao[playerid][i][amodel], ao[playerid][i][abone], ao[playerid][i][ax], ao[playerid][i][ay], ao[playerid][i][az], ao[playerid][i][arx], ao[playerid][i][ary], ao[playerid][i][arz], ao[playerid][i][asx], ao[playerid][i][asy], ao[playerid][i][asz]);
	}

	for(new i = 0; i < MAX_VEHICLES; i++) {
 		PlayerStolenVeh[playerid][i] = -1;
 	}

	switch(gTeam[playerid])
	{
	    case HITMAN:
	    {
	        switch(City[playerid])
	        {
	            case 0:
	            {
	            	printf("city 1");
			        Rand = random(sizeof(RandomSpawns));
			    	SetPlayerPos(playerid, RandomSpawns[Rand][0], RandomSpawns[Rand][1], RandomSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, RandomSpawns[Rand][3]);
				}
				case 1:
				{
					printf("city 2");
				    Rand = random(sizeof(LvSpawns));
				    SetPlayerPos(playerid, LvSpawns[Rand][0], LvSpawns[Rand][1], LvSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, LvSpawns[Rand][3]);
				}
			}
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
 			GivePlayerWeapon(playerid, 31, 500);
 			SetPlayerTeam(playerid, NO_TEAM);
		}
		case CIVILIAN || TERRORIST:
		{
		    switch(City[playerid])
	        {
	            case 0:
	            {
	            	printf("city 1");
			        Rand = random(sizeof(RandomSpawns));
			    	SetPlayerPos(playerid, RandomSpawns[Rand][0], RandomSpawns[Rand][1], RandomSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, RandomSpawns[Rand][3]);
				}
				case 1:
				{
					printf("city 2");
				    Rand = random(sizeof(LvSpawns));
				    SetPlayerPos(playerid, LvSpawns[Rand][0], LvSpawns[Rand][1], LvSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, LvSpawns[Rand][3]);
				}
			}
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	ShowPlayerDialog(playerid, DIALOG_CLASS, DIALOG_STYLE_LIST, "Choose your class", "Drug Dealer\nPedo\nGun merchant\nThief\nItems dealer\nRapist\nKidnapper\nTerrorist\nCar Jacker\nWhore", "select", "cancel");
		}
		case ARMY:
		{
			SetPlayerColor(playerid, COLOR_PURPLE);
			GivePlayerWeapon(playerid, 24, 500);
 			GivePlayerWeapon(playerid, 31, 500);
		}
		case STAT:
		{
		    Rand = random(sizeof(StatSpawns));
	    	SetPlayerPos(playerid, StatSpawns[Rand][0], StatSpawns[Rand][1], StatSpawns[Rand][2]);
	    	SetPlayerFacingAngle(playerid, StatSpawns[Rand][3]);
	    	SetPlayerColor(playerid, COLOR_BLACK);
    		GivePlayerWeapon(playerid, 24, 500);
 			GivePlayerWeapon(playerid, 31, 500);
	    }
	    case POLICE:
		{
	 		SetPlayerColor(playerid, COLOR_BLUE1);
	 		GivePlayerWeapon(playerid, 3, 1);
	 		GivePlayerWeapon(playerid, 22, 500);
		}
	    case RAPIST: SetPlayerColor(playerid, COLOR_WHITE);
	    case MECHANIC:
		{
	 		SetPlayerColor(playerid, COLOR_WHITE);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
		}
	    case MEDIC:
		{
	 		SetPlayerColor(playerid, COLOR_PINK);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
 			Injections[playerid] = 10;
		}
	    case DRUG: SetPlayerColor(playerid, COLOR_WHITE);
	    case ROB: SetPlayerColor(playerid, COLOR_WHITE);
	    case WEP: SetPlayerColor(playerid, COLOR_WHITE);
	    case ITEMS: SetPlayerColor(playerid, COLOR_WHITE);
	    case KIDNAPPER: SetPlayerColor(playerid, COLOR_WHITE);
	    case PEDO: SetPlayerColor(playerid, COLOR_WHITE);
	    case TRUCKER:
		{
	 		SetPlayerColor(playerid, COLOR_GREEN);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
		}
	    case TAXI:
		{
	 		SetPlayerColor(playerid, COLOR_WHITE);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
		}
	    case SWAT:
		{
	 		SetPlayerColor(playerid, COLOR_LIGHTBLUE);
	 		GivePlayerWeapon(playerid, 24, 500);
 			GivePlayerWeapon(playerid, 31, 500);
		}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerSpawn() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerSpawn()", debug_String);

    #endif

	SendDebugMessage("OnPlayerSpawn()", "OnPlayerSpawn End");

	return 1;
}

public OnPlayerUpdate(playerid)
{
	AFK[playerid] = gettime();
	/*new Float:poso[3];
	GetPlayerPos(playerid, poso[0], poso[1], poso[2]);
	SetObjectPos(iArrowObject, poso[0], poso[1], poso[2]+4);
	SetObjectFaceCoords3D(iArrowObject, 999.0, 1086.75, 11.0, 0.0, 180.0, 90.0);*/

	
	return 1;
}