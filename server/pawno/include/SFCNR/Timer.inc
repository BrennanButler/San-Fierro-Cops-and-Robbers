public ServerCoreTimer()
{
	SendDebugMessage("ServerCoreTimer()", "ServerCoreTimer Start");

	timing[0] = GetTickCount();

    new Float:VHealth;
	for(new i = 0; i < MAX_VEHICLES; i++) {

	 	if(VehicleDestroy[i] == true) {
	 	    GetVehicleHealth(i, VHealth);
	 	    SetVehicleHealth(i, VHealth - 100);

	 	    if(VHealth < 400)
                VehicleDestroy[i] = false;
	 	}
	}
	for(new i = 0; i < MAX_WEED; i++) {

	    if(WeedInfo[i][Burnt] == true && gettime() - WeedInfo[i][burnttime] >= 30) {
	    	format(WeedInfo[i][Owner], 24, "NULL");
	        DestroyDynamicObject(WeedInfo[i][WeedObject]);
	        DestroyDynamic3DTextLabel(WeedInfo[i][WeedLabel]);
	    }
	}

	for(new i = 0; i < MAX_CENTERID; i++) {

		for(new f = 0; f < MAX_FIRES; f++) {

			if(FireInfo[f][centerid] == i && (gettime() - FireInfo[f][Ftime]) >= 600) {
				DestroyDynamicObject(FireInfo[f][object]);
				FireInfo[f][Ftime] = 0;
				FireInfo[f][centerid] = -1;
				CenterCreated[i] = false;
				FireCreated[f] = false;
				DestroyDynamicArea(f);

			}

		}
		
	}

	/*for(new i = 0; i < MAX_OBJECTS; i++)
	{
		if(IsValidDynamicObject(i) && IsACow[i] == true)
		{
			if((gettime() - gCowLastMove[i]) >= 180) 
			{
				printf("Called");
				PutCowOnNextNode(i);
				gCowLastMove[i] = gettime();
			}
		}
	}*/
	
	foreach(Player, i) {

		if(IsPlayerCivilian(i) && !(PlayerVariables[i] & PLAYER_IN_CLASS_SELECTION) && PlayerVariables[i] & PLAYER_SPAWNED) {
			if(IsPlayerInArea(i, -1686, 258, -1440, 354) || IsPlayerInArea(i, -1620, 258, -1314, 414) || IsPlayerInArea(i, -1518, 360, -1200, 522) || IsPlayerInArea(i, -1620,282,-1494,420) || IsPlayerInArea(i, -1560,306,-1398,480) || IsPlayerInArea(i, -1548,384,-1380,528)) {
		    	if(WantedLevel[i] == 0) {
			    	ArmyGangZoneTimer[i]--;
			    	format(G_String, 128, "~r~In restricted area!~w~~n~%d seconds to get out!", ArmyGangZoneTimer[i]);
			   	 	GameTextForPlayer(i, G_String, 1500, 4);
			    	if(ArmyGangZoneTimer[i] == 0) {
				    	ArmyGangZoneTimer[i] = 25;
				    	SetPlayerWantedLevel(i, 6);
				    	WantedLevel[i] = 6;
				    	CallLocalFunction("OnPlayerCommitCrime", "iis", i, WantedLevel[i], "Restricted area", -1);
				   	 	SendClientMessage(i, COLOR_RED2, "[CRIME] :{FFFFFF} You have stayed in a restricted area for too long and have gained a wanted level of 6.");
				   	}
				}
		    }
		}
		if(InCriminalBase[i] && GetPlayerInterior(i) == 0) {
			if(IsPlayerInRangeOfPoint(i, 10.0, -1508.8900,2608.7500,55.8359)) {
				SetPlayerPos(i, -2086.8035,70.3976,35.2727);
				InCriminalBase[i] = false;
				SetPlayerVirtualWorld(i, 0);
			}
		}

		printf("item bar = %d", ItemBarValue[i]);
		if(ItemBarValue[i] != -1) {
			printf("item bar in scope1");
			SetProgressBarValue(ItemBatch[i], ItemBarValue[i]);
			ShowProgressBarForPlayer(i, ItemBatch[i]);
			ItemBarValue[i]+=10;

			if(ItemBarValue[i] >= 100.0) {
				printf("item bar in scope2");
				if(JobStatus[i] == 1) {
					printf("item bar in scope3");
					SendClientMessage(i, COLOR_GREEN, "[ALERT] :{FFFFFF} You have the items, now deliver them.");
					DestroyDynamicCP(JobCheckpoint[i]);
					JobStatus[i] = 2;
					TogglePlayerControllable(i, 1);
					JobIcon[i] = SetPlayerMapIcon(i, 54, PilotJobs[CurrentJobID[i]][ToX], PilotJobs[CurrentJobID[i]][ToY], PilotJobs[CurrentJobID[i]][ToZ], 0, COLOR_YELLOW, MAPICON_GLOBAL);
					JobCheckpoint[i] = CreateDynamicCP(PilotJobs[CurrentJobID[i]][ToX], PilotJobs[CurrentJobID[i]][ToY], PilotJobs[CurrentJobID[i]][ToZ], 7.0, -1, -1, i, 100.0);
					ItemBarValue[i] = -1;
					HideProgressBarForPlayer(i, ItemBatch[i]);
				} else if(JobStatus[i] == 2) {
					printf("item bar in scope4");
					SendClientMessage(i, COLOR_GREEN, "[ALERT] :{FFFFFF} You have successfully unloaded your items. Thank you for the delivery.");
			    	GivePlayerMoney(i, PilotJobs[CurrentJobID[i]][Payment]);
			    	DestroyDynamicCP(JobCheckpoint[i]);
			    	RemovePlayerMapIcon(i, 54);
			    	TogglePlayerControllable(i, 1);
			    	PlayerTextDrawHide(i, JobTextdraw[i]);
			    	ItemBarValue[i] = -1;
			    	HideProgressBarForPlayer(i, ItemBatch[i]);
			    	format(G_String, 128, "~g~Earned $%d!", PilotJobs[CurrentJobID[i]][Payment]);
			    	GameTextForPlayer(i, G_String, 4000, 4);
			    	PlayerVariables[i] &= ~PLAYER_IN_JOB;
				}
			}
		}

		for(new f = 0; f < MAX_FIRES; f++) {
			if(IsValidDynamicObject(FireInfo[f][object])) {
				new Float:HP;
				GetPlayerHealth(i, HP);
				if(IsPlayerInRangeOfPoint(i, 4.0, FireInfo[f][pos1], FireInfo[f][pos2], FireInfo[f][pos3]) && HP >= 1 && PlayerVariables[i] & PLAYER_SPAWNED) {
						SetPlayerHealth(i, HP - 8);
				}
			}
		}
		

		if((gettime() - JobTime[i][gTeam[i]]) > 60 * 10) {
			CallLocalFunction("OnPlayerRecieveJobWage", "iii", i, gTeam[i], JobWage[gTeam[i]]);
		}

		if(PlayerVariables[i] & PLAYER_REQUESTED_PIZZA) {

			if((gettime() - PizzaRequestTime[i]) > 60 * 5) {
				PlayerVariables[i] &= ~PLAYER_REQUESTED_PIZZA;
			}
		}

		if((gettime() - RequestedDriverCoolDown[i]) > 60 * 2) 
			if(!(PlayerVariables[i] & PLAYER_HAS_PRIVATE_DRIVER)) RequestedDriver[i] = -1;
		if(PlayerVariables[i] & PLAYER_BANNED) {

			new Query[300];
			format(Query, 300, "INSERT INTO `bans` (`username`, `time`, `reason`, `admin`, `ip`, `id`, `issued`, `active`) VALUES('%s', '%s', '%s', '%s', '%s', NULL, '%s', '1')", PlayerName(i), BanInfo[i][UnbanDate], BanInfo[i][BanReason], BanInfo[i][BanAdmin], BanInfo[i][BanIP], BanInfo[i][issued]);
			mysql_function_query (Gconnection, Query, false, "OnPlayerBanned", "i", i);
			GameTextForPlayer(i, "~r~Banned", 1000*5, 0);
			new string[4][128];
			format(string[0], 128, "UNBAN DATE\t: {FFFFFF}%s", BanInfo[i][UnbanDate]);
			format(string[1], 128, "BAN REASON\t: {FFFFFF}%s", BanInfo[i][BanReason]);
			format(string[2], 128, "BAN ADMIN\t: {FFFFFF}%s", BanInfo[i][BanAdmin]);
			format(string[3], 128, "BAN ISSUED\t: {FFFFFF}%s", BanInfo[i][issued]);

			SendClientMessage(i, COLOR_RED2, string[0]);
			SendClientMessage(i, COLOR_RED2, string[1]);
			SendClientMessage(i, COLOR_RED2, string[2]);
			SendClientMessage(i, COLOR_RED2, string[3]);
			
		}
		
		//anticheat

		if(IsPlayerInAnyVehicle(i)) {

			if(GetVehicleModel(GetPlayerVehicleID(i)) == 520 || GetVehicleModel(GetPlayerVehicleID(i)) == 592 || GetVehicleModel(GetPlayerVehicleID(i)) == 476 || GetVehicleModel(GetPlayerVehicleID(i)) == 519 || GetVehicleModel(GetPlayerVehicleID(i)) == 577 || GetVehicleModel(GetPlayerVehicleID(i)) == 553) {
				if(GetVehicleSpeed(GetPlayerVehicleID(i)) >= 208) {
					new day, month, year, ip[16];
					GetPlayerIp(i, ip, 16);
					getdate(year, month, day);
					format(BanInfo[i][issued], 50, "%02d/%02d/%d", day, month, year);
					format(BanInfo[i][BanReason], 50, "Speed Hacks");
					format(BanInfo[i][UnbanDate], 50, "Never");
					format(BanInfo[i][BanAdmin], 24, "Anti Cheat");
					format(BanInfo[i][BanIP], 24, ip);
					PlayerVariables[i] |= PLAYER_BANNED;	
				}
			} else {
				if(GetVehicleSpeed(GetPlayerVehicleID(i)) >= 180) {
					new day, month, year, ip[16];
					GetPlayerIp(i, ip, 16);
					getdate(year, month, day);
					format(BanInfo[i][issued], 50, "%02d/%02d/%d", day, month, year);
					format(BanInfo[i][BanReason], 50, "Speed Hacks");
					format(BanInfo[i][UnbanDate], 50, "Never");
					format(BanInfo[i][BanAdmin], 24, "Anti Cheat");
					format(BanInfo[i][BanIP], 24, ip);
					PlayerVariables[i] |= PLAYER_BANNED;	
				}
			}
		}
		
		

		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK && PlayerInfo[i][Padmin] < ADMIN) {
			new day, month, year, ip[16];
			GetPlayerIp(i, ip, 16);
			getdate(year, month, day);
			format(BanInfo[i][issued], 50, "%02d/%02d/%d", day, month, year);
			format(BanInfo[i][BanReason], 50, "Jetpack hacking");
			format(BanInfo[i][UnbanDate], 50, "Never");
			format(BanInfo[i][BanAdmin], 24, "Anti Cheat");
			format(BanInfo[i][BanIP], 24, ip);
			PlayerVariables[i] |= PLAYER_BANNED;
		}
		
		
		for(new w =0; w < MAX_WEED; w++) {
		    if(IsPlayerInRangeOfPoint(i, 5.0, WeedInfo[w][Xpos], WeedInfo[w][Ypos], WeedInfo[w][Zpos]) && WeedInfo[w][Burnt] == true) {
		        SetPlayerDrunkLevel(i, GetPlayerDrunkLevel(i)+500);
		    }

		    if(WeedInfo[w][HHour] >= Hour && WeedInfo[w][HMin] >= Minute) {
		        WeedInfo[w][ForHarvest] = true;
		    }
		}
		

		if(IsPlayerInAnyVehicle(i)) {

			for(new v = 0; v < MAX_VEHICLES; v++)
			{
			    if(VehicleInfo[v][VID] == GetPlayerVehicleID(i)) {
			        if(!strcmp(VehicleInfo[v][Owner], PlayerName(i), false)) {
			            new Float:VPOS[4];
						new Float:VehHealth;
			            GetVehiclePos(GetPlayerVehicleID(i), VPOS[0], VPOS[1], VPOS[2]);
			            GetVehicleZAngle(GetPlayerVehicleID(i), VPOS[3]);
						VehicleInfo[v][X_pos] = VPOS[0];
						VehicleInfo[v][Y_pos] = VPOS[1];
						VehicleInfo[v][Z_pos] = VPOS[2];
						VehicleInfo[v][Rotation] = VPOS[3];
						GetVehicleHealth(GetPlayerVehicleID(i), VehHealth);
						VehicleInfo[v][VehicleHealth] = VehHealth;
						printf("VHealth = %f", VHealth);
						new panels,door,lvghts,tvres;
						GetVehicleDamageStatus(GetPlayerVehicleID(i),panels,door,lvghts,tvres);
						VehicleInfo[v][PannelDamage] = panels;
						VehicleInfo[v][DoorDamage] = door;
						VehicleInfo[v][LightDamage] = lvghts;
						VehicleInfo[v][TireDamage] = tvres;
			        }
			    }
			}
		}

		if(PlayerVariables[i] & PLAYER_HAS_VEHICLE_ARMOUR) {
		    SetVehicleHealth(GetPlayerVehicleID(i), 1000.0);
		    RepairVehicle(GetPlayerVehicleID(i));
		    VBulletArmourTime[i] --;

		    if(VBulletArmourTime[i] <= 0) {
		        PlayerVariables[i] &= ~PLAYER_HAS_VEHICLE_ARMOUR;
		    }
		}
		

		if(TaxiDriver[i] != -1) { // is in a taxi
		    new rate = PlayerInfo[TaxiDriver[i]][Ptaxirate];//get the rate per-second
			if(GetPlayerMoney(i) < rate) { // Player no longer has enough money
			    SendClientMessage(TaxiDriver[i], COLOR_RED2, "[TAXI] :{FFFFFF} A player using your services no longer has enough cash to pay for them and has been ejected."); //inform the taxi driver
			    TaxiDriver[i] = -1; //the player is no longer in a taxi and no longer charged
			    RemovePlayerFromVehicle(i);//remove him
			} else {
				//the player has enough cash
				GivePlayerMoney(i, -rate); //charge the player the rate
			}
		}
		

		//remove the laser if the player has changed to a civilian
		if(Laser[i] == 1) {
		    if(gTeam[i] != STAT && gTeam[i] != SWAT && gTeam[i] != ARMY)
		        Laser[i] = 0;
	 	}
	 	
	 	if((gettime() - TimeMessages) > 60 * 5) {

			SendClientMessageToAll(COLOR_COOLBLUE, RandomMessages[MessageIndex]);
			TimeMessages = gettime();
			MessageIndex++;
			if(MessageIndex > 20) {
				MessageIndex = 0;
			}
	 	}
	 	
		if(PlayerVariables[i] & PLAYER_RAPED) {

			new Float:health = 1.3;
			new Float:current;
			GetPlayerHealth(i, current);

			SetPlayerHealth(i, current - health  + 1);
		}
		
		if(IsPlayerInAnyVehicle(i)) {
		    new Float:pos[3];
		    GetVehiclePos(GetPlayerVehicleID(i), pos[0], pos[1], pos[2]);
			for(new s = 0; s < MAX_SPIKES; s++) {
			    if(IsPointInRangeOfPoint(SpikeInfo[s][SpikeX], SpikeInfo[s][SpikeY], SpikeInfo[s][SpikeZ], pos[0], pos[1], pos[2], 10.0)) {
			        new panels, door, lights, tires;
					GetVehicleDamageStatus(GetPlayerVehicleID(i), panels, door, lights, tires);
					UpdateVehicleDamageStatus(GetPlayerVehicleID(i), panels, door, lights, 15);
			    }
			}
		}
		
		if(gettime() - AFK[i] >= 1) {
		    AFKSec[i]++;
		    format(G_String, 128, "%s is AFK for\n%d seconds", PlayerName(i), AFKSec[i]);
	    	SetPlayerChatBubble(i, G_String, -1, 10, 10000);
	 	} else {
	 	    AFKSec[i] = 0;
	 	}

	 	
		if(PlayerVariables[i] & PLAYER_IN_JAIL) {

		    if(PlayerInfo[i][PrisonTime] != 0) {

			    PlayerInfo[i][PrisonTime]--;
				new pstring[128];
				format(pstring, 128, "Time Left: %d Seconds", PlayerInfo[i][PrisonTime]);
			    PlayerTextDrawSetString(i, PlayerText:PrisonTextdraw[i], pstring);
		    	PlayerTextDrawShow(i, PlayerText:PrisonTextdraw[i]);

			} else {

			    CallLocalFunction("OnPlayerSpawn", "d", i);
			    SpawnPlayer(i);
	            PlayerVariables[i] &= ~PLAYER_IN_JAIL;
			    PlayerTextDrawHide(i, PlayerText:PrisonTextdraw[i]);

			}
		}
		

		if(PlayerVariables[i] & PLAYER_KICKED || PlayerVariables[i] & PLAYER_BANNED) {
		    Kick(i);
		}
		
		if(PlayerVariables[i] & PLAYER_SPAWNED && !(PlayerVariables[i] & PLAYER_IN_MOVIE_MODE)) {
			PlayerTextDrawSetString(i, PlayerText:Zone[i], PlayerZone(i));
	    	PlayerTextDrawShow(i, PlayerText:Zone[i]);
		}
		
		if(IsPlayerInArea(i, -2976.5625,-2976.5625,-1570.3125,2988.28125) || IsPlayerInArea(i, -2062.5,-1078.125,-1148.4375,1523.4375) || IsPlayerInArea(i, -1265.625,-3023.4375,-761.71875,492.1875))
		    City[i] = 0;
		else if(IsPlayerInArea(i, -1347.65625,1863.28125,1945.3125,2964.84375) || IsPlayerInArea(i, -1113.28125,550.78125,2929.6875,2976.5625))
		    City[i] = 1;
		else
	        City[i] = 2;
	    
	    if(PlayerVariables[i] & PLAYER_REQUESTED_WEAPONS) {
	        RequestWepCooldown[i]--;
	        if(RequestWepCooldown[i] == 0) {
	            PlayerVariables[i] &= ~PLAYER_REQUESTED_WEAPONS;
	            RequestWepCooldown[i] = 30;
	        }
	    }
	   
	    if(PlayerVariables[i] & PLAYER_REQUESTED_ITEMS) {
	        RequestItemCooldown[i]--;
	        if(RequestItemCooldown[i] == 0) {
	            PlayerVariables[i] &= ~PLAYER_REQUESTED_ITEMS;
	            RequestItemCooldown[i] = 30;
	        }
	    }
	    
	    if(StoreRobbing[i] != -1) { //currently robbing a store
	        if(RobberyTime[i] > 0) {//still robbing
	            RobberyTime[i]--;
	            format(G_String, 128, "Attempting robbery stay in the ~r~checkpoint!~n~~w~Time Left: %d", RobberyTime[i]);
	            PlayerTextDrawSetString(i, RobberyText[i], G_String);
	            PlayerTextDrawShow(i, RobberyText[i]);

	        } else {//finished robbery


				//lets see if they failed or succeeded

				if(gTeam[i] == ROB)//if the player is a robber, he has a better chance in robbing
					Rand = random(2);// 1/2 chance to fail

				if(gTeam[i] != ROB)//the player is NOT a robber, he has a worse chance in robbing
					Rand = random(3);

				if(Rand == 1 || Rand == 0) {//they robbed

					PlayerTextDrawHide(i, RobberyText[i]);//go away textdraw
					RobberyTime[i] = 16;
					StoreTimeRobbed[StoreRobbing[i]] = gettime();
					StoreRobbed[StoreRobbing[i]] = true;
					StoreRobbing[i] = -1;
					Rand = randomEx(100, 400);
					format(G_String, 128, "~g~Robbery completed!~n~$%d robbed", Rand);
					GivePlayerMoney(i, Rand);
					SetPlayerScore(i, GetPlayerScore(i)+1);
	        		GameTextForPlayer(i, G_String, 3000, 4);
	        		WantedLevel[i]+=4;
	        		CallLocalFunction("OnPlayerCommitCrime", "iis", i, WantedLevel[i], "Robbed a store", -1);
				} else if(Rand != 1) {//they failed
					WantedLevel[i]+=4;
					RobberyTime[i] = 16;
					PlayerTextDrawHide(i, RobberyText[i]);//go away textdraw
					StoreRobbed[StoreRobbing[i]] = true;
					StoreTimeRobbed[StoreRobbing[i]] = gettime();
					StoreRobbing[i] = -1;
					CallLocalFunction("OnPlayerCommitCrime", "iis", i, WantedLevel[i], "Attempted robbery", -1);
					GameTextForPlayer(i, "~r~Robbery failed!", 3000, 4);
					SendClientMessage(i, COLOR_ORANGE, "You have failed this robbery!");
				}
	        }
	    }
	    

	    for(new s = 0; s < MAX_STORES; s++) {

	    	if(StoreRobbed[s]) {

		    	if((gettime() - StoreTimeRobbed[s]) > 200) {
		    		StoreRobbed[s] = false;
		    	}
		    }
	    }
	    

	    //army gate
	    if(gTeam[i] == ARMY) {

			if(IsPlayerInRangeOfPoint(i, 20, -1536.9000244, 482.2000122, 6.1999998)) {
				MoveDynamicObject(ArmyGate, -1536.9000244,482.2000122,-1.0000000, 2);
			} else {
				MoveDynamicObject(ArmyGate, -1536.9000244, 482.2000122, 6.1999998, 2);
			}
		}
		

		if(Laser[i] == 1)
		{
		    switch(GetPlayerWeapon(i))
			{
				case 23:
				{
				    if(IsPlayerAiming(i))
				    {
				        if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
				        {
				            SetPlayerAttachedObject(i, 0, 18643, 6, 0.108249, 0.030232, 0.118051, 1.468254, 350.512573, 364.284240);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.108249, 0.030232, 0.118051, 1.468254, 349.862579, 364.784240);
						}
					}
					else
					{
					    if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
					    {
					        SetPlayerAttachedObject(i, 0, 18643, 6, 0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
						}
					}
				}
				case 27:
				{
				    if(IsPlayerAiming(i))
				    {
				        if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
				        {
				            SetPlayerAttachedObject(i, 0, 18643, 6,0.588246, -0.022766, 0.138052, -11.531745, 347.712585, 352.784271);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.588246, -0.022766, 0.138052, 1.468254, 350.712585, 352.784271);
						}
					}
					else
					{
					    if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
					    {
	       					SetPlayerAttachedObject(i, 0, 18643, 6, 0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
						}
					}
				}
				case 30:
				{
				    if(IsPlayerAiming(i))
				    {
				        if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
				        {
				            SetPlayerAttachedObject(i, 0, 18643, 6, 0.628249, -0.027766, 0.078052, -6.621746, 352.552642, 355.084289);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.628249, -0.027766, 0.078052, -1.621746, 356.202667, 355.084289);
						}
					}
					else
					{
					    if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
					    {
					        SetPlayerAttachedObject(i, 0, 18643, 6, 0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
						}
					}
				}
				case 31:
				{
				    if(IsPlayerAiming(i))
				    {
				        if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
				        {
				            SetPlayerAttachedObject(i, 0, 18643, 6, 0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
						}
					}
					else
					{
					    if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
					    {
					        SetPlayerAttachedObject(i, 0, 18643, 6, 0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
						}
					}
				}
				case 29:
				{
				    if(IsPlayerAiming(i))
				    {
				        if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
				        {
				            SetPlayerAttachedObject(i, 0, 18643, 6, 0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
						}
					}
					else
					{
					    if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_DUCK)
					    {
					         SetPlayerAttachedObject(i, 0, 18643, 6, 0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
						}
						else
						{
						    SetPlayerAttachedObject(i, 0, 18643, 6, 0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
						}
					}
				}
		 		default:
				{
				    RemovePlayerAttachedObject(i, 0);
				}
			}
		}
		
		if((PlayerVariables[i] & PLAYER_IN_JOB) && GetVehicleModel(GetPlayerVehicleID(i)) == 574) {
			new Float:pos[3];
	    	GetVehiclePos(GetPlayerVehicleID(i), pos[0], pos[1], pos[2]);
	    	if(Sweeped[i] == TotalSweeps) {
				
				ShowJobTextdraw(i, "Press ~g~CAPSLOCK ~w~to start the sweeper job");
				format(G_String, 128, "[ALERT] :{FFFFFF} You have finished your job and earned $%d!", SweeperCash[i]);
				SendClientMessage(i, COLOR_GREEN, G_String);
				GivePlayerMoney(i, SweeperCash[i]);
				SetPlayerScore(i, GetPlayerScore(i)+TotalSweeps);
				format(G_String, 128, "~g~$%d Earned!", SweeperCash[i]);
				GameTextForPlayer(i, G_String, 3000, 4);
				SweeperCash[i] = 0;
				SweeperWeight[i] = 0;
				Sweeped[i] = 0;
				TimeSinceSweep[i] = gettime();
				PlayerVariables[i] &= ~PLAYER_IN_JOB;
			}
			
			for(new j = 0; j < MAX_SWEEPS; j++) {

				
				new Float:weight = SweeperInfo[j][Weight];
				new payment = (weight > 9 && weight <= 50) ? 100 : ((weight > 50 && weight <= 100) ? 150 : ((weight > 100 && weight <= 150) ? 200 : ((weight > 150 && weight <= 200) ? 250 : 0)));
				if(IsPointInRangeOfPoint(SweeperInfo[j][Xpos], SweeperInfo[j][Ypos], SweeperInfo[j][Zpos], pos[0], pos[1], pos[2]-0.75, 3.0) && IsValidDynamicObject(SweeperInfo[j][Obj])) {
					
					Sweeped[i]++;
					DestroyDynamicMapIcon(SweeperInfo[j][MapIcon]);
					DestroyDynamicObject(SweeperInfo[j][Obj]);
					SweeperCash[i] += payment;
					SweeperWeight[i] += SweeperInfo[j][Weight];
					format(G_String, 128, "You have picked up %d KG worth a total of $%d!", floatround(SweeperInfo[j][Weight]), payment);
					SendClientMessage(i, COLOR_GREEN, G_String);
					break;

				}
			}
			
		}
	}
	
	#if defined __DEBUG
   
    format(debug_String, 128, "ServerCoreTimer() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("ServerCoreTimer()", debug_String);

    #endif

    SendDebugMessage("ServerCoreTimer()", "ServerCoreTimer End");

	return 1;
}

public timeupdate()
{
	Minute += 01;
	if(Minute == 60 && Hour < 24) {
		Hour += 01, Minute = 00;
		Rand = random(18);
		SetWeather(Rand);
	}
 	if(Hour == 24 && Minute == 00) Hour = 00, Minute = 00;
 	if(Hour < 10 && Minute < 10) format(timestring,sizeof(timestring),"0%i:0%i",Hour,Minute);
 	if(Hour < 10 && Minute > 9) format(timestring,sizeof(timestring),"0%i:%i",Hour,Minute);
 	if(Hour > 9 && Minute < 10) format(timestring,sizeof(timestring),"%i:0%i",Hour,Minute);
 	else if(Hour > 9 && Minute > 9) format(timestring,sizeof(timestring),"%i:%i",Hour,Minute);
 	TextDrawSetString(timetext,timestring);
 	SetWorldTime(Hour);

 	for(new i = 0; i != MAX_PLAYERS;++i)
 	{
 		SetPlayerTime(i,Hour,Minute);
 		if(!(PlayerVariables[i] & PLAYER_IN_MOVIE_MODE))
 		{	
 			TextDrawShowForPlayer(i, timetext);
 		}
 	  	
 	}


}