public OnRconLoginAttempt(ip[], password[], success)
{
	if(success) { // They have logged in.
	    PlayerInfo[PlayeridFromIP(ip)][Padmin] = SENIOR_ADMIN; // Lets make them senior admin as they already
	                                                // Have access to rcon.
	} else { // They failed.
	    printf("Attempt at rcon using password: %s\nIP: %s\nName: %s", password, ip, PlayerName(PlayeridFromIP(ip)));//Log it.
	}
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	SendDebugMessage("OnVehicleRespray()", "OnVehicleRespray Start");

	timing[0] = GetTickCount();

	if(WantedLevel[playerid] > 0) {
	    if(ResprayWanted[playerid] != 1) {
	        for(new i = 0; i < MAX_PLAYERS; i++) {
	            if(!IsPlayerCivilian(i)) {
	                if(!IsPlayerInRangeOfPlayer(i, playerid, 150)) {
	                    WantedLevel[playerid]--;
	                    SetPlayerWantedLevel(playerid, WantedLevel[playerid]);
	                    ResprayWanted[playerid] = 1;
					}
				}
	        }
		}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnVehicleRespray() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnVehicleRespray()", debug_String);

    #endif

	SendDebugMessage("OnVehicleRespray()", "OnVehicleRespray End");

	return 1;
}


//------------------------------------------------





public OnVehicleDeath(vehicleid, killerid)
{
	SendDebugMessage("OnVehicleDeath()", "OnVehicleDeath Start");

	timing[0] = GetTickCount();

	if(CreatedVehicle[vehicleid] == true) {

	    DestroyVehicle(vehicleid);
	    CreatedVehicle[vehicleid] = false;

	} else {
		new Float:pos[3];
		GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
		if(!IsPointInRangeOfPoint(pos[0], pos[1], pos[2], pos[0], pos[1], -0.0974, 15.0)) {
			if(CreateVehicleFire(vehicleid, randomEx(10, 20))) {
				
				format(G_String, 128, "[FIRE] :{FFFFFF} there is a vehicle fire at %s! Dispatch and put out the fire", Location(pos[0], pos[1]));
				SendMessageToClass(FIREFIGHTER, COLOR_FIRE, G_String);
			}
		}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnVehicleDeath() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnVehicleDeath()", debug_String);

    #endif

	SendDebugMessage("OnVehicleDeath()", "OnVehicleDeath End");

	return 1;
}






public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	SendDebugMessage("OnDialogResponse()", "OnDialogResponse Start");

	timing[0] = GetTickCount();

	switch(dialogid)
	{
	    //register dialog
	    case DIALOG_REGISTER:
		{
		    if(!response) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are not registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");
			Mysql_Register(playerid, inputtext);
		}
	    //login dialog
	    case DIALOG_LOGIN:
		{
		    if(!response) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");
			new Query[200];
			format(Query, 200, "SELECT `salt` FROM `users` WHERE `username`='%s'", PlayerName(playerid));
			mysql_function_query (Gconnection, Query, true, "Mysql_Login", "ds",  playerid, inputtext);
		}
	    //all commands dialog
	    case DIALOG_CMDS:
	    {
	        if(PlayerInfo[playerid][Padmin] >= MOD) {
				switch(listitem)
				{

				    case 0:
					{
					    switch(gTeam[playerid])
					    {
					        case HITMAN:
					        {
					        	ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Hitman", "{FFFFFF}/hits - See what players have a hit on their head and for how much money", "Ok", "Close");
					        }
					        case TERRORIST:
					        {
					            new string[350], temp[100];
								for(new i = 0; i < sizeof(TerroristCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", TerroristCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Terrorist", string, "Ok", "Close");
					        }
					        case STAT:
					        {
					            new string[500], temp[100];
								for(new i = 0; i < sizeof(StatCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", StatCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Stat", string, "Ok", "Close");
					        }
					        case ARMY:
					        {
					            new string[500], temp[100];
								for(new i = 0; i < sizeof(ArmyCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", ArmyCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Army", string, "Ok", "Close");
					        }
							case POLICE:
							{
							    new string[500], temp[100];
								for(new i = 0; i < sizeof(PoliceCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PoliceCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Police", string, "Ok", "Close");
							}
							case RAPIST:
							{
							    new string[400], temp[100];
								for(new i = 0; i < sizeof(RapistCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", RapistCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Rapist", string, "Ok", "Close");
							}
							case MECHANIC:
							{
							    new string[300], temp[100];
								for(new i = 0; i < sizeof(MechanicCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MechanicCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Mechanic", string, "Ok", "Close");
							}
							case MEDIC:
							{
							    new string[300], temp[100];
								for(new i = 0; i < sizeof(MedicCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MedicCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Mechanic", string, "Ok", "Close");
							}
							case DRUG:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(DrugCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", DrugCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Drug Dealer", string, "Ok", "Close");
							}
							case ROB:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(RobCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", RobCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Robber", string, "Ok", "Close");
							}
							case WEP:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(WepCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", WepCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Weapon dealer", string, "Ok", "Close");
							}
							case ITEMS:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(ItemsCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", ItemsCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Items dealer", string, "Ok", "Close");
							}
							case KIDNAPPER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(KidnapperCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", KidnapperCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Kidnapper", string, "Ok", "Close");
							}
							case PEDO:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(PedoCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PedoCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Pedo", string, "Ok", "Close");
							}
							case TRUCKER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(TruckerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", TruckerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Trucker", string, "Ok", "Close");
							}
							case TAXI:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(TaxiCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", TaxiCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Taxi", string, "Ok", "Close");
							}
							case SWAT:
							{
							    new string[550], temp[100];
								for(new i = 0; i < sizeof(SwatCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", SwatCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Swat", string, "Ok", "Close");
							}
							case PILOT:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(PilotCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PilotCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Pilot", string, "Ok", "Close");
							}
							case PIZZABOY:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(PizzaCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PizzaCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Pizza Boy", string, "Ok", "Close");
							}
							case FARMER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(FarmerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", FarmerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Farmer", string, "Ok", "Close");
							}
							case MINER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(MinerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MinerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Miner", string, "Ok", "Close");
							}
							case CARJACKER:
							{
								new string[350], temp[100];
								for(new i = 0; i < sizeof(CarjackerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", CarjackerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - CarJacker", string, "Ok", "Close");
							}
							case WHORE:
							{
								new string[350], temp[100];
								for(new i = 0; i < sizeof(WhoreCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", WhoreCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Whore", string, "Ok", "Close");
							}
							case MAYOR:
							{
								new string[350], temp[100];
								for(new i = 0; i < sizeof(MayorCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MayorCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Mayor", string, "Ok", "Close");
							}
						}
					}
				    case 1:
					{
					    new string[1700], temp[100];
						for(new i = 0; i < sizeof(GeneralCommands); i++) {
							format(temp, 100, "{FFFFFF}%s\n", GeneralCommands[i]);
							strcat(string, temp);
						}
						ShowPlayerDialog(playerid, DIALOG_GCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}General Commands", string, "Ok", "Close");
					}
				    case 2:
					{
					    if(PlayerInfo[playerid][Padmin] >= HELPER)
					    {
							ShowPlayerDialog(playerid, DIALOG_ACMDS, DIALOG_STYLE_LIST, "{FFFFFF}Admin Commands", "{FFFFFF}Moderator Commands\n{FFFFFF}Admin Commands\n{FFFFFF}Senior Admin Commands", "Ok", "Close");
						}
						else
						{
	                        SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This is for staff members only!");
						}
					}
				    case 3:
					{
					    new string[500], temp[100];
						for(new i = 0; i < sizeof(VehicleCommands); i++) {
							format(temp, 100, "{FFFFFF}%s\n", VehicleCommands[i]);
							strcat(string, temp);
						}
				 		ShowPlayerDialog(playerid, DIALOG_VCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Vehicle Commands", string, "Ok", "Close");
					}
				}
			} else {

			    switch(listitem)
			    {
			        case 0:
			        {
			            switch(gTeam[playerid])
					    {
					        case HITMAN:
					        {
					        	ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Hitman", "{FFFFFF}/hits - See what players have a hit on their head and for how much money", "Ok", "Close");
					        }
					        case TERRORIST:
					        {
					            new string[350], temp[100];
								for(new i = 0; i < sizeof(TerroristCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", TerroristCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Terrorist", string, "Ok", "Close");
					        }
					        case STAT:
					        {
					            new string[500], temp[100];
								for(new i = 0; i < sizeof(StatCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", StatCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Stat", string, "Ok", "Close");
					        }
					        case ARMY:
					        {
					            new string[500], temp[100];
								for(new i = 0; i < sizeof(ArmyCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", ArmyCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Army", string, "Ok", "Close");
					        }
							case POLICE:
							{
							    new string[500], temp[100];
								for(new i = 0; i < sizeof(PoliceCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PoliceCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Police", string, "Ok", "Close");
							}
							case RAPIST:
							{
							    new string[400], temp[100];
								for(new i = 0; i < sizeof(RapistCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", RapistCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Rapist", string, "Ok", "Close");
							}
							case MECHANIC:
							{
							    new string[300], temp[100];
								for(new i = 0; i < sizeof(MechanicCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MechanicCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Mechanic", string, "Ok", "Close");
							}
							case MEDIC:
							{
							    new string[300], temp[100];
								for(new i = 0; i < sizeof(MedicCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MedicCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Mechanic", string, "Ok", "Close");
							}
							case DRUG:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(DrugCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", DrugCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Drug Dealer", string, "Ok", "Close");
							}
							case ROB:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(RobCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", RobCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Robber", string, "Ok", "Close");
							}
							case WEP:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(WepCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", WepCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Weapon dealer", string, "Ok", "Close");
							}
							case ITEMS:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(ItemsCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", ItemsCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Items dealer", string, "Ok", "Close");
							}
							case KIDNAPPER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(KidnapperCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", KidnapperCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Kidnapper", string, "Ok", "Close");
							}
							case PEDO:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(PedoCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PedoCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Pedo", string, "Ok", "Close");
							}
							case TRUCKER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(TruckerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", TruckerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Trucker", string, "Ok", "Close");
							}
							case TAXI:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(TaxiCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", TaxiCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Taxi", string, "Ok", "Close");
							}
							case SWAT:
							{
							    new string[550], temp[100];
								for(new i = 0; i < sizeof(SwatCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", SwatCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Swat", string, "Ok", "Close");
							}
							case PILOT:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(PilotCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PilotCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Pilot", string, "Ok", "Close");
							}
							case PIZZABOY:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(PizzaCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", PizzaCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Pizza Boy", string, "Ok", "Close");
							}
							case FARMER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(FarmerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", FarmerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Farmer", string, "Ok", "Close");
							}
							case MINER:
							{
							    new string[350], temp[100];
								for(new i = 0; i < sizeof(MinerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MinerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Miner", string, "Ok", "Close");
							}
							case CARJACKER:
							{
								new string[350], temp[100];
								for(new i = 0; i < sizeof(CarjackerCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", CarjackerCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - CarJacker", string, "Ok", "Close");
							}
							case WHORE:
							{
								new string[350], temp[100];
								for(new i = 0; i < sizeof(WhoreCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", WhoreCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Whore", string, "Ok", "Close");
							}
							case MAYOR:
							{
								new string[350], temp[100];
								for(new i = 0; i < sizeof(MayorCommands); i++) {
									format(temp, 100, "{FFFFFF}%s\n", MayorCommands[i]);
									strcat(string, temp);
								}
								ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands - Mayor", string, "Ok", "Close");
							}
						}
					}
				    case 1:
					{
					    new string[1600], temp[100];
						for(new i = 0; i < sizeof(GeneralCommands); i++) {
							format(temp, 100, "{FFFFFF}%s\n", GeneralCommands[i]);
							strcat(string, temp);
						}
						ShowPlayerDialog(playerid, DIALOG_GCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}General Commands", string, "Ok", "Close");
					}
				    case 2:
					{
					    new string[500], temp[100];
						for(new i = 0; i < sizeof(VehicleCommands); i++) {
							format(temp, 100, "{FFFFFF}%s\n", VehicleCommands[i]);
							strcat(string, temp);
						}
				 		ShowPlayerDialog(playerid, DIALOG_VCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Vehicle Commands", string, "Ok", "Close");
					}
				}
			}
		}
		case DIALOG_BUY_FOOD:
		{
			if(!response) return 0;
			foreach(Player, i) 
			{
				if(IsPlayerInDynamicCP(playerid, PlayerFoodSale[i])) {
					GivePlayerMoney(playerid, -FoodPrice[i]);
					ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					new Float:H;
					GetPlayerHealth(playerid, H);
					SetPlayerHealth(playerid, H+25);
					format(G_String, 128, "[ALERT] :{FFFFFF} Thankyou for purchasing food from %s' food service, Enjoy your meal!", PlayerName(i));
					SendClientMessage(playerid, COLOR_GREEN, G_String);
				}
			}
		}
		case DIALOG_ACMDS:
		{
			new string[800];
			switch(listitem)
			{
			    case 0:
				{

    				strcat(string, "{FF0000}[CMD]{FFFFFF} /slap -{FF0000} Slaps a player into the air and reduces some health\n{FF0000}[CMD]{FFFFFF} /apm -{FF0000} Send an admin privite message to a player \
			    	\n{FF0000}[CMD] {FFFFFF}/mute -{FF0000} Mutes a player\n{FF0000}[CMD]{FFFFFF} /unmute -{FF0000} UnMutes a player\n{FF0000}[CMD]{FFFFFF} /ann -{FF0000} Announces a message on the screen\n{FF0000}[CMD]{FFFFFF} /disarm -{FF0000} Disarms a player");
					strcat(string, "\n{FF0000}[CMD]{FFFFFF} /freeze -{FF0000} Freezes a player\n{FF0000}[CMD]{FFFFFF} /unfreeze -{FF0000} Unfreezes a player\
					\n{FF0000}[CMD]{FFFFFF} /goto -{FF0000} Teleports yourself to the given player\n{FF0000}[CMD]{FFFFFF} /bring -{FF0000} Bring a player to your position");
			 		ShowPlayerDialog(playerid, DIALOG_HELPERCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Helper Commands", string, "Ok", "Close");
				}
				case 1:
				{
				    new Bstring[1100];
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Moderators have helper commands plus these:");
				    strcat(Bstring, "{00FF00}Moderators have helpers commands aswell as thier own!\n{FF0000}[CMD]{FFFFFF} /explode -{FF0000} Creates an explosion at a players position\n{FF0000}[CMD]{FFFFFF} /kick -{FF0000} Kicks a player from the server\n{FF0000}[CMD]{FFFFFF} /tempban -{FF0000} Temp ban a player from the server\n{FF0000}[CMD]{FFFFFF} /givecash -{FF0000} Gives a player an ammount of cash");
				    strcat(Bstring, "\n{FF0000}[CMD]{FFFFFF} /dveh -{FF0000} Destroys the vehicle your in or vehicles around you if you're not in a vehicle\n{FF0000}[CMD]{FFFFFF} /getall -{FF0000} gets every player to your position\n{FF0000}[CMD]{FFFFFF} /respawnv -{FF0000} Respawns all vehicles in the server\n{FF0000}[CMD]{FFFFFF} /warn -{FF0000} Warns a player ( 3/3 = kick )\n{FF0000}[CMD]{FFFFFF} /resetwarnings -{FF0000} Resets a players wanrings");
				    strcat(Bstring, "\n{FF0000}[CMD]{FFFFFF} /warnlist -{FF0000} Displays everyone that has been warned\n{FF0000}[CMD]{FFFFFF} /richlist -{FF0000} Displays a list of players with 1 million or more and smaller than 10 score\n{FF0000}[CMD]{FFFFFF} /akill -{FF0000} Kills a given player");
				    ShowPlayerDialog(playerid, DIALOG_MODCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Moderator Commands", Bstring, "Ok", "Close");
				}
				case 2:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Admins have helper and moderator commands plus these:");
				    strcat(string, "{00FF00}Admins have helpers and moderator commands aswell as thier own!\n{FF0000}[CMD]{FFFFFF} /clearchat -{FF0000} Clears the chat\n{FF0000}[CMD]{FFFFFF} /fine -{FF0000} Fine a player a given ammount of money\n{FF0000}[CMD]{FFFFFF} /setwanted -{FF0000} Set a players wanted level\n{FF0000}[CMD]{FFFFFF} /sethealth -{FF0000} Set a players health\n{FF0000}[CMD]{FFFFFF} /setarmour -{FF0000} Set a players armour");
				    ShowPlayerDialog(playerid, DIALOG_ADMINCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Admin Commands", string, "Ok", "Close");
				}
			}
		}
		case DIALOG_CLASS:
		{
		    if(!response)
		    {
		        SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You did not select you have been assigned to: {00FF00}Drug Dealer{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
		        GivePlayerWeapon(playerid, 22, 500);
				GivePlayerWeapon(playerid, 25, 100);
				GivePlayerWeapon(playerid, 28, 300);
				GivePlayerWeapon(playerid, 30, 500);
				gTeam[playerid] = DRUG;
				ShowDialog(playerid, "Job Selection - Drug Dealer", "You have selected \"Drug Dealer\". Your aim is to sell and grow drugs in order to gain profit.", "Okay", "", true);
			}
		    switch(listitem)
		    {
		        case 0:
		        {
		            SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Drug Dealer{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = DRUG;
					ShowDialog(playerid, "Job Selection - Drug Dealer", "You have selected \"Drug Dealer\". Your aim is to sell and grow drugs in order to gain profit.", "Okay", "", true);
		        }
		        case 1:
		        {
		            SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Pedo{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 43, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = PEDO;
					ShowDialog(playerid, "Job Selection - Pedo", "You have selected \"Pedo\". Your aim is to rape / rob and kidnap players.", "Okay", "", true);
				}
				case 2:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Gun Merchant{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 26, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = WEP;
					ShowDialog(playerid, "Job Selection - Weapons Dealer", "You have selected \"Weapons Dealer\". Your aim is to rape / rob and sell weapons to players.", "Okay", "", true);
				}
				case 3:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Robber{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = ROB;
					ShowDialog(playerid, "Job Selection - Thief", "You have selected \"Thief\". Your aim is to rape / rob players.", "Okay", "", true);
				}
				case 4:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Items Dealer{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = ITEMS;
					ShowDialog(playerid, "Job Selection - Items Dealer", "You have selected \"Items Dealer\". Your aim is to rape / rob and sell weapons to players.", "Okay", "", true);
				}
				case 5:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Rapist{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = RAPIST;
					ShowDialog(playerid, "Job Selection - Rapist", "You have selected \"Rapist\". Your aim is to rape / rob and give std's to players.", "Okay", "", true);
				}
				case 6:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Kidnapper{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = KIDNAPPER;
					ShowDialog(playerid, "Job Selection - Kidnapper", "You have selected \"Kidnapper\". Your aim is to rob and kidnap players.", "Okay", "", true);
				}
				case 7:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Terroist{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = TERRORIST;
					ShowDialog(playerid, "Job Selection - Terroist", "You have selected \"Terroist\". Your aim is to rape / rob and plant bombs.", "Okay", "", true);
				}
				case 8:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Car Jacker{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = CARJACKER;
					ShowDialog(playerid, "Job Selection - Car Jacker", "You have selected \"Car Jacker\". Your aim is to rape / rob and sell owned cars to illegal dealers.", "Okay", "", true);
				}
				case 9:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {2e72d0}Whore{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = WHORE;
					ShowDialog(playerid, "Job Selection - Whore", "You have selected \"Whore\". Your aim is to rape / rob and sell sex & toys to players.", "Okay", "", true);
				}
			}
		}
		case DIALOG_LESURE:
		{
		    if(!response) { return 0; }
		    switch(listitem)
		    {
		        case 0:
		        {
		            SetPlayerPos(playerid, 1302.519897,-1.787510,1001.028259);
		            SetPlayerInterior(playerid, 18);
		            PlayerVariables[playerid] |= PLAYER_IN_LEISURE;
		            SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have entered the leisure center. Use /exitleisure to exit the leisure center.");
				}
				case 1:
				{
				    SetPlayerPos(playerid, -1444.645507,-664.526000,1053.572998);
				    SetPlayerInterior(playerid, 4);
				    PlayerVariables[playerid] |= PLAYER_IN_LEISURE;
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have entered the leisure center. Use /exitleisure to exit the leisure center.");
				}
				case 2:
				{
				    SetPlayerPos(playerid, -1398.103515,937.631164,1036.479125);
				    SetPlayerInterior(playerid, 15);
				    PlayerVariables[playerid] |= PLAYER_IN_LEISURE;
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have entered the leisure center. Use /exitleisure to exit the leisure center.");
				}
			}
		}
		case DIALOG_COPGUN:
		{
			if(!response) { CloseDialog(playerid); return 0; }
			switch(listitem)
			{
			    case 0:
				{
				    SetPlayerArmour(playerid, 100.0);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given armour.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 1:
				{
				    GivePlayerWeapon(playerid, 22, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a 9mm.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 2:
				{
				    GivePlayerWeapon(playerid, 23, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Silenced 9mm.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 3:
				{
				    GivePlayerWeapon(playerid, 24, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Desert Eagle.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 4:
				{
				    GivePlayerWeapon(playerid, 27, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Combat Shotgun.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 5:
				{
                    GivePlayerWeapon(playerid, 29, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a MP5.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 6:
				{
				    GivePlayerWeapon(playerid, 32, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Tec 9.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 7:
				{
				    GivePlayerWeapon(playerid, 30, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a AK47.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 8:
				{
				    GivePlayerWeapon(playerid, 31, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a M4.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
				case 9:
				{
				    GivePlayerWeapon(playerid, 34, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Sniper Rifle.");
				    ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
				}
			}
		}
		case DIALOG_DRUG:
		{
		    if(!response) return 0;
		    switch(listitem)
		    {
		        case 0:
		        {
		            if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(Cocaine[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					Cocaine[playerid] = 500;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of cocaine");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now sell this cocaine or use it.");
					GivePlayerMoney(playerid, -50000);
				}
				case 1:
		        {
		            if(GetPlayerMoney(playerid) < 35000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(Heroin[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					Heroin[playerid] = 500;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of Heroin");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now sell this heroin or use it");
					GivePlayerMoney(playerid, -35000);
				}
				case 2:
		        {
		            if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(Weed[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					Weed[playerid] = 500;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of Weed");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now sell this weed or use it.");
                    GivePlayerMoney(playerid, -50000);
				}
				case 3:
		        {
		            if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(WeedSeeds[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					WeedSeeds[playerid] += 10;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 10 weed seeds");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now plant some seeds and grow them or sell them on.");
					GivePlayerMoney(playerid, -3000);
				}

			}
		}
		case DIALOG_BUYSTUFF:
		{
		    if(!response) {
				PlayerVariables[playerid] &= ~PLAYER_ON_PICKUP;
				return 0;
			}
			if(GetPlayerVirtualWorld(playerid) == 2 || GetPlayerVirtualWorld(playerid) == 4)
  			{
  				switch(listitem)
     			{

		            case 0:
		            {
		                if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
		                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		                GivePlayerMoney(playerid, -10);
		                SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your blunt.");
					}
					case 1:
					{
					    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough moneu for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -6);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+25);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your burger.");
					}
					case 2:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -10);
						new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+50);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your bacon.");
					}
					case 3:
					{
					    if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -1);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+10);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your chips.");
					}
					case 4:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
					    GivePlayerWeapon(playerid, 14, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your flowers.");
					}
					case 5:
					{
					    if(GetPlayerMoney(playerid) < 200) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -200);
					    StunGun[playerid] = true;
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your stun gun.");
					    SendClientMessage(playerid, COLOR_ORANGE, "Use /stun <id> to stun a player.");
					}
					case 6:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -10);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your beer.");
					}
					case 7:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
						Cuffs[playerid] = true;
						SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your cuffs.");
						SendClientMessage(playerid, COLOR_ORANGE, "You can use cuffs to cuff people. If you are a kidnapper you can then kidnap them after you cuff them.");
					}
					case 8:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    AntiRape[playerid] = true;
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your anti rape device.");
						SendClientMessage(playerid, COLOR_ORANGE, "With the anti rape device players are unable to rape you untill your anti rape device is removed (when you die)");
					}
					case 9:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    Wallet[playerid] = true;
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your wallet.");
						SendClientMessage(playerid, COLOR_ORANGE, "With the wallet players are unable to rob you of any of your money untill your wallet is removed (when you die)");
					}
					case 10:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    GivePlayerWeapon(playerid, 22, 30);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your pistol.");
					}
					case 11:
					{
					    if(GetPlayerMoney(playerid) < 300) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -300);
					    Spod[playerid] = true;
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your Spod.");
						SendClientMessage(playerid, COLOR_ORANGE, "With the spod you can add your favourite songs from youtube and listen to them anywhere ingame.");
					}
				}
			}
			if(GetPlayerVirtualWorld(playerid) == 1)
			{
			    switch(listitem)
			    {
			        case 0:
					{
					    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough moneu for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -6);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+25);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your burger.");
					}
					case 1:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -10);
						new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+50);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your bacon.");
					}
					case 2:
					{
					    if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -1);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+10);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your chips.");
					}
					case 3:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
					    GivePlayerWeapon(playerid, 14, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your flowers.");
					}
					case 4:
					{
					    if(GetPlayerMoney(playerid) < 200) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -200);
					    // need variable to give the gun
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your stun gun.");
					}
					case 5:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -10);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your beer.");
					}
					case 6:
					{
					    if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -5);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your sprunk.");
					}
					case 7:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    // give k-rose music
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your K-rose music.");
					}
					case 8:
					{
					    if(GetPlayerMoney(playerid) < 30) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -30);
					    GivePlayerWeapon(playerid, 2, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your golf club.");
					}
				}
			}
			if(GetPlayerVirtualWorld(playerid) == 3)
			{
			    switch(listitem)
			    {
			        case 0:
					{
					    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough moneu for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -6);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+25);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your burger.");
					}
					case 1:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -10);
						new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+50);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your bacon.");
					}
					case 2:
					{
					    if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -1);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+10);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your chips.");
					}
					case 3:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
					    GivePlayerWeapon(playerid, 14, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your flowers.");
					}
					case 4:
					{
					    if(GetPlayerMoney(playerid) < 200) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -200);
					    // need variable to give the gun
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your stun gun.");
					}
					case 5:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -10);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your beer.");
					}
					case 6:
					{
					    if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -5);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your sprunk.");
					}
					case 7:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    // give k-rose music
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your K-rose music.");
					}
					case 8:
					{
					    if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -3000);
					    //give spod
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your spod.");
					}
				}
			}
		}
		case DIALOG_HOUSE:
		{
		    if(!response) { SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have closed the house dialog."); return 0;}
            if(PlayerInfo[playerid][Padmin] < ADMIN) {
			    switch(listitem)
			    {
	     			case 0:
					{
			        	new ID = HouseStanding[playerid];
	          			SetPlayerInterior(playerid, HouseInfo[ID][interiorid]);
	 					SetPlayerPos(playerid, HouseInfo[ID][IntXpos], HouseInfo[ID][IntYpos], HouseInfo[ID][IntZpos]);
	     				House[playerid] = ID;
	        			SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Use /exithouse to exit the house.");
	        		}
	        		case 1:
	        		{
	 					new ID = HouseStanding[playerid];
	  					if(PlayerInfo[playerid][Prob] < 111 && !strlen(HouseInfo[ID][pass])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} To break into a locked house you need to have 111 rob level or more.");
					}
				}
			} else {
			    switch(listitem)
			    {
	     			case 0:
					{
			        	new ID = HouseStanding[playerid];
	          			SetPlayerInterior(playerid, HouseInfo[ID][interiorid]);
	 					SetPlayerPos(playerid, HouseInfo[ID][IntXpos], HouseInfo[ID][IntYpos], HouseInfo[ID][IntZpos]);
	     				House[playerid] = ID;
	        			SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Use /exithouse to exit the house.");
	        		}
	        		case 1:
	        		{
	 					new ID = HouseStanding[playerid];
	  					if(PlayerInfo[playerid][Prob] < 111 && !strlen(HouseInfo[ID][pass])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} To break into a locked house you need to have 111 rob level or more.");
					}
					case 2:
					{
					    new ID = HouseStanding[playerid];
					    format(G_String, 128, "{FF0000}[EDIT HOUSE][%i]{FFFFFF} %s", HouseInfo[ID][SqlID], HouseInfo[ID][Howner]);
					    ShowPlayerDialog(playerid, DIALOG_EDITHOUSE, DIALOG_STYLE_LIST, G_String, "{FFFFFF}Delete House\n{FFFFFF}Edit Owner\n{FFFFFF}Rent\n{FFFFFF}Edit Value For Rent\n{FFFFFF}Sale\n{FFFFFF}Edit Sale Value", "Select", "Close");
						PlayerVariables[playerid] |= PLAYER_EDITING_HOUSE;
					}
				}
			}
		}
		case DIALOG_EDITHOUSE:
		{
		    if(!response) {return 0;}
			switch(listitem)
			{
			    case 0:
			    {
			        new ID = HouseStanding[playerid], Query[200];
			        DestroyDynamicPickup(HouseInfo[ID][HID]);
			        HouseInfo[ID][HID] = 0;
			        format(Query, 200, "DELETE FROM house WHERE Xpos = '%f' AND Ypos = '%f' AND Zpos = '%f' AND owner = '%s'", HouseInfo[ID][Xpos], HouseInfo[ID][Ypos], HouseInfo[ID][Zpos], HouseInfo[ID][Howner]);
			        mysql_function_query (Gconnection, Query, false, "", "");
			        HouseInfo[ID][Xpos] = 0;
			        HouseInfo[ID][Ypos] = 0;
			        HouseInfo[ID][Zpos] = 0;
			        HouseInfo[ID][Howner] = 0;
					DestroyDynamic3DTextLabel(HouseInfo[ID][Doortext]);
			       	PlayerVariables[playerid] &= ~PLAYER_EDITING_HOUSE;
			        SendClientMessage(playerid, COLOR_RED2, "[HOUSE] :{FFFFFF} House has been deleted.");
				}
				case 1:
				{
				    ShowPlayerDialog(playerid, DIALOG_EDITHOUSEOWNER, DIALOG_STYLE_INPUT, "{FFFFFF}Change house owner", "{FFFFFF}Please enter a username/base name to change this houses owner.", "Ok", "Cancel");
				}
				case 2:
				{
				    new newtext[200], ID = HouseStanding[playerid];
				    format(newtext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} yes\n{FFFFFF}For sale: {FF0000}No\n{FFFFFF}Rent Price: {FF0000}$%d", HouseInfo[ID][Howner], HouseInfo[ID][Hrentprice]);
                    UpdateDynamic3DTextLabelText(HouseInfo[ID][Doortext], -1, newtext);
                    HouseInfo[ID][Hrented] = true;
                    PlayerVariables[playerid] &= ~PLAYER_EDITING_HOUSE;
				}
				case 3:
				{
				    ShowPlayerDialog(playerid, DIALOG_EDITHOUSEPRICE, DIALOG_STYLE_INPUT, "{FFFFFF}Change house rent price", "{FFFFFF}Please enter a number to change the house rent price.", "Ok", "Cancel");
				}
				case 4:
				{
    				new newtext[200], ID = HouseStanding[playerid];
				    format(newtext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} No\n{FFFFFF}For sale: {FF0000}Yes\n{FFFFFF}Price: {FF0000}$%d", HouseInfo[ID][Howner], HouseInfo[ID][Hsaleprice]);
                    UpdateDynamic3DTextLabelText(HouseInfo[ID][Doortext], -1, newtext);
                    HouseInfo[ID][Hsale] = true;
                    PlayerVariables[playerid] &= ~PLAYER_EDITING_HOUSE;
				}
				case 5:
				{
				    ShowPlayerDialog(playerid, DIALOG_EDITHOUSESALEPRICE, DIALOG_STYLE_INPUT, "{FFFFFF}Change house sale price", "{FFFFFF}Please enter a number to change the house sale price.", "Ok", "Cancel");
				}
			}
		}
		case DIALOG_RADIO:
		{
		    if(!response) { return 0; }
		    switch(listitem)
		    {
		        case 0:
		        {
		            PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=111772");
				}
				case 1:
				{
				    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=38370");
				}
				case 2:
				{
                    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=43280");
				}
				case 3:
				{
				    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=203280");
				}
				case 4:
				{
				    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=631339");
				}
				case 5:
				{
				    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=2000");
				}
				case 6:
				{
				    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687");
				}
				case 7:
				{
					PlayAudioStreamForPlayer(playerid, "http://www.youtube-mp3.org/get?video_id=QbAZiVRG6h0");
				}
				case 8:
				{
				    PlayAudioForEveryoneInVeh(GetPlayerVehicleID(playerid), "Streaming was stoped.");
				}
			}
		}
		case DIALOG_EDITHOUSEOWNER:
		{
		    if(!response) { return 0; }
		    new ID = HouseStanding[playerid], newtext[200];
		    if(strlen(inputtext) < 2) return ShowPlayerDialog(playerid, DIALOG_EDITHOUSEOWNER, DIALOG_STYLE_INPUT, "{FFFFFF}Change house owner", "{FFFFFF}Please enter a username/base name to change this houses owner.\n{FF0000}Please enter more characters", "Ok", "Cancel");
		    format(HouseInfo[ID][Howner], 24, inputtext);
		    PlayerVariables[playerid] &= ~PLAYER_EDITING_HOUSE;
		    if(HouseInfo[ID][Howned] == false)
		    {
		    	format(newtext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} yes\n{FFFFFF}For sale: {FF0000}No\n{FFFFFF}Rent Price: {FF0000}$%d", HouseInfo[ID][Howner], HouseInfo[ID][Hrentprice]);
    			UpdateDynamic3DTextLabelText(HouseInfo[ID][Doortext], -1, newtext);
			} else {
			    format(newtext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} yes\n{FFFFFF}For sale: {FF0000}No", HouseInfo[ID][Howner]);
    			UpdateDynamic3DTextLabelText(HouseInfo[ID][Doortext], -1, newtext);
			}
		}
		case DIALOG_EDITHOUSEPRICE:
		{
		    if(!response) { return 0; }
		    new ID = HouseStanding[playerid], newtext[200];
		    if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, DIALOG_EDITHOUSEPRICE, DIALOG_STYLE_INPUT, "{FFFFFF}Change house rent price", "{FFFFFF}Please enter a number to change the house rent price.\n{FF0000}Please enter more numbers", "Ok", "Cancel");
		    HouseInfo[ID][Hrentprice] = strval(inputtext);
		    PlayerVariables[playerid] &= ~PLAYER_EDITING_HOUSE;
		    SendClientMessage(playerid, COLOR_RED2, "[HOUSE] :{FFFFFF} You have changed this houses price.");
		    if(HouseInfo[ID][Howned] == false)
		    {
		        format(newtext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} yes\n{FFFFFF}For sale: {FF0000}No\n{FFFFFF}Rent Price: {FF0000}$%d", HouseInfo[ID][Howner], HouseInfo[ID][Hrentprice]);
          		UpdateDynamic3DTextLabelText(HouseInfo[ID][Doortext], -1, newtext);
			}
		}
		case DIALOG_EDITHOUSESALEPRICE:
		{
		    if(!response) { return 0; }
		    new ID = HouseStanding[playerid], newtext[200];
		    if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, DIALOG_EDITHOUSESALEPRICE, DIALOG_STYLE_INPUT, "{FFFFFF}Change house sale price", "{FFFFFF}Please enter a number to change the house sale price.\n{FF0000}Please enter more numbers", "Ok", "Cancel");
		    HouseInfo[ID][Hsaleprice] = strval(inputtext);
		    PlayerVariables[playerid] &= ~PLAYER_EDITING_HOUSE;
		    SendClientMessage(playerid, COLOR_RED2, "[HOUSE] :{FFFFFF} You have changed this houses sale price.");
		    if(HouseInfo[ID][Howned] == false)
		    {
		        format(newtext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} No\n{FFFFFF}For sale: {FF0000}Yes\n{FFFFFF}Rent Price: {FF0000}$%d", HouseInfo[ID][Howner], HouseInfo[ID][Hsaleprice]);
          		UpdateDynamic3DTextLabelText(HouseInfo[ID][Doortext], -1, newtext);
			}
		}
		case DIALOG_BANKMENU:
		{
			if(!response) { return 0; }

			switch(listitem)
			{

				case 0: ShowPlayerDialog(playerid, DIALOG_BANKWITH, DIALOG_STYLE_INPUT, "{FFFFFF}Withdraw", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in the bank first.", "Okay", "Cancel");
				case 1: ShowPlayerDialog(playerid, DIALOG_BANKDEP, DIALOG_STYLE_INPUT, "{FFFFFF}Deposit", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in your pocket first.", "Okay", "Cancel");
				case 2:
				{
					new string[300];
					format(string, 300, "{FFFFFF}Your bank balace stands at: $%d\n\nThe tax for the server is currently set at $%d so make sure you have enough in the bank at all times!", PlayerInfo[playerid][Pbank], G_TAX);
					ShowPlayerDialog(playerid, DIALOG_STATEMENT, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bank Statement", string, "Okay", "Cancel");
				}
				case 3: ShowPlayerDialog(playerid, DIALOG_BANKWIREID, DIALOG_STYLE_INPUT, "{FFFFFF}Wire transfer", "{FFFFFF}Please select a players id to transfer money to.", "Okay", "Cancel");
				case 4: SendClientMessage(playerid, -1, "Please check back later for this feature...");
			}
		}
		case DIALOG_BANKWITH:
		{

			if(!response) { return 0; }

			//needs to be a number
			if(!IsNumeric(inputtext)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Your input must be of numeric value (numbers)"), ShowPlayerDialog(playerid, DIALOG_BANKWITH, DIALOG_STYLE_INPUT, "{FFFFFF}Withdraw", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in the bank first.", "Okay", "Cancel");

			//needs to be the minimum at least or the maximum
			if(strval(inputtext) < 1 || strval(inputtext) > 3000000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum withdraw: $1 Maximum withdraw: $3000000"), ShowPlayerDialog(playerid, DIALOG_BANKWITH, DIALOG_STYLE_INPUT, "{FFFFFF}Withdraw", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in the bank first.", "Okay", "Cancel");

			//need to have that ammount in the bank
			if(strval(inputtext) > PlayerInfo[playerid][Pbank]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to enter a value that you have in the bank."), ShowPlayerDialog(playerid, DIALOG_BANKWITH, DIALOG_STYLE_INPUT, "{FFFFFF}Withdraw", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in the bank first.", "Okay", "Cancel");

			//take the money out
			TakePlayerBankMoney(playerid, strval(inputtext));

			//give the money to the player
			GivePlayerMoney(playerid, strval(inputtext));

			new string[300];
			format(string, 300, "{FFFFFF}Your bank balace stands at: $%d\n\nThe tax for the server is currently set at $%d so make sure you have enough in the bank at all times!", PlayerInfo[playerid][Pbank], G_TAX);
			ShowPlayerDialog(playerid, DIALOG_STATEMENT, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bank Statement", string, "Okay", "Cancel");

		}
		case DIALOG_BANKDEP:
		{

			if(!response) { return 0; }

			//needs to be a number
			if(!IsNumeric(inputtext)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Your input must be of numeric value (numbers)"), ShowPlayerDialog(playerid, DIALOG_BANKDEP, DIALOG_STYLE_INPUT, "{FFFFFF}Deposit", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in your pocket first.", "Okay", "Cancel");

			//needs to be the minimum at least or the maximum
			if(strval(inputtext) < 1 || strval(inputtext) > 3000000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum deposit: $1 Maximum deposit: $3000000"), ShowPlayerDialog(playerid, DIALOG_BANKDEP, DIALOG_STYLE_INPUT, "{FFFFFF}Deposit", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in your pocket first.", "Okay", "Cancel");

			//need to have that ammount in the bank
			if(strval(inputtext) > GetPlayerMoney(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to have that ammount of cash in your pocket first."), ShowPlayerDialog(playerid, DIALOG_BANKDEP, DIALOG_STYLE_INPUT, "{FFFFFF}Deposit", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in your pocket first.", "Okay", "Cancel");

			//put the money in
			GivePlayerBankMoney(playerid, strval(inputtext));

			//take the money from the player
			GivePlayerMoney(playerid, -strval(inputtext));

			new string[300];
			format(string, 300, "{FFFFFF}Your bank balace stands at: $%d\n\nThe tax for the server is currently set at $%d so make sure you have enough in the bank at all times!", PlayerInfo[playerid][Pbank], G_TAX);
			ShowPlayerDialog(playerid, DIALOG_STATEMENT, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bank Statement", string, "Okay", "Cancel");

		}
		case DIALOG_BANKWIREPEFORM:
		{

			if(!response) { return WireID[playerid] = -1, 0; }

			//needs to be a number
			if(!IsNumeric(inputtext)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Your input must be of numeric value (numbers)"), ShowPlayerDialog(playerid, DIALOG_BANKDEP, DIALOG_STYLE_INPUT, "{FFFFFF}Deposit", "{FFFFFF}Select an ammount between 1 - 3000000 ! Make sure you have that ammount in your pocket first.", "Okay", "Cancel");

			//needs to be the minimum at least or the maximum
			if(strval(inputtext) < 1 || strval(inputtext) > 3000000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum deposit: $1 Maximum deposit: $3000000"), ShowPlayerDialog(playerid, DIALOG_BANKWIREID, DIALOG_STYLE_INPUT, "{FFFFFF}Bank Wire", "{FFFFFF}Please enter an id of a player that is connected to send him money.", "Okay", "Cancel");

			//need to have that ammount in the bank
			if(strval(inputtext) > PlayerInfo[playerid][Pbank]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to enter a value that you have in the bank."), ShowPlayerDialog(playerid, DIALOG_BANKWIREID, DIALOG_STYLE_INPUT, "{FFFFFF}Bank Wire", "{FFFFFF}Please enter an id of a player that is connected to send him money.", "Okay", "Cancel");

			//take the money out
			TakePlayerBankMoney(playerid, strval(inputtext));

			//give the money to the new player
			GivePlayerBankMoney(WireID[playerid], strval(inputtext));

			format(G_String, 128, "[BANK] :{FFFFFF} %s has performed a wire transfer to your bank account.", PlayerName(playerid));
			SendClientMessage(WireID[playerid], COLOR_RED2, G_String);

			format(G_String, 128, "%s has transfered $%d to your account.\nYour balance now stands at $%d", PlayerName(playerid),strval(inputtext), PlayerInfo[WireID[playerid]][Pbank]);
			ShowPlayerDialog(playerid, DIALOG_STATEMENT, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bank Wire", G_String, "Okay", "Cancel");

			new string[300];
			format(string, 300, "{FFFFFF}Your bank balace stands at: $%d\n\nThe tax for the server is currently set at $%d so make sure you have enough in the bank at all times!", PlayerInfo[playerid][Pbank], G_TAX);
			ShowPlayerDialog(playerid, DIALOG_STATEMENT, DIALOG_STYLE_MSGBOX, "{FFFFFF}Bank Statement", string, "Okay", "Cancel");

		}
		case DIALOG_BANKWIREID:
		{

			if(!response) { return 0; }

			//needs to be a number
			if(!IsNumeric(inputtext)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Your input must be of numeric value (numbers)"), ShowPlayerDialog(playerid, DIALOG_BANKWIREID, DIALOG_STYLE_INPUT, "{FFFFFF}Bank Wire", "{FFFFFF}Please enter an id of a player that is connected to send him money.", "Okay", "Cancel");

			if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to enter an id of a player that is connected.");

			WireID[playerid] = strval(inputtext);

			format(G_String, 128, "[BANK] :{FFFFFF} Please input how much money you would like to transfer to %s' bank.", PlayerName(strval(inputtext)));
			SendClientMessage(playerid, COLOR_RED2, G_String);
			format(G_String, 128, "{FFFFFF} Please input how much money you would like to transfer to %s' bank.", PlayerName(strval(inputtext)));

			ShowPlayerDialog(playerid, DIALOG_BANKWIREPEFORM, DIALOG_STYLE_INPUT, "{FFFFFF}Bank Wire", G_String, "Okay", "Cancel");

		}
		case DIALOG_TAXIPAY:
		{
		    if(!response)
			{
				RemovePlayerFromVehicle(playerid), TaxiDriver[playerid] = -1;
				SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have decided to not take this taxi.");
				return 0;
   			}
   			ShowPlayerDialog(playerid, DIALOG_DESTINATION, DIALOG_STYLE_INPUT, "Input the destination", "Input the destination in which you would like to travel to. Please make sure it is as descriptive (or use the exact locaiton name) as possible so the taxi driver knows where to go.\n Note: Once destination is entered \
			   your taxi driver will start to depart and you will then start to be charged his rate.. So make sure you have enough money!", "Ok", "Cancel");
		}
		case DIALOG_DESTINATION:
		{
		    if(!response) {
	 			RemovePlayerFromVehicle(playerid);
	 			TaxiDriver[playerid] = -1;
			  	return 0;
			}
		    if(strlen(inputtext) < 3 || strlen(inputtext) > 20 || inputtext[0] == ' ')
				ShowPlayerDialog(playerid, DIALOG_DESTINATION, DIALOG_STYLE_INPUT, "Input the destination", "Input the destination in which you would like to travel to. Please make sure it is as descriptive (or use the exact locaiton name) as possible \
			so the taxi driver knows where to go.\n Note: Once destination is entered your taxi driver will start to depart and you will then start to be charged his rate.. So make sure you have enough money!", "Ok", "Cancel");


			format(G_String, 128, "[TAXI] :{FFFFFF} %s has requested a destination of %s. Please deliver him there as quick as possible.", PlayerName(playerid), inputtext);
			SendClientMessage(TaxiDriver[playerid], COLOR_RED2, G_String);
		}
		case DIALOG_BUYCAR:
		{
		    if(!response) return 0;
			switch(listitem)
			{
			    case 0:
			    {
			        //purchase the vehicle
			        if(PlayerInfo[playerid][totalvehs] == 3) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have reached the maximum ownable vehicles. You need to delete a vehicle to free up a slot.");
					new string[1500], temp[500];
					for(new i = 0; i < sizeof(VehiclePurchase); i++) {
						format(temp, 500, "%s{1E9E1E}$%d\n", VehiclePurchase[i][VehicleName], VehiclePurchase[i][PurchasePrice]);
						strcat(string, temp);
					}
					ShowPlayerDialog(playerid, DIALOG_PURCHASEVEH, DIALOG_STYLE_LIST, "{FFFFFF}Purchase your vehicle", string, "Select", "Cancel");
			    }
				case 1:
				{
				    //manage vehicles
				    ShowPlayerDialog(playerid, DIALOG_VEHMANAGE, DIALOG_STYLE_LIST, "{FFFFFF}Manage your vehicles", "[EMPTY SLOT]\n[EMPTY SLOT]\n[EMPTY SLOT]", "Select", "Cancel");
				}
			}
		}
		case DIALOG_PURCHASEVEH:
		{
		    if(!response) return 0;

		    switch(listitem)
		    {
		        case 0:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[0][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 411;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 1:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[1][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 402;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 2:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[2][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 429;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 3:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[3][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 536;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 4:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[4][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 575;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 5:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[5][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 541;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 6:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[6][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 542;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 7:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[7][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 415;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 8:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[8][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 466;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 9:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[9][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 579;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 10:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[10][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 545;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 11:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[11][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 500;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 12:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[12][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 603;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 13:
				{
				    if(GetPlayerMoney(playerid) < VehiclePurchase[13][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 475;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 14:
				{
					if(GetPlayerMoney(playerid) < VehiclePurchase[14][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 560;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
				case 15:
				{
                    if(GetPlayerMoney(playerid) < VehiclePurchase[15][PurchasePrice]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle.");
				    PVehicle[playerid] = 506;
				    ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
				}
			}

		}
		case DIALOG_VEHNUMPLATE:
		{
			if(strlen(inputtext) > 32)
			{
				ShowPlayerDialog(playerid, DIALOG_VEHNUMPLATE, DIALOG_STYLE_INPUT, "Choose your vehicle number plate", "Please input text you want on your vehicle number plate. You can embed colors such as \"{ 00FF00 }\" Without the spaces.\nWarning: The limit is 32 characters", "Ok", "Cancel");
			} else {
	  			new ID = GetVehID();
			 	PlayerInfo[playerid][totalvehs]++;
	  			VehCreated[ID] = true;
	  			new color = random(255);
		    	VehicleInfo[ID][VID] = CreateVehicle(PVehicle[playerid], -1982.2952,260.8316,35.1779,92.2532, color, color, -1);
		    	if(strlen(inputtext) > 0) {
					SetVehicleNumberPlate(VehicleInfo[ID][VID], inputtext);
		    		SetVehicleToRespawn(VehicleInfo[ID][VID]);
				}
		    	PutPlayerInVehicle(playerid, VehicleInfo[ID][VID], 0);
		    	format(VehicleInfo[ID][Owner], 24, "%s", PlayerName(playerid));
				format(VehicleInfo[ID][NumberPlate], 32, "%s", inputtext);
				VehicleInfo[ID][Vcolor1] = color;
				VehicleInfo[ID][Vcolor2] = color;
				new panels,door,lights,tires;
				GetVehicleDamageStatus(VehicleInfo[ID][VID],panels,door,lights,tires);

	   			switch(PVehicle[playerid])
			    {
	      			case 411:
		        	{
	          			format(VehicleInfo[ID][VehName], 100, "Infernus");
		            	VehicleInfo[ID][model] = 411;
			            VehicleInfo[ID][value] = (240000 / 2);
					}
					case 402:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Buffalo");
	        			VehicleInfo[ID][model] = 402;
	          			VehicleInfo[ID][value] = (12500 / 2);
					}
					case 429:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Banshee");
	        			VehicleInfo[ID][model] = 429;
	           			VehicleInfo[ID][value] = (50000 / 2);
					}
					case 536:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Blade");
	        			VehicleInfo[ID][model] = 429;
	           			VehicleInfo[ID][value] = (3567 / 2);
					}
					case 575:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Broadway");
	        			VehicleInfo[ID][model] = 575;
	        			VehicleInfo[ID][value] = (5000 / 2);
					}
					case 541:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Bullet");
	        			VehicleInfo[ID][model] = 541;
	           			VehicleInfo[ID][value] = (149995 / 2);
					}
					case 542:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Clover");
	        			VehicleInfo[ID][model] = 542;
	           			VehicleInfo[ID][value] = (16000 / 2);
					}
					case 415:
					{
		   				format(VehicleInfo[ID][VehName], 100, "Cheetah");
	        			VehicleInfo[ID][model] = 415;
	          			VehicleInfo[ID][value] = (99995 / 2);
					}
					case 466:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Glendale");
	        			VehicleInfo[ID][model] = 466;
	           			VehicleInfo[ID][value] = (25000 / 2);
					}
					case 579:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Huntley");
	        			VehicleInfo[ID][model] = 579;
	           			VehicleInfo[ID][value] = (56000 / 2);
					}
					case 545:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Hustler");
	        			VehicleInfo[ID][model] = 545;
	           			VehicleInfo[ID][value] = (73000 / 2);
					}
					case 500:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Mesa");
	        			VehicleInfo[ID][model] = 500;
	           			VehicleInfo[ID][value] = (15000 / 2);
					}
					case 603:
					{
						    format(VehicleInfo[ID][VehName], 100, "Pheonix");
				            VehicleInfo[ID][model] = 603;
				            VehicleInfo[ID][value] = (17000 / 2);
					}
					case 475:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Saber");
	        			VehicleInfo[ID][model] = 475;
	           			VehicleInfo[ID][value] = (87000 / 2);
					}
					case 560:
					{
		   				format(VehicleInfo[ID][VehName], 100, "Sultan");
	        			VehicleInfo[ID][model] = 560;
	           			VehicleInfo[ID][value] = (8000 / 2);
					}
					case 506:
					{
	    				format(VehicleInfo[ID][VehName], 100, "Super GT");
	        			VehicleInfo[ID][model] = 506;
	           			VehicleInfo[ID][value] = (99995 / 2);
					}
				}

				new Query[400];
				format(Query, 400, "INSERT INTO `vehicle`(`owner`, `model`, `vehname`, `numberplate`, `x_pos`, `y_pos`, `z_pos`, `rotation`, `value`, `pannel_damage`, `door_damage`, `light_damage`, `tire_damage`, `vehicle_health`, `color1`, `color2`) VALUES('%s', '%d', '%s', '%s', '-1982.2952', '260.8316', '35.1779', '92.2532', '%d', '%d', '%d', '%d', '%d', '1000.0', '%d', '%d')", VehicleInfo[ID][Owner], VehicleInfo[ID][model], VehicleInfo[ID][VehName], VehicleInfo[ID][NumberPlate], VehicleInfo[ID][value],
	   											panels, door, lights, tires, color, color);
				mysql_function_query (Gconnection, Query, false, "", "");
				VehicleInfo[ID][SQLID] = mysql_insert_id();
			}

		}
		case DIALOG_CRIM_WEP:
		{
			if(!response) return 0;

			new weapons[13][2];
 
			for (new i = 0; i < 13; i++) {
			    GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
			}

			switch(listitem)
			{
				case 0:
				{
					if(strval(weapons[8][0]) == 16) return SendClientMessage(playerid, -1, "You already have this weapon");
				}
			}
		}

	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerStartSweeperJob() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerStartSweeperJob()", debug_String);

    #endif

	SendDebugMessage("OnDialogResponse()", "OnDialogResponse End");

	return 1;
}