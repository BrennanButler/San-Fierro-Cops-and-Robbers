public OnGameModeInit()
{
	SendDebugMessage("OnGameModeInit()", "OnGameModeInit Start");

	#if defined __DEBUG
	timing[0] = GetTickCount();
	#endif

	//Misc
	SetGameModeText("SFCNR");
	Mysql_init();
	UsePlayerPedAnims();
	SetTimer("timeupdate", 5760, true);
	G_TAX = 1000;
	SetWeather(10);

 	CreateSettingsFile(1);

 	for(new i = 0; i < MAX_FIRES; i++) {
 		FireInfo[i][centerid] = -1;
 	}
 	

 	//menu's
 	clothingtype = CreateMenu("Clothing", 2, 20.0, 100.0, 100.0, 0.0);
	AddMenuItem(clothingtype, 0, "Hats");
	AddMenuItem(clothingtype, 0, "Glasses");
    AddMenuItem(clothingtype, 0, "Misc");
    Hats =  CreateMenu("Clothing", 2, 20.0, 100.0, 100.0, 0.0);
	AddMenuItem(Hats, 0, "Cowboy hat");
    AddMenuItem(Hats, 0, "Builders hat");
    AddMenuItem(Hats, 0, "Army hat");
    AddMenuItem(Hats, 0, "Burger hat");
    AddMenuItem(Hats, 0, "Chicken hat");
    AddMenuItem(Hats, 0, "Top hat");
    Misc =  CreateMenu("Clothing", 2, 20.0, 100.0, 100.0, 0.0);
	AddMenuItem(Misc, 0, "Parrot");
    AddMenuItem(Misc, 0, "Eyepatch");

    EnableStuntBonusForAll(0);
    TotalSweeps = 0;
 	for(new i = 0; i < MAX_STORES; i++) {
 	    StoreRobbed[i] =false;
 	    CNodeTaken[i] = false;
 	}

 	//irc bot
 	BotID[0] = IRC_Connect(IRC_SERVER, IRC_PORT, "Jeffrey", "Jeffrey", "Jeffrey");
 	IRC_SetIntData(BotID[0], E_IRC_CONNECT_DELAY, 20);
    BGroupID = IRC_CreateGroup();
    IRC_GroupSay(BGroupID, IRC_CHANNEL, "Jeffrey, the server bot, has joined the irc channel.");
	SetTimer("ServerCoreTimer", 1000, true);

	CreateCow(0);
	CreateCow(0);
	CreateCow(0);
	CreateCow(1);
	CreateCow(1);

	for(new i = 0; i < 60; i++) {

		gCowLastMove[i] = 0;
	}
	//job wage

	JobWage[POLICE] = 70;
	JobWage[SWAT] = 100;
	JobWage[ARMY] = 105;
	JobWage[MEDIC] = 30;
	JobWage[ITEMS] = 30;
	JobWage[WEP] = 30;

	//Checkpoints
	checkpoints[0] = CreateDynamicCP(-2110.3142,-445.6071,38.7344, 2, -1, -1, -1, 100.0); // leisure center
	checkpoints[1] = CreateDynamicCP(-1615.9908,686.2200,7.1875, 2, -1, -1, -1, 100.0); // cop gun point
	checkpoints[2] = CreateDynamicCP(-1676.2111,432.1548,7.1797, 2, -1, -1, -1, 100.0); //  24/7
 	checkpoints[3] = CreateDynamicCP(-2588.1697,59.9089,4.3422, 2, -1, -1, -1, 100.0); // hippy shopper 1
	checkpoints[4] = CreateDynamicCP(-2442.5732,754.9309,35.1719, 2, -1, -1, -1, 100.0); // super save
	//checkpoints[5] = CreateDynamicCP(-26.0607,-187.2907,1003.5469, 2, -1, 17, -1, 100.0); // shop exit
	checkpoints[6] = CreateDynamicCP(-2511.1479,-49.9410,25.6833, 2, -1, -1, -1, 100.0);//hippy shopper 2
	checkpoints[7] = CreateDynamicCP(-1955.1440,255.8476,41.0471, 3, -1, -1, -1, 100.0);//car buy checkpoint
	checkpoints[8] = CreateDynamicCP(-2766.1589,375.5858,6.3347, 2, -1, -1, -1, 100.0);//mayor building
	checkpoints[9] = CreateDynamicCP(-2053.5571,454.2387,35.1719, 3, -1, -1, -1, 100.0);//bank entrance
	checkpoints[10] = CreateDynamicCP(2305.3916,-16.0711,26.7496, 2, -1, -1, -1, 50.0);//bank exit
	checkpoints[11] = CreateDynamicCP(2316.4424,-7.5928,26.7422, 2, -1, -1, -1, 50.0);//bank menu
	checkpoints[12] = CreateDynamicCP(501.1848,-78.2146,998.7578, 2, 0, -1, -1, 100.0);//Bar rob
	checkpoints[13] = CreateDynamicCP(378.7888,-64.8880,1001.5078, 2, 0, -1, -1, 100.0);//Burger rob
	checkpoints[14] = CreateDynamicCP(-201.2298,-5.2262,1002.2734, 2, 0, -1, -1, 100.0);//Tat rob
	checkpoints[15] = CreateDynamicCP(203.5807,-40.4363,1001.8047, 2, 0, -1, -1, 100.0);//Suburban rob
	checkpoints[16] = CreateDynamicCP(502.8620,-23.7864,1000.6797, 2, 0, -1, -1, 100.0);//rob club
	checkpoints[17] = CreateDynamicCP(418.5417,-75.1641,1001.8047, 2, 0, -1, -1, 100.0);//Barber rob
	checkpoints[18] = CreateDynamicCP(371.8004,-4.3236,1001.8589, 2, 0, -1, -1, 100.0);//Clucking bell rob
	checkpoints[19] = CreateDynamicCP(207.6289,-98.3428,1005.2578, 2, 0, -1, -1, 100.0);//Binco rob
	checkpoints[20] = CreateDynamicCP(161.3155,-80.2635,1001.8047, 2, 0, -1, -1, 100.0);//Zip rob
	checkpoints[21] = CreateDynamicCP(379.1379,-116.3564,1001.4922, 2, 0, -1, -1, 100.0);//Pizza rob
	checkpoints[22] = CreateDynamicCP(204.8533,-8.0930,1001.2109, 2, 0, -1, -1, 100.0);//Victim rob
	checkpoints[23] = CreateDynamicCP(204.1348,-157.5937,1000.5234, 2, 0, -1, -1, 100.0);//Didier rob
	checkpoints[24] = CreateDynamicCP(207.0713,-127.3425,1003.5078, 2, 0, -1, -1, 100.0);//Pro laps rob
	checkpoints[25] = CreateDynamicCP(414.3527,-10.8976,1001.8120, 2, 0, -1, -1, 100.0);//Barber2 rob
	checkpoints[26] = CreateDynamicCP(-2655.0178,639.8524,14.4545, 2, -1, -1, -1, 100.0);//hospital cp
	checkpoints[27] = CreateDynamicCP(-2081.7068,71.6446,35.2503, 2, -1, -1, -1, 100.0);//crim base cp
	checkpoints[28] = CreateDynamicCP(-1754.1857,964.1262,24.8906, 3, -1, -1, -1, 100.0);//hotel cp

	CreateDynamicCP(322.4677, 110.0439, 1003.2095, 2, -1, -1, -1, 100.0);
	//Pickups
	pickups[0] = CreateDynamicPickup(1279, 1, -2184.2314,-262.8053,40.7195, -1, -1, -1, 100.0);//drug
	pickups[1] = CreateDynamicPickup(1274, 1,-19.3077,-184.5640,1003.5469, -1, -1, -1, 100.0);//shop
	//CreateDynamicPickup(954, 1, -2721.0088,989.9558,54.5639, -1, -1, -1, 100.0);

	//Vehicles.

	//LV
	total_vehicles += LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");

    //LS
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_airport.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");

    //SF
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/civilian.txt");

    //OTHER
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/whetstone.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/bone.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/flint.txt");
    //total_vehicles += LoadStaticVehiclesFromFile("vehicles/tierra.txt"); STAT
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/red_county.txt");

    printf("Total vehicles loaded from file: %d", total_vehicles);

	//Text labels
	CreateDynamic3DTextLabel("Armoury Weapons", COLOR_DBLUE, -1615.9908,686.2200,7.1875, 30.0);
	CreateDynamic3DTextLabel("[BANK EXIT]", -1, 2305.3916,-16.0711,26.7496, 30.0);
	CreateDynamic3DTextLabel("[BANK MENU]", -1, 2316.4424,-7.5928,26.7422, 30.0);
    CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 501.1848,-78.2146,998.7578, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 378.7888,-64.8880,1001.5078, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, -201.2298,-5.2262,1002.2734, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 203.5807,-40.4363,1001.8047, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 502.8620,-23.7864,1000.6797, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 418.5417,-75.1641,1001.8047, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 371.8004,-4.3236,1001.8589, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 207.6289,-98.3428,1005.2578, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 161.3155,-80.2635,1001.8047, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 379.1379,-116.3564,1001.4922, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 204.8533,-8.0930,1001.2109, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 204.1348,-157.5937,1000.5234, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 207.0713,-127.3425,1003.5078, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 414.3527,-10.8976,1001.8120, 30.0);

	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access criminal weapons", COLOR_WHITE, 311.9479,-169.7130,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access criminal clothing", COLOR_WHITE, 318.2002,-161.2641,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access criminal ammunition", COLOR_WHITE, 315.0459,-160.9110,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access criminal ammunition", COLOR_WHITE, 313.6811,-162.4501,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access criminal ammunition", COLOR_WHITE, 315.0622,-163.7775,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access criminal ammunition", COLOR_WHITE, 316.5235,-162.2851,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Press {00FF00}ENTER {FFFFFF}to access special items", COLOR_WHITE, 309.3592,-162.4006,999.5938, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 2);
	CreateDynamic3DTextLabel("Criminal resource base", COLOR_WHITE, -2081.7068,71.6446,35.2503, 30.0);

	//Gangzones
	ArmyGangzone[0] = GangZoneCreate(-1518,360,-1200,522);
	ArmyGangzone[1] = GangZoneCreate(-1620,258,-1314,414);
	ArmyGangzone[2] = GangZoneCreate (-1686,258,-1440,354);
	ArmyGangzone[3] = GangZoneCreate(-1560,306,-1398,480);
	ArmyGangzone[4] = GangZoneCreate(-1620,282,-1494,420);
	ArmyGangzone[5] = GangZoneCreate(-1548,384,-1380,528);
	SwatGangzone = GangZoneCreate(-1122,-768,-960,-582);
	StatGangzone = GangZoneCreate(-2304,2226,-2160,2364);
	SwatGangzone = GangZoneCreate(-2477.1289,476.7579, -2399.8323,552.8561);

	//Loading houses
	mysql_function_query (Gconnection, "SELECT * FROM `house`", true, "OnHousesLoaded", "", "");

	//Textdraws

    RulesTextDraw[0] = TextDrawCreate(465.000000, 99.000000, "                   ");
	TextDrawBackgroundColor(RulesTextDraw[0], 255);
	TextDrawFont(RulesTextDraw[0], 1);
	TextDrawLetterSize(RulesTextDraw[0], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[0], -1);
	TextDrawSetOutline(RulesTextDraw[0], 0);
	TextDrawSetProportional(RulesTextDraw[0], 1);
	TextDrawSetShadow(RulesTextDraw[0], 1);
	TextDrawUseBox(RulesTextDraw[0], 1);
	TextDrawBoxColor(RulesTextDraw[0], 255);
	TextDrawTextSize(RulesTextDraw[0], 169.000000, 0.000000);
	TextDrawSetSelectable(RulesTextDraw[0], 0);

	RulesTextDraw[1] = TextDrawCreate(468.000000, 99.000000, "   ");
	TextDrawBackgroundColor(RulesTextDraw[1], 255);
	TextDrawFont(RulesTextDraw[1], 1);
	TextDrawLetterSize(RulesTextDraw[1], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[1], -1);
	TextDrawSetOutline(RulesTextDraw[1], 0);
	TextDrawSetProportional(RulesTextDraw[1], 1);
	TextDrawSetShadow(RulesTextDraw[1], 1);
	TextDrawUseBox(RulesTextDraw[1], 1);
	TextDrawBoxColor(RulesTextDraw[1], 1863855615);
	TextDrawTextSize(RulesTextDraw[1], 166.000000, 0.000000);
	TextDrawSetSelectable(RulesTextDraw[1], 0);

	RulesTextDraw[2] = TextDrawCreate(297.000000, 102.000000, "Rules");
	TextDrawBackgroundColor(RulesTextDraw[2], 48);
	TextDrawFont(RulesTextDraw[2], 3);
	TextDrawLetterSize(RulesTextDraw[2], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[2], -1);
	TextDrawSetOutline(RulesTextDraw[2], 1);
	TextDrawSetProportional(RulesTextDraw[2], 1);
	TextDrawSetSelectable(RulesTextDraw[2], 0);

	RulesTextDraw[3] = TextDrawCreate(179.000000, 127.000000, ". No ~r~Deathmatching");
	TextDrawBackgroundColor(RulesTextDraw[3], 255);
	TextDrawFont(RulesTextDraw[3], 1);
	TextDrawLetterSize(RulesTextDraw[3], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[3], -1);
	TextDrawSetOutline(RulesTextDraw[3], 0);
	TextDrawSetProportional(RulesTextDraw[3], 1);
	TextDrawSetShadow(RulesTextDraw[3], 1);
	TextDrawSetSelectable(RulesTextDraw[3], 0);

	RulesTextDraw[4] = TextDrawCreate(179.000000, 139.000000, ". No ~r~Cheating");
	TextDrawBackgroundColor(RulesTextDraw[4], 255);
	TextDrawFont(RulesTextDraw[4], 1);
	TextDrawLetterSize(RulesTextDraw[4], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[4], -1);
	TextDrawSetOutline(RulesTextDraw[4], 0);
	TextDrawSetProportional(RulesTextDraw[4], 1);
	TextDrawSetShadow(RulesTextDraw[4], 1);
	TextDrawSetSelectable(RulesTextDraw[4], 0);

	RulesTextDraw[5] = TextDrawCreate(179.000000, 151.000000, ". No ~r~Advertisment");
	TextDrawBackgroundColor(RulesTextDraw[5], 255);
	TextDrawFont(RulesTextDraw[5], 1);
	TextDrawLetterSize(RulesTextDraw[5], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[5], -1);
	TextDrawSetOutline(RulesTextDraw[5], 0);
	TextDrawSetProportional(RulesTextDraw[5], 1);
	TextDrawSetShadow(RulesTextDraw[5], 1);
	TextDrawSetSelectable(RulesTextDraw[5], 0);

	RulesTextDraw[6] = TextDrawCreate(179.000000, 163.000000, ". No ~r~Racism");
	TextDrawBackgroundColor(RulesTextDraw[6], 255);
	TextDrawFont(RulesTextDraw[6], 1);
	TextDrawLetterSize(RulesTextDraw[6], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[6], -1);
	TextDrawSetOutline(RulesTextDraw[6], 0);
	TextDrawSetProportional(RulesTextDraw[6], 1);
	TextDrawSetShadow(RulesTextDraw[6], 1);
	TextDrawSetSelectable(RulesTextDraw[6], 0);

	RulesTextDraw[7] = TextDrawCreate(179.000000, 222.000000, ". Speak ~r~English");
	TextDrawBackgroundColor(RulesTextDraw[7], 255);
	TextDrawFont(RulesTextDraw[7], 1);
	TextDrawLetterSize(RulesTextDraw[7], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[7], -1);
	TextDrawSetOutline(RulesTextDraw[7], 0);
	TextDrawSetProportional(RulesTextDraw[7], 1);
	TextDrawSetShadow(RulesTextDraw[7], 1);
	TextDrawSetSelectable(RulesTextDraw[7], 0);

	RulesTextDraw[8] = TextDrawCreate(179.000000, 175.000000, ". No Mods That Give ~r~Advantages");
	TextDrawBackgroundColor(RulesTextDraw[8], 255);
	TextDrawFont(RulesTextDraw[8], 1);
	TextDrawLetterSize(RulesTextDraw[8], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[8], -1);
	TextDrawSetOutline(RulesTextDraw[8], 0);
	TextDrawSetProportional(RulesTextDraw[8], 1);
	TextDrawSetShadow(RulesTextDraw[8], 1);
	TextDrawSetSelectable(RulesTextDraw[8], 0);

	RulesTextDraw[9] = TextDrawCreate(179.000000, 187.000000, ". No ~r~Insulting");
	TextDrawBackgroundColor(RulesTextDraw[9], 255);
	TextDrawFont(RulesTextDraw[9], 1);
	TextDrawLetterSize(RulesTextDraw[9], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[9], -1);
	TextDrawSetOutline(RulesTextDraw[9], 0);
	TextDrawSetProportional(RulesTextDraw[9], 1);
	TextDrawSetShadow(RulesTextDraw[9], 1);
	TextDrawSetSelectable(RulesTextDraw[9], 0);

	RulesTextDraw[10] = TextDrawCreate(179.000000, 236.000000, ". Always ~r~Respect ~w~Staff");
	TextDrawBackgroundColor(RulesTextDraw[10], 255);
	TextDrawFont(RulesTextDraw[10], 1);
	TextDrawLetterSize(RulesTextDraw[10], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[10], -1);
	TextDrawSetOutline(RulesTextDraw[10], 0);
	TextDrawSetProportional(RulesTextDraw[10], 1);
	TextDrawSetShadow(RulesTextDraw[10], 1);
	TextDrawSetSelectable(RulesTextDraw[10], 0);

	RulesTextDraw[11] = TextDrawCreate(179.000000, 199.000000, ". No ~r~ScoreBoosting");
	TextDrawBackgroundColor(RulesTextDraw[11], 255);
	TextDrawFont(RulesTextDraw[11], 1);
	TextDrawLetterSize(RulesTextDraw[11], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[11], -1);
	TextDrawSetOutline(RulesTextDraw[11], 0);
	TextDrawSetProportional(RulesTextDraw[11], 1);
	TextDrawSetShadow(RulesTextDraw[11], 1);
	TextDrawSetSelectable(RulesTextDraw[11], 0);

	RulesTextDraw[12] = TextDrawCreate(179.000000, 210.000000, ". No ~r~Abusing ~w~Bugs");
	TextDrawBackgroundColor(RulesTextDraw[12], 255);
	TextDrawFont(RulesTextDraw[12], 1);
	TextDrawLetterSize(RulesTextDraw[12], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[12], -1);
	TextDrawSetOutline(RulesTextDraw[12], 0);
	TextDrawSetProportional(RulesTextDraw[12], 1);
	TextDrawSetShadow(RulesTextDraw[12], 1);
	TextDrawSetSelectable(RulesTextDraw[12], 0);

	RulesTextDraw[13] = TextDrawCreate(282.000000, 253.000000, "Have ~g~fun!");
	TextDrawBackgroundColor(RulesTextDraw[13], 255);
	TextDrawFont(RulesTextDraw[13], 1);
	TextDrawLetterSize(RulesTextDraw[13], 0.500000, 1.000000);
	TextDrawColor(RulesTextDraw[13], -1);
	TextDrawSetOutline(RulesTextDraw[13], 0);
	TextDrawSetProportional(RulesTextDraw[13], 1);
	TextDrawSetShadow(RulesTextDraw[13], 1);
	TextDrawSetSelectable(RulesTextDraw[13], 0);

	timetext = TextDrawCreate(547.000000, 23.000000, "");
  	TextDrawBackgroundColor(timetext, 255);
   	TextDrawFont(timetext, 3);
   	TextDrawLetterSize(timetext, 0.599999, 2.100000);
    TextDrawColor(timetext, -1);
    TextDrawSetOutline(timetext, 1);
    TextDrawSetProportional(timetext, 1);

	DialogBoxes[0] = TextDrawCreate(469.000000, 130.000000, "             ");
	TextDrawBackgroundColor(DialogBoxes[0], 255);
	TextDrawFont(DialogBoxes[0], 1);
	TextDrawLetterSize(DialogBoxes[0], 0.500000, 1.000000);
	TextDrawColor(DialogBoxes[0], -1);
	TextDrawSetOutline(DialogBoxes[0], 0);
	TextDrawSetProportional(DialogBoxes[0], 1);
	TextDrawSetShadow(DialogBoxes[0], 1);
	TextDrawUseBox(DialogBoxes[0], 1);
	TextDrawBoxColor(DialogBoxes[0], 64);
	TextDrawTextSize(DialogBoxes[0], 164.000000, 0.000000);
	TextDrawSetSelectable(DialogBoxes[0], 0);

	DialogBoxes[1] = TextDrawCreate(469.000000, 130.000000, "   ");
	TextDrawBackgroundColor(DialogBoxes[1], 255);
	TextDrawFont(DialogBoxes[1], 1);
	TextDrawLetterSize(DialogBoxes[1], 0.500000, 1.000000);
	TextDrawColor(DialogBoxes[1], -1);
	TextDrawSetOutline(DialogBoxes[1], 0);
	TextDrawSetProportional(DialogBoxes[1], 1);
	TextDrawSetShadow(DialogBoxes[1], 1);
	TextDrawUseBox(DialogBoxes[1], 1);
	TextDrawBoxColor(DialogBoxes[1], 0x2e72d0AA);
	TextDrawTextSize(DialogBoxes[1], 164.000000, 0.000000);
	TextDrawSetSelectable(DialogBoxes[1], 0);

	//button left
	DialogButtons[0] = TextDrawCreate( 290.000000, 210.000000, "   ");
	TextDrawBackgroundColor( DialogButtons[0], 255);
	TextDrawFont( DialogButtons[0], 1);
	TextDrawLetterSize( DialogButtons[0], 0.500000, 1.000000);
	TextDrawColor( DialogButtons[0], -1);
	TextDrawSetOutline( DialogButtons[0], 0);
	TextDrawSetProportional( DialogButtons[0], 1);
	TextDrawSetShadow( DialogButtons[0], 1);
	TextDrawUseBox( DialogButtons[0], 1);
	TextDrawBoxColor( DialogButtons[0], 0x2e72d0AA);
	TextDrawTextSize( DialogButtons[0], 210.000000, 20.000000);
	TextDrawSetSelectable( DialogButtons[0], 0);

	//button right
	DialogButtons[1] = TextDrawCreate( 421.000000, 210.000000, "   ");
	TextDrawBackgroundColor( DialogButtons[1], 255);
	TextDrawFont( DialogButtons[1], 1);
	TextDrawLetterSize( DialogButtons[1], 0.500000, 1.000000);
	TextDrawColor( DialogButtons[1], -1);
	TextDrawSetOutline( DialogButtons[1], 0);
	TextDrawSetProportional( DialogButtons[1], 1);
	TextDrawSetShadow( DialogButtons[1], 1);
	TextDrawUseBox( DialogButtons[1], 1);
	TextDrawBoxColor( DialogButtons[1], 0x2e72d0AA);
	TextDrawTextSize( DialogButtons[1], 342.000000, 20.000000);
	TextDrawSetSelectable( DialogButtons[1], 0);

	DialogButtons[2] = TextDrawCreate( 368.000000, 210.000000, "   ");
	TextDrawBackgroundColor( DialogButtons[2], 255);
	TextDrawFont( DialogButtons[2], 1);
	TextDrawLetterSize( DialogButtons[2], 0.500000, 1.000000);
	TextDrawColor( DialogButtons[2], -1);
	TextDrawSetOutline( DialogButtons[2], 0);
	TextDrawSetProportional( DialogButtons[2], 1);
	TextDrawSetShadow( DialogButtons[2], 1);
	TextDrawUseBox( DialogButtons[2], 1);
	TextDrawBoxColor( DialogButtons[2], 0x2e72d0AA);
	TextDrawTextSize( DialogButtons[2], 265.000000, 20.000000);
	TextDrawSetSelectable( DialogButtons[2], 0);

	URL = TextDrawCreate(502.000000, 3.000000, "www.sf-cnr.co.uk");
	TextDrawBackgroundColor(URL, 255);
	TextDrawFont(URL, 2);
	TextDrawLetterSize(URL, 0.250000, 1.200000);
	TextDrawColor(URL, -1);
	TextDrawSetOutline(URL, 1);
	TextDrawSetProportional(URL, 1);
	TextDrawSetSelectable(URL, 0);


	VehButtons[0] = TextDrawCreate(504.000000, 193.000000, "ld_beat:right");
	TextDrawBackgroundColor(VehButtons[0], 0);
	TextDrawFont(VehButtons[0], 4);
	TextDrawLetterSize(VehButtons[0], 0.840000, 3.300000);
	TextDrawColor(VehButtons[0], -1);
	TextDrawSetOutline(VehButtons[0], 0);
	TextDrawSetProportional(VehButtons[0], 1);
	TextDrawSetShadow(VehButtons[0], 1);
	TextDrawUseBox(VehButtons[0], 1);
	TextDrawBoxColor(VehButtons[0], 255);
	TextDrawTextSize(VehButtons[0], 45.000000, 36.000000);
	TextDrawSetSelectable(VehButtons[0], 1);

	VehButtons[1] = TextDrawCreate(74.000000, 193.000000, "ld_beat:left");
	TextDrawBackgroundColor(VehButtons[1], 0);
	TextDrawFont(VehButtons[1], 4);
	TextDrawLetterSize(VehButtons[1], 0.840000, 3.300000);
	TextDrawColor(VehButtons[1], -1);
	TextDrawSetOutline(VehButtons[1], 0);
	TextDrawSetProportional(VehButtons[1], 1);
	TextDrawSetShadow(VehButtons[1], 1);
	TextDrawUseBox(VehButtons[1], 1);
	TextDrawBoxColor(VehButtons[1], 255);
	TextDrawTextSize(VehButtons[1], 45.000000, 36.000000);
	TextDrawSetSelectable(VehButtons[1], 1);

	JobSelection[0] = TextDrawCreate(589.000000, 85.000000, "                               ");
	TextDrawBackgroundColor(JobSelection[0], 255);
	TextDrawFont(JobSelection[0], 1);
	TextDrawLetterSize(JobSelection[0], 0.500000, 1.000000);
	TextDrawColor(JobSelection[0], -1);
	TextDrawSetOutline(JobSelection[0], 0);
	TextDrawSetProportional(JobSelection[0], 1);
	TextDrawSetShadow(JobSelection[0], 1);
	TextDrawUseBox(JobSelection[0], 1);
	TextDrawBoxColor(JobSelection[0], 1096134911);
	TextDrawTextSize(JobSelection[0], 55.000000, 0.000000);
	TextDrawSetSelectable(JobSelection[0], 0);

	JobSelection[1] = TextDrawCreate(73.000000, 88.000000, "Class Selection");
	TextDrawBackgroundColor(JobSelection[1], 255);
	TextDrawFont(JobSelection[1], 2);
	TextDrawLetterSize(JobSelection[1], 0.370000, 1.700000);
	TextDrawColor(JobSelection[1], -1);
	TextDrawSetOutline(JobSelection[1], 1);
	TextDrawSetProportional(JobSelection[1], 1);
	TextDrawSetSelectable(JobSelection[1], 0);

	JobSelection[2] = TextDrawCreate(589.000000, 85.000000, "    ");
	TextDrawBackgroundColor(JobSelection[2], 255);
	TextDrawFont(JobSelection[2], 1);
	TextDrawLetterSize(JobSelection[2], 0.500000, 1.000000);
	TextDrawColor(JobSelection[2], -1);
	TextDrawSetOutline(JobSelection[2], 0);
	TextDrawSetProportional(JobSelection[2], 1);
	TextDrawSetShadow(JobSelection[2], 1);
	TextDrawUseBox(JobSelection[2], 1);
	TextDrawBoxColor(JobSelection[2], 319951615);
	TextDrawTextSize(JobSelection[2], 55.000000, 0.000000);
	TextDrawSetSelectable(JobSelection[2], 0);

	JobSelection[3] = TextDrawCreate(183.000000, 123.000000, "                        ");
	TextDrawBackgroundColor(JobSelection[3], 255);
	TextDrawFont(JobSelection[3], 1);
	TextDrawLetterSize(JobSelection[3], 0.500000, 1.000000);
	TextDrawColor(JobSelection[3], -1);
	TextDrawSetOutline(JobSelection[3], 0);
	TextDrawSetProportional(JobSelection[3], 1);
	TextDrawSetShadow(JobSelection[3], 1);
	TextDrawUseBox(JobSelection[3], 1);
	TextDrawBoxColor(JobSelection[3], 910926591);
	TextDrawTextSize(JobSelection[3], 55.000000, 0.000000);
	TextDrawSetSelectable(JobSelection[3], 0);

	JobSelection[4] = TextDrawCreate(69.000000, 127.000000, "Drug Dealer");
	TextDrawBackgroundColor(JobSelection[4], 255);
	TextDrawFont(JobSelection[4], 2);
	TextDrawLetterSize(JobSelection[4], 0.340000, 1.200000);
	TextDrawColor(JobSelection[4], -1);
	TextDrawSetOutline(JobSelection[4], 1);
	TextDrawSetProportional(JobSelection[4], 1);
	TextDrawSetSelectable(JobSelection[4], 1);

	JobSelection[5] = TextDrawCreate(69.000000, 149.000000, "Pedo");
	TextDrawBackgroundColor(JobSelection[5], 255);
	TextDrawFont(JobSelection[5], 2);
	TextDrawLetterSize(JobSelection[5], 0.340000, 1.200000);
	TextDrawColor(JobSelection[5], -1);
	TextDrawSetOutline(JobSelection[5], 1);
	TextDrawSetProportional(JobSelection[5], 1);
	TextDrawSetSelectable(JobSelection[5], 1);

	JobSelection[6] = TextDrawCreate(69.000000, 170.000000, "Wep Dealer");
	TextDrawBackgroundColor(JobSelection[6], 255);
	TextDrawFont(JobSelection[6], 2);
	TextDrawLetterSize(JobSelection[6], 0.340000, 1.200000);
	TextDrawColor(JobSelection[6], -1);
	TextDrawSetOutline(JobSelection[6], 1);
	TextDrawSetProportional(JobSelection[6], 1);
	TextDrawSetSelectable(JobSelection[6], 1);

	JobSelection[7] = TextDrawCreate(69.000000, 191.000000, "Thief");
	TextDrawBackgroundColor(JobSelection[7], 255);
	TextDrawFont(JobSelection[7], 2);
	TextDrawLetterSize(JobSelection[7], 0.340000, 1.200000);
	TextDrawColor(JobSelection[7], -1);
	TextDrawSetOutline(JobSelection[7], 1);
	TextDrawSetProportional(JobSelection[7], 1);
	TextDrawSetSelectable(JobSelection[7], 1);

	JobSelection[8] = TextDrawCreate(69.000000, 211.000000, "Items Dealer");
	TextDrawBackgroundColor(JobSelection[8], 255);
	TextDrawFont(JobSelection[8], 2);
	TextDrawLetterSize(JobSelection[8], 0.340000, 1.200000);
	TextDrawColor(JobSelection[8], -1);
	TextDrawSetOutline(JobSelection[8], 1);
	TextDrawSetProportional(JobSelection[8], 1);
	TextDrawSetSelectable(JobSelection[8], 1);

	JobSelection[9] = TextDrawCreate(69.000000, 231.000000, "Rapist");
	TextDrawBackgroundColor(JobSelection[9], 255);
	TextDrawFont(JobSelection[9], 2);
	TextDrawLetterSize(JobSelection[9], 0.340000, 1.200000);
	TextDrawColor(JobSelection[9], -1);
	TextDrawSetOutline(JobSelection[9], 1);
	TextDrawSetProportional(JobSelection[9], 1);
	TextDrawSetSelectable(JobSelection[9], 1);

	JobSelection[10] = TextDrawCreate(69.000000, 251.000000, "Kidnapper");
	TextDrawBackgroundColor(JobSelection[10], 255);
	TextDrawFont(JobSelection[10], 2);
	TextDrawLetterSize(JobSelection[10], 0.340000, 1.200000);
	TextDrawColor(JobSelection[10], -1);
	TextDrawSetOutline(JobSelection[10], 1);
	TextDrawSetProportional(JobSelection[10], 1);
	TextDrawSetSelectable(JobSelection[10], 1);

	JobSelection[11] = TextDrawCreate(69.000000, 272.000000, "Terrorist");
	TextDrawBackgroundColor(JobSelection[11], 255);
	TextDrawFont(JobSelection[11], 2);
	TextDrawLetterSize(JobSelection[11], 0.340000, 1.200000);
	TextDrawColor(JobSelection[11], -1);
	TextDrawSetOutline(JobSelection[11], 1);
	TextDrawSetProportional(JobSelection[11], 1);
	TextDrawSetSelectable(JobSelection[11], 1);

	JobSelection[12] = TextDrawCreate(69.000000, 294.000000, "Car Jacker");
	TextDrawBackgroundColor(JobSelection[12], 255);
	TextDrawFont(JobSelection[12], 2);
	TextDrawLetterSize(JobSelection[12], 0.340000, 1.200000);
	TextDrawColor(JobSelection[12], -1);
	TextDrawSetOutline(JobSelection[12], 1);
	TextDrawSetProportional(JobSelection[12], 1);
	TextDrawSetSelectable(JobSelection[12], 1);

	JobSelection[13] = TextDrawCreate(69.000000, 316.000000, "Whore");
	TextDrawBackgroundColor(JobSelection[13], 255);
	TextDrawFont(JobSelection[13], 2);
	TextDrawLetterSize(JobSelection[13], 0.340000, 1.200000);
	TextDrawColor(JobSelection[13], -1);
	TextDrawSetOutline(JobSelection[13], 1);
	TextDrawSetProportional(JobSelection[13], 1);
	TextDrawSetSelectable(JobSelection[13], 1);

	JobSelection[14] = TextDrawCreate(579.000000, 125.000000, "       ");
	TextDrawBackgroundColor(JobSelection[14], 255);
	TextDrawFont(JobSelection[14], 1);
	TextDrawLetterSize(JobSelection[14], 0.500000, 1.000000);
	TextDrawColor(JobSelection[14], -1);
	TextDrawSetOutline(JobSelection[14], 0);
	TextDrawSetProportional(JobSelection[14], 1);
	TextDrawSetShadow(JobSelection[14], 1);
	TextDrawUseBox(JobSelection[14], 1);
	TextDrawBoxColor(JobSelection[14], 572662527);
	TextDrawTextSize(JobSelection[14], 302.000000, 0.000000);
	TextDrawSetSelectable(JobSelection[14], 0);

	JobSelection[15] = TextDrawCreate(418.000000, 125.000000, "Info");
	TextDrawBackgroundColor(JobSelection[15], 255);
	TextDrawFont(JobSelection[15], 2);
	TextDrawLetterSize(JobSelection[15], 0.409999, 1.100000);
	TextDrawColor(JobSelection[15], -1);
	TextDrawSetOutline(JobSelection[15], 1);
	TextDrawSetProportional(JobSelection[15], 1);
	TextDrawSetSelectable(JobSelection[15], 0);

	JobSelection[16] = TextDrawCreate(580.000000, 324.000000, "   ");
	TextDrawBackgroundColor(JobSelection[16], 255);
	TextDrawFont(JobSelection[16], 1);
	TextDrawLetterSize(JobSelection[16], 0.500000, 1.000000);
	TextDrawColor(JobSelection[16], -1);
	TextDrawSetOutline(JobSelection[16], 0);
	TextDrawSetProportional(JobSelection[16], 1);
	TextDrawSetShadow(JobSelection[16], 1);
	TextDrawUseBox(JobSelection[16], 1);
	TextDrawBoxColor(JobSelection[16], 572662527);
	TextDrawTextSize(JobSelection[16], 470.000000, 0.000000);
	TextDrawSetSelectable(JobSelection[16], 0);

	JobSelection[17] = TextDrawCreate(497.000000, 326.000000, "Spawn");
	TextDrawBackgroundColor(JobSelection[17], 255);
	TextDrawFont(JobSelection[17], 2);
	TextDrawLetterSize(JobSelection[17], 0.389999, 1.299999);
	TextDrawColor(JobSelection[17], -1);
	TextDrawSetOutline(JobSelection[17], 1);
	TextDrawSetProportional(JobSelection[17], 1);
	TextDrawSetSelectable(JobSelection[17], 1);

	// Add our player classes.

	AddPlayerClass(165,-2185.2268,2416.2488,5.1836,179.4194,0,0,0,0,0,0); // statpos1
	AddPlayerClass(166,-2237.9580,2353.4204,4.9802,139.6023,0,0,0,0,0,0); // statpos2
	AddPlayerClass(287,-1345.1957,501.4555,18.2344,4.3111,0,0,0,0,0,0); // armypos1
	AddPlayerClass(179,-1345.1957,501.4555,18.2344,4.3111,0,0,0,0,0,0); // armypos2
	AddPlayerClass(285,-1040.0908,-642.3456,32.0078,116.2276,0,0,0,0,0,0); // swatpos
	AddPlayerClass(279,-1040.0908,-642.3456,32.0078,116.2276,0,0,0,0,0,0); // Firefighter
	AddPlayerClass(147,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//mayor
	AddPlayerClass(155,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//pizza boy
 	AddPlayerClass(265,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 1
  	AddPlayerClass(266,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 2
   	AddPlayerClass(267,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 3
   	AddPlayerClass(280,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 4
    AddPlayerClass(281,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 5
    AddPlayerClass(282,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 6
    AddPlayerClass(283,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 7
    AddPlayerClass(284,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 8
    AddPlayerClass(288,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 9
    AddPlayerClass(61,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // pilot
    AddPlayerClass(220,-1985.3322,137.4805,27.6875,88.6009,0,0,0,0,0,0);//Driver (taxi)
 	AddPlayerClass(247,-2060.8259,1161.4252,46.1480,1.9959,0,0,0,0,0,0); // civilainspawn1
	AddPlayerClass(1,-1881.8544,823.8978,35.1759,37.2722,0,0,0,0,0,0); // civilainspawn2
 	AddPlayerClass(2,-2314.1809,-11.7072,35.3203,87.2880,0,0,0,0,0,0); // civilianspawn3
	AddPlayerClass(3,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn4
	AddPlayerClass(4,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn5
	AddPlayerClass(5,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn6
	AddPlayerClass(6,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn7
	AddPlayerClass(7,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn8
	AddPlayerClass(8,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn9
	AddPlayerClass(9,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn10
	AddPlayerClass(10,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn11
	AddPlayerClass(11,-2169.1365,742.9042,64.8667,167.9534,0,0,0,0,0,0); // civilianspawn12
	AddPlayerClass(12,-2116.6648,926.3867,86.0791,181.0840,0,0,0,0,0,0); // civilianspawn13
    AddPlayerClass(13,-2551.9285,54.4629,16.4219,178.6517,0,0,0,0,0,0); // civilianspawn14
	AddPlayerClass(14,-2231.2878,252.3141,35.3203,93.4476,0,0,0,0,0,0); // civilianspawn15
	AddPlayerClass(15,-1738.8618,860.2408,24.8828,176.3124,0,0,0,0,0,0); // civilianspawn16
	AddPlayerClass(16,-1988.5133,1117.8582,54.4730,272.7819,0,0,0,0,0,0); // civilianspawn17
	AddPlayerClass(17,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn18
	AddPlayerClass(18,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn19
	AddPlayerClass(19,-2023.8074,-405.6918,38.7344,352.9976,0,0,0,0,0,0); // civilianspawn20
	AddPlayerClass(20,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn21
	AddPlayerClass(21,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn22
	AddPlayerClass(22,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn23
	AddPlayerClass(23,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn24
	AddPlayerClass(24,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn25
	AddPlayerClass(25,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn26
	AddPlayerClass(26,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn27
	AddPlayerClass(27,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn28
	AddPlayerClass(28,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn29
	AddPlayerClass(29,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn30
	AddPlayerClass(30,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn31
	AddPlayerClass(31,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn32
	AddPlayerClass(32,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn33
	AddPlayerClass(33,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn34
	AddPlayerClass(34,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn35
	AddPlayerClass(35,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn36
	AddPlayerClass(36,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn37
	AddPlayerClass(37,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn38
	AddPlayerClass(38,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn39
	AddPlayerClass(39,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn40
	AddPlayerClass(40,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn41
	AddPlayerClass(41,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn42
	AddPlayerClass(43,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn43
	AddPlayerClass(45,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn44
	AddPlayerClass(46,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn45
	AddPlayerClass(47,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn46
	AddPlayerClass(48,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn47
	AddPlayerClass(49,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn48
	AddPlayerClass(51,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn49
	AddPlayerClass(52,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn50
	AddPlayerClass(53,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn51
	AddPlayerClass(54,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn52
	AddPlayerClass(55,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn53
	AddPlayerClass(56,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn54
	AddPlayerClass(57,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn55
	AddPlayerClass(58,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn56
	AddPlayerClass(59,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn57
	AddPlayerClass(60,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn58
	AddPlayerClass(62,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn60
	AddPlayerClass(63,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn61
	AddPlayerClass(64,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn62
	AddPlayerClass(65,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn63
	AddPlayerClass(66,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn64
	AddPlayerClass(67,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn65
	AddPlayerClass(68,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn66
	AddPlayerClass(69,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn67
	AddPlayerClass(70,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn68
	AddPlayerClass(71,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn69
	AddPlayerClass(72,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn70
	AddPlayerClass(73,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn71
	AddPlayerClass(74,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn72
	AddPlayerClass(86,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn73
	AddPlayerClass(76,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn74
	AddPlayerClass(77,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn75
	AddPlayerClass(78,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn78
	AddPlayerClass(79,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn79
	AddPlayerClass(80,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn80
	AddPlayerClass(81,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn81
	AddPlayerClass(82,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn82
	AddPlayerClass(83,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn83
	AddPlayerClass(84,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn84
	AddPlayerClass(85,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn85
	AddPlayerClass(87,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn86
	AddPlayerClass(88,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn87
	AddPlayerClass(89,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn88
	AddPlayerClass(90,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn89
	AddPlayerClass(91,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn90
	AddPlayerClass(92,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn91
	AddPlayerClass(93,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn92
	AddPlayerClass(94,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn93
	AddPlayerClass(95,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn94
	AddPlayerClass(96,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn95
	AddPlayerClass(97,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn96
	AddPlayerClass(98,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn97
	AddPlayerClass(99,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn98
	AddPlayerClass(100,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn99
	AddPlayerClass(247,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn100
	AddPlayerClass(248,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn101
	AddPlayerClass(254,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn102
    AddPlayerClass(170,-2765.9897,375.4386,6.3347,278.5965,0,0,0,0,0,0);//civilianspawn103
    AddPlayerClass(264,-2767.3179,788.7258,52.7813,262.3263,0,0,0,0,0,0);//civilianspawn104
    AddPlayerClass(216,-2442.7800,752.9677,35.1719,179.2369,0,0,0,0,0,0);//civilianspawn105
    AddPlayerClass(75,-2359.2136,1006.7867,50.6953,87.5064,0,0,0,0,0,0);//civilianspawn106
    AddPlayerClass(170,-1725.3872,1356.5693,7.1799,107.8884,0,0,0,0,0,0);//civilianspawn107
    AddPlayerClass(143,-1985.3896,665.8715,46.5683,275.6404,0,0,0,0,0,0);//civilianspawn108
    AddPlayerClass(101,-2383.1177,-584.4406,132.1172,90.4442,0,0,0,0,0,0);//civilianspawn109
    AddPlayerClass(246,-1989.2987,1118.1178,54.4688,272.2214,0,0,0,0,0,0);//civilianspawn110
    AddPlayerClass(276,-2651.2454,609.7889,14.4531,191.8591,0,0,0,0,0,0);//medic
    AddPlayerClass(202,-1547.2676,126.4054,3.5547,137.0018,0,0,0,0,0,0);//trucker
    AddPlayerClass(42,-2030.6611,156.5619,28.8359,272.7437,0,0,0,0,0,0);//mechanic
    AddPlayerClass(223,-1712.3699,7.4375,3.5547,316.8104,0,0,0,0,0,0);//hitman
    AddPlayerClass(158,-1712.3699,7.4375,3.5547,316.8104,0,0,0,0,0,0);//farmer


    //maps

    //fierro devils HQ map
    CreateDynamicObject(19362, -1874.73962, -157.60110, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1878.24133, -157.58389, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1874.73706, -151.19090, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1874.74084, -147.98990, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1878.24609, -147.98390, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1878.22986, -151.18900, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19447, -1873.04053, -160.86259, 14.41510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19362, -1878.22949, -154.38750, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1874.73718, -154.39600, 10.89140,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19447, -1879.88196, -160.85490, 14.40440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, -1875.17358, -157.05530, 14.40910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19447, -1873.02258, -151.24240, 14.41510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, -1873.05273, -160.87500, 12.71570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, -1875.17358, -157.03529, 12.71570,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14826, -1874.96228, -153.21100, 11.36270,   0.00000, 0.00000, 90.10540);
	CreateDynamicObject(941, -1877.46924, -156.07930, 11.38730,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(918, -1873.89587, -156.16870, 11.43850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(918, -1873.36365, -156.56212, 11.33850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(918, -1873.33691, -155.95320, 11.33850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1225, -1873.55029, -155.07190, 11.35920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2690, -1878.64673, -156.67480, 11.33870,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2121, -1877.27625, -155.15309, 11.48260,   0.00000, 0.00000, 18.91045);
	CreateDynamicObject(2121, -1878.32043, -155.08971, 11.48260,   0.00000, 0.00000, 57.56220);
	CreateDynamicObject(19447, -1873.04260, -151.24240, 12.71570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, -1879.85376, -151.22150, 14.39830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, -1879.90186, -160.85490, 12.71570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19447, -1879.87366, -151.22150, 12.71570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2254, -1877.10010, -156.93260, 13.50250,   0.00000, 0.00000, 179.76849);
	CreateDynamicObject(2255, -1879.26941, -153.51920, 13.32730,   0.00000, 0.00000, 89.68970);
	CreateDynamicObject(1676, -1879.31494, -150.34830, 12.51490,   0.00000, 0.00000, 270.73230);
	CreateDynamicObject(2057, -1879.16040, -156.61789, 11.15830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1330, -1879.28723, -155.92630, 11.37420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3632, -1873.91626, -148.85507, 11.45740,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3632, -1873.46875, -147.86459, 11.45740,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2672, -1878.07690, -153.83405, 11.25650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1712, -1879.27148, -153.84200, 10.97840,   0.00000, 0.00000, 90.98780);
	CreateDynamicObject(1327, -1879.00024, -147.90530, 11.90520,   0.00000, -10.00000, 0.00000);
	CreateDynamicObject(1893, -1872.56055, -155.41220, 14.45680,   90.00000, 0.00000, 89.52900);
	CreateDynamicObject(1893, -1872.53760, -149.70248, 14.45680,   90.00000, 0.00000, 89.52899);
	CreateDynamicObject(1893, -1872.54846, -152.70190, 14.45680,   90.00000, 0.00000, 89.52899);
	CreateDynamicObject(1893, -1872.53760, -149.70248, 14.45680,   90.00000, 0.00000, 89.52899);
	CreateDynamicObject(3785, -1873.17273, -146.87790, 14.36730,   0.00000, 0.00000, 200.40759);
	CreateDynamicObject(17951, -1876.19861, -146.53790, 15.13780,   0.00000, 0.00000, 269.96649);
	CreateDynamicObject(19428, -1880.05627, -146.47960, 14.51000,   0.00000, 0.00000, 271.29910);
	CreateDynamicObject(19428, -1880.05627, -146.45959, 12.43820,   0.00000, 0.00000, 271.29910);
	CreateDynamicObject(19454, -1889.59705, -151.21010, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1875.17786, -157.89999, 16.24400,   0.00000, 90.00000, 269.93530);
	CreateDynamicObject(19454, -1874.75378, -151.34540, 16.24400,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19425, -1877.68164, -146.34680, 10.88360,   0.00000, 0.00000, 360.00000);
	CreateDynamicObject(19425, -1874.64404, -146.34880, 10.88360,   0.00000, 0.00000, 360.00000);
	CreateDynamicObject(19355, -1888.81433, -146.55531, 12.64080,   0.00000, 0.00000, 270.40698);
	CreateDynamicObject(19385, -1885.65796, -146.53790, 12.64300,   0.00000, 0.00000, 90.95450);
	CreateDynamicObject(19355, -1880.19482, -173.12350, 12.54080,   0.00000, 0.00000, 359.76880);
	CreateDynamicObject(19462, -1884.82568, -148.34290, 10.85110,   0.00000, 90.00000, 270.57489);
	CreateDynamicObject(19462, -1891.35425, -151.43930, 10.85110,   0.00000, 90.00000, 180.34621);
	CreateDynamicObject(19450, -1890.03601, -151.46680, 12.68620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19450, -1880.08044, -151.36230, 12.68620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19462, -1884.78650, -151.84030, 10.85110,   0.00000, 90.00000, 270.57489);
	CreateDynamicObject(19388, -1885.19971, -156.98599, 12.68080,   0.00000, 0.00000, 270.55106);
	CreateDynamicObject(19358, -1888.40405, -157.01570, 12.69090,   0.00000, 0.00000, 270.46921);
	CreateDynamicObject(19358, -1888.90759, -146.77020, 12.69090,   0.00000, 0.00000, 270.46921);
	CreateDynamicObject(19388, -1885.70544, -146.69730, 12.68080,   0.00000, 0.00000, 271.17880);
	CreateDynamicObject(19358, -1882.00244, -156.96429, 12.69090,   0.00000, 0.00000, 270.46921);
	CreateDynamicObject(1502, -1884.42151, -156.94051, 10.93790,   0.00000, 0.00000, 180.53529);
	CreateDynamicObject(19462, -1884.75549, -155.32910, 10.85110,   0.00000, 90.00000, 270.57489);
	CreateDynamicObject(19385, -1880.18884, -176.33510, 12.54530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, -1880.16089, -179.53380, 12.54080,   0.00000, 0.00000, 359.76880);
	CreateDynamicObject(1499, -1884.91162, -146.50800, 10.87630,   0.00000, 0.00000, 180.76263);
	CreateDynamicObject(19401, -1882.47034, -146.50220, 12.64050,   0.00000, 0.00000, 270.34491);
	CreateDynamicObject(19404, -1882.50073, -146.63330, 12.67780,   0.00000, 0.00000, 270.69800);
	CreateDynamicObject(19446, -1890.06116, -161.92650, 12.67160,   0.00000, 0.00000, 0.07840);
	CreateDynamicObject(19446, -1880.30566, -161.85851, 12.67160,   0.00000, 0.00000, 0.07840);
	CreateDynamicObject(19354, -1882.01013, -157.08490, 12.65350,   0.00000, 0.00000, 270.52490);
	CreateDynamicObject(19384, -1885.34033, -168.50729, 12.68090,   0.00000, 0.00000, 271.21420);
	CreateDynamicObject(1491, -1886.08374, -168.56470, 11.03810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19427, -1890.02405, -157.94740, 12.66810,   0.00000, 0.00000, 180.20660);
	CreateDynamicObject(19427, -1883.04956, -168.16040, 12.64810,   0.00000, 0.00000, 295.44623);
	CreateDynamicObject(19354, -1881.76807, -167.50575, 12.65350,   0.00000, 0.00000, 297.93207);
	CreateDynamicObject(19384, -1885.21411, -157.10651, 12.67660,   0.00000, 0.00000, 270.40500);
	CreateDynamicObject(19354, -1888.89966, -167.53300, 12.65350,   0.00000, 0.00000, 231.87320);
	CreateDynamicObject(19354, -1888.41321, -157.12219, 12.65350,   0.00000, 0.00000, 270.52490);
	CreateDynamicObject(19363, -1880.39758, -179.50301, 12.66990,   0.00000, 0.00000, 359.38480);
	CreateDynamicObject(19363, -1880.24683, -168.42320, 12.66990,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19363, -1881.89746, -168.75900, 12.66990,   0.00000, 0.00000, 257.97409);
	CreateDynamicObject(19363, -1888.89221, -169.18221, 12.66990,   0.00000, 0.00000, 294.64151);
	CreateDynamicObject(19363, -1890.08118, -168.57620, 12.66990,   0.00000, 0.00000, 180.88789);
	CreateDynamicObject(19458, -1885.20227, -158.82150, 10.95450,   0.00000, 90.00000, 270.36221);
	CreateDynamicObject(19458, -1885.17090, -165.14799, 10.91450,   0.00000, 90.00000, 270.36221);
	CreateDynamicObject(19458, -1885.18152, -162.30881, 10.95450,   0.00000, 90.00000, 270.36221);
	CreateDynamicObject(19357, -1883.69580, -174.88240, 12.72560,   0.00000, 0.00000, 359.93329);
	CreateDynamicObject(19363, -1890.04456, -171.78870, 12.66990,   0.00000, 0.00000, 180.88789);
	CreateDynamicObject(19363, -1881.90845, -179.73241, 12.66990,   0.00000, 0.00000, 270.17773);
	CreateDynamicObject(19392, -1880.36450, -176.29990, 12.63440,   0.00000, 0.00000, 180.44730);
	CreateDynamicObject(19363, -1888.33374, -173.34320, 12.66990,   0.00000, 0.00000, 89.14291);
	CreateDynamicObject(19363, -1883.59546, -174.96820, 12.66990,   0.00000, 0.00000, 0.35380);
	CreateDynamicObject(19357, -1888.37256, -173.50240, 12.74560,   0.00000, 0.00000, 269.33920);
	CreateDynamicObject(19357, -1889.85474, -176.55321, 12.74560,   0.00000, 0.00000, 270.85275);
	CreateDynamicObject(19357, -1890.15991, -178.36639, 12.74560,   0.00000, 0.00000, 180.08630);
	CreateDynamicObject(19357, -1888.48254, -179.71510, 12.74560,   0.00000, 0.00000, 90.54004);
	CreateDynamicObject(19357, -1885.27124, -179.72290, 12.74560,   0.00000, 0.00000, 89.37030);
	CreateDynamicObject(19357, -1883.69727, -178.06750, 12.72560,   0.00000, 0.00000, 359.93329);
	CreateDynamicObject(19387, -1888.29480, -175.01221, 12.73600,   0.00000, 0.00000, 180.20670);
	CreateDynamicObject(19357, -1888.79260, -173.46240, 12.74560,   0.00000, 0.00000, 269.33920);
	CreateDynamicObject(19392, -1885.33435, -168.55730, 12.67440,   0.00000, 0.00000, 270.76929);
	CreateDynamicObject(19363, -1880.24414, -171.62080, 12.66990,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19363, -1880.31714, -173.40710, 12.66990,   0.00000, 0.00000, 359.38477);
	CreateDynamicObject(1523, -1888.24243, -175.79860, 10.90470,   0.00000, 0.00000, 90.04720);
	CreateDynamicObject(19452, -1882.00635, -176.83810, 10.97340,   0.00000, 90.00000, 180.03751);
	CreateDynamicObject(19452, -1885.16455, -170.32240, 10.97340,   0.00000, 90.00000, 270.75070);
	CreateDynamicObject(19363, -1889.05652, -167.68269, 12.66990,   0.00000, 0.00000, 232.73180);
	CreateDynamicObject(19363, -1881.76282, -167.57790, 12.66990,   0.00000, 0.00000, 298.99139);
	CreateDynamicObject(19392, -1885.13428, -173.34109, 12.67440,   0.00000, 0.00000, 270.76929);
	CreateDynamicObject(19436, -1882.93884, -168.47971, 12.66780,   0.00000, 0.00000, 274.56030);
	CreateDynamicObject(19436, -1887.04602, -168.59920, 12.66780,   0.00000, 0.00000, 274.56030);
	CreateDynamicObject(19433, -1888.98755, -172.45340, 10.99300,   0.00000, 90.00000, 359.68701);
	CreateDynamicObject(19433, -1885.49329, -172.60950, 10.99300,   0.00000, 90.00000, 0.61520);
	CreateDynamicObject(19363, -1883.58447, -178.15970, 12.66990,   0.00000, 0.00000, 0.35380);
	CreateDynamicObject(19362, -1885.54114, -175.18559, 11.02760,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1888.31750, -175.18570, 11.06760,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1888.31750, -178.38530, 11.10760,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19362, -1885.54907, -178.37849, 11.02760,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19439, -1887.97083, -167.27589, 10.87270,   0.00000, 90.00000, 318.03531);
	CreateDynamicObject(19439, -1882.49463, -166.94991, 10.87270,   0.00000, 90.00000, 26.00750);
	CreateDynamicObject(19439, -1885.48523, -167.69820, 10.89270,   0.00000, 90.00000, 0.10510);
	CreateDynamicObject(19431, -1880.59485, -146.63290, 12.70220,   0.00000, 0.00000, 270.84259);
	CreateDynamicObject(19431, -1890.03015, -156.53641, 12.70220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19431, -1880.08936, -156.98470, 12.70220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19431, -1880.64941, -156.94470, 12.70220,   0.00000, 0.00000, 270.84259);
	CreateDynamicObject(19427, -1886.92761, -168.52251, 12.66810,   0.00000, 0.00000, 269.33310);
	CreateDynamicObject(19462, -1891.35425, -152.15930, 10.83110,   0.00000, 90.00000, 180.34621);
	CreateDynamicObject(1649, -1882.65698, -146.52780, 12.13850,   0.00000, 0.00000, 0.72140);
	CreateDynamicObject(14752, -1882.47998, -146.85910, 12.90120,   0.00000, 0.00000, 89.51240);
	CreateDynamicObject(2117, -1885.66907, -164.44431, 11.00230,   0.00000, 0.00000, 270.31271);
	CreateDynamicObject(2117, -1885.71228, -160.46820, 11.04230,   0.00000, 0.00000, 270.31271);
	CreateDynamicObject(2117, -1885.69727, -162.44690, 11.04230,   0.00000, 0.00000, 270.31271);
	CreateDynamicObject(2117, -1884.70154, -162.45441, 11.04230,   0.00000, 0.00000, 270.31271);
	CreateDynamicObject(2117, -1884.68384, -164.43330, 10.98230,   0.00000, 0.00000, 270.31271);
	CreateDynamicObject(2117, -1884.73621, -160.47749, 11.04230,   0.00000, 0.00000, 270.31271);
	CreateDynamicObject(1739, -1885.26477, -166.07341, 11.92800,   0.00000, 0.00000, 270.04202);
	CreateDynamicObject(1739, -1883.70020, -161.15730, 11.92800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1739, -1883.74097, -162.96536, 11.92800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1739, -1883.69214, -164.85864, 11.92800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1739, -1886.80664, -164.92137, 11.92800,   0.00000, 0.00000, 179.26250);
	CreateDynamicObject(1739, -1886.74060, -163.12564, 11.92800,   0.00000, 0.00000, 179.26250);
	CreateDynamicObject(1739, -1886.86963, -161.16145, 11.92800,   0.00000, 0.00000, 179.26250);
	CreateDynamicObject(1739, -1885.32922, -159.75003, 11.92800,   0.00000, 0.00000, 95.43951);
	CreateDynamicObject(16151, -1881.25305, -152.43990, 11.25770,   0.00000, 0.00000, 0.58340);
	CreateDynamicObject(1753, -1889.41602, -155.56830, 10.93720,   0.00000, 0.00000, 90.21960);
	CreateDynamicObject(2290, -1886.55713, -156.37050, 10.94040,   0.00000, 0.00000, 180.08929);
	CreateDynamicObject(1822, -1888.52466, -155.35728, 10.93887,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2001, -1889.69202, -147.03351, 10.91920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2964, -1887.87952, -150.21922, 10.93801,   0.00000, 0.00000, 269.96933);
	CreateDynamicObject(338, -1887.15552, -150.95790, 11.23590,   0.00000, -10.00000, 0.00000);
	CreateDynamicObject(338, -1887.15552, -150.83791, 11.23590,   0.00000, -10.00000, 0.00000);
	CreateDynamicObject(2965, -1887.90918, -150.55910, 11.85510,   0.00000, 0.00000, 331.56519);
	CreateDynamicObject(2001, -1889.55151, -156.53542, 10.91920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2001, -1880.29333, -156.75558, 10.91920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2001, -1880.21765, -147.00746, 10.91920,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1712, -1882.06580, -169.53300, 11.05920,   0.00000, 0.00000, 324.09299);
	CreateDynamicObject(1711, -1881.80127, -179.00218, 11.05999,   0.00000, 0.00000, 180.85835);
	CreateDynamicObject(2254, -1882.35901, -156.85550, 13.17330,   0.00000, 0.00000, 180.38519);
	CreateDynamicObject(2257, -1880.19336, -154.48891, 13.15180,   0.00000, 0.00000, 270.10001);
	CreateDynamicObject(19173, -1889.94531, -154.49850, 12.59280,   0.00000, 0.00000, 270.06711);
	CreateDynamicObject(1486, -1887.82617, -154.69792, 11.55640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1888.00024, -154.97681, 11.55640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1888.26001, -154.66469, 11.55640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1888.02002, -154.46500, 11.55640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1950, -1887.76819, -154.92039, 11.59640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2823, -1888.27466, -154.91110, 11.43600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1882.30786, -151.76643, 12.02440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1882.38904, -152.18980, 12.02440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1882.42810, -151.46950, 12.02440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, -1882.41260, -150.71262, 11.88450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, -1882.51587, -150.42780, 11.88450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, -1882.61206, -151.04588, 11.90450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, -1882.32715, -150.94250, 11.90450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1951, -1882.24817, -152.45224, 12.06450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1951, -1882.10364, -151.87410, 12.06450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2894, -1885.60449, -165.65630, 11.82710,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(941, -1881.05298, -163.48672, 11.52130,   0.00000, 0.00000, 269.43152);
	CreateDynamicObject(941, -1889.25830, -161.08073, 11.52130,   0.00000, 0.00000, 269.99588);
	CreateDynamicObject(941, -1881.12097, -160.55901, 11.52130,   0.00000, 0.00000, 271.22739);
	CreateDynamicObject(941, -1889.23218, -163.65654, 11.52130,   0.00000, 0.00000, 269.99588);
	CreateDynamicObject(2058, -1881.09375, -160.23950, 12.01560,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3014, -1880.79907, -158.70889, 11.72810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3014, -1880.85132, -157.47450, 11.26210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3014, -1880.83435, -158.24290, 11.26210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3014, -1880.80334, -159.13651, 11.26210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3014, -1880.79004, -157.81329, 11.72810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3014, -1880.79907, -158.22890, 12.18810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, -1880.79919, -161.40443, 11.97510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, -1880.86316, -160.95590, 11.97510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1577, -1889.70898, -160.49612, 11.97510,   0.00000, 0.00000, 68.43761);
	CreateDynamicObject(1578, -1881.38611, -161.18600, 11.97510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1579, -1881.34326, -160.80840, 11.95520,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1580, -1881.09558, -160.96350, 12.08640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1672, -1880.80298, -163.19531, 12.09580,   0.00000, 0.00000, 317.31711);
	CreateDynamicObject(1672, -1881.11169, -163.25960, 12.09580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1672, -1881.05579, -162.85742, 12.09580,   0.00000, 0.00000, 317.31711);
	CreateDynamicObject(1672, -1881.30823, -163.12512, 12.09580,   0.00000, 0.00000, 317.31711);
	CreateDynamicObject(2034, -1881.08582, -164.00020, 12.01570,   0.00000, 0.00000, 294.62289);
	CreateDynamicObject(2035, -1888.90466, -163.62096, 12.01570,   0.00000, 0.00000, 278.02570);
	CreateDynamicObject(2036, -1889.16980, -164.31538, 12.01560,   0.00000, 0.00000, 338.11414);
	CreateDynamicObject(2044, -1889.18823, -162.22588, 12.01560,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2040, -1889.09509, -160.62407, 12.12150,   0.00000, 0.00000, 298.72507);
	CreateDynamicObject(2057, -1880.73389, -165.81557, 11.18220,   0.00000, 0.00000, 284.72400);
	CreateDynamicObject(2049, -1880.44788, -163.89970, 13.11710,   0.00000, 0.00000, 269.71051);
	CreateDynamicObject(2050, -1880.45752, -160.84821, 13.13860,   0.00000, 0.00000, 269.02539);
	CreateDynamicObject(2048, -1885.23999, -157.23599, 13.88070,   0.00000, 0.00000, 359.30179);
	CreateDynamicObject(2048, -1885.29163, -168.38429, 13.86070,   0.00000, 0.00000, 181.54550);
	CreateDynamicObject(2055, -1882.28369, -157.27025, 13.16545,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2035, -1881.49207, -163.94380, 12.01570,   0.00000, 0.00000, 278.02570);
	CreateDynamicObject(2035, -1889.51294, -163.53571, 12.01570,   0.00000, 0.00000, 278.02570);
	CreateDynamicObject(2035, -1889.21289, -163.57777, 12.01570,   0.00000, 0.00000, 278.02570);
	CreateDynamicObject(2036, -1880.74744, -164.02690, 12.01560,   0.00000, 0.00000, 286.85959);
	CreateDynamicObject(2036, -1889.22668, -164.72153, 12.01560,   0.00000, 0.00000, 338.11414);
	CreateDynamicObject(2044, -1880.93079, -164.62050, 12.01560,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2044, -1889.05920, -162.04099, 12.01560,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2044, -1889.46130, -161.98462, 12.01560,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2040, -1881.44971, -164.72830, 12.12150,   0.00000, 0.00000, 33.60770);
	CreateDynamicObject(2040, -1889.42822, -161.50876, 12.12150,   0.00000, 0.00000, 33.60770);
	CreateDynamicObject(2040, -1889.02612, -161.56512, 12.12150,   0.00000, 0.00000, 354.95602);
	CreateDynamicObject(2040, -1889.35608, -160.99344, 12.12150,   0.00000, 0.00000, 354.95602);
	CreateDynamicObject(2040, -1888.85095, -161.06424, 12.12150,   0.00000, 0.00000, 354.95602);
	CreateDynamicObject(1577, -1881.31714, -161.67220, 11.97510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2057, -1880.78918, -165.17450, 11.18220,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(359, -1880.58899, -162.50169, 12.88859,   0.00000, 0.00000, 267.44070);
	CreateDynamicObject(2395, -1880.45435, -161.02020, 11.05330,   0.00000, 0.00000, 270.05469);
	CreateDynamicObject(359, -1880.58899, -162.50169, 13.19160,   0.00000, 0.00000, 267.44070);
	CreateDynamicObject(1550, -1889.67310, -159.79866, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.79309, -158.69980, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.69446, -158.17918, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.78284, -157.58228, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.32263, -157.53421, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.59619, -159.32710, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.29541, -158.56827, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1889.09998, -158.07477, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1550, -1888.63025, -157.71213, 11.39140,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1212, -1885.30701, -164.11531, 11.84764,   0.00000, 0.00000, 165.43161);
	CreateDynamicObject(1212, -1885.45642, -164.60962, 11.84764,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1212, -1885.49194, -164.26065, 11.84764,   0.00000, 0.00000, 301.76215);
	CreateDynamicObject(1212, -1885.60669, -164.88846, 11.84764,   0.00000, 0.00000, 229.32343);
	CreateDynamicObject(1212, -1885.74866, -164.32207, 11.84764,   0.00000, 0.00000, 229.32343);
	CreateDynamicObject(1212, -1885.44324, -164.43074, 11.84764,   0.00000, 0.00000, 165.43161);
	CreateDynamicObject(1212, -1885.77295, -164.55118, 11.84764,   0.00000, 0.00000, 165.43161);
	CreateDynamicObject(1486, -1885.94800, -160.56029, 11.98810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1884.41663, -161.17171, 11.98810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, -1884.75696, -161.57220, 11.98810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2860, -1885.26697, -161.04790, 11.84820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2858, -1884.75684, -164.37660, 11.78740,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2064, -1874.67517, -147.65919, 16.95660,   0.00000, 0.00000, 179.39340);
	CreateDynamicObject(2985, -1876.32312, -147.41220, 16.32240,   0.00000, 0.00000, 90.00100);
	CreateDynamicObject(2255, -1882.08423, -167.02510, 12.64620,   0.00000, 0.00000, 208.81760);
	CreateDynamicObject(19164, -1885.19885, -162.92830, 11.92810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19175, -1889.96851, -162.83681, 13.15990,   0.00000, 0.00000, 90.18486);
	CreateDynamicObject(19317, -1888.47314, -167.70799, 13.40330,   0.00000, 50.00000, 145.23920);
	CreateDynamicObject(19318, -1888.74194, -167.51401, 12.83320,   0.00000, 50.00000, 139.09140);
	CreateDynamicObject(19319, -1889.02490, -167.32030, 12.20890,   0.00000, 50.00000, 141.34930);
	CreateDynamicObject(1670, -1882.14111, -149.37970, 11.90490,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2103, -1882.26721, -154.41980, 11.88450,   0.00000, 0.00000, 273.34991);
	CreateDynamicObject(2232, -1880.24683, -146.88000, 13.67250,   0.00000, 0.00000, 325.94119);
	CreateDynamicObject(2232, -1880.29907, -156.72368, 13.67250,   0.00000, 0.00000, 229.64571);
	CreateDynamicObject(2232, -1889.79492, -156.72740, 13.67250,   0.00000, 0.00000, 136.75330);
	CreateDynamicObject(2232, -1889.64612, -147.08803, 13.67250,   0.00000, 0.00000, 46.20272);
	CreateDynamicObject(2099, -1888.12561, -146.87061, 10.93870,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1778, -1880.66455, -171.14468, 11.06090,   0.00000, 0.00000, 325.51569);
	CreateDynamicObject(1828, -1885.46680, -151.89960, 10.91760,   0.00000, 0.00000, 300.90799);
	CreateDynamicObject(19387, -1885.15625, -173.50070, 12.73600,   0.00000, 0.00000, 270.71841);
	CreateDynamicObject(19357, -1890.16370, -175.15170, 12.74560,   0.00000, 0.00000, 180.08630);
	CreateDynamicObject(19387, -1888.29565, -178.04614, 12.73600,   0.00000, 0.00000, 180.20670);
	CreateDynamicObject(1523, -1884.36096, -173.29660, 10.90470,   0.00000, 0.00000, 180.70500);
	CreateDynamicObject(1523, -1888.25305, -178.84300, 10.90470,   0.00000, 0.00000, 90.04720);
	CreateDynamicObject(1736, -1887.97034, -157.53210, 13.42850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1712, -1889.42139, -172.27090, 11.05920,   0.00000, 0.00000, 91.03010);
	CreateDynamicObject(2225, -1880.73059, -166.76849, 11.00190,   0.00000, 0.00000, 248.47530);
	CreateDynamicObject(1518, -1880.56836, -166.54420, 13.70410,   0.00000, 0.00000, 239.41080);
	CreateDynamicObject(2602, -1884.17212, -178.56540, 11.62160,   0.00000, 0.00000, 271.82690);
	CreateDynamicObject(2602, -1884.18579, -175.82120, 11.62160,   0.00000, 0.00000, 271.82690);
	CreateDynamicObject(2602, -1884.16553, -177.19980, 11.62160,   0.00000, 0.00000, 271.82690);
	CreateDynamicObject(2525, -1889.56885, -178.31779, 11.15630,   0.00000, 0.00000, 90.10390);
	CreateDynamicObject(2525, -1889.57275, -175.06841, 11.15630,   0.00000, 0.00000, 90.10390);
	CreateDynamicObject(2524, -1886.61462, -179.10941, 11.17500,   0.00000, 0.00000, 179.77980);
	CreateDynamicObject(2524, -1884.63867, -179.09171, 11.09500,   0.00000, 0.00000, 182.16420);
	CreateDynamicObject(2524, -1885.67175, -179.11740, 11.09500,   0.00000, 0.00000, 179.77980);
	CreateDynamicObject(1235, -1884.24255, -174.49840, 11.63500,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, -1878.24097, -151.34261, 16.24400,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1886.14185, -170.45779, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1886.10095, -151.21860, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1881.78845, -180.27820, 14.38870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1882.63025, -160.86031, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1882.64966, -170.49380, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1882.65735, -180.11749, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1886.14246, -180.08200, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1886.12244, -160.83350, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1889.62476, -160.84891, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1889.63025, -170.47830, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1889.63440, -180.10080, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1882.61804, -151.22580, 14.46870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1881.67700, -151.39880, 14.50870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1881.63464, -161.02730, 14.50870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19454, -1881.77881, -170.66431, 14.38870,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(1661, -1885.11829, -163.58389, 14.01680,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, -1885.94287, -176.30283, 14.05430,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, -1882.00195, -177.44330, 14.05430,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, -1881.96619, -171.47484, 14.05430,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1734, -1885.43506, -152.29510, 14.37690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1687, -1888.18298, -153.11380, 15.36090,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1688, -1888.03979, -159.03807, 15.57315,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1689, -1878.51404, -153.33150, 17.18790,   0.00000, 0.00000, 88.33270);
	CreateDynamicObject(1692, -1882.27820, -176.14401, 15.27445,   0.00000, 0.00000, 269.33209);
	CreateDynamicObject(910, -1885.89380, -134.83160, 12.36330,   0.00000, 0.00000, 76.64390);
	CreateDynamicObject(910, -1884.99780, -129.85110, 12.78330,   0.00000, 0.00000, 76.64390);
	CreateDynamicObject(910, -1885.50195, -132.29990, 12.62330,   0.00000, 0.00000, 76.64390);
	CreateDynamicObject(1227, -1884.12012, -127.40665, 12.39370,   0.00000, 0.00000, 75.46387);
	CreateDynamicObject(1333, -1883.49194, -124.81900, 12.77140,   0.00000, 0.00000, 260.12250);
	CreateDynamicObject(1437, -1870.06311, -144.62019, 12.10120,   -10.00000, 0.00000, 179.53430);
	CreateDynamicObject(922, -1887.40234, -137.91980, 12.01187,   0.00000, 0.00000, 258.31058);
	CreateDynamicObject(987, -1847.29565, -154.23994, 7.93486,   0.00000, 0.00000, 90.21313);
	CreateDynamicObject(971, -1847.06909, -165.90773, 10.92547,   0.00000, 0.00000, 89.45168);
	CreateDynamicObject(987, -1847.22473, -189.54073, 8.34090,   0.00000, 0.00000, 90.21313);
	CreateDynamicObject(987, -1847.19104, -168.78062, 7.93486,   0.00000, 0.00000, 90.21313);
	CreateDynamicObject(987, -1847.35303, -142.29213, 7.93486,   0.00000, 0.00000, 90.21313);
	CreateDynamicObject(1215, -1848.43884, -146.11313, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1872.02332, -146.13884, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1868.24573, -146.09799, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1864.71045, -146.01443, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1859.89587, -146.26929, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1847.85864, -130.30118, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1852.19214, -146.21098, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1855.82996, -146.20500, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1873.40332, -124.67475, 11.49524,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1863.34656, -126.57462, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1859.07239, -126.72188, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1855.38477, -126.86317, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1850.97717, -126.98183, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2064, -1874.67517, -147.65919, 11.59810,   0.00000, 0.00000, 176.13770);
	CreateDynamicObject(2985, -1875.68591, -148.09480, 10.97850,   0.00000, 0.00000, 90.00100);
	CreateDynamicObject(967, -1874.59241, -124.93767, 10.89094,   0.00000, 0.00000, 74.98278);
	CreateDynamicObject(966, -1876.21594, -123.96178, 10.56946,   0.00000, 0.00000, 348.28888);
	CreateDynamicObject(968, -1876.25195, -123.94280, 11.51840,   0.00000, -20.00000, 347.83279);
	CreateDynamicObject(1215, -1867.42590, -125.95482, 11.39221,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, -1870.76746, -125.30975, 11.49524,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1297, -1871.37561, -178.66322, 11.63301,   0.00000, 0.00000, 272.55429);
	CreateDynamicObject(1297, -1849.15405, -143.97743, 14.34228,   0.00000, 0.00000, 356.32263);
	CreateDynamicObject(1297, -1848.77271, -178.35947, 11.63301,   0.00000, 0.00000, 272.55429);
	CreateDynamicObject(1297, -1854.59131, -178.30505, 11.63301,   0.00000, 0.00000, 272.55429);
	CreateDynamicObject(1297, -1860.20227, -178.61670, 11.63301,   0.00000, 0.00000, 272.55429);
	CreateDynamicObject(1297, -1865.40515, -178.66412, 11.63301,   0.00000, 0.00000, 272.55429);
	CreateDynamicObject(1297, -1887.99646, -142.91946, 14.13612,   0.00000, 0.00000, 157.35472);
	CreateDynamicObject(1297, -1848.94495, -133.68668, 14.34228,   0.00000, 0.00000, 356.32263);
	CreateDynamicObject(1297, -1849.15527, -138.74889, 14.34228,   0.00000, 0.00000, 356.32263);
	CreateDynamicObject(971, -1847.05811, -179.60796, 10.92547,   0.00000, 0.00000, 89.45168);
	CreateDynamicObject(1280, -1882.42334, -146.06361, 11.29392,   0.00000, 0.00000, 270.12283);
	CreateDynamicObject(1280, -1888.52014, -145.98894, 11.29392,   0.00000, 0.00000, 270.12283);
	CreateDynamicObject(1297, -1882.92651, -122.37712, 15.26049,   0.00000, 0.00000, 224.91576);
	CreateDynamicObject(3928, -1857.10840, -155.00549, 20.67370,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8572, -1868.72302, -153.06320, 19.05750,   0.00000, 0.00000, 268.40320);
	CreateDynamicObject(1499, -1880.20764, -177.08040, 10.95480,   0.00000, 0.00000, 90.61280);
	AddStaticVehicleEx(463,-1850.0464000,-136.5824000,11.3686000,102.7331000,-1,-1,15); //Freeway
	AddStaticVehicleEx(463,-1850.2921000,-143.9169000,11.3686000,102.7331000,-1,-1,15); //Freeway
	AddStaticVehicleEx(463,-1850.1732000,-142.5974000,11.3686000,102.7331000,-1,-1,15); //Freeway
	AddStaticVehicleEx(463,-1850.1405000,-141.0456000,11.3686000,102.7331000,-1,-1,15); //Freeway
	AddStaticVehicleEx(463,-1850.1079000,-139.4961000,11.3686000,102.7331000,-1,-1,15); //Freeway
	AddStaticVehicleEx(463,-1850.0773000,-138.0445000,11.3686000,102.7331000,-1,-1,15); //Freeway
	AddStaticVehicleEx(586,-1849.8586000,-129.6577000,11.3692000,107.5425000,-1,-1,15); //Wayfarer
	AddStaticVehicleEx(586,-1849.8464000,-134.8021000,11.3692000,107.5425000,-1,-1,15); //Wayfarer
	AddStaticVehicleEx(586,-1849.8501000,-133.2522000,11.3692000,107.5425000,-1,-1,15); //Wayfarer
	AddStaticVehicleEx(586,-1849.8542000,-131.5064000,11.3692000,107.5425000,-1,-1,15); //Wayfarer
	AddStaticVehicleEx(482,-1862.1844000,-143.6092000,11.8851000,0.0000000,-1,-1,15); //Burrito
	AddStaticVehicleEx(554,-1857.1379000,-130.1315000,11.8846000,177.3878000,-1,-1,15); //Yosemite
	AddStaticVehicleEx(475,-1861.0826000,-129.6534000,11.5930000,178.3914000,-1,-1,15); //Sabre
	AddStaticVehicleEx(600,-1865.1593000,-129.2302000,11.5945000,180.9919000,-1,-1,15); //Picador
	AddStaticVehicleEx(560,-1851.4189000,-169.5377000,8.8083000,0.0000000,-1,-1,15); //Sultan
	AddStaticVehicleEx(560,-1855.9043000,-169.6032000,8.7683000,0.0000000,-1,-1,15); //Sultan

	//stat map
	CreateDynamicObject(4571,-2505.9394500,-689.3858000,74.3257000,0.0000000,0.0000000,269.6835000); //
	CreateDynamicObject(4571,-2506.3886700,-656.8720100,74.3587000,0.0000000,0.0000000,269.4679900); //
	CreateDynamicObject(19454,-2486.8593800,-640.4539200,136.4503900,0.0000000,0.0000000,359.3703900); //
	CreateDynamicObject(19454,-2501.1489300,-625.9503800,136.4633900,0.0000000,0.0000000,89.4149000); //
	CreateDynamicObject(19454,-2491.5380900,-626.0568800,132.9796000,0.0000000,0.0000000,89.4149000); //
	CreateDynamicObject(19454,-2510.7644000,-625.8465000,136.4776000,0.0000000,0.0000000,89.4149000); //
	CreateDynamicObject(19454,-2501.1489300,-625.9503800,132.9796000,0.0000000,0.0000000,89.4149000); //
	CreateDynamicObject(19454,-2510.7644000,-625.8465000,132.9796000,0.0000000,0.0000000,89.4149000); //
	CreateDynamicObject(19454,-2491.5380900,-626.0568800,136.4503900,0.0000000,0.0000000,89.4149000); //
	CreateDynamicObject(19454,-2486.7783200,-630.8325200,136.4503900,0.0000000,0.0000000,359.2591900); //
	CreateDynamicObject(987,-2487.1274400,-719.3234300,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(987,-2498.6765100,-626.1198700,138.3526000,0.0000000,0.0000000,179.6411000); //
	CreateDynamicObject(987,-2487.0310100,-649.8131700,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(8613,-2509.4133300,-621.7912000,134.9851100,0.0000000,0.0000000,178.9622000); //
	CreateDynamicObject(987,-2487.1149900,-632.1022900,131.4861000,0.0000000,0.0000000,87.6998000); //
	CreateDynamicObject(987,-2486.7602500,-626.2854000,138.3196000,0.0000000,0.0000000,179.3392000); //
	CreateDynamicObject(987,-2487.0710400,-661.6862200,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(987,-2486.9553200,-673.6987300,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(987,-2486.9760700,-685.6187100,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(987,-2487.0971700,-697.5837400,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(987,-2542.3425300,-688.4319500,138.3526000,0.0000000,0.0000000,270.8178700); //
	CreateDynamicObject(987,-2486.9792500,-638.4758900,138.3196000,0.0000000,0.0000000,89.6567000); //
	CreateDynamicObject(987,-2541.9077100,-619.2175300,131.4861000,0.0000000,0.0000000,269.8797900); //
	CreateDynamicObject(9241,-2526.8447300,-706.8059100,139.7566100,0.0000000,0.0000000,179.6466100); //
	CreateDynamicObject(987,-2487.0473600,-709.5885600,138.3526000,0.0000000,0.0000000,89.8577000); //
	CreateDynamicObject(987,-2498.9880400,-719.1936600,138.3526000,0.0000000,0.0000000,0.5938600); //
	CreateDynamicObject(987,-2538.4318800,-719.6511200,138.3526000,0.0000000,0.0000000,0.5938600); //
	CreateDynamicObject(987,-2542.2922400,-719.6095000,138.3526000,0.0000000,0.0000000,0.5938600); //
	CreateDynamicObject(987,-2542.4751000,-707.4569100,138.3526000,0.0000000,0.0000000,271.4331100); //
	CreateDynamicObject(987,-2542.4387200,-695.5891700,138.3526000,0.0000000,0.0000000,270.8178700); //
	CreateDynamicObject(987,-2526.4829100,-719.5791600,138.3526000,0.0000000,0.0000000,0.5938600); //
	CreateDynamicObject(987,-2514.1606400,-707.4276700,138.3526000,0.0000000,0.0000000,91.1298400); //
	CreateDynamicObject(987,-2502.6811500,-719.1849400,138.3526000,0.0000000,0.0000000,0.5938600); //
	CreateDynamicObject(987,-2485.8383800,-611.4556900,131.4861000,0.0000000,0.0000000,89.0219000); //
	CreateDynamicObject(987,-2485.6442900,-606.3695700,131.4861000,0.0000000,0.0000000,89.8380700); //
	CreateDynamicObject(987,-2485.6394000,-594.6585100,131.4861000,0.0000000,0.0000000,180.5056200); //
	CreateDynamicObject(987,-2497.6403800,-594.7377900,131.4861000,0.0000000,0.0000000,180.0995800); //
	CreateDynamicObject(987,-2509.6462400,-594.7164900,131.4861000,0.0000000,0.0000000,180.0995800); //
	CreateDynamicObject(987,-2521.6142600,-594.6111500,131.4861000,0.0000000,0.0000000,180.0995800); //
	CreateDynamicObject(987,-2530.5129400,-594.7766100,131.4861000,0.0000000,0.0000000,180.0995900); //
	CreateDynamicObject(987,-2541.9038100,-595.0595100,131.4861000,0.0000000,0.0000000,270.0808100); //
	CreateDynamicObject(987,-2541.8972200,-607.0955200,131.4861000,0.0000000,0.0000000,269.8797900); //
	CreateDynamicObject(987,-2514.5322300,-719.2720900,138.3526000,0.0000000,0.0000000,0.5938600); //
	CreateDynamicObject(987,-2513.8618200,-719.3567500,138.3526000,0.0000000,0.0000000,91.1298400); //
	CreateDynamicObject(654,-2484.2695300,-660.9972500,136.4993100,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(654,-2482.1938500,-704.0059800,137.1145200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(654,-2471.5419900,-676.6515500,134.8298200,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(705,-2477.0332000,-666.2099000,135.6987000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(971,-2485.9628900,-615.8967900,135.1002000,0.0000000,0.0000000,86.3364000); //
	CreateDynamicObject(1536,-2514.8960000,-660.4826000,138.3250000,0.0000000,0.0000000,89.8023500); //
	CreateDynamicObject(1536,-2514.9255400,-660.4559900,138.3250000,0.0000000,0.0000000,269.8551000); //
	CreateDynamicObject(1215,-2537.5710400,-598.6171300,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2487.8881800,-625.6967200,132.1535900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2492.3938000,-625.6182900,132.1866000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2497.3547400,-625.5498000,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2502.0578600,-625.6539900,132.2525900,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2507.0805700,-625.5883800,132.2856000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1278,-2540.2790500,-690.5324700,138.3279300,0.0000000,0.0000000,42.9564100); //
	CreateDynamicObject(1278,-2488.1867700,-718.0403400,138.3279300,0.0000000,0.0000000,33.6077100); //
	CreateDynamicObject(1278,-2513.2019000,-718.8113400,138.3279300,0.0000000,0.0000000,135.8338200); //
	CreateDynamicObject(1278,-2487.9997600,-627.4591700,138.3640400,0.0000000,0.0000000,329.3262300); //
	CreateDynamicObject(3279,-2493.8430200,-711.7938200,138.3430000,0.0000000,0.0000000,181.7992200); //
	CreateDynamicObject(3279,-2492.4335900,-632.8717700,138.3430000,0.0000000,0.0000000,269.2080700); //
	CreateDynamicObject(1290,-2511.8620600,-598.1332400,137.2557500,0.0000000,0.0000000,1.2930800); //
	CreateDynamicObject(1290,-2496.5246600,-598.2307700,137.2557500,0.0000000,0.0000000,1.2930800); //
	CreateDynamicObject(1290,-2534.8198200,-598.2374300,137.2557500,0.0000000,0.0000000,1.2930800); //
	CreateDynamicObject(1290,-2504.1752900,-598.1940300,137.2557500,0.0000000,0.0000000,1.2930800); //
	CreateDynamicObject(1290,-2519.5927700,-598.2404800,137.2557500,0.0000000,0.0000000,1.2930800); //
	CreateDynamicObject(1290,-2527.1533200,-598.2374300,137.2557500,0.0000000,0.0000000,1.2930800); //
	CreateDynamicObject(1215,-2512.1337900,-625.5308200,132.3186000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2537.5188000,-619.7396200,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2537.5261200,-616.0181900,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2537.6201200,-611.9918800,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2537.6176800,-608.0269800,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1215,-2537.6057100,-603.4262700,132.2196000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(967,-2487.3559600,-610.4656400,131.5815400,0.0000000,0.0000000,358.2742000); //
	CreateDynamicObject(966,-2487.2768600,-612.2520800,131.5273000,0.0000000,0.0000000,86.3109000); //
	CreateDynamicObject(1226,-2512.6342800,-701.4304200,141.9764600,0.0000000,0.0000000,179.6485400); //
	CreateDynamicObject(1226,-2510.2253400,-627.3591900,141.9765000,0.0000000,0.0000000,88.3855000); //
	CreateDynamicObject(1226,-2489.1921400,-649.9173600,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2489.0752000,-658.8614500,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2489.0127000,-667.7183800,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2488.9050300,-676.7587300,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2489.0075700,-685.8639500,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2488.9570300,-694.5990000,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2489.3022500,-641.1346400,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2498.7199700,-628.1178000,141.9765000,0.0000000,0.0000000,83.6442000); //
	CreateDynamicObject(1226,-2504.4406700,-627.9412800,141.9765000,0.0000000,0.0000000,88.3855000); //
	CreateDynamicObject(1226,-2489.1154800,-703.7494500,141.9764600,0.0000000,0.0000000,359.4744600); //
	CreateDynamicObject(1226,-2502.9008800,-717.1880500,141.9764600,0.0000000,0.0000000,269.1952200); //
	CreateDynamicObject(1226,-2511.6638200,-717.4076500,141.9764600,0.0000000,0.0000000,269.1952200); //
	CreateDynamicObject(1226,-2512.4780300,-710.1702900,141.9764600,0.0000000,0.0000000,179.6485400); //
	CreateDynamicObject(640,-2537.2216800,-624.8613300,132.4223000,0.0000000,0.0000000,89.8505000); //
	CreateDynamicObject(640,-2526.4958500,-624.9066800,132.4223000,0.0000000,0.0000000,89.8505000); //
	CreateDynamicObject(640,-2531.8632800,-624.8928200,132.4223000,0.0000000,0.0000000,89.8505000); //

	CreateDynamicObject(19377,1840.2998047,-1721.5996094,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(1)
	CreateDynamicObject(19377,1840.3000488,-1731.1999512,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(3)
	CreateDynamicObject(19377,1840.2998047,-1712.0000000,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(4)
	CreateDynamicObject(19396,1827.6999512,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(7)
	CreateDynamicObject(19377,1829.8000488,-1712.0000000,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(5)
	CreateDynamicObject(19377,1829.7998047,-1721.5996094,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(7)
	CreateDynamicObject(19377,1829.7998047,-1731.1992188,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(8)
	CreateDynamicObject(19377,1840.3000488,-1731.6999512,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(11)
	CreateDynamicObject(19377,1842.0999756,-1711.6999512,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(12)
	CreateDynamicObject(19441,1824.5000000,-1721.5000000,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_landbit_33_a)(1)
	CreateDynamicObject(19377,1840.3000488,-1712.0000000,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(19)
	CreateDynamicObject(19377,1840.2998047,-1721.5996094,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(20)
	CreateDynamicObject(19377,1840.3000488,-1731.1999512,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(21)
	CreateDynamicObject(19377,1829.8000488,-1731.1999512,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(22)
	CreateDynamicObject(19377,1829.7998047,-1721.5996094,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(23)
	CreateDynamicObject(19377,1829.8000488,-1712.0000000,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(24)
	CreateDynamicObject(19377,1819.3000488,-1721.5999756,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(25)

    stairs[0] = CreateObject(14877,1823.00000000,-1719.19995117,5203.10009766,0.00000000,0.00000000,0.00000000); //object(michelle-stairs) (1)
    CreateDynamicObject(19362,1826.2399902,-1724.0999756,5205.1000977,0.0000000,90.0000000,180.0000000); //object(archbrij_sfw)(1)
	CreateDynamicObject(19362,1826.2399902,-1720.9000244,5205.1000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(2)
	CreateDynamicObject(19362,1826.2399902,-1717.6999512,5205.1010742,0.0000000,90.0000000,180.0000000); //object(archbrij_sfw)(3)
	CreateDynamicObject(19362,1819.6999512,-1719.0999756,5203.5000000,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(4)
	CreateDynamicObject(19362,1819.6999512,-1722.3000488,5203.5000000,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(5)
	CreateDynamicObject(19362,1819.6992188,-1725.3994141,5203.5000000,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(6)
	CreateDynamicObject(19441,1821.3994141,-1721.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19368,1822.9000244,-1725.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(5)
	CreateDynamicObject(19368,1819.6999512,-1725.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(6)
	CreateDynamicObject(19368,1818.0999756,-1723.6999512,5203.2998047,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(7)
	CreateDynamicObject(19368,1818.0999756,-1720.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(8)
	CreateDynamicObject(19368,1818.0999756,-1717.3000488,5203.2998047,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(9)
	CreateDynamicObject(19368,1819.6999512,-1717.6999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(10)
	CreateDynamicObject(19368,1822.9000244,-1717.6999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(11)
	CreateDynamicObject(19368,1824.5000000,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(12)
	CreateDynamicObject(19368,1822.9000244,-1720.6999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(13)
	CreateDynamicObject(19368,1822.9000244,-1720.6999512,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(14)
	CreateDynamicObject(19368,1822.8994141,-1722.2998047,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(15)
	CreateDynamicObject(19368,1822.9000244,-1725.3000488,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(16)
	CreateDynamicObject(19368,1819.6999512,-1725.3000488,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(17)
	CreateDynamicObject(19368,1818.0999756,-1723.6999512,5206.7998047,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(18)
	CreateDynamicObject(19368,1818.0999756,-1720.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(19)
	CreateDynamicObject(19368,1818.0999756,-1717.3000488,5206.7998047,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(20)
	CreateDynamicObject(19368,1819.6999512,-1717.6999512,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(21)
	CreateDynamicObject(19368,1822.9000244,-1717.6999512,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(22)
	CreateDynamicObject(19441,1821.4000244,-1721.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_landbit_33_a)(6)
	CreateDynamicObject(19362,1825.5000000,-1719.3000488,5205.1020508,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(7)
	CreateDynamicObject(19377,1822.8000488,-1721.3000488,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(26)
	CreateDynamicObject(19368,1824.5000000,-1716.0999756,5206.8999023,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(26)
	CreateDynamicObject(19368,1824.5000000,-1712.9000244,5206.8999023,0.0000000,0.0000000,0.0000000); //object(sboxbld4_sfw84)(27)
	CreateDynamicObject(19377,1829.7998047,-1731.6992188,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(27)

    fence0 = CreateObject(19304,1827.90002441,-1725.19995117,5205.79980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (1)
    fence1 = CreateObject(19304,1827.90002441,-1721.69995117,5205.79980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (2)
    fence2 = CreateObject(19304,1832.69921875,-1716.39941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (3)

    CreateDynamicObject(19362,1826.2399902,-1727.3000488,5205.1010742,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(8)
	CreateDynamicObject(19377,1831.5999756,-1711.6999512,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(28)
	CreateDynamicObject(19368,1822.8994141,-1722.2998047,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(29)
	CreateDynamicObject(19460,1826.0999756,-1709.4000244,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(1)
	CreateDynamicObject(19460,1824.5000000,-1717.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(2)
	CreateDynamicObject(19460,1824.5000000,-1730.0999756,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(3)
	CreateDynamicObject(19377,1829.7998047,-1711.6992188,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(29)
	CreateDynamicObject(19377,1822.8000488,-1730.9000244,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(31)
	CreateDynamicObject(19396,1827.6999512,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(8)
	CreateDynamicObject(19368,1824.5000000,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(32)
	CreateDynamicObject(19460,1826.0996094,-1709.3994141,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(4)
	CreateDynamicObject(19396,1830.9000244,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(9)
	CreateDynamicObject(19396,1834.0999756,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(10)
	CreateDynamicObject(19396,1837.3000488,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(11)
	CreateDynamicObject(19396,1840.5000000,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(12)
	CreateDynamicObject(19396,1843.6999512,-1714.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(13)
	CreateDynamicObject(19460,1845.3000488,-1709.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(5)
	CreateDynamicObject(19460,1845.3000488,-1709.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(6)
	CreateDynamicObject(19377,1840.2998047,-1711.6992188,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(32)
	CreateDynamicObject(19396,1843.6999512,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(14)
	CreateDynamicObject(19396,1850.0996094,-1714.2998047,5203.2998047,0.0000000,0.0000000,90.0000000); //object(land_37_sfw)(15)
	CreateDynamicObject(19396,1837.3000488,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(16)
	CreateDynamicObject(19396,1834.0999756,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(17)
	CreateDynamicObject(19396,1830.9000244,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(19)
	CreateDynamicObject(19396,1843.6999512,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(20)
	CreateDynamicObject(19460,1845.3000488,-1709.5000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(7)
	CreateDynamicObject(19396,1840.5000000,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(21)
	CreateDynamicObject(19396,1837.3000488,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(22)
	CreateDynamicObject(19396,1834.0999756,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(23)
	CreateDynamicObject(19396,1830.9000244,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(24)
	CreateDynamicObject(19396,1827.6999512,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(25)
	CreateDynamicObject(19368,1824.5000000,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(33)
	CreateDynamicObject(19460,1829.6999512,-1707.5999756,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(8)
	CreateDynamicObject(19460,1826.0996094,-1709.3994141,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(9)
	CreateDynamicObject(19460,1829.2998047,-1709.5000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(10)
	CreateDynamicObject(19460,1832.5000000,-1709.5000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(11)
	CreateDynamicObject(19460,1835.6999512,-1709.5000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(12)
	CreateDynamicObject(19460,1838.9000244,-1709.5000000,5210.2998047,0.0000000,0.0000000,0.2500000); //object(cs_mntdetail01)(13)
	CreateDynamicObject(19460,1842.0999756,-1709.5000000,5210.2998047,0.0000000,0.0000000,0.2471924); //object(cs_mntdetail01)(14)
	CreateDynamicObject(19460,1852.1999512,-1717.5999756,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(15)
	CreateDynamicObject(19460,1848.9000244,-1707.5999756,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(16)
	CreateDynamicObject(19460,1824.5000000,-1719.1999512,5210.3999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(17)
	CreateDynamicObject(19460,1824.5000000,-1728.8000488,5210.3999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(18)
	CreateDynamicObject(19368,1846.8994141,-1714.2998047,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(34)
	CreateDynamicObject(19377,1850.7998047,-1712.0000000,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19377,1850.7998047,-1721.5996094,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(36)
	CreateDynamicObject(19460,1847.2998047,-1715.3994141,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19396,1840.5000000,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(26)
	CreateDynamicObject(19362,1845.6992188,-1718.0996094,5205.1010742,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(9)

    stairs[1] = CreateObject(14877,1849.19995117,-1722.19995117,5206.60009766,0.00000000,0.00000000,179.99450684); //object(michelle-stairs) (4)
    stairs[2] = CreateObject(14877,1822.19921875,-1723.79980469,5201.50000000,0.00000000,0.00000000,179.99450684); //object(michelle-stairs) (5)

    CreateDynamicObject(19377,1821.0999756,-1711.6999512,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(39)
	CreateDynamicObject(19377,1852.5996094,-1711.6992188,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(41)
	CreateDynamicObject(19377,1852.5996094,-1721.2998047,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(42)
	CreateDynamicObject(19460,1847.4000244,-1712.8000488,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(20)
	CreateDynamicObject(19460,1839.3000488,-1707.5999756,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(21)
	CreateDynamicObject(19368,1846.9000244,-1714.3000488,5206.8999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(36)
	CreateDynamicObject(19460,1852.4000244,-1717.5999756,5210.3999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(23)
	CreateDynamicObject(19362,1847.3000488,-1714.9000244,5208.6000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(13)
	CreateDynamicObject(19460,1847.5000000,-1715.9000244,5210.3999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(24)
	CreateDynamicObject(19368,1846.9000244,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(37)
	CreateDynamicObject(19362,1845.6999512,-1724.5000000,5208.6000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(15)
	CreateDynamicObject(19368,1849.0999756,-1720.6999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(38)
	CreateDynamicObject(19362,1845.6992188,-1721.2998047,5205.1010742,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(17)
	CreateDynamicObject(19362,1845.6999512,-1724.5000000,5205.1010742,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(18)
	CreateDynamicObject(19362,1845.6999512,-1727.6999512,5205.1020508,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(19)
	CreateDynamicObject(19460,1847.5000000,-1725.5000000,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(25)
	CreateDynamicObject(19460,1852.2998047,-1723.6992188,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(26)
	CreateDynamicObject(19460,1856.6992188,-1720.3994141,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(27)
	CreateDynamicObject(19460,1856.6999512,-1720.3000488,5210.3999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(28)
	CreateDynamicObject(19460,1852.2998047,-1723.6992188,5210.3999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(29)
	CreateDynamicObject(19362,1845.6992188,-1721.2998047,5208.6000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(21)
	CreateDynamicObject(19362,1845.6999512,-1718.0999756,5208.6000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(22)
	CreateDynamicObject(19368,1849.0999756,-1720.6999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(40)
	CreateDynamicObject(19377,1850.8000488,-1721.5999756,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(45)
	CreateDynamicObject(19377,1850.8000488,-1712.0000000,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(46)
	CreateDynamicObject(19460,1831.0000000,-1736.0000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(30)
	CreateDynamicObject(19460,1829.6999512,-1707.5999756,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(31)
	CreateDynamicObject(19460,1839.3000488,-1707.5999756,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(32)
	CreateDynamicObject(19460,1839.3000488,-1707.5999756,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(33)
	CreateDynamicObject(19460,1848.9000244,-1707.5999756,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(34)
	CreateDynamicObject(19368,1845.6999512,-1707.5999756,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(41)
	CreateDynamicObject(19377,1850.7998047,-1731.1992188,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(47)
	CreateDynamicObject(19377,1852.5996094,-1730.8994141,5205.1010742,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19460,1824.5000000,-1727.0999756,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(35)
	CreateDynamicObject(19460,1845.2998047,-1734.0000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(36)
	CreateDynamicObject(19368,1824.5000000,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(43)
	CreateDynamicObject(19396,1827.6999512,-1714.3000488,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(28)
	CreateDynamicObject(19396,1830.9000244,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(29)
	CreateDynamicObject(19396,1834.0999756,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(30)
	CreateDynamicObject(19396,1837.3000488,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(31)
	CreateDynamicObject(19396,1840.5000000,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(32)
	CreateDynamicObject(19396,1843.6999512,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(33)
	CreateDynamicObject(19368,1846.9000244,-1729.1999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(44)
	CreateDynamicObject(19460,1826.0996094,-1734.0996094,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(37)
	CreateDynamicObject(19377,1829.8000488,-1731.6999512,5208.6010742,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(49)
	CreateDynamicObject(19377,1840.2998047,-1731.6992188,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19460,1847.5000000,-1728.5000000,5210.3999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(38)
	CreateDynamicObject(19377,1850.7998047,-1731.1992188,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19460,1829.6992188,-1707.5996094,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(39)
    CreateDynamicObject(19460,1840.5996094,-1736.0000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)

    fence3 = CreateObject(19304,1844.00000000,-1718.09997559,5205.79980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (7)
    fence4 = CreateObject(19304,1836.00000000,-1716.39941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (8)
    fence5 = CreateObject(19304,1839.09960938,-1716.39941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (9)
    fence6 = CreateObject(19304,1842.19921875,-1716.39941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (11)
    fence7 = CreateObject(19304,1829.59960938,-1716.39941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (13)

    CreateDynamicObject(19368,1824.5000000,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(49)
	CreateDynamicObject(19396,1827.6999512,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(34)
	CreateDynamicObject(19396,1830.9000244,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(35)
	CreateDynamicObject(19396,1834.0999756,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(36)
	CreateDynamicObject(19396,1837.3000488,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(37)
	CreateDynamicObject(19396,1840.5000000,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(38)
	CreateDynamicObject(19396,1843.6999512,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(39)
	CreateDynamicObject(19368,1846.8994141,-1729.1992188,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19460,1826.0999756,-1734.0999756,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(41)
	CreateDynamicObject(19460,1831.0000000,-1736.0000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(42)
	CreateDynamicObject(19460,1840.5999756,-1736.0000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(43)
	CreateDynamicObject(19460,1845.2998047,-1734.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(44)
	CreateDynamicObject(19368,1824.5000000,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(51)
	CreateDynamicObject(19460,1826.0999756,-1734.0999756,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(45)
	CreateDynamicObject(19396,1827.6999512,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(42)
	CreateDynamicObject(19396,1830.9000244,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(43)
	CreateDynamicObject(19396,1834.0999756,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(44)
	CreateDynamicObject(19396,1837.3000488,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(45)
	CreateDynamicObject(19396,1840.5000000,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(46)
	CreateDynamicObject(19396,1843.6999512,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(land_37_sfw)(47)
	CreateDynamicObject(19368,1846.9000244,-1729.1999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(52)
	CreateDynamicObject(19460,1831.0000000,-1736.0000000,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(46)
	CreateDynamicObject(19460,1840.5999756,-1736.0000000,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(47)
	CreateDynamicObject(19460,1845.2998047,-1734.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(48)
	CreateDynamicObject(19460,1847.2998047,-1728.1992188,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(49)

    fence8 = CreateObject(19304,1827.89941406,-1718.19921875,5205.79980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (14)
    fence9 = CreateObject(19304,1844.00000000,-1721.59997559,5205.79980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (15)
    fence10 = CreateObject(19304,1844.00000000,-1725.09997559,5205.79980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (16)
    fence11 = CreateObject(19304,1842.19921875,-1726.89941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (17)
    fence12 = CreateObject(19304,1839.09960938,-1726.89941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (18)
    fence13 = CreateObject(19304,1836.19921875,-1726.89941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (19)
    fence14 = CreateObject(19304,1832.69921875,-1726.89941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (20)
    fence15 = CreateObject(19304,1829.69921875,-1726.89941406,5205.79980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (21)
    fence16 = CreateObject(19304,1827.90002441,-1718.19995117,5209.29980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (27)
    fence17 = CreateObject(19304,1827.90002441,-1721.69995117,5209.29980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (28)
    fence18 = CreateObject(19304,1827.90002441,-1725.19995117,5209.29980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (29)
    fence19 = CreateObject(19304,1844.00000000,-1725.09997559,5209.29980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (36)
    fence20 = CreateObject(19304,1844.00000000,-1721.59997559,5209.29980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (37)
    fence21 = CreateObject(19304,1844.00000000,-1718.09997559,5209.29980469,0.00000000,0.00000000,90.00000000); //object(vgstwires22_lvs) (38)

    CreateDynamicObject(19460,1842.0999756,-1734.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(50)
	CreateDynamicObject(19460,1838.9000244,-1734.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(51)
	CreateDynamicObject(19460,1835.6999512,-1734.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(52)
	CreateDynamicObject(19460,1832.5000000,-1734.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(53)
	CreateDynamicObject(19460,1829.3000488,-1734.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(54)
	CreateDynamicObject(19460,1829.3000488,-1734.0000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(55)
	CreateDynamicObject(19460,1832.5000000,-1734.0000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(56)
	CreateDynamicObject(19460,1835.6999512,-1734.0000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(57)
	CreateDynamicObject(19460,1838.9000244,-1734.0000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(58)
	CreateDynamicObject(19460,1842.0999756,-1734.0000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(59)
	CreateDynamicObject(19460,1842.0999756,-1734.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(60)
	CreateDynamicObject(19460,1838.9000244,-1734.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(61)
	CreateDynamicObject(19460,1835.6999512,-1734.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(62)
	CreateDynamicObject(19460,1832.5000000,-1734.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(63)
	CreateDynamicObject(19460,1829.3000488,-1734.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(64)
	CreateDynamicObject(19460,1829.3000488,-1709.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(65)
	CreateDynamicObject(19460,1832.5000000,-1709.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(66)
	CreateDynamicObject(19460,1835.6999512,-1709.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(67)
	CreateDynamicObject(19460,1838.9000244,-1709.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(68)
	CreateDynamicObject(19460,1842.0999756,-1709.5000000,5206.7998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(69)
	CreateDynamicObject(19460,1842.0999756,-1709.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(70)
	CreateDynamicObject(19460,1838.9000244,-1709.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(71)
	CreateDynamicObject(19460,1835.8000488,-1709.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(72)
	CreateDynamicObject(19460,1832.5000000,-1709.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(73)
	CreateDynamicObject(19460,1829.3000488,-1709.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(74)
	CreateDynamicObject(19396,1847.2998047,-1721.7998047,5203.2998047,0.0000000,0.0000000,179.9945068); //object(land_37_sfw)(15)
	CreateDynamicObject(19368,1853.2998047,-1714.2998047,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(34)
	CreateDynamicObject(19460,1847.2998047,-1705.7998047,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19368,1856.5000000,-1714.2998047,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(34)
	CreateDynamicObject(19368,1852.3000488,-1720.6999512,5206.8999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(38)
	CreateDynamicObject(19368,1852.3000488,-1720.6999512,5210.3999023,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(38)
	CreateDynamicObject(19377,1861.2998047,-1721.5996094,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(45)
	CreateDynamicObject(19377,1849.1992188,-1730.8994141,5208.6010742,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19362,1846.6999512,-1722.3000488,5208.6010742,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(21)

    fence22 = CreateObject(19304,1829.59997559,-1716.40002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (13)
    fence23 = CreateObject(19304,1832.69995117,-1716.40002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (3)
    fence24 = CreateObject(19304,1836.00000000,-1716.40002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (8)
    fence25 = CreateObject(19304,1839.09997559,-1716.40002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (9)
    fence26 = CreateObject(19304,1842.19995117,-1716.40002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (11)
    fence27 = CreateObject(19304,1842.19995117,-1726.90002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (17)
    fence28 = CreateObject(19304,1839.09997559,-1726.90002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (18)
    fence29 = CreateObject(19304,1868.00000000,-1733.09997559,5210.70019531,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (19)
    fence30 = CreateObject(19304,1832.69995117,-1726.90002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (20)
    fence31 = CreateObject(19304,1829.69995117,-1726.90002441,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (21)

    CreateDynamicObject(19460,1858.0000000,-1712.2998047,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19414,1851.4010010,-1707.5009766,5203.3007812,0.0000000,0.0000000,270.0000000); //object(lodkmod2_sfw01)(1)
	CreateDynamicObject(19414,1848.9010010,-1707.5000000,5203.3007812,0.0000000,0.0000000,270.0000000); //object(lodkmod2_sfw01)(2)
	CreateDynamicObject(19414,1853.9003906,-1707.5000000,5203.3007812,0.0000000,0.0000000,270.0000000); //object(lodkmod2_sfw01)(3)
	CreateDynamicObject(19377,1861.2998047,-1712.0000000,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19414,1856.3994141,-1707.5009766,5203.2998047,0.0000000,0.0000000,270.0000000); //object(lodkmod2_sfw01)(4)
	CreateDynamicObject(19460,1853.1992188,-1719.0996094,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1854.7998047,-1719.0996094,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19441,1848.3000488,-1740.6999512,5206.7998047,0.0000000,0.0000000,180.0000000); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19377,1852.5999756,-1702.4000244,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19377,1852.5996094,-1702.3994141,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19377,1863.0996094,-1702.3994141,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19460,1853.1999512,-1701.0000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19396,1854.0000000,-1725.5000000,5203.2998047,0.0000000,0.0000000,179.9945068); //object(land_37_sfw)(15)
	CreateDynamicObject(19441,1854.0000000,-1727.0996094,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19460,1854.7998047,-1731.8994141,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1853.1999512,-1731.9000244,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19396,1850.0000000,-1729.1999512,5203.2998047,0.0000000,0.0000000,90.0000000); //object(land_37_sfw)(15)
	CreateDynamicObject(19368,1853.1999512,-1729.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(14416,1857.4000244,-1738.5999756,5205.3999023,0.0000000,0.0000000,359.9945068); //object(carter-stairs07)(1)
	CreateDynamicObject(19377,1850.8000488,-1740.8000488,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(47)
	CreateDynamicObject(19368,1846.6999512,-1736.1999512,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1853.7998047,-1741.5000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19377,1852.5996094,-1731.8994141,5205.1020508,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19460,1848.2998047,-1741.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(49)
	CreateDynamicObject(19460,1852.1999512,-1741.0000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(49)
	CreateDynamicObject(19377,1850.5000000,-1746.0996094,5205.0000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19368,1847.2998047,-1734.5996094,5203.2998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1848.2998047,-1738.2998047,5206.7998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19441,1854.0000000,-1723.8994141,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19441,1852.1992188,-1740.6992188,5206.7998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19460,1843.5000000,-1741.5000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19368,1852.1992188,-1738.2998047,5206.7998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1853.7998047,-1736.1992188,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19377,1861.0000000,-1746.0996094,5205.0000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19368,1856.3994141,-1717.0996094,5203.2998047,0.0000000,0.0000000,270.0000000); //object(sboxbld4_sfw84)(34)
	CreateDynamicObject(19377,1861.2998047,-1721.5996094,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19377,1861.2998047,-1731.1992188,5201.5000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(35)
	CreateDynamicObject(19460,1845.5999756,-1746.3000488,5206.7998047,0.0000000,0.0000000,180.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(14416,1850.1992188,-1739.3994141,5201.7998047,0.0000000,0.0000000,179.9945068); //object(carter-stairs07)(1)
	CreateDynamicObject(19377,1859.6992188,-1732.1992188,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19441,1855.4000244,-1740.8000488,5206.7998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19368,1866.1999512,-1749.4000244,5206.7998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19441,1859.4000244,-1740.8000488,5206.7998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19460,1850.3000488,-1751.0000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19377,1850.1999512,-1740.5000000,5208.6010742,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19460,1864.1992188,-1741.5996094,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1859.9000244,-1751.0000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1869.5000000,-1751.0000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19396,1866.2001953,-1746.2998047,5206.7998047,0.0000000,0.0000000,179.9945068); //object(land_37_sfw)(15)
	CreateDynamicObject(19368,1855.3994141,-1738.3994141,5206.7998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1866.1999512,-1743.1999512,5206.7998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19377,1850.1992188,-1750.0996094,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19377,1860.5996094,-1746.3994141,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19377,1871.0999756,-1746.4000244,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19377,1864.5996094,-1736.7998047,5208.6020508,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19368,1859.4000244,-1738.4000244,5206.7998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19377,1864.5996094,-1732.1992188,5208.6010742,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19460,1845.3000488,-1743.5999756,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1850.0999756,-1751.1999512,5210.2998047,0.0000000,0.0000000,90.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1845.2998047,-1753.1992188,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1859.6999512,-1751.1999512,5210.2998047,0.0000000,0.0000000,90.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1869.3000488,-1751.1999512,5210.2998047,0.0000000,0.0000000,90.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1855.4000244,-1740.0000000,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1869.7998047,-1736.8994141,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(40)
	CreateDynamicObject(14416,1869.0999756,-1725.0999756,5205.3999023,0.0000000,0.0000000,179.9890137); //object(carter-stairs07)(1)
	CreateDynamicObject(19377,1863.0996094,-1725.8994141,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(14416,1859.6999512,-1732.5000000,5201.8999023,0.0000000,0.0000000,89.9890137); //object(carter-stairs07)(1)
	CreateDynamicObject(19460,1869.8000488,-1724.5000000,5206.8999023,0.0000000,0.0000000,180.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1858.0999756,-1730.5999756,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19441,1863.0000000,-1721.8000488,5203.2998047,0.0000000,0.0000000,180.0000000); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19460,1867.7998047,-1721.0000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1867.0999756,-1726.9000244,5206.8999023,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19377,1863.0996094,-1716.2998047,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19460,1862.3000488,-1727.5000000,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(29)
	CreateDynamicObject(19377,1861.8994141,-1722.6992188,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19377,1873.5996094,-1717.3994141,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19460,1869.8010254,-1724.0999756,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19368,1869.8000488,-1730.5000000,5210.2998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1868.3000488,-1722.4000244,5210.2998047,0.0000000,0.0000000,90.0000000); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19460,1852.6992188,-1727.5000000,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(29)
	CreateDynamicObject(19460,1869.8000488,-1714.9000244,5206.8999023,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1861.7998047,-1717.5996094,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1871.3994141,-1717.5996094,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19377,1872.4000244,-1717.6999512,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19460,1867.0999756,-1722.6999512,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19368,1848.5000000,-1727.5996094,5210.3999023,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19460,1862.5999756,-1730.5999756,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1867.7998047,-1722.5996094,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1862.0999756,-1733.3000488,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1862.0996094,-1733.2998047,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19377,1867.6992188,-1735.3994141,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19460,1849.5999756,-1731.8000488,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(36)
	CreateDynamicObject(19368,1849.5999756,-1725.4000244,5206.8999023,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19460,1854.3994141,-1727.3994141,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(26)
	CreateDynamicObject(19460,1859.1999512,-1722.5999756,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(27)
	CreateDynamicObject(19377,1861.8994141,-1713.0996094,5208.6000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(50)
	CreateDynamicObject(19460,1855.6999512,-1730.4000244,5210.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(48)
	CreateDynamicObject(19460,1850.5999756,-1737.1999512,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(29)
	CreateDynamicObject(19460,1841.0000000,-1737.1999512,5210.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(29)
	CreateDynamicObject(19368,1857.3000488,-1734.9000244,5206.8999023,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1862.5999756,-1732.1999512,5206.8999023,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19460,1853.0999756,-1736.5999756,5206.8999023,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1866.5000000,-1728.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1866.5000000,-1718.8994141,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1866.5000000,-1709.2998047,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1866.5000000,-1699.6999512,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1858.0000000,-1696.3000488,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1843.5999756,-1701.0000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19460,1862.5000000,-1698.2998047,5203.2998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19377,1863.0996094,-1706.6992188,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(41)
	CreateDynamicObject(19377,1863.0999756,-1697.0999756,5205.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(41)
	CreateDynamicObject(19460,1868.0000000,-1742.5000000,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19368,1869.5996094,-1737.6992188,5210.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1859.4000244,-1738.4000244,5210.2998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19441,1859.3994141,-1740.7998047,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19368,1857.0000000,-1741.5999756,5210.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1860.1992188,-1741.5996094,5210.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1857.0000000,-1744.7998047,5210.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1858.5999756,-1743.1999512,5210.2998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19377,1850.5000000,-1740.8000488,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1850.5000000,-1750.4000244,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1861.0000000,-1750.3994141,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1871.5000000,-1750.4000244,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1861.0000000,-1740.8000488,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1871.5000000,-1740.8000488,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1861.2998047,-1731.1992188,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1871.8000488,-1731.1999512,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19377,1871.8000488,-1721.5999756,5212.1000977,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(52)
	CreateDynamicObject(19460,1859.1999512,-1713.0000000,5206.8999023,0.0000000,0.0000000,0.0000000); //object(cs_mntdetail01)(27)
	CreateDynamicObject(19368,1861.8000488,-1738.4000244,5210.2998047,0.0000000,0.0000000,179.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19441,1861.8000488,-1740.8000488,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19377,1871.5000000,-1746.0999756,5205.0000000,0.0000000,90.0000000,0.0000000); //object(freight_interiorsfw)(48)
	CreateDynamicObject(19460,1873.8000488,-1741.5999756,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1879.0999756,-1751.0000000,5206.7998047,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19460,1876.4000244,-1746.5000000,5206.7998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(40)
	CreateDynamicObject(19396,1857.8000488,-1729.0000000,5206.8999023,0.0000000,0.0000000,179.9945068); //object(land_37_sfw)(15)
	CreateDynamicObject(19396,1862.8000488,-1710.9000244,5203.2998047,0.0000000,0.0000000,89.9945068); //object(land_37_sfw)(15)
	CreateDynamicObject(19362,1860.8000488,-1734.8000488,5205.1000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(17)
	CreateDynamicObject(19362,1859.5000000,-1734.8010254,5205.1000977,0.0000000,90.0000000,179.9945068); //object(archbrij_sfw)(17)
	CreateDynamicObject(19441,1858.0000000,-1706.6992188,5203.2998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19441,1858.0000000,-1701.9000244,5203.2998047,0.0000000,0.0000000,179.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19442,1854.7412109,-1710.2294922,5269.5117188,0.0000000,0.0000000,0.0000000); //object(cs_landbit_44_a)(1)
	CreateDynamicObject(19442,1855.1999512,-1707.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_landbit_44_a)(2)
	CreateDynamicObject(19442,1852.6999512,-1707.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_landbit_44_a)(3)
	CreateDynamicObject(19442,1850.0999756,-1707.5000000,5203.2998047,0.0000000,0.0000000,0.0000000); //object(cs_landbit_44_a)(4)
	CreateDynamicObject(19466,1851.4000244,-1707.5000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(lod_liberty06)(1)
	CreateDynamicObject(19466,1853.9000244,-1707.5000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(lod_liberty06)(2)
	CreateDynamicObject(19466,1856.4000244,-1707.5000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(lod_liberty06)(3)
	CreateDynamicObject(19466,1848.9000244,-1707.5000000,5203.2998047,0.0000000,0.0000000,270.0000000); //object(lod_liberty06)(4)
	CreateDynamicObject(19396,1858.0000000,-1704.2998047,5203.2998047,0.0000000,0.0000000,179.9945068); //object(land_37_sfw)(15)
	CreateDynamicObject(19368,1859.5999756,-1710.9000244,5203.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(19368,1866.0000000,-1710.9000244,5203.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(1569,1860.8000488,-1698.4000244,5201.6000977,0.0000000,0.0000000,0.0000000); //object(adam_v_door)(1)
	CreateDynamicObject(1569,1863.8000488,-1698.4000244,5201.6000977,0.0000000,0.0000000,179.7999878); //object(adam_v_door)(2)
	CreateDynamicObject(19370,1859.6992188,-1706.0000000,5200.7998047,0.0000000,0.0000000,270.0000000); //object(freight_sfw15)(2)
	CreateDynamicObject(19370,1864.7998047,-1706.0000000,5200.7998047,0.0000000,0.0000000,270.0000000); //object(freight_sfw15)(3)
	CreateDynamicObject(19435,1859.7998047,-1706.6992188,5202.5000000,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(19435,1864.6999512,-1706.6999512,5202.5000000,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(2)
	CreateDynamicObject(19443,1861.1992188,-1706.6992188,5200.7001953,0.0000000,0.0000000,0.0000000); //object(cs_landbit_61_a)(1)
	CreateDynamicObject(19370,1859.6992188,-1707.3994141,5200.7998047,0.0000000,0.0000000,270.0000000); //object(freight_sfw15)(5)
	CreateDynamicObject(19443,1863.2998047,-1706.6992188,5200.7001953,0.0000000,0.0000000,0.0000000); //object(cs_landbit_61_a)(2)
	CreateDynamicObject(19370,1864.8000488,-1707.4000244,5200.7998047,0.0000000,0.0000000,270.0000000); //object(freight_sfw15)(6)
	CreateDynamicObject(2008,1859.0996094,-1707.0996094,5201.7700195,0.0000000,0.0000000,0.0000000); //object(officedesk1)(1)
	CreateDynamicObject(2008,1864.0999756,-1707.0999756,5201.7700195,0.0000000,0.0000000,0.0000000); //object(officedesk1)(2)
	CreateDynamicObject(19462,1862.8000488,-1706.0000000,5205.5000000,0.0000000,0.0000000,270.0000000); //object(cs_mntdetail01)(19)
	CreateDynamicObject(19435,1859.7998047,-1706.6992188,5203.7998047,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(19435,1863.2998047,-1706.6992188,5203.7998047,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(19435,1866.7998047,-1706.6992188,5203.7998047,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(2606,1863.8000488,-1707.1999512,5204.1000977,0.0000000,0.0000000,0.0000000); //object(cj_police_counter2)(1)
	CreateDynamicObject(2606,1863.7998047,-1707.1992188,5204.5297852,0.0000000,0.0000000,0.0000000); //object(cj_police_counter2)(2)
	CreateDynamicObject(2608,1861.1999512,-1707.4000244,5204.6000977,0.0000000,0.0000000,0.0000000); //object(polce_shelf)(1)
	CreateDynamicObject(2608,1859.3160400,-1707.4000244,5204.6000977,0.0000000,0.0000000,0.0000000); //object(polce_shelf)(2)
	CreateDynamicObject(16101,1863.3000488,-1707.4000244,5192.7998047,0.0000000,0.0000000,0.0000000); //object(des_windsockpole)(1)
	CreateDynamicObject(16101,1861.1999512,-1707.3000488,5192.7998047,0.0000000,0.0000000,0.0000000); //object(des_windsockpole)(2)
	CreateDynamicObject(16101,1858.3000488,-1707.4000244,5192.7998047,0.0000000,0.0000000,0.0000000); //object(des_windsockpole)(3)
	CreateDynamicObject(16101,1866.0999756,-1707.4000244,5192.7998047,0.0000000,0.0000000,0.0000000); //object(des_windsockpole)(4)
	CreateDynamicObject(1806,1860.0000000,-1708.4000244,5201.6000977,0.0000000,0.0000000,0.0000000); //object(med_office_chair)(1)
	CreateDynamicObject(1806,1865.0000000,-1708.4000244,5201.6000977,0.0000000,0.0000000,0.0000000); //object(med_office_chair)(2)
	CreateDynamicObject(1811,1865.9000244,-1700.9000244,5202.2001953,0.0000000,0.0000000,0.0000000); //object(med_din_chair_5)(1)
	CreateDynamicObject(1811,1865.9000244,-1701.6999512,5202.2001953,0.0000000,0.0000000,0.0000000); //object(med_din_chair_5)(2)
	CreateDynamicObject(1811,1865.9000244,-1702.5000000,5202.2001953,0.0000000,0.0000000,0.0000000); //object(med_din_chair_5)(3)
	CreateDynamicObject(1811,1865.8994141,-1703.2998047,5202.2001953,0.0000000,0.0000000,0.0000000); //object(med_din_chair_5)(4)
	CreateDynamicObject(1811,1848.8994141,-1706.5000000,5202.2001953,0.0000000,0.0000000,90.0000000); //object(med_din_chair_5)(5)
	CreateDynamicObject(1811,1851.4000244,-1706.5000000,5202.2001953,0.0000000,0.0000000,90.0000000); //object(med_din_chair_5)(6)
	CreateDynamicObject(1811,1854.0000000,-1706.5000000,5202.2001953,0.0000000,0.0000000,90.0000000); //object(med_din_chair_5)(7)
	CreateDynamicObject(1811,1856.5999756,-1706.5000000,5202.2001953,0.0000000,0.0000000,90.0000000); //object(med_din_chair_5)(8)
	CreateDynamicObject(2007,1855.4000244,-1727.1999512,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(2)
	CreateDynamicObject(2007,1856.4000244,-1727.1999512,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(11)
	CreateDynamicObject(2007,1857.4000244,-1727.1999512,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(12)
	CreateDynamicObject(2007,1858.4000244,-1730.0000000,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(13)
	CreateDynamicObject(2007,1858.4000244,-1727.1999512,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(14)
	CreateDynamicObject(19370,1857.3000488,-1727.8000488,5202.7001953,0.0000000,0.0000000,270.0000000); //object(freight_sfw15)(5)
	CreateDynamicObject(2007,1857.4000244,-1728.4000244,5201.6000977,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(15)
	CreateDynamicObject(2007,1856.4000244,-1728.4000244,5201.6000977,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(16)
	CreateDynamicObject(2007,1855.4000244,-1728.4000244,5201.6000977,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(17)
	CreateDynamicObject(2007,1858.4000244,-1727.1999512,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(18)
	CreateDynamicObject(2007,1857.4000244,-1727.1999512,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(19)
	CreateDynamicObject(2007,1856.4000244,-1727.1999512,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(20)
	CreateDynamicObject(2007,1855.4000244,-1727.1999512,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(21)
	CreateDynamicObject(2007,1858.4000244,-1728.4000244,5203.0000000,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(22)
	CreateDynamicObject(2007,1857.4000244,-1728.4000244,5203.0000000,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(23)
	CreateDynamicObject(2007,1856.4000244,-1728.4000244,5203.0000000,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(24)
	CreateDynamicObject(2007,1855.4000244,-1728.4000244,5203.0000000,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(25)
	CreateDynamicObject(2007,1858.4000244,-1728.4000244,5201.6000977,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(26)
	CreateDynamicObject(2007,1857.4000244,-1730.0000000,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(27)
	CreateDynamicObject(2007,1856.4000244,-1730.0000000,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(28)
	CreateDynamicObject(2007,1855.4000244,-1730.0000000,5201.6000977,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(29)
	CreateDynamicObject(2007,1855.4000244,-1730.0000000,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(30)
	CreateDynamicObject(2007,1856.4000244,-1730.0000000,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(31)
	CreateDynamicObject(2007,1857.4000244,-1730.0000000,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(32)
	CreateDynamicObject(2007,1858.3994141,-1730.0000000,5203.0000000,0.0000000,0.0000000,179.9945068); //object(filing_cab_nu01)(33)
	CreateDynamicObject(19370,1854.8000488,-1727.8010254,5202.7001953,0.0000000,0.0000000,270.0000000); //object(freight_sfw15)(5)
	CreateDynamicObject(2303,1865.9000244,-1724.0000000,5201.6000977,0.0000000,0.0000000,270.0000000); //object(cj_k3_wash_mac)(1)
	CreateDynamicObject(2303,1865.8994141,-1725.0000000,5201.6000977,0.0000000,0.0000000,270.0000000); //object(cj_k3_wash_mac)(2)
	CreateDynamicObject(2303,1865.9000244,-1726.0000000,5201.6000977,0.0000000,0.0000000,270.0000000); //object(cj_k3_wash_mac)(3)
	CreateDynamicObject(2303,1865.9000244,-1726.0000000,5202.6000977,0.0000000,0.0000000,270.0000000); //object(cj_k3_wash_mac)(4)
	CreateDynamicObject(2303,1865.8994141,-1725.0000000,5202.6000977,0.0000000,0.0000000,270.0000000); //object(cj_k3_wash_mac)(5)
	CreateDynamicObject(2303,1865.9000244,-1724.0000000,5202.6000977,0.0000000,0.0000000,270.0000000); //object(cj_k3_wash_mac)(6)
	CreateDynamicObject(1892,1862.5999756,-1699.0999756,5201.6000977,0.0000000,0.0000000,0.0000000); //object(security_gatsh)(1)
	CreateDynamicObject(1892,1861.0000000,-1699.0999756,5201.6000977,0.0000000,0.0000000,0.0000000); //object(security_gatsh)(2)
	CreateDynamicObject(2008,1856.6999512,-1721.6999512,5201.6000977,0.0000000,0.0000000,180.0000000); //object(officedesk1)(1)
	CreateDynamicObject(2008,1856.6999512,-1718.9000244,5201.6000977,0.0000000,0.0000000,179.9945068); //object(officedesk1)(1)
	CreateDynamicObject(1671,1864.5000000,-1719.0000000,5202.0000000,0.0000000,0.0000000,270.0000000); //object(swivelchair_a)(1)
	CreateDynamicObject(1671,1855.8000488,-1717.9000244,5202.0000000,0.0000000,0.0000000,0.0000000); //object(swivelchair_a)(2)
	CreateDynamicObject(2846,1864.4000244,-1724.4000244,5201.6000977,0.0000000,0.0000000,0.0000000); //object(gb_bedclothes05)(1)
	CreateDynamicObject(2713,1865.9000244,-1723.0000000,5201.7001953,0.0000000,0.0000000,0.0000000); //object(cj_bucket)(1)
	CreateDynamicObject(2008,1863.5000000,-1719.9000244,5201.6000977,0.0000000,0.0000000,89.9945068); //object(officedesk1)(1)
	CreateDynamicObject(2008,1863.5000000,-1716.5999756,5201.6000977,0.0000000,0.0000000,89.9945068); //object(officedesk1)(1)
	CreateDynamicObject(2008,1864.9000244,-1711.5999756,5201.6000977,0.0000000,0.0000000,0.0000000); //object(officedesk1)(1)
	CreateDynamicObject(1671,1855.7998047,-1720.6992188,5202.0000000,0.0000000,0.0000000,0.0000000); //object(swivelchair_a)(3)
	CreateDynamicObject(1671,1864.5000000,-1715.5999756,5202.0000000,0.0000000,0.0000000,270.0000000); //object(swivelchair_a)(4)
	CreateDynamicObject(1671,1858.8000488,-1712.5000000,5202.0000000,0.0000000,0.0000000,90.0000000); //object(swivelchair_a)(5)
	CreateDynamicObject(2186,1866.0000000,-1714.4000244,5201.6000977,0.0000000,0.0000000,270.0000000); //object(photocopier_1)(1)
	CreateDynamicObject(2008,1860.0000000,-1711.6999512,5201.6000977,0.0000000,0.0000000,269.9945068); //object(officedesk1)(1)
	CreateDynamicObject(2008,1860.0000000,-1715.5999756,5201.6000977,0.0000000,0.0000000,269.9890137); //object(officedesk1)(1)
	CreateDynamicObject(1671,1865.7998047,-1712.3994141,5202.0000000,0.0000000,0.0000000,179.9945068); //object(swivelchair_a)(6)
	CreateDynamicObject(1671,1858.9000244,-1716.5999756,5202.0000000,0.0000000,0.0000000,90.0000000); //object(swivelchair_a)(7)
	CreateDynamicObject(14401,1853.9000244,-1705.4000244,5205.5000000,0.0000000,0.0000000,180.0000000); //object(bench1)(1)
	CreateDynamicObject(19368,1859.0999756,-1723.0999756,5206.8999023,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(14782,1862.3994141,-1718.0996094,5206.2001953,0.0000000,0.0000000,0.0000000); //object(int3int_boxing30)(3)
	CreateDynamicObject(14401,1853.8994141,-1706.5000000,5205.5000000,0.0000000,0.0000000,179.9945068); //object(bench1)(4)
	CreateDynamicObject(19368,1862.3000488,-1723.0999756,5206.8999023,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(14782,1860.5996094,-1722.6396484,5206.2001953,0.0000000,0.0000000,179.9945068); //object(int3int_boxing30)(4)
	CreateDynamicObject(2007,1859.9000244,-1723.6999512,5205.2001953,0.0000000,0.0000000,359.9945068); //object(filing_cab_nu01)(33)
	CreateDynamicObject(2007,1860.9000244,-1723.6999512,5205.2001953,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(33)
	CreateDynamicObject(2007,1861.9000244,-1723.6999512,5205.2001953,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(33)
	CreateDynamicObject(2007,1862.9000244,-1723.6999512,5205.2001953,0.0000000,0.0000000,359.9890137); //object(filing_cab_nu01)(33)
	CreateDynamicObject(14791,1871.5999756,-1745.9000244,5206.2001953,0.0000000,0.0000000,0.0000000); //object(a_vgsgymboxa)(1)
	CreateDynamicObject(2290,1853.4000244,-1733.9000244,5205.2001953,0.0000000,0.0000000,270.0000000); //object(swk_couch_1)(1)
	CreateDynamicObject(2290,1850.3000488,-1735.9000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(swk_couch_1)(2)
	CreateDynamicObject(2315,1851.9000244,-1734.1999512,5205.2001953,0.0000000,0.0000000,270.0000000); //object(cj_tv_table4)(1)
	CreateDynamicObject(1754,1856.4000244,-1735.6999512,5205.2001953,0.0000000,0.0000000,219.9981690); //object(swank_single_1)(1)
	CreateDynamicObject(2964,1863.3000488,-1727.5000000,5205.2001953,0.0000000,0.0000000,270.0000000); //object(k_pooltablesm)(1)
	CreateDynamicObject(19441,1860.1999512,-1736.8000488,5210.2998047,0.0000000,0.0000000,89.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(19441,1861.0000000,-1736.8010254,5210.2998047,0.0000000,0.0000000,89.9945068); //object(cs_landbit_33_a)(4)
	CreateDynamicObject(18059,1847.3000488,-1739.3000488,5209.1000977,0.0000000,0.0000000,0.0000000); //object(tables)(1)
	CreateDynamicObject(18059,1847.3000488,-1744.1999512,5209.1000977,0.0000000,0.0000000,0.0000000); //object(tables)(2)
	CreateDynamicObject(18059,1853.5999756,-1749.1999512,5209.1000977,0.0000000,0.0000000,0.0000000); //object(tables)(3)
	CreateDynamicObject(18059,1869.3000488,-1749.1999512,5209.1000977,0.0000000,0.0000000,0.0000000); //object(tables)(4)
	CreateDynamicObject(1746,1850.4000244,-1732.5000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(swank_1_footstool)(1)
	CreateDynamicObject(2140,1855.0000000,-1728.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_tall_unit1)(1)
	CreateDynamicObject(2137,1851.1500244,-1728.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_low_unit3)(1)
	CreateDynamicObject(2135,1850.1992188,-1728.9794922,5205.2001953,0.0000000,0.0000000,90.0000000); //object(cj_k3_cooker)(1)
	CreateDynamicObject(2136,1853.0498047,-1727.9941406,5205.2001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_sink)(1)
	CreateDynamicObject(2305,1850.1999512,-1728.0000000,5205.2001953,0.0000000,0.0000000,90.0000000); //object(cj_k3_c_unit)(1)
	CreateDynamicObject(2137,1852.1093750,-1728.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_low_unit3)(2)
	CreateDynamicObject(2137,1850.2060547,-1729.9499512,5205.2001953,0.0000000,0.0000000,90.0000000); //object(cj_k3_low_unit3)(3)
	CreateDynamicObject(2638,1848.8000488,-1739.1999512,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(1)
	CreateDynamicObject(2638,1852.0000000,-1739.1999512,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(2)
	CreateDynamicObject(2638,1852.0000000,-1744.1999512,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(3)
	CreateDynamicObject(2638,1848.8000488,-1744.1999512,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(4)
	CreateDynamicObject(2638,1848.9000244,-1749.1999512,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(5)
	CreateDynamicObject(2638,1852.0000000,-1749.3000488,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(6)
	CreateDynamicObject(2638,1855.0999756,-1749.4000244,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(7)
	CreateDynamicObject(2638,1858.3000488,-1749.4000244,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(8)
	CreateDynamicObject(2638,1861.4000244,-1749.4000244,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(9)
	CreateDynamicObject(2638,1864.5999756,-1749.4000244,5209.2998047,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair2)(10)
	CreateDynamicObject(2639,1867.4000244,-1749.4000244,5209.2001953,0.0000000,0.0000000,90.0000000); //object(cj_pizza_chair3)(1)
	CreateDynamicObject(2639,1846.0000000,-1744.1999512,5209.2001953,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair3)(2)
	CreateDynamicObject(2639,1854.9000244,-1739.3000488,5209.2001953,0.0000000,0.0000000,90.0000000); //object(cj_pizza_chair3)(3)
	CreateDynamicObject(2639,1845.9000244,-1739.0999756,5209.2001953,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair3)(4)
	CreateDynamicObject(2639,1854.7998047,-1744.1992188,5209.2001953,0.0000000,0.0000000,90.0000000); //object(cj_pizza_chair3)(5)
	CreateDynamicObject(2639,1864.9000244,-1745.4000244,5209.2001953,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair3)(6)
	CreateDynamicObject(18059,1872.4000244,-1745.4000244,5209.1000977,0.0000000,0.0000000,0.0000000); //object(tables)(7)
	CreateDynamicObject(18059,1872.4000244,-1741.0999756,5209.1000977,0.0000000,0.0000000,0.0000000); //object(tables)(6)
	CreateDynamicObject(19460,1868.0000000,-1752.0999756,5210.2998047,0.0000000,0.0000000,179.9945068); //object(cs_mntdetail01)(40)
	CreateDynamicObject(2639,1867.4000244,-1745.4000244,5209.2001953,0.0000000,0.0000000,90.0000000); //object(cj_pizza_chair3)(7)
	CreateDynamicObject(2639,1867.4000244,-1741.1999512,5209.2001953,0.0000000,0.0000000,90.0000000); //object(cj_pizza_chair3)(8)
	CreateDynamicObject(2639,1845.8994141,-1749.0996094,5209.2001953,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair3)(9)
	CreateDynamicObject(2639,1864.9000244,-1741.0999756,5209.2001953,0.0000000,0.0000000,270.0000000); //object(cj_pizza_chair3)(10)
	CreateDynamicObject(2357,1853.6999512,-1730.6999512,5205.6000977,0.0000000,0.0000000,0.0000000); //object(dunc_dinning)(1)
	CreateDynamicObject(2120,1855.0999756,-1731.8000488,5205.7998047,0.0000000,0.0000000,270.0000000); //object(med_din_chair_4)(1)
	CreateDynamicObject(2120,1854.1999512,-1731.8000488,5205.7998047,0.0000000,0.0000000,270.0000000); //object(med_din_chair_4)(2)
	CreateDynamicObject(2120,1853.3000488,-1731.8000488,5205.7998047,0.0000000,0.0000000,270.0000000); //object(med_din_chair_4)(3)
	CreateDynamicObject(2120,1852.4000244,-1731.8000488,5205.7998047,0.0000000,0.0000000,270.0000000); //object(med_din_chair_4)(4)
	CreateDynamicObject(2120,1852.4000244,-1729.5999756,5205.7998047,0.0000000,0.0000000,90.0000000); //object(med_din_chair_4)(5)
	CreateDynamicObject(2120,1853.3000488,-1729.5999756,5205.7998047,0.0000000,0.0000000,90.0000000); //object(med_din_chair_4)(6)
	CreateDynamicObject(2120,1854.1999512,-1729.5999756,5205.7998047,0.0000000,0.0000000,90.0000000); //object(med_din_chair_4)(7)
	CreateDynamicObject(2120,1855.0999756,-1729.5999756,5205.7998047,0.0000000,0.0000000,90.0000000); //object(med_din_chair_4)(8)
	CreateDynamicObject(2441,1869.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(1)
	CreateDynamicObject(2441,1868.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(2)
	CreateDynamicObject(2441,1867.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(3)
	CreateDynamicObject(2441,1866.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(4)
	CreateDynamicObject(2441,1865.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(5)
	CreateDynamicObject(2441,1864.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(6)
	CreateDynamicObject(2441,1863.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(7)
	CreateDynamicObject(2441,1862.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(8)
	CreateDynamicObject(2441,1861.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(9)
	CreateDynamicObject(2441,1860.1992188,-1732.8994141,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(11)
	CreateDynamicObject(2441,1859.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(12)
	CreateDynamicObject(2441,1858.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(13)
	CreateDynamicObject(2441,1857.1999512,-1732.9000244,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(14)
	CreateDynamicObject(2441,1856.3000488,-1732.9000244,5212.2998047,0.0000000,180.0000000,0.0000000); //object(cj_ff_conter_4)(15)
	CreateDynamicObject(19368,1854.1839600,-1735.1999512,5210.2998047,0.0000000,0.0000000,89.9945068); //object(sboxbld4_sfw84)(50)
	CreateDynamicObject(2441,1856.1992188,-1732.8994141,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_conter_4)(17)
	CreateDynamicObject(2441,1857.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(18)
	CreateDynamicObject(2441,1858.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(19)
	CreateDynamicObject(2441,1859.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(20)
	CreateDynamicObject(2441,1860.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(21)
	CreateDynamicObject(2441,1861.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(22)
	CreateDynamicObject(2441,1862.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(23)
	CreateDynamicObject(2441,1863.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(24)
	CreateDynamicObject(2441,1864.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(25)
	CreateDynamicObject(2441,1865.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(26)
	CreateDynamicObject(2441,1866.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(27)
	CreateDynamicObject(2441,1867.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(28)
	CreateDynamicObject(2441,1868.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(29)
	CreateDynamicObject(2441,1869.3000488,-1732.9000244,5212.2998047,0.0000000,179.9945068,0.0000000); //object(cj_ff_conter_4)(30)

    fence32 = CreateObject(19304,1836.19921875,-1726.89941406,5209.29980469,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (19)
    fence33 = CreateObject(19304,1864.50000000,-1733.09997559,5210.70019531,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (19)
    fence34 = CreateObject(19304,1861.00000000,-1733.09997559,5210.70019531,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (19)
    fence35 = CreateObject(19304,1857.50000000,-1733.09997559,5210.70019531,0.00000000,0.00000000,0.00000000); //object(vgstwires22_lvs) (19)

    CreateDynamicObject(2137,1856.3000488,-1728.0999756,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_low_unit3)(2)
	CreateDynamicObject(2140,1858.2399902,-1728.0999756,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_tall_unit1)(1)
	CreateDynamicObject(2137,1857.2700195,-1728.0999756,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_low_unit3)(2)
	CreateDynamicObject(2140,1859.1999512,-1728.0999756,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_tall_unit1)(1)
	CreateDynamicObject(2136,1860.1999512,-1728.0999756,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_sink)(1)
	CreateDynamicObject(2135,1864.0999756,-1728.0999756,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_cooker)(1)
	CreateDynamicObject(2137,1862.1600342,-1728.1070557,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_low_unit3)(2)
	CreateDynamicObject(2137,1863.1199951,-1728.1070557,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_k3_low_unit3)(2)
	CreateDynamicObject(2627,1865.1999512,-1742.9000244,5205.1000977,0.0000000,0.0000000,0.0000000); //object(gym_treadmill)(1)
	CreateDynamicObject(2627,1863.9000244,-1742.9000244,5205.1000977,0.0000000,0.0000000,0.0000000); //object(gym_treadmill)(2)
	CreateDynamicObject(2627,1862.5999756,-1742.9000244,5205.1000977,0.0000000,0.0000000,0.0000000); //object(gym_treadmill)(3)
	CreateDynamicObject(2628,1864.9000244,-1749.5000000,5205.1000977,0.0000000,0.0000000,230.0000000); //object(gym_bench2)(1)
	CreateDynamicObject(2628,1863.1999512,-1749.9000244,5205.1000977,0.0000000,0.0000000,229.9987793); //object(gym_bench2)(2)
	CreateDynamicObject(2630,1858.8000488,-1749.9000244,5205.1000977,0.0000000,0.0000000,150.0000000); //object(gym_bike)(1)
	CreateDynamicObject(2630,1857.4000244,-1749.6999512,5205.1000977,0.0000000,0.0000000,149.9963379); //object(gym_bike)(2)
	CreateDynamicObject(2630,1859.0999756,-1747.8000488,5205.1000977,0.0000000,0.0000000,149.9963379); //object(gym_bike)(3)
	CreateDynamicObject(2416,1863.0999756,-1730.5000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_disp)(1)
	CreateDynamicObject(2416,1860.8000488,-1730.5000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_disp)(2)
	CreateDynamicObject(2451,1865.4000244,-1728.1999512,5208.7001953,0.0000000,0.0000000,0.0000000); //object(cj_ff_worktop_3)(1)
	CreateDynamicObject(1330,1869.0999756,-1737.0999756,5209.2001953,0.0000000,0.0000000,0.0000000); //object(binnt14_la)(1)
	CreateDynamicObject(1330,1861.0000000,-1742.1999512,5209.2001953,0.0000000,0.0000000,0.0000000); //object(binnt14_la)(2)
	CreateDynamicObject(2994,1859.0999756,-1744.0999756,5209.2001953,0.0000000,0.0000000,0.0000000); //object(kmb_trolley)(2)
	CreateDynamicObject(2994,1859.0999756,-1742.5999756,5209.2001953,0.0000000,0.0000000,0.0000000); //object(kmb_trolley)(3)
	CreateDynamicObject(14401,1857.8000488,-1760.5999756,5205.3999023,0.0000000,0.0000000,359.9945068); //object(bench1)(4)
	CreateDynamicObject(14401,1857.8000488,-1762.5000000,5205.3999023,0.0000000,0.0000000,359.9890137); //object(bench1)(4)
	CreateDynamicObject(2700,1849.3000488,-1750.5999756,5207.2998047,0.0000000,0.0000000,90.0000000); //object(cj_sex_tv2)(1)
	CreateDynamicObject(1811,1848.8000488,-1708.6999512,5202.2001953,0.0000000,0.0000000,270.0000000); //object(med_din_chair_5)(5)
	CreateDynamicObject(1811,1851.4000244,-1708.6999512,5202.2001953,0.0000000,0.0000000,270.0000000); //object(med_din_chair_5)(5)
	CreateDynamicObject(1811,1854.0000000,-1708.6999512,5202.2001953,0.0000000,0.0000000,270.0000000); //object(med_din_chair_5)(5)
	CreateDynamicObject(1811,1856.5999756,-1708.8000488,5202.2001953,0.0000000,0.0000000,270.0000000); //object(med_din_chair_5)(5)
	CreateDynamicObject(19435,1856.0000000,-1707.4000244,5202.6000977,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(19435,1852.5000000,-1707.4000244,5202.6000977,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(19435,1849.0000000,-1707.4000244,5202.6000977,0.0000000,90.0000000,0.0000000); //object(cs_landbit_58_a)(1)
	CreateDynamicObject(1800,1842.6999512,-1711.3000488,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(1)
	CreateDynamicObject(1800,1839.5000000,-1711.3000488,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(2)
	CreateDynamicObject(1800,1836.4000244,-1711.1999512,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(3)
	CreateDynamicObject(1800,1833.0999756,-1711.1999512,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(4)
	CreateDynamicObject(1800,1829.9000244,-1711.1999512,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(5)
	CreateDynamicObject(1800,1826.6999512,-1711.1999512,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(6)
	CreateDynamicObject(1800,1826.6999512,-1711.1999512,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(7)
	CreateDynamicObject(1800,1829.9000244,-1711.1999512,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(8)
	CreateDynamicObject(1800,1833.0999756,-1711.1999512,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(9)
	CreateDynamicObject(1800,1836.3000488,-1711.1999512,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(10)
	CreateDynamicObject(1800,1839.5000000,-1711.1999512,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(11)
	CreateDynamicObject(1800,1842.6999512,-1711.1999512,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(12)
	CreateDynamicObject(1800,1842.6999512,-1711.1999512,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(13)
	CreateDynamicObject(1800,1839.5000000,-1711.3000488,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(14)
	CreateDynamicObject(1800,1836.3000488,-1711.1999512,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(15)
	CreateDynamicObject(1800,1833.0999756,-1711.1999512,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(16)
	CreateDynamicObject(1800,1829.9000244,-1711.1999512,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(17)
	CreateDynamicObject(1800,1826.6999512,-1711.1999512,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(18)
	CreateDynamicObject(1800,1826.6999512,-1737.0000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(19)
	CreateDynamicObject(1800,1829.9000244,-1737.0000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(20)
	CreateDynamicObject(1800,1833.0999756,-1737.0000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(21)
	CreateDynamicObject(1800,1836.3000488,-1737.0000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(22)
	CreateDynamicObject(1800,1839.5000000,-1737.0000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(23)
	CreateDynamicObject(1800,1842.6999512,-1737.0000000,5208.7001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(24)
	CreateDynamicObject(1800,1842.6999512,-1737.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(25)
	CreateDynamicObject(1800,1839.5000000,-1737.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(26)
	CreateDynamicObject(1800,1836.3000488,-1737.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(27)
	CreateDynamicObject(1800,1833.0999756,-1737.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(28)
	CreateDynamicObject(1800,1829.9000244,-1737.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(29)
	CreateDynamicObject(1800,1826.6999512,-1737.0000000,5205.2001953,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(30)
	CreateDynamicObject(1800,1826.6999512,-1737.0000000,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(31)
	CreateDynamicObject(1800,1829.9000244,-1737.0000000,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(32)
	CreateDynamicObject(1800,1833.0999756,-1737.0000000,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(33)
	CreateDynamicObject(1800,1836.3000488,-1737.0000000,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(34)
	CreateDynamicObject(1800,1839.5000000,-1737.0000000,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(35)
	CreateDynamicObject(1800,1842.6999512,-1737.0000000,5201.6000977,0.0000000,0.0000000,0.0000000); //object(low_bed_1)(36)
	CreateDynamicObject(2000,1826.6999512,-1711.3000488,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(1)
	CreateDynamicObject(2000,1829.9000244,-1711.4000244,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(2)
	CreateDynamicObject(2000,1833.0999756,-1711.4000244,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(3)
	CreateDynamicObject(2000,1836.3000488,-1711.4000244,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(4)
	CreateDynamicObject(2000,1839.5000000,-1711.4000244,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(5)
	CreateDynamicObject(2000,1842.6999512,-1711.4000244,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(6)
	CreateDynamicObject(2000,1842.6999512,-1711.4000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(7)
	CreateDynamicObject(2000,1839.5000000,-1711.4000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(8)
	CreateDynamicObject(2000,1836.3000488,-1711.4000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(9)
	CreateDynamicObject(2000,1833.0999756,-1711.4000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(10)
	CreateDynamicObject(2000,1829.9000244,-1711.4000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(11)
	CreateDynamicObject(2000,1826.6999512,-1711.4000244,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(12)
	CreateDynamicObject(2000,1826.6999512,-1711.4000244,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(13)
	CreateDynamicObject(2000,1829.9000244,-1711.5000000,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(14)
	CreateDynamicObject(2000,1833.0999756,-1711.5999756,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(15)
	CreateDynamicObject(2000,1836.4000244,-1711.6999512,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(16)
	CreateDynamicObject(2000,1839.5000000,-1711.8000488,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(17)
	CreateDynamicObject(2000,1842.6999512,-1732.1999512,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(18)
	CreateDynamicObject(2000,1842.6992188,-1711.8994141,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(19)
	CreateDynamicObject(2000,1839.5000000,-1732.0999756,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(20)
	CreateDynamicObject(2000,1836.3000488,-1732.0999756,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(21)
	CreateDynamicObject(2000,1833.0999756,-1732.0999756,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(22)
	CreateDynamicObject(2000,1829.9000244,-1732.0999756,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(23)
	CreateDynamicObject(2000,1826.6999512,-1732.0999756,5201.6000977,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(24)
	CreateDynamicObject(2000,1826.6999512,-1732.0999756,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(25)
	CreateDynamicObject(2000,1829.9000244,-1732.0999756,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(26)
	CreateDynamicObject(2000,1833.0999756,-1732.0000000,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(27)
	CreateDynamicObject(2000,1836.3000488,-1732.0000000,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(28)
	CreateDynamicObject(2000,1839.5000000,-1732.0000000,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(29)
	CreateDynamicObject(2000,1842.6999512,-1732.0000000,5205.2001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(30)
	CreateDynamicObject(2000,1842.6999512,-1732.0000000,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(32)
	CreateDynamicObject(2000,1839.5000000,-1732.0000000,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(33)
	CreateDynamicObject(2000,1836.3000488,-1732.0000000,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(34)
	CreateDynamicObject(2000,1833.0999756,-1732.0000000,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(35)
	CreateDynamicObject(2000,1829.9000244,-1732.0000000,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(36)
	CreateDynamicObject(2000,1826.6999512,-1732.0000000,5208.7001953,0.0000000,0.0000000,90.0000000); //object(filing_cab_nu)(37)
	CreateDynamicObject(1886,1857.4000244,-1713.6999512,5205.1000977,9.7500000,0.0000000,220.5000000); //object(shop_sec_cam)(1)
	CreateDynamicObject(1886,1858.3994141,-1698.7998047,5205.0000000,9.7448731,0.0000000,20.4949951); //object(shop_sec_cam)(2)
	CreateDynamicObject(1886,1848.0000000,-1701.7998047,5205.1000977,9.7448731,0.0000000,20.4949951); //object(shop_sec_cam)(3)
	CreateDynamicObject(1886,1852.5999756,-1715.0000000,5205.0000000,9.7448731,0.0000000,320.4956055); //object(shop_sec_cam)(4)
	CreateDynamicObject(1886,1865.6999512,-1723.0999756,5205.1000977,9.7448731,0.0000000,270.4931641); //object(shop_sec_cam)(5)
	CreateDynamicObject(1886,1846.5999756,-1728.6999512,5205.0000000,13.9949036,0.0000000,236.4888916); //object(shop_sec_cam)(6)
	CreateDynamicObject(1886,1846.5999756,-1728.6999512,5208.5000000,13.9910889,0.0000000,236.4862060); //object(shop_sec_cam)(8)
	CreateDynamicObject(1886,1846.5999756,-1728.6999512,5212.1000977,13.9910889,0.0000000,236.4862060); //object(shop_sec_cam)(9)
	CreateDynamicObject(1886,1865.4000244,-1742.3000488,5208.6000977,13.9910889,0.0000000,308.7362061); //object(shop_sec_cam)(10)
	CreateDynamicObject(1886,1846.1992188,-1750.3994141,5208.6000977,13.9910889,0.0000000,128.7322998); //object(shop_sec_cam)(11)
	CreateDynamicObject(1886,1869.0999756,-1733.8000488,5212.2001953,13.9910889,0.0000000,294.7322998); //object(shop_sec_cam)(12)
	CreateDynamicObject(1886,1866.7998047,-1742.1992188,5208.6000977,13.9910889,0.0000000,46.7303467); //object(shop_sec_cam)(13)
	CreateDynamicObject(1886,1867.5000000,-1750.5999756,5212.1000977,13.9910889,0.0000000,224.7302246); //object(shop_sec_cam)(14)
	CreateDynamicObject(1886,1845.8000488,-1750.5999756,5212.2001953,13.9910889,0.0000000,146.7253418); //object(shop_sec_cam)(15)

    //Doors
    doors[0] = CreateObject(1495,1849.32995605,-1714.31005859,5201.54003906,0.00000000,0.00000000,0.00000000); //object(gen_doorext01) (2)
    doors[1] = CreateObject(1495,1847.31994629,-1722.56994629,5201.54003906,0.00000000,0.00000000,90.00000000); //object(gen_doorext01) (3)
    doors[2] = CreateObject(1495,1854.01953125,-1726.27343750,5201.54003906,0.00000000,0.00000000,90.00000000); //object(gen_doorext01) (4)
    doors[3] = CreateObject(1495,1862.02246094,-1710.91992188,5201.54003906,0.00000000,0.00000000,0.00000000); //object(gen_doorext01) (4)

    //SetObjectMaterial - Fences
    SetObjectMaterial(fence0, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence1, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence2, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence3, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence4, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence5, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence6, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence7, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence8, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence9, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence10, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence11, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence12, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence13, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence14, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence15, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence16, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence17, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence18, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence19, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence20, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence21, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence22, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence23, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence24, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence25, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence26, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence27, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence28, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence29, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence30, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence31, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence32, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence33, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence34, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);
    SetObjectMaterial(fence35, 0, 19304, "pd_jail_door_top01", "pd_jail_door_top01", 0xFF000000);

    //SetObjectMaterial - Stairs
    SetObjectMaterial(stairs[0], 0, 19377, "all_walls", "la_carp3", 0);
    SetObjectMaterial(stairs[0], 1, 19377, "all_walls", "la_carp3", 0);
    SetObjectMaterial(stairs[1], 0, 19377, "all_walls", "la_carp3", 0);
    SetObjectMaterial(stairs[1], 1, 19377, "all_walls", "la_carp3", 0);
    SetObjectMaterial(stairs[2], 0, 19377, "all_walls", "la_carp3", 0);
    SetObjectMaterial(stairs[2], 1, 19377, "all_walls", "la_carp3", 0);


    // Army map and vehicles
		

    CreateDynamicObject(4571, -1311.42798, 418.53189, -57.84590,   0.00000, 0.00000, 359.83246);
    CreateDynamicObject(4571, -1250.48572, 418.22934, -57.84590,   0.00000, 0.00000, 359.74481);
    CreateDynamicObject(4571, -1250.65320, 379.35779, -57.84590,   0.00000, 0.00000, 359.74481);
    CreateDynamicObject(4571, -1250.81750, 340.51160, -57.84590,   0.00000, 0.00000, 359.74481);
    CreateDynamicObject(4571, -1311.76941, 340.78961, -57.84590,   0.00000, 0.00000, 359.74481);
    CreateDynamicObject(4571, -1311.59033, 379.64130, -57.84590,   0.00000, 0.00000, 359.74481);
    CreateDynamicObject(8171, -1410.35791, 426.73651, 6.15300,   0.00000, 0.00000, 89.59500);
    CreateDynamicObject(8171, -1406.66565, 355.30649, 6.15300,   0.00000, 0.00000, 89.59500);
    CreateDynamicObject(8171, -1410.92041, 391.28558, 6.15300,   0.00000, 0.00000, 89.59500);
    CreateDynamicObject(8150, -1507.68884, 260.21121, 9.26020,   0.00000, 0.00000, 180.08417);
    CreateDynamicObject(3268, -1238.17310, 416.79868, 6.13641,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3268, -1238.13354, 379.35956, 6.13641,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3268, -1238.23254, 341.76260, 6.13641,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3279, -1287.16919, 428.56000, 6.12947,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3279, -1288.03467, 328.27280, 6.12947,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.66345, 334.23700, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1234.60474, 371.82489, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.76965, 424.38770, 5.64580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1243.55579, 389.74271, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1234.57617, 389.78760, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1234.58704, 380.80960, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.58484, 371.75510, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.60681, 331.43231, 5.63800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1234.67102, 334.24731, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.65125, 343.22781, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1234.67114, 343.21301, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.57104, 380.75119, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.58276, 406.44269, 5.65580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1243.57471, 415.43091, 5.65580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1232.77124, 427.27881, 5.63580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1234.57800, 424.40881, 5.65580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1234.59241, 415.42841, 5.65580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(8661, -1338.69812, 335.68909, 6.17670,   0.00000, 0.00000, 269.34619);
    CreateDynamicObject(8661, -1238.18933, 340.99109, 6.16870,   0.00000, 0.00000, 89.89390);
    CreateDynamicObject(8661, -1230.83899, 340.95499, 6.19770,   0.00000, 0.00000, 89.68250);
    CreateDynamicObject(8661, -1337.73779, 415.65411, 6.17670,   0.00000, 0.00000, 269.34619);
    CreateDynamicObject(8661, -1338.20496, 375.66730, 6.17670,   0.00000, 0.00000, 269.34619);
    CreateDynamicObject(8661, -1238.15222, 413.64340, 6.17870,   0.00000, 0.00000, 90.00100);
    CreateDynamicObject(8661, -1230.31531, 448.15823, 6.17870,   0.00000, 0.00000, 89.68250);
    CreateDynamicObject(8661, -1230.70801, 373.65240, 6.18800,   0.00000, 0.00000, 89.88350);
    CreateDynamicObject(8661, -1238.14380, 344.33691, 6.17870,   0.00000, 0.00000, 90.00100);
    CreateDynamicObject(3095, -1234.64404, 352.21301, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.82324, 352.21179, 5.64580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.73511, 343.22351, 5.64580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1243.56116, 368.85941, 5.62580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.72815, 389.85361, 5.64580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.69995, 380.86511, 5.64580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.71704, 371.89429, 5.64580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.72009, 368.97751, 5.63580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1241.70007, 368.87601, 5.63580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.75586, 334.22760, 5.64580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1232.84558, 331.28360, 5.64800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1241.82275, 331.41351, 5.64800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3095, -1234.59900, 406.43881, 5.65580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1232.76196, 406.44119, 5.64580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1232.77185, 415.41681, 5.64580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1243.56421, 424.41071, 5.65580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1243.58936, 427.16299, 5.64580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(3095, -1234.59351, 427.26349, 5.64580,   0.00000, 0.00000, 359.88470);
    CreateDynamicObject(16093, -1320.90735, 408.38486, 10.25090,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(16638, -1320.83813, 407.42160, 8.50510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(16093, -1320.70947, 333.38968, 10.25090,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(16638, -1320.61450, 332.41599, 8.50510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(16093, -1320.91736, 372.68140, 10.25090,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(16638, -1320.85144, 371.69211, 8.50510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3277, -1264.43298, 428.72839, 6.95360,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3277, -1301.02917, 428.17609, 6.95360,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3277, -1264.95886, 327.31134, 6.95360,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3277, -1303.42322, 327.20929, 6.95360,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3267, -1300.94055, 428.23624, 6.98960,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3267, -1303.44263, 327.16791, 6.99790,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3267, -1264.81091, 327.09097, 6.96490,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3267, -1264.72632, 428.93661, 6.98960,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3578, -1348.35706, 363.36929, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1347.69006, 418.36389, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1327.95874, 418.46219, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1328.21411, 395.99570, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1347.78723, 399.18152, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1247.89575, 398.00201, 5.40130,   0.00000, 0.00000, 270.22720);
    CreateDynamicObject(8150, -1221.15906, 405.01761, 9.25290,   0.00000, 0.00000, 269.95520);
    CreateDynamicObject(3630, -1230.06543, 422.35541, 7.67710,   0.00000, 0.00000, 269.11099);
    CreateDynamicObject(3576, -1230.01318, 415.17096, 7.66880,   0.00000, 0.00000, 90.19400);
    CreateDynamicObject(3633, -1230.58057, 412.11981, 6.67320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(5269, -1229.33228, 385.91501, 8.51840,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(5261, -1229.66479, 376.96091, 8.43930,   0.00000, 0.00000, 270.21161);
    CreateDynamicObject(5262, -1232.74902, 347.42191, 9.11350,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(5269, -1229.60010, 338.06491, 8.51890,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19467, -1248.28894, 334.54910, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.27148, 423.75500, 5.64030,   250.64700, 0.00000, 270.05826);
    CreateDynamicObject(19467, -1248.25806, 419.48431, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.25146, 415.22360, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.23438, 410.96231, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.23975, 409.60480, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.27661, 386.50699, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.28247, 382.22861, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.27173, 377.96399, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.27454, 373.70251, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.26221, 372.21701, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.33508, 348.84241, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.32397, 344.60229, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.31384, 340.33331, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(19467, -1248.30554, 336.09491, 5.64030,   250.64700, 0.00000, 270.05829);
    CreateDynamicObject(3624, -1240.89929, 450.28119, 10.40920,   0.00000, 0.00000, 359.46280);
    CreateDynamicObject(8661, -1230.55029, 413.64081, 6.18870,   0.00000, 0.00000, 89.68250);
    CreateDynamicObject(10245, -1334.90894, 493.80521, 6.60480,   0.00000, 0.00000, 315.06470);
    CreateDynamicObject(10245, -1334.44434, 475.78741, 6.60480,   0.00000, 0.00000, 135.17000);
    CreateDynamicObject(3761, -1247.71350, 442.35608, 8.20170,   0.00000, 0.00000, 357.81161);
    CreateDynamicObject(3761, -1248.82092, 458.38910, 8.20170,   0.00000, 0.00000, 357.81161);
    CreateDynamicObject(3761, -1240.72229, 458.44781, 8.20170,   0.00000, 0.00000, 357.81161);
    CreateDynamicObject(3761, -1232.52258, 457.93811, 8.20170,   0.00000, 0.00000, 357.81161);
    CreateDynamicObject(3761, -1233.15759, 442.44638, 8.20170,   0.00000, 0.00000, 357.81161);
    CreateDynamicObject(3761, -1240.99207, 442.68234, 8.20170,   0.00000, 0.00000, 357.81161);
    CreateDynamicObject(987, -1495.11218, 481.54251, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1220.57288, 467.89529, 6.16660,   0.00000, 0.00000, 135.06050);
    CreateDynamicObject(987, -1225.84473, 473.30807, 6.16660,   0.00000, 0.00000, 135.06050);
    CreateDynamicObject(987, -1234.17944, 481.72180, 6.16660,   0.00000, 0.00000, 180.12222);
    CreateDynamicObject(987, -1733.77246, 263.09518, 6.19960,   0.00000, 0.00000, 345.12949);
    CreateDynamicObject(987, -1258.16626, 481.71921, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1270.14294, 481.75034, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1282.08496, 481.72330, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1294.00378, 481.71231, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(3578, -1327.85339, 428.76410, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1347.56787, 428.63202, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1328.33862, 385.71619, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1347.88684, 388.97766, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1328.72131, 349.77139, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1348.45447, 353.07513, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3095, -1243.63940, 352.22861, 5.65580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3794, -1230.22791, 369.08353, 6.65930,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3794, -1230.08875, 370.73819, 6.65930,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3578, -1328.62500, 360.07269, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1247.99670, 326.24911, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(3578, -1247.94202, 360.21851, 5.40130,   0.00000, 0.00000, 269.47931);
    CreateDynamicObject(4100, -1273.07031, 375.19409, 10.39110,   0.00000, 0.00000, 49.93820);
    CreateDynamicObject(4100, -1279.70386, 392.91400, 10.29700,   0.00000, 0.00000, 320.16830);
    CreateDynamicObject(4100, -1291.20984, 392.90891, 10.23990,   0.00000, 0.00000, 320.16830);
    CreateDynamicObject(4100, -1297.98413, 386.34250, 10.12960,   0.00000, 0.00000, 50.66130);
    CreateDynamicObject(4100, -1297.95508, 375.23331, 10.17800,   0.00000, 0.00000, 50.23340);
    CreateDynamicObject(4100, -1291.32141, 368.02850, 10.17230,   0.00000, 0.00000, 140.38710);
    CreateDynamicObject(4100, -1273.10486, 386.34921, 10.36140,   0.00000, 0.00000, 49.93820);
    CreateDynamicObject(18255, -1257.67688, 433.81140, 6.88660,   0.00000, 0.00000, 270.52429);
    CreateDynamicObject(987, -1246.17224, 481.73721, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1221.23792, 321.17859, 6.16660,   0.00000, 0.00000, 89.13270);
    CreateDynamicObject(987, -1244.77148, 321.24469, 6.16660,   0.00000, 0.00000, 0.24377);
    CreateDynamicObject(987, -1256.76575, 321.19751, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1268.59949, 321.24200, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1280.63452, 321.29630, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1292.60315, 321.27130, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1304.64307, 321.50000, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1316.68066, 321.54675, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1232.74829, 321.27701, 6.16660,   0.00000, 0.00000, 359.42029);
    CreateDynamicObject(987, -1221.21216, 330.30881, 6.16660,   0.00000, 0.00000, 89.13270);
    CreateDynamicObject(987, -1327.46130, 321.53439, 6.16660,   0.00000, 0.00000, 0.24380);
    CreateDynamicObject(987, -1327.76709, 305.72415, 6.16660,   0.00000, 0.00000, 89.96261);
    CreateDynamicObject(987, -1335.99719, 297.51157, 6.16660,   0.00000, 0.00000, 45.06412);
    CreateDynamicObject(987, -1341.51599, 291.97601, 6.16660,   0.00000, 0.00000, 45.06410);
    CreateDynamicObject(987, -1353.46326, 291.97672, 6.16660,   0.00000, 0.00000, 0.34684);
    CreateDynamicObject(987, -1365.31982, 291.91901, 6.16660,   0.00000, 0.00000, 0.34684);
    CreateDynamicObject(987, -1377.31836, 291.75433, 6.16660,   0.00000, 0.00000, 0.34684);
    CreateDynamicObject(987, -1389.31824, 291.80118, 6.16660,   0.00000, 0.00000, 359.92438);
    CreateDynamicObject(987, -1401.34399, 291.67310, 6.16660,   0.00000, 0.00000, 0.64570);
    CreateDynamicObject(987, -1413.32007, 291.59995, 6.16660,   0.00000, 0.00000, 0.64570);
    CreateDynamicObject(987, -1425.24792, 291.63220, 6.16660,   0.00000, 0.00000, 359.92435);
    CreateDynamicObject(987, -1437.30103, 291.82330, 6.16660,   0.00000, 0.00000, 359.92435);
    CreateDynamicObject(987, -1444.73889, 260.51770, 6.16660,   0.00000, 0.00000, 90.50090);
    CreateDynamicObject(987, -1444.84167, 272.52600, 6.16660,   0.00000, 0.00000, 90.50090);
    CreateDynamicObject(987, -1444.70227, 276.52841, 6.16660,   0.00000, 0.00000, 90.50092);
    CreateDynamicObject(987, -1582.59412, 260.10959, 6.16660,   0.00000, 0.00000, 359.57761);
    CreateDynamicObject(987, -1594.65405, 259.98090, 6.16660,   0.00000, 0.00000, 0.41180);
    CreateDynamicObject(987, -1600.43555, 259.86227, 6.16660,   0.00000, 0.00000, 0.04187);
    CreateDynamicObject(987, -1612.29834, 259.98370, 6.16660,   0.00000, 0.00000, 359.91431);
    CreateDynamicObject(987, -1624.30664, 260.19171, 6.14180,   0.00000, 0.00000, 359.15250);
    CreateDynamicObject(987, -1642.13013, 260.12170, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1654.04321, 260.11887, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1666.01428, 260.08954, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1677.99609, 260.12997, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1689.84717, 259.97137, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1701.91785, 259.94760, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1713.83728, 259.98462, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1725.77686, 260.13422, 6.19960,   0.00000, 0.00000, 0.27670);
    CreateDynamicObject(987, -1327.61682, 309.47025, 6.16660,   0.00000, 0.00000, 89.96261);
    CreateDynamicObject(18850, -1608.27100, 285.32880, -5.83420,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(9241, -1285.74304, 380.54721, 7.88960,   0.00000, 0.00000, 0.07790);
    CreateDynamicObject(3576, -1237.82678, 399.97751, 7.67150,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3576, -1237.23242, 362.57300, 7.67150,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3526, -1294.76086, 370.74469, 8.80970,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3526, -1275.67676, 370.63159, 8.80970,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3526, -1275.73889, 390.19965, 8.80970,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3526, -1294.50256, 390.18500, 8.80970,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(987, -1303.12537, 481.71359, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1320.98950, 481.74149, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1336.31567, 481.74979, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1348.37073, 481.76840, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1360.29736, 481.81873, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1372.34363, 481.81519, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1384.34314, 481.77170, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1396.28369, 481.82190, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1408.15088, 481.86407, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1420.14307, 481.80701, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1432.17346, 481.80310, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1451.53906, 481.88010, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1463.50977, 481.86151, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1475.47339, 481.78220, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(987, -1485.02124, 481.80649, 6.16660,   0.00000, 0.00000, 180.12219);
    CreateDynamicObject(10810, -1242.07764, 473.76489, 10.89716,   0.00000, 0.00000, 199.79959);
    CreateDynamicObject(1278, -1252.02869, 430.95007, 4.17074,   0.00000, 0.00000, 322.21194);
    CreateDynamicObject(1278, -1254.21851, 324.97992, 4.08627,   0.00000, 0.00000, 212.69081);
    CreateDynamicObject(1278, -1323.86450, 325.19696, 4.25745,   0.00000, 0.00000, 117.72379);
    CreateDynamicObject(1290, -1333.52625, 409.37747, 11.98580,   0.00000, 0.00000, 87.86347);
    CreateDynamicObject(1290, -1332.81628, 372.91840, 11.98580,   0.00000, 0.00000, 87.86347);


	//Swat map and vehicles
    CreateVehicle(487,-991.79980469,-626.59960938,32.29999924,90.00000000,-1,-1,50);
	CreateVehicle(487,-991.39941406,-661.79980469,32.29999924,90.00000000,-1,-1,50);
	CreateVehicle(563,-993.00000000,-644.50000000,32.90000153,90.00000000,-1,-1,50);
	CreateVehicle(426,-1004.39941406,-679.09960938,31.79999924,90.00000000,-1,-1,50);
	CreateVehicle(426,-1004.29980469,-673.89941406,31.79999924,90.00000000,-1,-1,50);
	CreateVehicle(522,-1030.00000000,-684.00000000,31.70000076,271.99951172,-1,-1,50);
	CreateVehicle(522,-1030.09960938,-681.50000000,31.50000000,271.99951172,-1,-1,50);
	CreateVehicle(522,-1029.89941406,-679.00000000,31.70000076,271.99951172,-1,-1,50);
	CreateVehicle(601,-1039.09997559,-679.59997559,31.89999962,359.99499512,245,245,50);
	CreateVehicle(427,-1045.09997559,-611.79998779,32.29999924,270.00000000,-1,-1,50);
	CreateVehicle(426,-1004.50000000,-684.20001221,31.79999924,90.00000000,-1,-1,50);
	CreateVehicle(427,-1044.90002441,-605.79998779,32.29999924,269.99951172,-1,-1,50);
	CreateDynamicObject(3268, -1048.50, -653.90, 31.00,   0.00, 0.00, 179.98);
	CreateDynamicObject(16782, -1058.20, -652.50, 34.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(16662, -1053.20, -642.40, 32.20,   0.00, 0.00, 9.99);
	CreateDynamicObject(3394, -1040.80, -667.80, 31.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(3395, -1047.40, -667.70, 31.00,   0.00, 0.00, 272.00);
	CreateDynamicObject(3397, -1053.80, -667.30, 31.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(1671, -1040.50, -666.30, 31.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(1671, -1047.30, -666.40, 31.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(1671, -1053.60, -666.10, 31.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(955, -1044.20, -639.40, 31.40,   0.00, 0.00, 0.00);
	CreateDynamicObject(16093, -1026.80, -595.40, 35.30,   0.00, 0.00, 179.99);
	CreateDynamicObject(16638, -1026.90, -594.30, 33.70,   0.00, 0.00, 179.99);
	CreateDynamicObject(970, -1030.90, -588.40, 36.70,   0.00, 0.00, 358.00);
	CreateDynamicObject(970, -1026.80, -588.50, 36.70,   0.00, 0.00, 357.99);
	CreateDynamicObject(970, -1022.60, -588.60, 36.70,   0.00, 0.00, 358.00);
	CreateDynamicObject(3279, -1007.80, -599.50, 31.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(3279, -983.60, -680.80, 31.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(2165, -1057.50, -663.10, 31.00,   0.00, 0.00, 90.00);
	CreateDynamicObject(2605, -1057.10, -658.70, 31.40,   0.00, 0.00, 92.00);
	CreateDynamicObject(987, -1496.60, 450.50, 29.10,   0.00, 0.00, 0.00);
	CreateDynamicObject(967, -1038.80, -459.60, 35.10,   0.00, 0.00, 112.00);
	CreateDynamicObject(966, -1041.00, -460.10, 34.90,   0.00, 0.00, 24.00);
	CreateDynamicObject(3877, -1045.20, -587.90, 37.80,   0.00, 0.00, 0.00);
	CreateDynamicObject(3877, -1032.80, -588.42, 37.76,   0.00, 0.00, 0.00);
	CreateDynamicObject(3934, -991.90, -644.30, 31.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1963, -1056.90, -645.10, 31.40,   0.00, 0.00, 64.00);
	CreateDynamicObject(1963, -1053.90, -642.00, 31.40,   0.00, 0.00, 36.00);
	CreateDynamicObject(1963, -1050.00, -640.60, 31.40,   0.00, 0.00, 8.00);
	CreateDynamicObject(1671, -1055.80, -645.60, 31.50,   0.00, 0.00, 240.00);
	CreateDynamicObject(1671, -1053.30, -642.90, 31.50,   0.00, 0.00, 210.00);
	CreateDynamicObject(1671, -1049.80, -641.60, 31.50,   0.00, 0.00, 190.00);
	CreateDynamicObject(1671, 167.70, 134.40, 511.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(17017, -1074.90, -718.60, 85.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(2961, -1047.60, -639.10, 32.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(3934, -992.00, -626.70, 31.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1297, -1037.30, -644.70, 34.40,   0.00, 0.00, 106.00);
	CreateDynamicObject(1297, -1037.60, -662.60, 34.40,   0.00, 0.00, 250.00);
	CreateDynamicObject(1294, -1053.90, -465.90, 38.70,   0.00, 0.00, 290.00);
	CreateDynamicObject(1294, -1075.00, -478.30, 37.40,   0.00, 0.00, 310.00);
	CreateDynamicObject(1294, -1094.20, -496.10, 36.40,   0.00, 0.00, 320.00);
	CreateDynamicObject(1294, -1108.20, -513.80, 34.90,   0.00, 0.00, 330.00);
	CreateDynamicObject(1294, -1123.70, -538.80, 33.80,   0.00, 0.00, 330.00);
	CreateDynamicObject(1294, -1137.60, -565.70, 33.80,   0.00, 0.00, 330.00);
	CreateDynamicObject(1294, -1146.60, -589.20, 37.20,   0.00, 0.00, 340.00);
	CreateDynamicObject(1294, -1154.30, -615.00, 41.80,   0.00, 0.00, 346.00);
	CreateDynamicObject(1294, -1160.20, -634.10, 44.40,   0.00, 0.00, 350.00);
	CreateDynamicObject(1294, -1167.00, -658.90, 48.20,   0.00, 0.00, 350.00);
	CreateDynamicObject(1294, -1175.80, -690.70, 54.50,   0.00, 0.00, 340.00);
	CreateDynamicObject(1294, -1012.70, -448.40, 40.00,   0.00, 0.00, 300.00);
	CreateDynamicObject(1294, -1000.80, -422.40, 40.00,   0.00, 0.00, 130.00);
	CreateDynamicObject(1294, -1181.40, -707.00, 57.40,   0.00, 0.00, 348.00);
	CreateDynamicObject(1294, -1190.90, -730.80, 61.40,   0.00, 0.00, 338.00);
	CreateDynamicObject(1294, -1206.50, -753.30, 64.90,   0.00, 0.00, 320.00);
	CreateDynamicObject(1294, -1227.60, -779.50, 67.60,   0.00, 0.00, 220.00);
	CreateDynamicObject(1290, -1045.40, -579.80, 37.00,   0.00, 0.00, 356.00);
	CreateDynamicObject(1290, -1045.30, -555.00, 37.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1290, -1045.90, -529.40, 37.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1290, -1046.30, -509.90, 37.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1290, -1045.20, -488.30, 37.40,   0.00, 0.00, 358.75);
	CreateDynamicObject(9125, -2263.90, 2334.00, 4.10,   0.00, 0.00, 90.00);
	CreateDynamicObject(2207, -1054.50, -653.50, 31.00,   0.00, 0.00, 89.99);
	CreateDynamicObject(1671, -1056.10, -652.60, 31.50,   0.00, 0.00, 90.00);
	CreateDynamicObject(1671, -1045.80, -647.60, 31.50,   0.00, 0.00, 286.00);
	CreateDynamicObject(1671, -1047.60, -651.90, 31.50,   0.00, 0.00, 210.00);
	CreateDynamicObject(1671, -1047.40, -645.50, 31.50,   0.00, 0.00, 330.00);
	CreateDynamicObject(3934, -991.90, -661.80, 31.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -988.30, -630.30, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -988.20, -623.30, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.90, -623.40, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.90, -630.20, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.80, -641.00, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.80, -647.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -988.20, -640.90, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -988.20, -647.90, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.80, -658.50, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -988.10, -658.40, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.90, -665.40, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -995.90, -665.40, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -988.30, -665.30, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.80, -586.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.20, -586.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.20, -580.50, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.90, -580.50, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.90, -570.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.30, -570.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.30, -556.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.30, -556.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.30, -541.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.30, -541.80, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.30, -526.50, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.10, -526.50, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1043.80, -510.90, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.30, -510.90, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.30, -510.90, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1042.70, -490.10, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.20, -490.10, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1035.20, -477.00, 33.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1044.00, -477.00, 33.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1047.10, -466.50, 34.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1038.00, -464.60, 35.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1033.20, -500.60, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1215, -1043.10, -500.60, 31.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1499, -1058.50, -666.30, 31.00,   0.00, 0.00, 268.00);
	CreateDynamicObject(1499, -1058.40, -667.90, 31.00,   0.00, 0.00, 92.74);
	CreateDynamicObject(2147, 461.40, 2446.30, 8.40,   0.00, 0.00, 5.00);
	CreateDynamicObject(970, -1018.50, -588.70, 36.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, -1014.30, -588.70, 36.70,   0.00, 0.00, 358.00);
	CreateDynamicObject(970, -1010.20, -588.82, 36.70,   0.00, 0.00, 357.99);
	CreateDynamicObject(970, -1006.10, -589.00, 36.70,   0.00, 0.00, 357.99);
	CreateDynamicObject(970, -1002.30, -590.30, 36.70,   0.00, 0.00, 319.99);
	CreateDynamicObject(970, -999.40, -593.00, 36.70,   0.00, 0.00, 313.99);
	CreateDynamicObject(970, -996.80, -595.70, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -993.80, -598.85, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -991.00, -601.70, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -988.10, -604.70, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -985.20, -607.70, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -982.60, -610.40, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -979.70, -613.40, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -976.90, -616.30, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -974.20, -619.10, 36.70,   0.00, 0.00, 313.98);
	CreateDynamicObject(970, -972.40, -622.80, 36.70,   0.00, 0.00, 273.98);
	CreateDynamicObject(970, -972.40, -626.90, 36.70,   0.00, 0.00, 267.98);
	CreateDynamicObject(970, -972.50, -631.00, 36.70,   0.00, 0.00, 269.98);
	CreateDynamicObject(970, -972.50, -635.20, 36.70,   0.00, 0.00, 269.98);
	CreateDynamicObject(970, -972.50, -639.30, 36.70,   0.00, 0.00, 269.98);
	CreateDynamicObject(970, -972.50, -643.40, 36.70,   0.00, 0.00, 269.98);
	CreateDynamicObject(970, -972.55, -647.60, 36.70,   0.00, 0.00, 269.98);
	CreateDynamicObject(970, -972.60, -651.70, 36.70,   0.00, 0.00, 269.98);
	CreateDynamicObject(970, -972.60, -655.90, 36.70,   0.00, 0.00, 267.98);
	CreateDynamicObject(970, -972.70, -660.20, 36.70,   0.00, 0.00, 269.00);


	//pirate
	CreateDynamicObject(10410,-2077.9677734,-7664.4560547,16.1549606,0.0000000,0.0000000,249.9938965); //object(hc_golfcrse10_sfs)(1)
	CreateDynamicObject(6295,-2167.5878906,-7731.4648438,75.9764557,0.0000000,0.0000000,313.9892578); //object(sanpedlithus_law2)(1)
	CreateDynamicObject(8493,-2069.8544922,-7560.6767578,17.7500000,0.0000000,0.0000000,285.9960938); //object(pirtshp01_lvs)(1)
	CreateDynamicObject(9159,-2069.8999023,-7560.6699219,17.6590233,0.0000000,0.0000000,286.0000000); //object(pirtshp02_lvs)(1)
	CreateDynamicObject(3886,-2045.3730469,-7603.0781250,1.1680000,0.0000000,0.0000000,111.9951172); //object(ws_jettynol_sfx)(1)
	CreateDynamicObject(3886,-2054.7636719,-7607.0166016,1.1686039,0.0000000,0.0000000,111.9951477); //object(ws_jettynol_sfx)(2)
	CreateDynamicObject(3886,-2063.8105469,-7611.2519531,1.1686000,0.0000000,0.0000000,113.9886780); //object(ws_jettynol_sfx)(3)
	CreateDynamicObject(3886,-2073.0722656,-7615.6533203,1.1686039,0.0000000,0.0000000,115.9936218); //object(ws_jettynol_sfx)(4)
	CreateDynamicObject(3886,-2082.3447266,-7619.9082031,1.1686039,0.0000000,0.0000000,115.9881592); //object(ws_jettynol_sfx)(5)
	CreateDynamicObject(3886,-2037.7194824,-7605.9311523,-24.5813961,180.0000000,0.0000000,19.9896240); //object(ws_jettynol_sfx)(11)
	CreateDynamicObject(3886,-2034.0009766,-7614.6621094,-24.5813961,179.9945068,0.0000000,23.9831543); //object(ws_jettynol_sfx)(12)
	CreateDynamicObject(3886,-2029.4118652,-7622.5537109,-24.5813961,179.9945068,0.0000000,35.9831543); //object(ws_jettynol_sfx)(13)
	CreateDynamicObject(3886,-2026.5224609,-7627.2402344,-24.5813961,179.9945068,0.0000000,37.9802246); //object(ws_jettynol_sfx)(14)
	CreateDynamicObject(3886,-2041.6943359,-7607.2539062,-25.0813961,179.9945068,0.0000000,21.9781494); //object(ws_jettynol_sfx)(15)
	CreateDynamicObject(3886,-2046.0563965,-7608.5751953,-25.0813961,179.9945068,0.0000000,21.9781494); //object(ws_jettynol_sfx)(16)
	CreateDynamicObject(3886,-2048.6154785,-7609.6176758,-25.0813961,179.9945068,0.0000000,35.9781494); //object(ws_jettynol_sfx)(17)
	CreateDynamicObject(3886,-2053.3430176,-7612.2158203,-24.8313961,179.9945068,0.0000000,23.9747315); //object(ws_jettynol_sfx)(18)
	CreateDynamicObject(3886,-2057.3605957,-7613.0869141,-24.8313961,179.9945068,0.0000000,15.9721680); //object(ws_jettynol_sfx)(19)
	CreateDynamicObject(3886,-2058.9147949,-7614.1650391,-24.8313961,179.9945068,0.0000000,43.9686279); //object(ws_jettynol_sfx)(20)
	CreateDynamicObject(3886,-2063.5793457,-7616.3540039,-24.8313961,179.9945068,0.0000000,19.9672852); //object(ws_jettynol_sfx)(21)
	CreateDynamicObject(3886,-2067.7216797,-7617.7314453,-24.8313961,179.9945068,0.0000000,19.9621582); //object(ws_jettynol_sfx)(22)
	CreateDynamicObject(3886,-2071.5498047,-7619.2646484,-24.8313961,179.9945068,0.0000000,23.9621582); //object(ws_jettynol_sfx)(23)
	CreateDynamicObject(3886,-2074.9052734,-7620.9653320,-24.8313961,179.9945068,0.0000000,27.9611816); //object(ws_jettynol_sfx)(24)
	CreateDynamicObject(3886,-2079.5195312,-7622.8984375,-24.8313961,179.9945068,0.0000000,21.9602051); //object(ws_jettynol_sfx)(25)
	CreateDynamicObject(3886,-2084.4606934,-7623.9692383,-24.8313961,179.9945068,0.0000000,11.9561768); //object(ws_jettynol_sfx)(26)
	CreateDynamicObject(3886,-2082.4208984,-7622.4750977,-37.5813980,179.9945068,0.0000000,33.9531250); //object(ws_jettynol_sfx)(27)
	CreateDynamicObject(3886,-2079.6940918,-7621.1953125,-37.5813980,179.9945068,0.0000000,17.9516602); //object(ws_jettynol_sfx)(28)
	CreateDynamicObject(3886,-2075.4853516,-7619.3173828,-37.5813980,179.9945068,0.0000000,25.9516602); //object(ws_jettynol_sfx)(29)
	CreateDynamicObject(3886,-2072.3579102,-7617.9799805,-37.5813980,179.9945068,0.0000000,21.9497070); //object(ws_jettynol_sfx)(30)
	CreateDynamicObject(3886,-2084.9443359,-7623.4160156,-37.5813980,179.9945068,0.0000000,31.9477539); //object(ws_jettynol_sfx)(31)
	CreateDynamicObject(11245,-2168.1171875,-7732.6367188,102.3216629,0.0000000,289.9896240,0.0000000); //object(sfsefirehseflag)(1)
	CreateDynamicObject(16410,-2104.7675781,-7654.6787109,16.9130173,0.0000000,0.0000000,8.0000000); //object(desn2_graves)(1)
	CreateDynamicObject(3249,-2067.4228516,-7629.3164062,1.8240147,0.0000000,0.0000000,205.9936523); //object(des_westsaloon_)(1)
	CreateDynamicObject(16690,-2041.8210449,-7650.4287109,5.2282715,0.0000000,0.0000000,25.9881592); //object(des_westsaloon_02)(1)
	CreateDynamicObject(16051,-2063.6123047,-7621.0205078,5.3241577,0.0000000,0.0000000,295.9991455); //object(des_westsaloon_01)(1)
	CreateDynamicObject(16105,-2054.0625000,-7619.6005859,3.7141542,0.0000000,0.0000000,293.9996338); //object(des_westrn11_04)(1)
	CreateDynamicObject(711,-2051.6850586,-7614.5937500,7.4207993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(1)
	CreateDynamicObject(711,-2074.2119141,-7630.2626953,8.1707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(2)
	CreateDynamicObject(711,-2039.9179688,-7614.2939453,7.9207993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(3)
	CreateDynamicObject(837,-2048.8925781,-7618.1914062,2.6956103,0.0000000,0.0000000,291.9946289); //object(dead_tree_1)(1)
	CreateDynamicObject(711,-2058.1171875,-7637.7607422,8.6707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(4)
	CreateDynamicObject(711,-2085.1240234,-7656.3964844,22.1707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(711,-2079.0361328,-7670.5058594,17.7718258,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(9)
	CreateDynamicObject(746,-2042.0986328,-7608.6279297,2.0394743,0.0000000,0.0000000,17.9956055); //object(sm_scrub_rock2)(1)
	CreateDynamicObject(750,-2094.1042481,-7639.2153320,16.5030804,0.0000000,0.0000000,0.0000000); //object(sm_scrb_column2)(1)
	CreateDynamicObject(855,-2122.5229492,-7604.0375977,0.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(1)
	CreateDynamicObject(855,-2118.8051758,-7604.0429688,-0.8247299,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(2)
	CreateDynamicObject(855,-2114.6708984,-7606.5893555,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(3)
	CreateDynamicObject(855,-2110.8691406,-7606.3593750,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(4)
	CreateDynamicObject(855,-2113.2226562,-7605.5146484,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(5)
	CreateDynamicObject(855,-2116.5175781,-7604.3320312,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(6)
	CreateDynamicObject(855,-2121.7011719,-7606.1909180,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(7)
	CreateDynamicObject(855,-2121.0009766,-7610.1611328,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(8)
	CreateDynamicObject(855,-2107.1728516,-7609.7285156,1.4252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(17)
	CreateDynamicObject(855,-2108.3144531,-7608.0117188,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(18)
	CreateDynamicObject(855,-2104.9877930,-7611.0439453,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(19)
	CreateDynamicObject(855,-2106.8403320,-7613.0742188,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(20)
	CreateDynamicObject(855,-2111.0791016,-7613.2675781,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(21)
	CreateDynamicObject(855,-2116.2260742,-7612.9716797,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(22)
	CreateDynamicObject(855,-2115.8886719,-7612.6025391,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(23)
	CreateDynamicObject(855,-2113.0249023,-7609.4648438,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(24)
	CreateDynamicObject(855,-2110.4533691,-7611.4702148,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(25)
	CreateDynamicObject(855,-2104.0615234,-7615.4375000,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2105.8300781,-7618.5458984,0.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(30)
	CreateDynamicObject(855,-2109.5654297,-7618.2236328,5.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(31)
	CreateDynamicObject(855,-2107.7009277,-7614.5048828,5.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(39)
	CreateDynamicObject(855,-2107.7001953,-7614.5048828,5.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(40)
	CreateDynamicObject(1610,-2050.0810547,-7609.0312500,1.7020721,0.0000000,0.0000000,0.0000000); //object(sandcastle1)(1)
	CreateDynamicObject(2782,-2094.1220703,-7639.8862305,21.4331112,0.0000000,0.0000000,338.0000000); //object(cj_oyster_2)(1)
	CreateDynamicObject(711,-2100.1972656,-7637.9248047,22.1707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(20)
	CreateDynamicObject(711,-2111.6184082,-7697.5205078,24.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(22)
	CreateDynamicObject(711,-2092.0126953,-7699.6083984,24.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2118.5449219,-7644.1708984,18.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(24)
	CreateDynamicObject(3461,-2100.0214844,-7726.3544922,32.7479019,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(1)
	CreateDynamicObject(3461,-2093.2968750,-7728.3525391,33.0891571,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(2)
	CreateDynamicObject(3461,-2093.8515625,-7712.7236328,26.6715660,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(3)
	CreateDynamicObject(3461,-2088.6425781,-7714.6591797,26.8161583,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(4)
	CreateDynamicObject(3461,-2090.4062500,-7703.0322266,22.4768982,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(5)
	CreateDynamicObject(3461,-2077.8183594,-7686.2617188,16.6672363,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(6)
	CreateDynamicObject(3461,-2085.7324219,-7704.8720703,22.3755760,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(7)
	CreateDynamicObject(3461,-2082.0751953,-7684.8701172,16.5199318,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(8)
	CreateDynamicObject(3461,-2075.2568359,-7670.1025391,12.9233408,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(9)
	CreateDynamicObject(3461,-2069.6787109,-7671.3496094,13.1957521,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(10)
	CreateDynamicObject(3524,-2072.0839844,-7662.6376953,11.6257477,0.0000000,0.0000000,149.9963379); //object(skullpillar01_lvs)(1)
	CreateDynamicObject(3524,-2066.3886719,-7665.2128906,11.6257477,0.0000000,0.0000000,155.9908447); //object(skullpillar01_lvs)(2)
	CreateDynamicObject(711,-2111.6181641,-7697.5205078,24.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(25)
	CreateDynamicObject(711,-2128.1679688,-7723.9843750,37.8341942,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(33)
	CreateDynamicObject(2906,-2026.5169678,-7636.0288086,0.2279943,70.0000000,0.0000000,106.0000000); //object(kmb_deadarm)(1)
	CreateDynamicObject(855,-2100.1325684,-7616.8037109,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2101.3825684,-7621.2827148,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2099.8388672,-7623.2500000,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2095.7133789,-7624.4619141,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2096.3300781,-7623.6748047,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2098.6442871,-7621.3374023,2.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2101.3242188,-7624.9492188,2.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(855,-2105.1650391,-7621.7016602,3.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateDynamicObject(10409,-2105.5390625,-7727.3583984,27.3339996,0.0000000,0.0000000,251.9989014); //object(hc_golfcrse09_sfs)(55)
	CreateDynamicObject(10409,-2104.5922852,-7725.8886719,19.6664009,0.0000000,0.0000000,251.9989014); //object(hc_golfcrse09_sfs)(57)
	CreateDynamicObject(10409,-2103.3664551,-7732.8613281,18.1664009,0.0000000,0.0000000,251.9989014); //object(hc_golfcrse09_sfs)(58)
	CreateDynamicObject(18228,-2042.4100342,-7764.8798828,0.0000000,0.0000000,0.0000000,36.0000000); //object(cunt_rockgp2_21)(3)
	CreateDynamicObject(18228,-2058.5739746,-7795.7514648,0.0000000,0.0000000,0.0000000,357.9967041); //object(cunt_rockgp2_21)(4)
	CreateDynamicObject(18228,-2127.4396973,-7627.2460938,-4.2500000,0.0000000,0.0000000,233.9949951); //object(cunt_rockgp2_21)(5)
	CreateDynamicObject(18228,-2023.9123535,-7709.1137695,-12.2500000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(6)
	CreateDynamicObject(18228,-2022.9575195,-7686.8691406,-3.8886833,0.0000000,0.0000000,31.9949951); //object(cunt_rockgp2_21)(8)
	CreateDynamicObject(18228,-2128.0820312,-7653.0410156,-4.2500000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(9)
	CreateDynamicObject(18228,-2127.6586914,-7667.8330078,-1.5000000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(10)
	CreateDynamicObject(18228,-2130.2604981,-7694.2666016,-6.0000000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(11)
	CreateDynamicObject(18228,-2130.2597656,-7694.2666016,0.7500000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(12)
	CreateDynamicObject(18228,-2132.8496094,-7702.2597656,0.7500000,0.0000000,0.0000000,229.9877930); //object(cunt_rockgp2_21)(13)
	CreateDynamicObject(18228,-2153.6748047,-7713.7563477,14.2500000,0.0000000,0.0000000,179.9877930); //object(cunt_rockgp2_21)(14)
	CreateDynamicObject(18228,-2159.6213379,-7702.8701172,1.2500000,0.0000000,0.0000000,179.9835205); //object(cunt_rockgp2_21)(15)
	CreateDynamicObject(18228,-2159.6210938,-7702.8701172,1.2500000,0.0000000,0.0000000,179.9835205); //object(cunt_rockgp2_21)(16)
	CreateDynamicObject(18228,-2163.2722168,-7714.1958008,12.0000000,0.0000000,0.0000000,199.9835205); //object(cunt_rockgp2_21)(17)
	CreateDynamicObject(18228,-2166.0439453,-7706.1601562,1.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(18)
	CreateDynamicObject(18228,-2171.8359375,-7719.2661133,11.5000000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(19)
	CreateDynamicObject(18228,-2178.3566894,-7719.0332031,29.7500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(20)
	CreateDynamicObject(18228,-2180.4304199,-7710.4267578,17.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(21)
	CreateDynamicObject(18228,-2183.3876953,-7704.6376953,10.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(22)
	CreateDynamicObject(18228,-2186.9145508,-7697.7353516,2.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(23)
	CreateDynamicObject(18228,-2193.0917969,-7727.7421875,18.5000000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(24)
	CreateDynamicObject(18228,-2201.8417969,-7727.9643555,2.5000000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(25)
	CreateDynamicObject(18228,-2180.6689453,-7725.2216797,37.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(26)
	CreateDynamicObject(18228,-2173.7800293,-7748.9477539,37.5000000,0.0000000,0.0000000,259.9786377); //object(cunt_rockgp2_21)(27)
	CreateDynamicObject(18228,-2190.5173340,-7757.5468750,19.2500000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(28)
	CreateDynamicObject(18228,-2202.4040527,-7762.4746094,1.0000000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(29)
	CreateDynamicObject(18228,-2179.9916992,-7759.4296875,1.0000000,0.0000000,0.0000000,289.9749756); //object(cunt_rockgp2_21)(30)
	CreateDynamicObject(18228,-2177.2666016,-7707.1035156,11.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(31)
	CreateDynamicObject(18228,-2199.9726562,-7712.9916992,14.7500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(33)
	CreateDynamicObject(18228,-2208.2011719,-7701.6806641,7.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(34)
	CreateDynamicObject(18228,-2209.3935547,-7742.4218750,5.5000000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2160.8081055,-7714.9501953,14.2500000,0.0000000,0.0000000,177.9835205); //object(cunt_rockgp2_21)(36)
	CreateDynamicObject(18228,-2062.8613281,-7794.7851562,10.2500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(37)
	CreateDynamicObject(18228,-2089.4753418,-7797.6562500,4.7500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(38)
	CreateDynamicObject(18228,-2088.3398438,-7787.8359375,18.7500000,0.0000000,0.0000000,309.9902344); //object(cunt_rockgp2_21)(39)
	CreateDynamicObject(18228,-2108.8525391,-7757.3886719,30.5000000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(40)
	CreateDynamicObject(18228,-2130.2346191,-7777.9223633,24.5000000,0.0000000,0.0000000,289.9887695); //object(cunt_rockgp2_21)(42)
	CreateDynamicObject(18228,-2137.9902344,-7795.2519531,5.2500000,0.0000000,0.0000000,289.9841309); //object(cunt_rockgp2_21)(43)
	CreateDynamicObject(18228,-2153.7329102,-7772.8896484,5.2500000,0.0000000,0.0000000,293.9841309); //object(cunt_rockgp2_21)(44)
	CreateDynamicObject(18228,-2168.7634277,-7785.0517578,5.2500000,0.0000000,0.0000000,307.9831543); //object(cunt_rockgp2_21)(45)
	CreateDynamicObject(18228,-2058.4509277,-7805.5732422,-1.7500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(46)
	CreateDynamicObject(18228,-2162.1645508,-7766.6196289,20.0000000,0.0000000,0.0000000,305.9749756); //object(cunt_rockgp2_21)(47)
	CreateDynamicObject(18228,-2165.1953125,-7760.4140625,28.7500000,0.0000000,0.0000000,319.9713135); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(18228,-2170.5039062,-7753.7050781,36.2500000,0.0000000,0.0000000,319.9713135); //object(cunt_rockgp2_21)(49)
	CreateDynamicObject(18228,-2164.3654785,-7750.5161133,36.2500000,0.0000000,0.0000000,329.9713135); //object(cunt_rockgp2_21)(50)
	CreateDynamicObject(18228,-2175.9804688,-7763.4282227,28.0000000,0.0000000,0.0000000,305.9688721); //object(cunt_rockgp2_21)(51)
	CreateDynamicObject(18228,-2194.3469238,-7773.4877930,13.0000000,0.0000000,0.0000000,305.9637451); //object(cunt_rockgp2_21)(52)
	CreateDynamicObject(18228,-2204.5319824,-7782.0224609,3.7500000,0.0000000,0.0000000,293.9637451); //object(cunt_rockgp2_21)(53)
	CreateDynamicObject(18228,-2023.9121094,-7709.1132812,-12.2500000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(54)
	CreateDynamicObject(18228,-2032.9013672,-7729.9648438,0.0000000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(55)
	CreateDynamicObject(18228,-2014.3466797,-7657.4814453,-9.6386833,0.0000000,0.0000000,83.9849854); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(8483,-2141.6123047,-7748.5195312,38.9770126,0.0000000,0.0000000,73.9819336); //object(pirateland02_lvs)(3)
	CreateDynamicObject(18228,-2117.0849609,-7765.7192383,30.5000000,0.0000000,0.0000000,279.9887695); //object(cunt_rockgp2_21)(58)
	CreateDynamicObject(18228,-2131.9912109,-7768.1845703,35.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(59)
	CreateDynamicObject(18228,-2128.1982422,-7782.6699219,19.7500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(60)
	CreateDynamicObject(18228,-2112.2287598,-7612.6230469,-9.5000000,0.0000000,0.0000000,117.9923096); //object(cunt_rockgp2_21)(61)
	CreateDynamicObject(18228,-2121.4511719,-7608.6787109,-9.5000000,0.0000000,0.0000000,127.9852295); //object(cunt_rockgp2_21)(62)
	CreateDynamicObject(3434,-2140.0322266,-7741.9482422,44.8849983,0.0000000,0.0000000,161.9869385); //object(skllsgn01_lvs)(2)
	CreateDynamicObject(1431,-2049.5732422,-7615.0019531,2.7391636,0.0000000,0.0000000,0.0000000); //object(dyn_box_pile)(1)
	CreateDynamicObject(935,-2066.3583984,-7620.1826172,2.5155544,0.0000000,0.0000000,0.0000000); //object(cj_drum)(1)
	CreateDynamicObject(3243,-2105.4169922,-7647.0283203,17.8596230,0.0000000,0.0000000,221.9897461); //object(tepee_room_)(1)
	CreateDynamicObject(3243,-2086.4267578,-7651.6474609,17.3596230,0.0000000,0.0000000,107.9901123); //object(tepee_room_)(2)
	CreateDynamicObject(11427,-2066.4296875,-7724.3447266,23.6646576,0.0000000,0.0000000,273.9935303); //object(des_adobech)(1)
	CreateDynamicObject(5777,-2099.5976562,-7639.8193359,17.9263420,0.0000000,0.0000000,255.9979248); //object(tombston01_lawn)(1)
	CreateDynamicObject(2895,-2099.8232422,-7640.5947266,17.6321888,0.0000000,0.0000000,0.0000000); //object(fun_flower_law)(1)
	CreateDynamicObject(16689,-2071.9433594,-7762.6484375,36.0832710,0.0000000,0.0000000,11.9915771); //object(des_westrn7_02)(1)
	CreateDynamicObject(3461,-2094.7138672,-7740.5292969,34.8603020,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(6)
	CreateDynamicObject(3461,-2104.8818359,-7735.2851562,34.3212128,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(6)
	CreateDynamicObject(18228,-2109.4785156,-7765.7011719,30.5000000,0.0000000,0.0000000,271.9830322); //object(cunt_rockgp2_21)(63)
	CreateDynamicObject(16285,-2063.8000488,-7777.7001953,33.0999985,0.0000000,0.0000000,0.0000000); //object(des_westrn7_03)(1)
	CreateDynamicObject(2780,-2144.3366699,-7742.7075195,34.2502327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(11)
	CreateDynamicObject(2780,-2130.4155273,-7744.8330078,34.2502327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(12)
	CreateDynamicObject(2780,-2138.8811035,-7743.7475586,33.5002327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(14)
	CreateDynamicObject(2780,-2140.3300781,-7746.9326172,47.7502327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(15)
	CreateDynamicObject(3524,-2139.0537109,-7742.7500000,32.9286575,0.0000000,0.0000000,169.9969482); //object(skullpillar01_lvs)(3)
	CreateDynamicObject(3528,-2137.8278809,-7744.9760742,41.9174042,0.0000000,344.9926758,53.9979248); //object(vgsedragon)(1)
	CreateDynamicObject(3528,-2140.7412109,-7744.3662109,41.6674042,0.0000000,344.9871826,75.9979248); //object(vgsedragon)(2)
	CreateDynamicObject(14608,-2121.3964844,-7718.5488281,23.3348312,0.0000000,0.0000000,289.9946289); //object(triad_buddha01)(2)
	CreateDynamicObject(1313,-2077.8613281,-7753.5585938,35.8942223,0.0000000,0.0000000,0.0000000); //object(killfrenzy2plyr)(1)
	CreateDynamicObject(2045,-2137.1433106,-7734.1743164,33.1017571,0.0000000,0.0000000,0.0000000); //object(cj_bbat_nails)(1)
	CreateDynamicObject(3364,-2038.8000488,-7662.3999023,13.5000000,4.0000000,0.0000000,215.9966888); //object(des_ruin3_)(1)
	CreateDynamicObject(16502,-2015.9443359,-7661.8613281,11.3339825,0.0000000,0.0000000,23.9996338); //object(cn2_jetty1)(1)
	CreateDynamicObject(749,-2007.6063232,-7667.9345703,-3.0883808,0.0000000,0.0000000,0.0000000); //object(sm_scrb_column3)(2)
	CreateDynamicObject(749,-2010.8538818,-7667.8457031,-3.3383808,0.0000000,0.0000000,0.0000000); //object(sm_scrb_column3)(3)
	CreateDynamicObject(758,-2118.4687500,-7731.0546875,31.7370377,0.0000000,0.0000000,0.0000000); //object(sm_scrub_rock6)(1)
	CreateDynamicObject(711,-2121.7187500,-7736.2451172,39.1824265,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2157.2338867,-7710.0473633,57.1569099,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2154.9204102,-7721.2636719,57.2040138,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2159.9663086,-7743.5605469,58.3275375,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2169.9487305,-7723.7724609,58.1584206,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2151.0046387,-7736.6367188,57.7669105,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2146.4006348,-7740.4228516,49.3488884,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2091.7871094,-7738.0761719,39.3907394,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2070.8583984,-7772.6669922,38.8634186,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2068.6015625,-7746.2695312,38.7343826,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateDynamicObject(711,-2122.6694336,-7681.6025391,23.9806976,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(711,-2026.0341797,-7655.1279297,17.9575558,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(711,-2052.1289062,-7662.2695312,19.2276668,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(711,-2047.2607422,-7722.5214844,21.5943260,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(711,-2031.1933594,-7686.1445312,19.0006161,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(711,-2044.9404297,-7680.7587891,19.8836155,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateDynamicObject(803,-2086.7763672,-7660.2421875,18.9036121,0.0000000,0.0000000,0.0000000); //object(genveg_bush09)(1)
	CreateDynamicObject(808,-2076.2570801,-7643.5795898,4.4592061,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(1)
	CreateDynamicObject(808,-2047.8635254,-7722.4370117,16.9404411,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(2)
	CreateDynamicObject(808,-2038.7812500,-7626.1943359,3.5464511,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(3)
	CreateDynamicObject(808,-2027.2099609,-7654.2275391,14.0442267,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(4)
	CreateDynamicObject(808,-2135.1777344,-7721.7783203,35.1689987,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(5)
	CreateDynamicObject(808,-2089.7783203,-7762.7607422,34.8629494,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(6)
	CreateDynamicObject(648,-2207.2680664,-7694.1987305,14.4877014,0.0000000,41.0000000,128.0000000); //object(veg_palm01)(1)
	CreateDynamicObject(710,-2031.8701172,-7644.2636719,16.7120590,0.0000000,0.0000000,0.0000000); //object(vgs_palm01)(1)
	CreateDynamicObject(18228,-2180.6220703,-7742.3662109,37.5000000,0.0000000,0.0000000,243.9733887); //object(cunt_rockgp2_21)(64)
	CreateDynamicObject(3461,-2124.3251953,-7716.4150391,23.1778927,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(3)
	CreateDynamicObject(3461,-2117.5273438,-7719.1191406,22.9630699,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(3)
	CreateDynamicObject(2631,-2120.3076172,-7716.6376953,21.6839886,0.0000000,0.0000000,335.9948731); //object(gym_mat1)(1)
	CreateDynamicObject(2869,-2120.2656250,-7717.0263672,21.7376594,0.0000000,0.0000000,301.9976807); //object(gb_ornament04)(1)
	CreateDynamicObject(14705,-2121.6999512,-7716.7998047,21.8999996,0.0000000,0.0000000,0.0000000); //object(int2vase)(1)
	CreateDynamicObject(2096,-2080.0976562,-7753.0214844,33.2954788,0.0000000,0.0000000,129.9957275); //object(cj_rockingchair)(1)
	CreateDynamicObject(838,-2048.9785156,-7743.1435547,18.5378342,0.0000000,0.0000000,0.0000000); //object(dead_tree_9)(1)
	CreateDynamicObject(18228,-2213.1970215,-7693.6918945,1.2500000,0.0000000,0.0000000,181.9786377); //object(cunt_rockgp2_21)(66)
	CreateDynamicObject(710,-2090.9824219,-7777.9228516,47.7165565,0.0000000,0.0000000,0.0000000); //object(vgs_palm01)(2)
	CreateDynamicObject(710,-2170.9919434,-7719.1513672,64.0459747,0.0000000,0.0000000,0.0000000); //object(vgs_palm01)(3)
	CreateDynamicObject(9831,-2122.8876953,-7721.5693359,23.3250923,0.0000000,0.0000000,331.9958496); //object(sfw_waterfall)(1)
	CreateDynamicObject(9831,-2120.6591797,-7721.3916016,23.3250923,0.0000000,0.0000000,331.9903564); //object(sfw_waterfall)(15)
	CreateDynamicObject(9831,-2123.5058594,-7719.7451172,22.8250923,0.0000000,0.0000000,31.9921875); //object(sfw_waterfall)(16)
	CreateDynamicObject(1517,-2079.7561035,-7753.2255859,32.7452316,0.0000000,0.0000000,0.0000000); //object(dyn_wine_break)(1)
	CreateDynamicObject(1520,-2066.3242188,-7620.0664062,3.0794585,0.0000000,0.0000000,0.0000000); //object(dyn_wine_bounce)(1)
	CreateDynamicObject(1667,-2066.4746094,-7620.1630859,3.1535432,0.0000000,0.0000000,0.0000000); //object(propwineglass1)(1)
	CreateDynamicObject(1736,-2079.1230469,-7753.8271484,34.8935966,0.0000000,0.0000000,208.0000000); //object(cj_stags_head)(1)
	CreateDynamicObject(1828,-2054.8654785,-7617.0483398,1.6118135,0.0000000,0.0000000,0.0000000); //object(man_sdr_rug)(1)
	CreateDynamicObject(18228,-2046.0732422,-7789.4160156,-5.0000000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(37)
	CreateDynamicObject(18228,-2025.4140625,-7771.0830078,-15.2500000,0.0000000,0.0000000,27.9931641); //object(cunt_rockgp2_21)(37)
	CreateDynamicObject(18228,-2217.6384277,-7732.8471680,-7.5000000,0.0000000,0.0000000,271.9749756); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2218.6240234,-7766.5830078,-7.5000000,0.0000000,0.0000000,285.9720459); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2216.1665039,-7776.4511719,-7.5000000,0.0000000,0.0000000,319.9686279); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2208.5344238,-7779.4404297,-7.5000000,0.0000000,0.0000000,7.9658203); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2188.6933594,-7787.8525391,-7.5000000,0.0000000,0.0000000,27.9650879); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2111.1958008,-7761.4521484,30.5000000,0.0000000,0.0000000,25.9902344); //object(cunt_rockgp2_21)(40)
	CreateDynamicObject(18228,-2110.3432617,-7770.3813477,30.5000000,0.0000000,0.0000000,269.9830322); //object(cunt_rockgp2_21)(63)
	CreateDynamicObject(18228,-2081.4482422,-7789.5756836,18.7500000,0.0000000,0.0000000,297.9902344); //object(cunt_rockgp2_21)(39)
	CreateDynamicObject(18228,-2187.1354981,-7745.0781250,28.5000000,0.0000000,0.0000000,243.9733887); //object(cunt_rockgp2_21)(64)
	CreateDynamicObject(18228,-2197.6411133,-7744.9267578,14.7500000,0.0000000,0.0000000,243.9733887); //object(cunt_rockgp2_21)(64)
	CreateDynamicObject(18228,-2211.1794434,-7693.7905273,-2.2500000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(34)
	CreateDynamicObject(18228,-2187.5478516,-7718.1748047,25.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(26)
	CreateDynamicObject(18228,-2215.0410156,-7750.0004883,1.7500000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(18228,-2231.0366211,-7754.5312500,-12.0000000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(35)
	CreateDynamicObject(3872,-2171.2597656,-7726.1523438,94.3365097,0.0000000,0.0000000,299.9981689); //object(ws_floodbeams)(1)
	CreateDynamicObject(18228,-2166.8906250,-7702.4448242,1.7500000,0.0000000,0.0000000,221.9731445); //object(cunt_rockgp2_21)(31)
	CreateDynamicObject(18228,-2158.6037598,-7707.2460938,1.7500000,0.0000000,0.0000000,207.9677734); //object(cunt_rockgp2_21)(31)
	CreateDynamicObject(900,-2157.5981445,-7665.7988281,-6.0000000,0.0000000,0.0000000,0.0000000); //object(searock04)(1)
	CreateDynamicObject(900,-2151.0996094,-7648.9746094,-6.0000000,0.0000000,0.0000000,0.0000000); //object(searock04)(2)
	CreateDynamicObject(900,-2135.6938477,-7661.1860352,-6.0000000,0.0000000,0.0000000,344.0000000); //object(searock04)(3)
	CreateDynamicObject(900,-2140.1960449,-7671.9873047,-5.2500000,0.0000000,0.0000000,351.9984131); //object(searock04)(4)
	CreateDynamicObject(900,-2139.6005859,-7659.2587891,-5.0000000,0.0000000,0.0000000,0.0000000); //object(searock04)(9)
	CreateDynamicObject(18228,-2138.7749023,-7648.4213867,-9.5000000,0.0000000,0.0000000,231.9625244); //object(cunt_rockgp2_21)(18)
	CreateDynamicObject(18228,-2125.2451172,-7794.0112305,6.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(60)
	CreateDynamicObject(18228,-2181.0603027,-7732.5898438,36.0000000,0.0000000,0.0000000,213.9733887); //object(cunt_rockgp2_21)(64)
	CreateDynamicObject(18228,-2164.6660156,-7753.1206055,41.5000000,0.0000000,0.0000000,335.9713135); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(18228,-2170.4782715,-7762.6337891,29.5000000,0.0000000,0.0000000,335.9674072); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(18228,-2182.9541016,-7750.8593750,23.5000000,0.0000000,0.0000000,327.9638672); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(18228,-2173.0117188,-7769.7988281,18.7500000,0.0000000,0.0000000,335.9619141); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(18228,-2011.4984131,-7662.1625977,-9.6386833,0.0000000,0.0000000,83.9904785); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(622,-2156.6665039,-7797.4887695,13.5943832,0.0000000,0.0000000,248.0000000); //object(veg_palm03)(1)
	CreateDynamicObject(18228,-2081.4609375,-7807.1586914,0.2500000,0.0000000,0.0000000,309.9902344); //object(cunt_rockgp2_21)(39)
	CreateDynamicObject(18228,-2133.1745606,-7812.2416992,-13.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(60)
	CreateDynamicObject(18228,-2091.6181641,-7817.5532227,-13.2500000,0.0000000,0.0000000,331.9865723); //object(cunt_rockgp2_21)(60)
	CreateDynamicObject(18228,-2047.7703857,-7805.0346680,-13.2500000,0.0000000,0.0000000,5.9848633); //object(cunt_rockgp2_21)(60)
	CreateDynamicObject(18228,-2012.6967773,-7728.9047852,-16.2500000,0.0000000,0.0000000,61.9820557); //object(cunt_rockgp2_21)(60)
	CreateDynamicObject(1458,-2048.9843750,-7626.1025391,2.4700000,0.0000000,0.0000000,341.9989014); //object(dyn_cart)(1)
	CreateDynamicObject(16406,-2200.0524902,-7794.8593750,16.2338486,0.0000000,0.0000000,40.0000000); //object(desn2_weemineb)(1)
	CreateDynamicObject(18228,-2192.6025391,-7757.6489258,8.2500000,0.0000000,0.0000000,327.9638672); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(18228,-2173.4072266,-7771.4291992,16.5000000,0.0000000,0.0000000,335.9619141); //object(cunt_rockgp2_21)(48)
	CreateDynamicObject(16404,-2112.3005371,-7677.0405273,20.0237770,0.0000000,0.0000000,0.0000000); //object(desn2_hutskel2)(1)
	CreateDynamicObject(1451,-2060.2587891,-7766.2021484,33.6803551,0.0000000,0.0000000,0.0000000); //object(dyn_coup)(1)
	CreateDynamicObject(1454,-2086.5524902,-7770.0668945,33.5004845,0.0000000,0.0000000,0.0000000); //object(dyn_h_bale2)(1)
	CreateDynamicObject(6865,-2145.0986328,-7725.3212891,42.4707451,0.0000000,0.0000000,127.9962158); //object(steerskull)(1)
	CreateDynamicObject(1486,-2098.7487793,-7571.0405273,10.2123203,0.0000000,0.0000000,0.0000000); //object(dyn_beer_1)(1)
	CreateDynamicObject(1433,-2100.4768066,-7568.8222656,9.1228495,0.0000000,0.0000000,0.0000000); //object(dyn_table_1)(1)
	CreateDynamicObject(1609,-2013.2897949,-7648.1699219,0.0000000,0.0000000,0.0000000,0.0000000); //object(turtle)(1)
	CreateDynamicObject(18228,-2024.5277100,-7634.9394531,-15.6386833,0.0000000,0.0000000,77.9849854); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(18228,-2032.5144043,-7611.6518555,-18.1386833,0.0000000,0.0000000,77.9809570); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(18228,-2029.3835449,-7622.0610352,-15.6386833,0.0000000,0.0000000,77.9809570); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(18228,-2037.0043945,-7603.0527344,-18.6386833,0.0000000,0.0000000,85.9809570); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(18228,-2039.1359863,-7602.0156250,-18.6386833,0.0000000,0.0000000,93.9790039); //object(cunt_rockgp2_21)(56)
	CreateDynamicObject(18228,-2126.3449707,-7657.7314453,-4.2500000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(9)
	CreateDynamicObject(18228,-2132.9533691,-7706.5097656,4.2500000,0.0000000,0.0000000,229.9877930); //object(cunt_rockgp2_21)(13)
	CreateDynamicObject(18228,-2132.9533691,-7716.7661133,6.2500000,0.0000000,0.0000000,229.9877930); //object(cunt_rockgp2_21)(13)
	CreateDynamicObject(18228,-2061.3874512,-7791.8793945,14.7500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(37)
	CreateDynamicObject(18228,-2070.9362793,-7791.3408203,17.5000000,0.0000000,0.0000000,313.9963379); //object(cunt_rockgp2_21)(37)
	CreateDynamicObject(18228,-2129.0754395,-7767.1704102,35.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(59)
	CreateDynamicObject(2991,-1706.5000000,29.2000008,3.2000000,0.0000000,0.0000000,0.0000000); //object(imy_bbox)(1)
	CreateDynamicObject(2991,-1689.1999512,12.1999998,3.2000000,0.0000000,0.0000000,46.0000000); //object(imy_bbox)(2)
	CreateDynamicObject(2991,-1691.9000244,9.3999996,3.2000000,0.0000000,0.0000000,46.0000000); //object(imy_bbox)(3)
	CreateDynamicObject(3761,-1695.5000000,5.5000000,4.5999999,0.0000000,0.0000000,316.0000000); //object(industshelves)(1)
	CreateDynamicObject(3761,-1700.6999512,0.4000000,4.5999999,0.0000000,0.0000000,315.9997559); //object(industshelves)(2)
	CreateDynamicObject(3761,-1723.0999756,14.8999996,4.5999999,0.0000000,0.0000000,315.9997559); //object(industshelves)(3)
	CreateDynamicObject(2975,-1706.5999756,-3.2000000,2.5000000,0.0000000,0.0000000,0.0000000); //object(k_cargo3)(1)
	CreateDynamicObject(2973,-1710.0999756,26.2999992,2.5999999,0.0000000,0.0000000,0.0000000); //object(k_cargo2)(1)
	CreateDynamicObject(9958,-1632.0999756,109.1999969,-1.8000000,0.0000000,0.0000000,134.0000000); //object(submarr_sfe)(1)
	CreateDynamicObject(3077,-1571.5000000,134.1000061,2.5999999,0.0000000,0.0000000,344.0000000); //object(nf_blackboard)(1)
	CreateDynamicObject(10230,-3157.5000000,358.5000000,1.0000000,340.0000000,340.0000000,90.0000000); //object(freighter_sfe)(1)

	//bank
	CreateDynamicObject(14847,322.2700000,119.8400000,1005.6100000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(16760,333.4400000,123.5000000,1011.2900000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(14852,322.3900000,108.7500000,1007.6900000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(1569,320.9400000,108.9400000,1002.2200000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1569,323.9400000,108.9400000,1002.2200000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(2614,322.6400000,120.3000000,1008.3700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(14779,331.5400000,121.3200000,1004.5800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(14779,325.4800000,120.1600000,1008.6900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(18553,315.6900000,128.0300000,1003.4700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3109,329.3500000,126.5800000,1003.4200000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1493,312.8500000,121.2600000,1002.2100000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1493,309.1300000,121.2500000,1002.2200000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1493,302.6400000,117.9000000,1002.2200000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(14848,320.6800000,122.2400000,1003.6100000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(3033,304.5500000,118.7000000,999.5100000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(3033,298.9500000,118.7000000,999.5100000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3033,298.9500000,118.7000000,1001.9800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3033,304.5500000,118.7000000,1001.9800000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(3033,298.9500000,126.7500000,1001.9800000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(3033,304.5500000,126.7500000,1001.9800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3033,298.9500000,126.7500000,999.5100000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(3033,304.5500000,126.7500000,999.5100000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(3033,296.1600000,119.3200000,999.5100000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(3033,296.1600000,119.3200000,1001.9800000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(3033,296.1600000,124.0000000,1002.7600000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(3033,303.4400000,121.5100000,999.5100000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(3033,303.4400000,127.1100000,999.5100000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(3033,303.4400000,121.5100000,1001.9800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(3033,303.4400000,127.1100000,1001.9800000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(3033,296.1200000,126.9400000,998.9900000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(18553,296.1200000,125.4400000,999.1300000,89.5000000,0.0000000,180.0000000); //
	CreateDynamicObject(1806,314.6600000,114.4200000,1002.2100000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1722,316.0700000,112.8100000,1002.2100000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(1722,316.0100000,112.0500000,1002.2100000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(1722,316.0000000,111.3100000,1002.2100000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(1722,315.9800000,110.5600000,1002.2100000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(1722,328.9100000,117.6300000,1002.2000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1722,328.8900000,116.9100000,1002.2000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1722,328.9000000,116.2500000,1002.2000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1722,328.8900000,115.5600000,1002.2000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1722,328.8900000,114.8400000,1002.2000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2724,327.9100000,122.8000000,1002.7400000,0.0000000,0.0000000,-31.8000000); //
	CreateDynamicObject(2724,322.5700000,122.9800000,1002.7400000,0.0000000,0.0000000,14.8800000); //
	CreateDynamicObject(2724,318.6300000,122.9900000,1002.7400000,0.0000000,0.0000000,38.8800000); //
	CreateDynamicObject(2773,324.6400000,119.4900000,1002.7400000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2773,320.3500000,119.4400000,1002.7400000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2773,323.6500000,118.5400000,1002.7300000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2773,321.2900000,118.5000000,1002.7300000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19325,319.0900000,121.5200000,1005.6700000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19325,325.7300000,121.5200000,1005.6700000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(19325,315.4300000,112.9300000,1005.6700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19325,329.4100000,117.7300000,1005.6700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(2269,328.5000000,116.4700000,1004.3100000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2270,316.3600000,111.5500000,1004.3800000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(2266,304.3800000,121.9700000,1003.7900000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(1493,303.9800000,119.0700000,1002.2200000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(17564,304.0500000,119.6200000,1003.2400000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2924,294.5300000,118.4900000,999.2200000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1535,329.3900000,110.3300000,1002.2000000,0.0000000,0.0000000,90.0000000); //
	CreateDynamicObject(18756,331.3800000,128.3200000,1003.8100000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(18758,310.5000000,116.0200000,1003.5100000,180.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(1493,314.2500000,118.1300000,1002.2100000,0.0000000,0.0000000,180.0000000); //
	CreateDynamicObject(18758,290.9400000,116.4200000,998.8100000,180.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(957,321.9100000,113.8100000,1010.5400000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(957,321.9100000,115.8500000,1010.5400000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(957,321.9400000,111.6400000,1010.5400000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(957,321.9300000,118.2400000,1010.5400000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(957,310.8900000,119.6200000,1006.1700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(957,305.5200000,119.6600000,1006.1700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(957,305.5500000,127.5900000,1006.1700000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19302,295.0500000,121.7500000,999.2700000,0.0000000,0.0000000,201.7200000); //
	CreateDynamicObject(2004,303.4000000,122.4400000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,123.3400000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,124.2400000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,125.1600000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,126.0600000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,126.0600000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,125.1600000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,124.2400000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,123.3400000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,122.4400000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,121.5500000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,121.5500000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,120.6700000,999.7500000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(2004,303.4000000,120.6700000,998.4900000,0.0000000,0.0000000,-90.0000000); //
	CreateDynamicObject(1826,299.9600000,126.1300000,998.0200000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(1826,299.9600000,119.2600000,998.0200000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19451,303.7800000,122.3100000,1004.4800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19455,303.7800000,122.3100000,1000.9800000,0.0000000,0.0000000,0.0000000); //
	CreateDynamicObject(19369,329.4300000,110.9900000,1003.8500000,0.0000000,180.0000000,0.0000000); //


	//scientist map
	AddStaticVehicleEx(548,-2085.7741699,3567.1083984,19.6669006,0.0000000,-1,-1,30); //Cargobob
	AddStaticVehicleEx(470,-2135.0388184,3612.5671387,7.1589999,278.0000000,-1,-1,30); //Patriot
	AddStaticVehicleEx(595,-2088.3720703,3694.6335449,0.3500000,280.0000000,84,123,30); //Launch
	CreateDynamicObject(18751,-1849.7011719,3254.7988281,0.5250000,0.0000000,0.0000000,0.0000000); //object(islandbase1)(1)
	CreateDynamicObject(18751,-1826.1910400,3277.4138184,1.2000000,0.0000000,0.0000000,20.0000000); //object(islandbase1)(2)
	CreateDynamicObject(18751,-1885.1180420,3291.3110352,1.1849999,0.0000000,0.0000000,339.9951172); //object(islandbase1)(3)
	CreateDynamicObject(18751,-1829.5966797,3324.2744141,1.0940000,0.0000000,0.0000000,319.9932861); //object(islandbase1)(4)
	CreateDynamicObject(17071,-1871.1386719,3246.3808594,4.1504002,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_25)(1)
	CreateDynamicObject(17076,-1855.3144531,3254.4326172,-5.1166000,0.0000000,0.0000000,119.9981384); //object(cunt_rockgp2_26)(1)
	CreateDynamicObject(18227,-1963.4207764,3196.3903809,-9.9815998,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_20)(1)
	CreateDynamicObject(18751,-1873.9849854,3363.3669434,0.2750000,0.0000000,0.0000000,319.9932861); //object(islandbase1)(9)
	CreateDynamicObject(18751,-1889.1250000,3324.0180664,0.4390000,0.0000000,0.0000000,357.3547363); //object(islandbase1)(11)
	CreateDynamicObject(17030,-1918.2021484,3305.2998047,-8.8023005,0.0000000,0.0000000,140.0000000); //object(cunt_rockgp2_11)(1)
	CreateDynamicObject(18751,-1855.2819824,3390.6101074,0.0290000,0.0000000,0.0000000,356.5646362); //object(islandbase1)(14)
	CreateDynamicObject(18751,-1897.5720215,3380.2419434,0.0290000,0.0000000,0.0000000,305.3609619); //object(islandbase1)(15)
	CreateDynamicObject(18751,-1907.1960449,3352.6101074,0.0290000,0.0000000,0.0000000,272.9431152); //object(islandbase1)(16)
	CreateDynamicObject(18751,-1836.7919922,3359.3059082,-0.7900000,0.0000000,0.0000000,25.8184204); //object(islandbase1)(18)
	CreateDynamicObject(904,-1859.7700195,3238.0136719,5.3978000,0.0000000,0.0000000,0.0000000); //object(sand_josh1)(1)
	CreateDynamicObject(904,-1874.7593994,3224.3471680,3.3728001,0.0000000,0.0000000,80.0000000); //object(sand_josh1)(2)
	CreateDynamicObject(904,-1833.4138184,3230.2385254,4.3228002,0.0000000,0.0000000,171.4969482); //object(sand_josh1)(3)
	CreateDynamicObject(904,-1820.8536377,3271.3249512,7.3978000,0.0000000,0.0000000,171.4965820); //object(sand_josh1)(4)
	CreateDynamicObject(858,-1826.8010254,3225.9548340,3.8984001,0.0000000,0.0000000,40.0000000); //object(sand_josh2)(1)
	CreateDynamicObject(711,-1855.1822510,3224.2219238,7.6050000,0.0000000,0.0000000,100.0000000); //object(vgs_palm02)(1)
	CreateDynamicObject(681,-1917.6600342,3270.7004395,4.4208999,0.0000000,0.0000000,0.0000000); //object(sm_des_josh_sm2)(1)
	CreateDynamicObject(652,-1819.0770264,3248.2578125,2.9881001,0.0000000,0.0000000,30.0000000); //object(sjmpalmbig)(2)
	CreateDynamicObject(645,-1925.1424561,3297.2167969,1.6190000,0.0000000,0.0000000,40.0000000); //object(veg_palmbig14)(1)
	CreateDynamicObject(645,-1863.1396484,3231.9099121,3.0604999,0.0000000,0.0000000,70.0000000); //object(veg_palmbig14)(2)
	CreateDynamicObject(641,-1844.9632568,3230.0458984,1.6671000,0.0000000,0.0000000,30.0000000); //object(veg_palmkb13)(1)
	CreateDynamicObject(652,-1804.6939697,3318.2509766,5.0349998,0.0000000,0.0000000,353.4265137); //object(sjmpalmbig)(3)
	CreateDynamicObject(641,-1843.3963623,3253.4174805,3.1738000,0.0000000,0.0000000,20.0000000); //object(veg_palmkb13)(2)
	CreateDynamicObject(634,-1868.5003662,3250.1093750,4.1967001,0.0000000,0.0000000,30.0000000); //object(veg_palmkbb11)(1)
	CreateDynamicObject(624,-1790.2714844,3259.3994141,2.5236001,0.0000000,0.0000000,0.0000000); //object(veg_palwee02)(1)
	CreateDynamicObject(624,-1801.2923584,3258.7731934,-5.0064001,0.0000000,0.0000000,90.0000000); //object(veg_palwee02)(2)
	CreateDynamicObject(801,-1845.7164307,3238.2897949,5.4291000,0.0000000,0.0000000,0.0000000); //object(genveg_bush01)(1)
	CreateDynamicObject(801,-1850.0583496,3240.6062012,5.4291000,0.0000000,0.0000000,0.0000000); //object(genveg_bush01)(2)
	CreateDynamicObject(18751,-1810.7099609,3408.7319336,0.0290000,0.0000000,0.0000000,246.8450928); //object(islandbase1)(20)
	CreateDynamicObject(801,-1852.7998047,3300.8349609,3.6545999,0.0000000,0.0000000,80.0000000); //object(genveg_bush01)(3)
	CreateDynamicObject(801,-1848.7446289,3251.2744141,5.4291000,0.0000000,0.0000000,87.9969482); //object(genveg_bush01)(4)
	CreateDynamicObject(18751,-1850.8780518,3407.4680176,0.3990000,0.0000000,0.0000000,202.9550781); //object(islandbase1)(21)
	CreateDynamicObject(801,-1827.4454346,3238.1113281,3.7040999,0.0000000,0.0000000,357.9949951); //object(genveg_bush01)(5)
	CreateDynamicObject(801,-1828.0930176,3237.4260254,3.7040999,0.0000000,0.0000000,297.9895020); //object(genveg_bush01)(6)
	CreateDynamicObject(801,-1830.7800293,3226.9091797,2.7291000,0.0000000,0.0000000,297.9876709); //object(genveg_bush01)(7)
	CreateDynamicObject(801,-1890.5804443,3286.2192383,6.7820001,0.0000000,0.0000000,37.9876709); //object(genveg_bush01)(8)
	CreateDynamicObject(806,-1871.8226318,3242.6650391,6.5261002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass)(1)
	CreateDynamicObject(806,-1877.3082275,3239.5288086,5.4761000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass)(2)
	CreateDynamicObject(806,-1872.1419678,3235.3237305,5.4761000,0.0000000,0.0000000,290.0000000); //object(genveg_tallgrass)(3)
	CreateDynamicObject(18751,-1813.2679443,3362.5700684,-0.7900000,0.0000000,0.0000000,3.8749695); //object(islandbase1)(22)
	CreateDynamicObject(808,-1851.0836182,3304.5317383,4.7400999,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(1)
	CreateDynamicObject(808,-1855.4160156,3224.7451172,3.6809001,0.0000000,0.0000000,280.0000000); //object(genveg_bush12)(2)
	CreateDynamicObject(808,-1856.3956299,3224.9472656,3.6809001,0.0000000,0.0000000,298.7475586); //object(genveg_bush12)(3)
	CreateDynamicObject(808,-1845.9783936,3228.6484375,5.1058998,0.0000000,0.0000000,298.7457275); //object(genveg_bush12)(4)
	CreateDynamicObject(808,-1865.3725586,3239.4240723,4.8558998,0.0000000,0.0000000,298.7457275); //object(genveg_bush12)(5)
	CreateDynamicObject(808,-1872.3696289,3225.7504883,4.5058999,0.0000000,0.0000000,78.7457275); //object(genveg_bush12)(6)
	CreateDynamicObject(809,-1869.9366455,3222.9428711,2.3501999,0.0000000,0.0000000,0.0000000); //object(genveg_bush13)(1)
	CreateDynamicObject(809,-1870.1241455,3224.2138672,2.3501999,0.0000000,0.0000000,290.0000000); //object(genveg_bush13)(2)
	CreateDynamicObject(809,-1871.9479980,3234.7180176,2.6501999,0.0000000,0.0000000,289.9951172); //object(genveg_bush13)(3)
	CreateDynamicObject(809,-1876.4320068,3276.7238770,5.3080001,0.0000000,0.0000000,0.0000000); //object(genveg_bush13)(4)
	CreateDynamicObject(809,-1818.5999756,3215.6030273,1.8096000,0.0000000,0.0000000,290.0000000); //object(genveg_bush13)(5)
	CreateDynamicObject(818,-1914.4295654,3298.7639160,6.2061000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass02)(1)
	CreateDynamicObject(18228,-1851.1291504,3290.9965820,-3.5420001,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_21)(1)
	CreateDynamicObject(18228,-1892.1701660,3410.2382812,-3.2500000,0.0000000,0.0000000,340.0000000); //object(cunt_rockgp2_21)(2)
	CreateDynamicObject(17031,-1898.5166016,3339.4248047,-1.0717000,0.0000000,0.0000000,270.0000000); //object(cunt_rockgp2_13)(1)
	CreateDynamicObject(17031,-1822.0760498,3315.9768066,-0.7784000,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_13)(2)
	CreateDynamicObject(17030,-1849.9110107,3400.8500977,3.4590001,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_11)(3)
	CreateDynamicObject(18228,-1867.5319824,3286.3391113,0.2080000,0.0000000,0.0000000,297.9993896); //object(cunt_rockgp2_21)(3)
	CreateDynamicObject(17030,-1874.5240479,3388.0639648,0.4270000,0.0000000,0.0000000,153.5998535); //object(cunt_rockgp2_11)(4)
	CreateDynamicObject(18228,-1832.8060303,3274.3574219,-2.0420001,0.0000000,0.0000000,160.0000000); //object(cunt_rockgp2_21)(4)
	CreateDynamicObject(17031,-1841.0625000,3366.6103516,1.3860000,0.0000000,0.0000000,330.7379150); //object(cunt_rockgp2_13)(3)
	CreateDynamicObject(17031,-1843.4372559,3296.9968262,-12.1834002,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_13)(4)
	CreateDynamicObject(18228,-1845.3564453,3309.6931152,-11.8170004,0.0000000,0.0000000,255.9986572); //object(cunt_rockgp2_21)(5)
	CreateDynamicObject(18228,-1926.2342529,3321.0368652,-5.7919998,0.0000000,0.0000000,247.9986572); //object(cunt_rockgp2_21)(7)
	CreateDynamicObject(17071,-1905.3909912,3373.8229980,8.3249998,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_25)(2)
	CreateDynamicObject(18228,-1805.9809570,3293.9233398,-6.7919998,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_21)(9)
	CreateDynamicObject(652,-1909.2130127,3375.1530762,6.1020002,0.0000000,0.0000000,323.4265137); //object(sjmpalmbig)(5)
	CreateDynamicObject(17031,-1801.5119629,3355.4987793,-4.8217001,0.0000000,0.0000000,30.0000000); //object(cunt_rockgp2_13)(6)
	CreateDynamicObject(880,-1878.2270508,3357.1147461,5.5939999,0.0000000,0.0000000,0.0000000); //object(p_rubble0bcol)(1)
	CreateDynamicObject(18228,-1828.8227539,3358.7568359,-3.5420001,0.0000000,0.0000000,150.0000000); //object(cunt_rockgp2_21)(11)
	CreateDynamicObject(17031,-1799.4620361,3297.1040039,-9.3217001,0.0000000,0.0000000,99.9981689); //object(cunt_rockgp2_13)(8)
	CreateDynamicObject(17076,-1805.1391602,3341.8198242,-4.9665999,0.0000000,0.0000000,259.9981689); //object(cunt_rockgp2_26)(2)
	CreateDynamicObject(896,-1835.2127686,3278.0021973,16.8659992,0.0000000,0.0000000,280.0000000); //object(searock06)(1)
	CreateDynamicObject(896,-1845.9752197,3299.0502930,11.0094004,0.0000000,0.0000000,100.0000000); //object(searock06)(2)
	CreateDynamicObject(896,-1852.0999756,3290.5710449,13.7594004,0.0000000,0.0000000,85.9975586); //object(searock06)(3)
	CreateDynamicObject(880,-1818.0855713,3245.5419922,2.5383000,0.0000000,0.0000000,0.0000000); //object(p_rubble0bcol)(2)
	CreateDynamicObject(897,-1886.2027588,3312.8859863,11.2389002,0.0000000,0.0000000,0.0000000); //object(searock01)(1)
	CreateDynamicObject(897,-1821.2712402,3321.1328125,13.3727999,0.0000000,0.0000000,80.0000000); //object(searock01)(2)
	CreateDynamicObject(897,-1891.7624512,3334.5212402,8.6639004,0.0000000,0.0000000,79.9969482); //object(searock01)(3)
	CreateDynamicObject(897,-1892.3157959,3337.0581055,14.6639004,0.0000000,0.0000000,159.9969482); //object(searock01)(4)
	CreateDynamicObject(898,-1851.1165771,3334.2016602,5.6764998,0.0000000,0.0000000,0.0000000); //object(searock02)(1)
	CreateDynamicObject(898,-1851.5395508,3342.2651367,10.1765003,0.0000000,0.0000000,0.0000000); //object(searock02)(2)
	CreateDynamicObject(897,-1852.9620361,3333.7382812,8.0639000,0.0000000,0.0000000,279.9938965); //object(searock01)(5)
	CreateDynamicObject(897,-1843.8398438,3306.5180664,14.3139000,0.0000000,0.0000000,279.9920654); //object(searock01)(6)
	CreateDynamicObject(899,-1831.6854248,3295.4628906,15.8326998,0.0000000,180.0000000,0.0000000); //object(searock03)(1)
	CreateDynamicObject(898,-1850.3775635,3274.1481934,9.3281002,0.0000000,0.0000000,0.0000000); //object(searock02)(3)
	CreateDynamicObject(898,-1843.7835693,3272.2824707,11.8281002,0.0000000,0.0000000,300.0000000); //object(searock02)(4)
	CreateDynamicObject(897,-1825.0833740,3281.0119629,12.9883003,0.0000000,0.0000000,159.9938965); //object(searock01)(7)
	CreateDynamicObject(897,-1822.6971436,3288.3898926,12.9883003,0.0000000,0.0000000,49.9938965); //object(searock01)(8)
	CreateDynamicObject(18228,-1845.7083740,3378.5200195,-4.5419998,0.0000000,0.0000000,269.9993896); //object(cunt_rockgp2_21)(12)
	CreateDynamicObject(896,-1844.2636719,3311.1660156,7.6343999,0.0000000,0.0000000,0.0000000); //object(searock06)(4)
	CreateDynamicObject(896,-1855.1512451,3279.9553223,11.3660002,0.0000000,0.0000000,342.7475586); //object(searock06)(5)
	CreateDynamicObject(898,-1847.2318115,3273.4758301,16.6040993,0.0000000,0.0000000,110.0000000); //object(searock02)(5)
	CreateDynamicObject(896,-1849.2603760,3273.4055176,20.7595997,0.0000000,0.0000000,208.0000000); //object(searock06)(6)
	CreateDynamicObject(897,-1856.3355713,3282.6772461,19.8749008,0.0000000,0.0000000,73.9969482); //object(searock01)(9)
	CreateDynamicObject(896,-1831.6844482,3249.7185059,1.5996000,0.0000000,0.0000000,277.9986572); //object(searock06)(7)
	CreateDynamicObject(18228,-1826.9753418,3353.2004395,-3.5420001,0.0000000,0.0000000,349.9963379); //object(cunt_rockgp2_21)(13)
	CreateDynamicObject(898,-1828.8310547,3346.1748047,10.1765003,0.0000000,0.0000000,300.0000000); //object(searock02)(6)
	CreateDynamicObject(897,-1824.2922363,3338.8854980,14.7329998,0.0000000,256.0000000,76.0001221); //object(searock01)(10)
	CreateDynamicObject(897,-1834.1977539,3363.6123047,13.5888996,0.0000000,0.0000000,305.9920654); //object(searock01)(11)
	CreateDynamicObject(900,-1837.1822510,3334.0876465,15.4935999,0.0000000,0.0000000,340.0000000); //object(searock04)(1)
	CreateDynamicObject(900,-1831.5555420,3315.3334961,15.4935999,0.0000000,0.0000000,251.9993896); //object(searock04)(2)
	CreateDynamicObject(897,-1888.3818359,3319.0107422,11.2389002,0.0000000,0.0000000,79.9969482); //object(searock01)(12)
	CreateDynamicObject(899,-1805.8420410,3420.6928711,2.0527000,0.0000000,0.0000000,60.0000000); //object(searock03)(2)
	CreateDynamicObject(897,-1811.9282227,3323.3754883,8.2329998,0.0000000,255.9979248,185.9979248); //object(searock01)(13)
	CreateDynamicObject(897,-1813.7803955,3324.1677246,12.4829998,0.0000000,255.9924316,115.9930420); //object(searock01)(14)
	CreateDynamicObject(897,-1811.1772461,3325.6582031,17.4430008,0.0000000,255.9924316,15.9881592); //object(searock01)(15)
	CreateDynamicObject(896,-1815.5325928,3357.6079102,16.7686005,0.0000000,0.0000000,207.9986572); //object(searock06)(8)
	CreateDynamicObject(896,-1817.4295654,3326.0649414,16.7686005,0.0000000,0.0000000,291.9986572); //object(searock06)(9)
	CreateDynamicObject(901,-1803.1464844,3331.9863281,16.4908009,0.0000000,0.0000000,0.0000000); //object(searock05)(1)
	CreateDynamicObject(897,-1796.5394287,3343.8999023,10.6248999,0.0000000,0.0000000,73.9929199); //object(searock01)(16)
	CreateDynamicObject(897,-1797.6003418,3340.0537109,15.1248999,0.0000000,14.0000000,13.9929199); //object(searock01)(17)
	CreateDynamicObject(901,-1817.1469727,3333.7082520,13.1157999,0.0000000,180.0000000,316.0000000); //object(searock05)(2)
	CreateDynamicObject(899,-1813.1616211,3343.2893066,16.4326992,0.0000000,179.9945068,0.0000000); //object(searock03)(3)
	CreateDynamicObject(897,-1841.4185791,3313.9846191,16.2388992,0.0000000,0.0000000,319.9920654); //object(searock01)(18)
	CreateDynamicObject(898,-1890.9057617,3324.4716797,19.9514999,0.0000000,46.0000000,228.0000000); //object(searock02)(7)
	CreateDynamicObject(897,-1891.4836426,3334.2622070,13.3139000,0.0000000,0.0000000,311.9920654); //object(searock01)(19)
	CreateDynamicObject(624,-1871.7978516,3306.3395996,3.5334001,0.0000000,0.0000000,40.0000000); //object(veg_palwee02)(3)
	CreateDynamicObject(897,-1853.6700439,3291.5832520,19.8749008,0.0000000,0.0000000,42.7429199); //object(searock01)(20)
	CreateDynamicObject(896,-1849.1810303,3299.1943359,17.0095997,0.0000000,0.0000000,271.9986572); //object(searock06)(10)
	CreateDynamicObject(897,-1841.8271484,3302.6721191,19.8749008,0.0000000,0.0000000,354.7423096); //object(searock01)(21)
	CreateDynamicObject(896,-1856.1124268,3289.0197754,17.0095997,0.0000000,0.0000000,297.9940186); //object(searock06)(11)
	CreateDynamicObject(809,-1819.7939453,3214.5087891,1.8096000,0.0000000,0.0000000,0.0000000); //object(genveg_bush13)(6)
	CreateDynamicObject(809,-1875.1394043,3276.3469238,5.3080001,0.0000000,0.0000000,320.0000000); //object(genveg_bush13)(7)
	CreateDynamicObject(809,-1875.9887695,3274.7573242,5.3080001,0.0000000,0.0000000,319.9987793); //object(genveg_bush13)(8)
	CreateDynamicObject(809,-1877.8747559,3276.0803223,5.3080001,0.0000000,0.0000000,259.9987793); //object(genveg_bush13)(9)
	CreateDynamicObject(809,-1890.0310059,3287.8764648,6.3579998,0.0000000,0.0000000,259.9969482); //object(genveg_bush13)(10)
	CreateDynamicObject(809,-1893.0795898,3289.6813965,6.3579998,0.0000000,0.0000000,149.9969482); //object(genveg_bush13)(11)
	CreateDynamicObject(808,-1908.3668213,3324.5749512,4.9383001,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(7)
	CreateDynamicObject(808,-1849.3060303,3304.3613281,4.7400999,0.0000000,0.0000000,310.0000000); //object(genveg_bush12)(8)
	CreateDynamicObject(808,-1830.6939697,3290.2949219,5.8400998,0.0000000,0.0000000,309.9957275); //object(genveg_bush12)(9)
	CreateDynamicObject(818,-1802.4720459,3343.8369141,5.2592001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass02)(2)
	CreateDynamicObject(899,-1865.3950195,3405.2150879,17.2450008,0.0000000,179.9945068,0.0000000); //object(searock03)(4)
	CreateDynamicObject(899,-1861.9912109,3386.2851562,19.0590000,0.0000000,179.9945068,0.0000000); //object(searock03)(5)
	CreateDynamicObject(900,-1856.8220215,3390.0371094,20.9580002,0.0000000,0.0000000,310.7421875); //object(searock04)(3)
	CreateDynamicObject(652,-1880.6518555,3314.0285645,5.3291998,0.0000000,0.0000000,59.9981689); //object(sjmpalmbig)(11)
	CreateDynamicObject(641,-1806.2884521,3303.0576172,1.9998000,0.0000000,0.0000000,69.9981689); //object(veg_palmkb13)(3)
	CreateDynamicObject(822,-1877.2120361,3353.3081055,6.1199999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(1)
	CreateDynamicObject(822,-1880.7060547,3356.2419434,6.1199999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(2)
	CreateDynamicObject(822,-1879.5970459,3361.3769531,6.1199999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(3)
	CreateDynamicObject(822,-1883.5360107,3360.1088867,6.1199999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(4)
	CreateDynamicObject(822,-1884.4210205,3357.8159180,6.7760000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(5)
	CreateDynamicObject(822,-1882.4029541,3351.1740723,6.7760000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(6)
	CreateDynamicObject(822,-1878.2060547,3349.0219727,5.4480000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(7)
	CreateDynamicObject(822,-1871.5379639,3353.4809570,6.1199999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(8)
	CreateDynamicObject(822,-1870.3160400,3346.9240723,5.7919998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(9)
	CreateDynamicObject(822,-1875.2490234,3365.0449219,6.9390001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(10)
	CreateDynamicObject(822,-1872.8659668,3360.7639160,6.5289998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(11)
	CreateDynamicObject(822,-1879.5419922,3365.7099609,5.9549999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(12)
	CreateDynamicObject(822,-1867.7740479,3364.8259277,6.3649998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(13)
	CreateDynamicObject(822,-1865.5019531,3360.5510254,6.0370002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(14)
	CreateDynamicObject(822,-1862.0660400,3355.7019043,5.4629998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(15)
	CreateDynamicObject(822,-1863.1923828,3350.3544922,5.1350002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(16)
	CreateDynamicObject(822,-1866.8470459,3355.5390625,5.4629998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(17)
	CreateDynamicObject(822,-1855.9940186,3363.7480469,5.6269999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(18)
	CreateDynamicObject(822,-1858.6760254,3372.3688965,5.4629998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(19)
	CreateDynamicObject(822,-1858.7080078,3359.7409668,5.7090001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(20)
	CreateDynamicObject(801,-1830.4531250,3225.8574219,2.7291000,0.0000000,0.0000000,37.9852295); //object(genveg_bush01)(9)
	CreateDynamicObject(652,-1861.7705078,3364.6806641,5.5730000,0.0000000,0.0000000,323.4265137); //object(sjmpalmbig)(13)
	CreateDynamicObject(801,-1891.1883545,3287.3815918,6.7820001,0.0000000,0.0000000,37.9852295); //object(genveg_bush01)(10)
	CreateDynamicObject(801,-1892.2540283,3285.4123535,6.7820001,0.0000000,0.0000000,357.9852295); //object(genveg_bush01)(11)
	CreateDynamicObject(801,-1911.2083740,3290.7761230,2.7820001,0.0000000,0.0000000,357.9840088); //object(genveg_bush01)(12)
	CreateDynamicObject(652,-1879.1259766,3359.6860352,1.8490000,0.0000000,0.0000000,353.4265137); //object(sjmpalmbig)(14)
	CreateDynamicObject(652,-1871.4921875,3342.1279297,5.4130001,0.0000000,0.0000000,303.4259033); //object(sjmpalmbig)(15)
	CreateDynamicObject(801,-1911.4366455,3288.5371094,2.7820001,0.0000000,0.0000000,317.9840088); //object(genveg_bush01)(13)
	CreateDynamicObject(801,-1912.1020508,3287.0883789,2.7820001,0.0000000,0.0000000,57.9827881); //object(genveg_bush01)(14)
	CreateDynamicObject(652,-1880.5930176,3350.6621094,6.3319998,0.0000000,0.0000000,353.4265137); //object(sjmpalmbig)(16)
	CreateDynamicObject(652,-1873.1059570,3352.6818848,6.1110001,0.0000000,0.0000000,13.4265137); //object(sjmpalmbig)(17)
	CreateDynamicObject(801,-1913.4919434,3296.9111328,3.8320000,0.0000000,0.0000000,57.9803467); //object(genveg_bush01)(15)
	CreateDynamicObject(801,-1912.0883789,3295.3264160,3.8320000,0.0000000,0.0000000,347.9803467); //object(genveg_bush01)(16)
	CreateDynamicObject(652,-1871.3050537,3358.0349121,6.2740002,0.0000000,0.0000000,303.4265137); //object(sjmpalmbig)(19)
	CreateDynamicObject(801,-1902.4063721,3329.9987793,4.1820002,0.0000000,0.0000000,347.9754639); //object(genveg_bush01)(17)
	CreateDynamicObject(808,-1856.0507812,3223.2626953,3.6809001,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(11)
	CreateDynamicObject(822,-1857.7349854,3368.3759766,4.5070000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(22)
	CreateDynamicObject(808,-1909.3045654,3324.0009766,4.9383001,0.0000000,0.0000000,320.0000000); //object(genveg_bush12)(12)
	CreateDynamicObject(808,-1910.6036377,3322.0075684,4.9383001,0.0000000,0.0000000,319.9987793); //object(genveg_bush12)(13)
	CreateDynamicObject(808,-1912.3358154,3314.2946777,4.3383002,0.0000000,0.0000000,319.9987793); //object(genveg_bush12)(14)
	CreateDynamicObject(808,-1912.2581787,3315.8903809,4.3383002,0.0000000,0.0000000,279.9987793); //object(genveg_bush12)(15)
	CreateDynamicObject(822,-1861.1059570,3371.4040527,4.5070000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(23)
	CreateDynamicObject(822,-1869.4840088,3362.4389648,6.6370001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(24)
	CreateDynamicObject(822,-1852.0069580,3369.7290039,4.5070000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(25)
	CreateDynamicObject(822,-1864.5760498,3368.3269043,5.2440000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(26)
	CreateDynamicObject(822,-1862.0510254,3364.5200195,5.6539998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(27)
	CreateDynamicObject(820,-1818.0340576,3353.5881348,4.0713000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass04)(1)
	CreateDynamicObject(822,-1862.7640381,3378.0471191,6.0640001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(28)
	CreateDynamicObject(822,-1862.9389648,3374.9379883,5.0809999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(29)
	CreateDynamicObject(822,-1865.8879395,3340.0200195,4.9169998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(30)
	CreateDynamicObject(820,-1819.4461670,3350.7800293,3.5462999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass04)(2)
	CreateDynamicObject(822,-1871.4520264,3336.4030762,4.9169998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(31)
	CreateDynamicObject(820,-1822.3835449,3348.6774902,2.8963001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass04)(3)
	CreateDynamicObject(822,-1873.8759766,3340.7099609,4.4130001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(32)
	CreateDynamicObject(820,-1814.1485596,3351.4042969,3.4963000,0.0000000,0.0000000,348.0000000); //object(genveg_tallgrass04)(4)
	CreateDynamicObject(822,-1869.5947266,3341.7246094,5.4910002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(33)
	CreateDynamicObject(820,-1810.3310547,3351.4038086,3.4963000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass04)(5)
	CreateDynamicObject(822,-1875.5849609,3345.3359375,5.4089999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(34)
	CreateDynamicObject(822,-1863.4870605,3334.0878906,5.1630001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(35)
	CreateDynamicObject(820,-1813.3261719,3331.8378906,3.2962999,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass04)(6)
	CreateDynamicObject(820,-1814.1419678,3330.8364258,3.2962999,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass04)(7)
	CreateDynamicObject(822,-1868.2314453,3333.7353516,4.9169998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(820,-1810.7906494,3330.4633789,2.9712999,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass04)(8)
	CreateDynamicObject(822,-1874.7349854,3332.8410645,4.9039998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(37)
	CreateDynamicObject(820,-1816.4577637,3333.3312988,2.9712999,0.0000000,0.0000000,257.9974365); //object(genveg_tallgrass04)(9)
	CreateDynamicObject(822,-1879.9360352,3330.1320801,5.2319999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(38)
	CreateDynamicObject(820,-1843.9676514,3334.4377441,2.9712999,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(10)
	CreateDynamicObject(820,-1844.2506104,3336.0922852,3.2962999,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(11)
	CreateDynamicObject(820,-1842.8365479,3337.3964844,3.2962999,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(12)
	CreateDynamicObject(820,-1844.3411865,3331.5739746,3.2962999,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(13)
	CreateDynamicObject(820,-1844.1512451,3328.7482910,3.2962999,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(14)
	CreateDynamicObject(820,-1846.0566406,3327.7041016,3.2962999,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1867.5808105,3337.0119629,2.7713001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(16)
	CreateDynamicObject(822,-1872.6180420,3328.1840820,5.4080000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(39)
	CreateDynamicObject(820,-1868.4820557,3341.5195312,2.7713001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(17)
	CreateDynamicObject(820,-1872.6469727,3341.0622559,2.7713001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(18)
	CreateDynamicObject(820,-1875.4154053,3346.4448242,4.0963001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(19)
	CreateDynamicObject(822,-1876.8800049,3327.7109375,5.1539998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(40)
	CreateDynamicObject(820,-1874.9941406,3351.2023926,4.0963001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(20)
	CreateDynamicObject(822,-1867.1369629,3324.2280273,4.8350000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(41)
	CreateDynamicObject(820,-1869.3781738,3356.4704590,4.0963001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(21)
	CreateDynamicObject(820,-1868.7541504,3359.6596680,4.0963001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(22)
	CreateDynamicObject(820,-1871.7038574,3361.5112305,4.0963001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(23)
	CreateDynamicObject(822,-1876.1159668,3322.2399902,5.5720000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(42)
	CreateDynamicObject(820,-1862.0312500,3347.1313477,4.0963001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(24)
	CreateDynamicObject(820,-1866.6175537,3341.9155273,3.6963000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(25)
	CreateDynamicObject(820,-1875.7585449,3335.5544434,3.6963000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(26)
	CreateDynamicObject(820,-1881.0378418,3332.0029297,3.6963000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(27)
	CreateDynamicObject(822,-1881.5620117,3325.4099121,5.4000001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(43)
	CreateDynamicObject(820,-1881.0371094,3332.0029297,3.6963000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(28)
	CreateDynamicObject(822,-1861.7659912,3327.4641113,4.0970001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(44)
	CreateDynamicObject(820,-1883.6247559,3329.7172852,3.8713000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(29)
	CreateDynamicObject(820,-1883.9085693,3327.1872559,3.8713000,0.0000000,0.0000000,217.9919434); //object(genveg_tallgrass04)(30)
	CreateDynamicObject(822,-1870.1030273,3318.7910156,4.5890002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(46)
	CreateDynamicObject(822,-1863.3640137,3319.0129395,4.5890002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(47)
	CreateDynamicObject(822,-1857.7230225,3322.1699219,4.4250002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(48)
	CreateDynamicObject(822,-1861.1409912,3314.6669922,4.0149999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(49)
	CreateDynamicObject(822,-1866.4460449,3315.3430176,4.2610002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(50)
	CreateDynamicObject(822,-1871.3050537,3312.0568848,5.0799999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(51)
	CreateDynamicObject(822,-1875.0439453,3316.8168945,5.0799999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(52)
	CreateDynamicObject(822,-1860.5300293,3304.9628906,4.0110002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(54)
	CreateDynamicObject(801,-1848.9365234,3239.2333984,5.4291000,0.0000000,0.0000000,79.9969482); //object(genveg_bush01)(18)
	CreateDynamicObject(822,-1866.7760010,3304.9860840,3.8350000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(55)
	CreateDynamicObject(822,-1866.1030273,3309.1931152,4.0850000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(56)
	CreateDynamicObject(822,-1856.2120361,3313.6918945,4.2610002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(57)
	CreateDynamicObject(801,-1850.8691406,3302.1325684,3.6545999,0.0000000,0.0000000,39.9969482); //object(genveg_bush01)(19)
	CreateDynamicObject(822,-1856.2340088,3308.6879883,3.2780001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(58)
	CreateDynamicObject(801,-1854.3730469,3310.0292969,3.6545999,0.0000000,0.0000000,39.9957275); //object(genveg_bush01)(20)
	CreateDynamicObject(822,-1856.1929932,3318.0568848,4.3429999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(59)
	CreateDynamicObject(801,-1869.7264404,3296.3894043,5.9046001,0.0000000,0.0000000,39.9957275); //object(genveg_bush01)(21)
	CreateDynamicObject(801,-1868.5283203,3297.8339844,5.9046001,0.0000000,0.0000000,89.9945068); //object(genveg_bush01)(22)
	CreateDynamicObject(822,-1848.4959717,3323.1340332,4.9990001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(60)
	CreateDynamicObject(801,-1862.2524414,3293.5749512,4.4545999,0.0000000,0.0000000,89.9945068); //object(genveg_bush01)(23)
	CreateDynamicObject(822,-1851.8909912,3319.9528809,4.7529998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(61)
	CreateDynamicObject(822,-1846.6169434,3320.6088867,5.6539998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(62)
	CreateDynamicObject(822,-1844.6419678,3324.6818848,5.9819999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(63)
	CreateDynamicObject(821,-1811.4573975,3316.8015137,5.7216001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(1)
	CreateDynamicObject(821,-1813.1259766,3313.6152344,5.7216001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(2)
	CreateDynamicObject(821,-1811.0147705,3311.7817383,4.1715999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(3)
	CreateDynamicObject(821,-1808.8665771,3309.4853516,4.1216002,0.0000000,0.0000000,314.0000000); //object(genveg_tallgrass05)(4)
	CreateDynamicObject(821,-1807.2637939,3301.8386230,4.2216001,0.0000000,0.0000000,313.9947510); //object(genveg_tallgrass05)(5)
	CreateDynamicObject(821,-1804.6622314,3303.5634766,4.2216001,0.0000000,0.0000000,273.9947510); //object(genveg_tallgrass05)(6)
	CreateDynamicObject(821,-1788.4824219,3309.4213867,1.3216000,0.0000000,0.0000000,273.9935303); //object(genveg_tallgrass05)(7)
	CreateDynamicObject(821,-1791.2540283,3310.2998047,1.3216000,0.0000000,0.0000000,273.9935303); //object(genveg_tallgrass05)(8)
	CreateDynamicObject(821,-1793.7399902,3310.6193848,2.5216000,0.0000000,0.0000000,273.9935303); //object(genveg_tallgrass05)(9)
	CreateDynamicObject(821,-1789.0225830,3306.7695312,1.9466000,0.0000000,0.0000000,273.9935303); //object(genveg_tallgrass05)(10)
	CreateDynamicObject(821,-1806.5892334,3326.4550781,5.4716001,0.0000000,0.0000000,273.9935303); //object(genveg_tallgrass05)(11)
	CreateDynamicObject(652,-1864.8349609,3336.6779785,-0.6750000,0.0000000,0.0000000,303.4259033); //object(sjmpalmbig)(22)
	CreateDynamicObject(652,-1871.7139893,3322.5419922,5.0330000,0.0000000,0.0000000,273.4259033); //object(sjmpalmbig)(23)
	CreateDynamicObject(652,-1879.4360352,3321.1809082,0.9000000,0.0000000,0.0000000,309.4259033); //object(sjmpalmbig)(24)
	CreateDynamicObject(652,-1870.1760254,3311.9719238,2.8720000,0.0000000,0.0000000,293.4259033); //object(sjmpalmbig)(27)
	CreateDynamicObject(652,-1859.2309570,3311.0830078,3.6190000,0.0000000,0.0000000,343.4259033); //object(sjmpalmbig)(28)
	CreateDynamicObject(822,-1838.1090088,3336.9130859,5.8369999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(65)
	CreateDynamicObject(822,-1831.3759766,3337.4250488,6.4109998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(66)
	CreateDynamicObject(822,-1834.4029541,3332.6430664,6.5749998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(67)
	CreateDynamicObject(822,-1838.3199463,3331.2229004,6.3290000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(68)
	CreateDynamicObject(822,-1835.4289551,3321.2390137,7.3119998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(69)
	CreateDynamicObject(822,-1806.5400391,3340.7451172,4.1980000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(70)
	CreateDynamicObject(822,-1802.8819580,3337.8820801,3.3789999,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(71)
	CreateDynamicObject(822,-1802.8349609,3343.6540527,4.1160002,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(72)
	CreateDynamicObject(822,-1810.8050537,3346.7280273,4.6079998,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(73)
	CreateDynamicObject(17030,-1814.0361328,3403.9501953,-5.3569999,0.0000000,0.0000000,0.0000000); //object(cunt_rockgp2_11)(7)
	CreateDynamicObject(652,-1794.9100342,3323.5949707,4.0949998,0.0000000,0.0000000,353.4265137); //object(sjmpalmbig)(30)
	CreateDynamicObject(652,-1795.4990234,3316.6840820,0.5950000,0.0000000,0.0000000,337.4265137); //object(sjmpalmbig)(31)
	CreateDynamicObject(652,-1805.0830078,3308.4550781,3.9159999,0.0000000,0.0000000,303.4265137); //object(sjmpalmbig)(32)
	CreateDynamicObject(1457,-1874.4658203,3338.9970703,6.5086002,0.0000000,0.0000000,0.0000000); //object(dyn_outhouse_2)(1)
	CreateDynamicObject(652,-1888.9069824,3375.0229492,5.7740002,0.0000000,0.0000000,323.4265137); //object(sjmpalmbig)(33)
	CreateDynamicObject(652,-1890.3950195,3360.6230469,5.1719999,0.0000000,0.0000000,323.4265137); //object(sjmpalmbig)(34)
	CreateDynamicObject(652,-1890.3945312,3360.6230469,5.1719999,0.0000000,0.0000000,323.4265137); //object(sjmpalmbig)(35)
	CreateDynamicObject(652,-1894.4239502,3391.0869141,2.1550000,0.0000000,0.0000000,337.4265137); //object(sjmpalmbig)(36)
	CreateDynamicObject(1458,-1873.7619629,3334.4880371,5.8407001,0.0000000,0.0000000,235.5000000); //object(dyn_cart)(1)
	CreateDynamicObject(16404,-1858.8349609,3360.9719238,6.9902000,0.0000000,0.0000000,0.0000000); //object(desn2_hutskel2)(1)
	CreateDynamicObject(16406,-1886.5378418,3354.2792969,8.8764000,0.0000000,0.0000000,270.0000000); //object(desn2_weemineb)(1)
	CreateDynamicObject(822,-1889.9565430,3356.3986816,4.8140001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(75)
	CreateDynamicObject(822,-1890.0069580,3358.8046875,4.8140001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(76)
	CreateDynamicObject(822,-1892.9821777,3357.0559082,4.8140001,0.0000000,0.0000000,70.0000000); //object(genveg_tallgrass06)(77)
	CreateDynamicObject(822,-1895.1954346,3346.5004883,3.9389999,0.0000000,0.0000000,69.9993896); //object(genveg_tallgrass06)(78)
	CreateDynamicObject(13367,-1820.6341553,3381.5559082,14.0000000,0.0000000,0.0000000,0.0000000); //object(sw_watertower01)(1)
	CreateDynamicObject(821,-1821.5732422,3376.2661133,3.4842000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(12)
	CreateDynamicObject(821,-1823.7650146,3377.8332520,3.4842000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(13)
	CreateDynamicObject(821,-1817.6672363,3377.9948730,2.1092000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(14)
	CreateDynamicObject(821,-1820.9285889,3378.4084473,2.1092000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass05)(15)
	CreateDynamicObject(821,-1810.3060303,3374.8352051,2.9092000,0.0000000,0.0000000,348.0000000); //object(genveg_tallgrass05)(16)
	CreateDynamicObject(821,-1810.2851562,3374.0600586,2.9092000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass05)(17)
	CreateDynamicObject(821,-1807.8293457,3373.8747559,2.9092000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass05)(18)
	CreateDynamicObject(821,-1823.9216309,3384.1640625,2.5592000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass05)(19)
	CreateDynamicObject(821,-1821.9354248,3386.3735352,2.5592000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass05)(20)
	CreateDynamicObject(821,-1823.7071533,3379.4655762,2.5592000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass05)(21)
	CreateDynamicObject(821,-1823.5589600,3374.3103027,3.8592000,0.0000000,0.0000000,347.9974365); //object(genveg_tallgrass05)(22)
	CreateDynamicObject(18751,-2010.1035156,3558.9677734,0.0000000,0.0000000,0.0000000,305.3540039); //object(islandbase1)(24)
	CreateDynamicObject(18751,-2037.5556641,3575.0439453,0.0000000,0.0000000,0.0000000,261.4636230); //object(islandbase1)(26)
	CreateDynamicObject(1452,-1841.0567627,3337.1943359,6.0432000,0.0000000,0.0000000,0.0000000); //object(dyn_outhouse)(1)
	CreateDynamicObject(897,-1838.2685547,3304.0185547,20.3749008,0.0000000,0.0000000,306.7327881); //object(searock01)(24)
	CreateDynamicObject(18228,-1881.9882812,3305.9892578,-3.5420001,0.0000000,0.0000000,69.9993896); //object(cunt_rockgp2_21)(14)
	CreateDynamicObject(18228,-1919.2543945,3420.1264648,-7.0000000,0.0000000,0.0000000,249.9993896); //object(cunt_rockgp2_21)(15)
	CreateDynamicObject(18228,-1910.1312256,3468.0788574,-3.2500000,0.0000000,0.0000000,91.9993896); //object(cunt_rockgp2_21)(16)
	CreateDynamicObject(18228,-1934.8493652,3470.8378906,-3.2500000,0.0000000,0.0000000,153.9940186); //object(cunt_rockgp2_21)(17)
	CreateDynamicObject(18228,-1944.7237549,3441.2812500,-7.0000000,0.0000000,0.0000000,301.9938965); //object(cunt_rockgp2_21)(18)
	CreateDynamicObject(18228,-1973.4007568,3466.0834961,-7.0000000,0.0000000,0.0000000,261.9921875); //object(cunt_rockgp2_21)(19)
	CreateDynamicObject(18228,-1955.4533691,3491.4287109,-3.2500000,0.0000000,0.0000000,83.9898682); //object(cunt_rockgp2_21)(20)
	CreateDynamicObject(18228,-1979.1171875,3517.7246094,-3.2500000,0.0000000,0.0000000,115.9826660); //object(cunt_rockgp2_21)(21)
	CreateDynamicObject(18228,-1994.1134033,3494.5920410,-7.0000000,0.0000000,0.0000000,291.9909668); //object(cunt_rockgp2_21)(22)
	CreateDynamicObject(18228,-1932.1219482,3467.7075195,-12.7500000,0.0000000,0.0000000,153.9898682); //object(cunt_rockgp2_21)(23)
	CreateDynamicObject(18228,-1918.6851807,3425.2814941,-13.2500000,0.0000000,0.0000000,249.9938965); //object(cunt_rockgp2_21)(24)
	CreateDynamicObject(18228,-1944.7236328,3441.2812500,-13.5000000,0.0000000,0.0000000,301.9921875); //object(cunt_rockgp2_21)(25)
	CreateDynamicObject(18228,-1935.5373535,3470.8146973,-6.2500000,0.0000000,0.0000000,153.9898682); //object(cunt_rockgp2_21)(26)
	CreateDynamicObject(18228,-1971.7657471,3465.0258789,-11.0000000,0.0000000,0.0000000,261.9909668); //object(cunt_rockgp2_21)(27)
	CreateDynamicObject(18228,-1955.8597412,3490.6455078,-7.5000000,0.0000000,0.0000000,83.9849854); //object(cunt_rockgp2_21)(28)
	CreateDynamicObject(900,-1916.5419922,3447.7661133,-8.9949999,0.0000000,350.5224609,310.7373047); //object(searock04)(4)
	CreateDynamicObject(18228,-1977.5269775,3514.8903809,-8.7500000,0.0000000,0.0000000,115.9826660); //object(cunt_rockgp2_21)(29)
	CreateDynamicObject(18228,-1992.6894531,3494.1188965,-8.2500000,0.0000000,0.0000000,291.9891357); //object(cunt_rockgp2_21)(30)
	CreateDynamicObject(900,-1924.5159912,3462.3688965,-10.3059998,0.0000000,350.5187988,310.7318115); //object(searock04)(5)
	CreateDynamicObject(900,-1939.9511719,3454.8315430,-10.1949997,0.0000000,350.5187988,310.7318115); //object(searock04)(6)
	CreateDynamicObject(900,-1962.4305420,3468.2231445,-10.1949997,0.0000000,350.5187988,310.7318115); //object(searock04)(7)
	CreateDynamicObject(900,-1966.0351562,3483.8759766,-10.1949997,0.0000000,350.5187988,310.7318115); //object(searock04)(8)
	CreateDynamicObject(900,-1976.4567871,3495.3496094,-8.7200003,0.0000000,350.5187988,310.7318115); //object(searock04)(10)
	CreateDynamicObject(900,-1983.6629639,3505.0205078,-8.7200003,0.0000000,350.5187988,99.7318115); //object(searock04)(11)
	CreateDynamicObject(899,-1917.9226074,3449.6621094,11.0590000,0.0000000,179.9945068,0.0000000); //object(searock03)(8)
	CreateDynamicObject(901,-1941.8480225,3456.8479004,8.4667997,0.0000000,0.0000000,54.0000000); //object(searock05)(3)
	CreateDynamicObject(901,-1933.2064209,3459.2304688,8.4667997,0.0000000,0.0000000,53.9978027); //object(searock05)(4)
	CreateDynamicObject(901,-1934.0898438,3448.4980469,8.4667997,0.0000000,0.0000000,343.9978027); //object(searock05)(5)
	CreateDynamicObject(901,-1921.0450439,3464.0944824,8.4667997,0.0000000,0.0000000,343.9929199); //object(searock05)(6)
	CreateDynamicObject(900,-1966.0351562,3483.8759766,7.1250000,0.0000000,350.5187988,310.7318115); //object(searock04)(12)
	CreateDynamicObject(900,-1959.5921631,3467.6064453,7.1250000,0.0000000,350.5187988,126.7318420); //object(searock04)(13)
	CreateDynamicObject(901,-1950.1647949,3452.0192871,6.2168002,0.0000000,0.0000000,53.9978027); //object(searock05)(7)
	CreateDynamicObject(899,-1974.1823730,3501.0756836,7.0590000,0.0000000,179.9945068,0.0000000); //object(searock03)(9)
	CreateDynamicObject(900,-1987.7788086,3510.4907227,7.1250000,0.0000000,350.5187988,166.7272949); //object(searock04)(15)
	CreateDynamicObject(901,-2003.7270508,3503.1032715,3.0418000,0.0000000,0.0000000,53.9978027); //object(searock05)(8)
	CreateDynamicObject(901,-1976.0676270,3476.6247559,3.8917999,0.0000000,0.0000000,53.9978027); //object(searock05)(9)
	CreateDynamicObject(901,-1902.1988525,3458.2241211,6.9668002,0.0000000,0.0000000,343.9929199); //object(searock05)(10)
	CreateDynamicObject(900,-1912.8775635,3423.2395020,-2.6250000,0.0000000,180.0000000,322.7318115); //object(searock04)(17)
	CreateDynamicObject(822,-1903.8157959,3418.4916992,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(79)
	CreateDynamicObject(822,-1902.9333496,3416.0744629,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(80)
	CreateDynamicObject(822,-1898.5761719,3418.8007812,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(81)
	CreateDynamicObject(822,-1899.7872314,3415.9560547,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(82)
	CreateDynamicObject(822,-1904.8553467,3417.5168457,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(83)
	CreateDynamicObject(822,-1907.7513428,3419.9992676,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(84)
	CreateDynamicObject(822,-1910.4555664,3418.9086914,1.4873000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(85)
	CreateDynamicObject(822,-1889.4112549,3417.5236816,3.0373001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(86)
	CreateDynamicObject(822,-1888.1097412,3418.2285156,3.0373001,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(87)
	CreateDynamicObject(822,-1887.7176514,3420.6967773,4.1373000,0.0000000,0.0000000,10.0000000); //object(genveg_tallgrass06)(88)
	CreateDynamicObject(822,-1890.0842285,3418.5402832,4.1373000,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(89)
	CreateDynamicObject(822,-1892.0842285,3418.8564453,3.4623001,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(90)
	CreateDynamicObject(822,-1879.0821533,3422.6191406,3.4623001,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(91)
	CreateDynamicObject(822,-1876.9498291,3423.2939453,3.4623001,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(92)
	CreateDynamicObject(822,-1874.8879395,3423.0170898,3.4623001,0.0000000,0.0000000,59.9975586); //object(genveg_tallgrass06)(93)
	CreateDynamicObject(822,-1874.3608398,3421.8828125,4.7122998,0.0000000,0.0000000,59.9963379); //object(genveg_tallgrass06)(94)
	CreateDynamicObject(624,-1847.9615479,3442.8579102,0.1410000,0.0000000,0.0000000,30.0000000); //object(veg_palwee02)(4)
	CreateDynamicObject(624,-1848.6152344,3416.6809082,4.0409999,0.0000000,0.0000000,79.9981689); //object(veg_palwee02)(5)
	CreateDynamicObject(801,-1849.5708008,3417.5732422,5.3045001,0.0000000,0.0000000,89.9945068); //object(genveg_bush01)(24)
	CreateDynamicObject(801,-1850.3841553,3416.0820312,5.3045001,0.0000000,0.0000000,43.9945068); //object(genveg_bush01)(25)
	CreateDynamicObject(801,-1850.0306396,3417.9741211,5.3045001,0.0000000,0.0000000,43.9892578); //object(genveg_bush01)(26)
	CreateDynamicObject(801,-1846.9996338,3417.1809082,5.3045001,0.0000000,0.0000000,131.9892578); //object(genveg_bush01)(27)
	CreateDynamicObject(801,-1839.1429443,3407.8967285,5.1294999,0.0000000,0.0000000,131.9842529); //object(genveg_bush01)(28)
	CreateDynamicObject(801,-1840.8210449,3409.0507812,5.1294999,0.0000000,0.0000000,61.9842529); //object(genveg_bush01)(29)
	CreateDynamicObject(801,-1841.5240479,3408.9794922,5.2544999,0.0000000,0.0000000,61.9793701); //object(genveg_bush01)(30)
	CreateDynamicObject(801,-1843.1794434,3408.3879395,5.2544999,0.0000000,0.0000000,61.9793701); //object(genveg_bush01)(31)
	CreateDynamicObject(801,-1844.3189697,3408.1035156,5.2544999,0.0000000,0.0000000,61.9793701); //object(genveg_bush01)(32)
	CreateDynamicObject(801,-1846.5500488,3407.5483398,5.2544999,0.0000000,0.0000000,61.9793701); //object(genveg_bush01)(33)
	CreateDynamicObject(801,-1843.6391602,3408.2714844,5.2544999,0.0000000,0.0000000,101.9793701); //object(genveg_bush01)(34)
	CreateDynamicObject(801,-1840.0003662,3409.1760254,5.2544999,0.0000000,0.0000000,101.9750977); //object(genveg_bush01)(35)
	CreateDynamicObject(801,-1829.6976318,3414.3188477,4.1044998,0.0000000,0.0000000,101.9750977); //object(genveg_bush01)(36)
	CreateDynamicObject(822,-1838.8906250,3408.2924805,5.0524001,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(95)
	CreateDynamicObject(822,-1821.4830322,3407.7429199,5.6273999,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(96)
	CreateDynamicObject(822,-1800.8850098,3364.7028809,6.0774002,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(97)
	CreateDynamicObject(822,-1797.4689941,3364.0458984,6.0774002,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(98)
	CreateDynamicObject(822,-1792.5401611,3357.0449219,3.8274000,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(99)
	CreateDynamicObject(822,-1794.3515625,3359.4606934,3.8274000,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(100)
	CreateDynamicObject(822,-1788.3082275,3354.6086426,2.5274000,0.0000000,0.0000000,9.9975586); //object(genveg_tallgrass06)(101)
	CreateDynamicObject(3350,-1878.0041504,3332.9916992,5.4926000,0.0000000,0.0000000,359.4964600); //object(torino_mic)(1)
	CreateDynamicObject(12990,-1816.3167725,3196.9572754,0.9000000,0.0000000,0.0000000,6.0795898); //object(sw_jetty)(1)
	CreateDynamicObject(16647,-2088.3173828,3578.6894531,10.0000000,0.0000000,0.0000000,0.0000000); //object(a51_storeroom)(1)
	CreateDynamicObject(19451,-2072.8925781,3568.5429688,11.8439999,0.0000000,0.0000000,90.0000000); //object(wall091)(1)
	CreateDynamicObject(19451,-2072.8925781,3566.0192871,11.8439999,0.0000000,0.0000000,90.0000000); //object(wall091)(2)
	CreateDynamicObject(19461,-2072.9658203,3567.2529297,10.0000000,0.0000000,90.0000000,90.0000000); //object(wall101)(1)
	CreateDynamicObject(8661,-2087.6435547,3577.5791016,15.8119001,0.0000000,0.0000000,90.0000000); //object(gnhtelgrnd_lvs)(1)
	CreateDynamicObject(8661,-2093.3967285,3577.5712891,15.8368998,0.0000000,0.0000000,90.0000000); //object(gnhtelgrnd_lvs)(2)
	CreateDynamicObject(8661,-2077.6704102,3587.5856934,-4.1564999,0.0000000,90.0000000,0.0000000); //object(gnhtelgrnd_lvs)(3)
	CreateDynamicObject(8661,-2077.6611328,3578.5104980,-4.1564999,0.0000000,90.0000000,0.0000000); //object(gnhtelgrnd_lvs)(4)
	CreateDynamicObject(8673,-2090.3247070,3558.4948730,11.5607004,0.0000000,0.0000000,0.0000000); //object(csrsfence03_lvs)(1)
	CreateDynamicObject(8673,-2090.3242188,3558.4938965,13.0356998,0.0000000,0.0000000,0.0000000); //object(csrsfence03_lvs)(3)
	CreateDynamicObject(16643,-2087.8991699,3569.7104492,11.4611998,0.0000000,0.0000000,180.0000000); //object(a51_stormech)(1)
	CreateDynamicObject(8661,-2077.6289062,3556.0314941,-4.1564999,0.0000000,90.0000000,0.0000000); //object(gnhtelgrnd_lvs)(5)
	CreateDynamicObject(8661,-2087.6005859,3546.0727539,-4.1564999,0.0000000,90.0000000,270.0000000); //object(gnhtelgrnd_lvs)(6)
	CreateDynamicObject(8661,-2092.4572754,3546.1103516,-4.1564999,0.0000000,90.0000000,270.0000000); //object(gnhtelgrnd_lvs)(7)
	CreateDynamicObject(8661,-2087.5476074,3566.0170898,15.8000002,0.0000000,0.0000000,90.0000000); //object(gnhtelgrnd_lvs)(8)
	CreateDynamicObject(8661,-2093.3115234,3566.0224609,15.7618999,0.0000000,0.0000000,90.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(8661,-2077.6826172,3565.7600098,-9.9064999,0.0000000,90.0000000,0.0000000); //object(gnhtelgrnd_lvs)(10)
	CreateDynamicObject(18260,-2089.8032227,3595.7128906,8.9793997,0.0000000,0.0000000,180.0000000); //object(crates01)(1)
	CreateDynamicObject(2951,-2081.2756348,3597.4235840,7.3906002,0.0000000,0.0000000,0.0000000); //object(a51_labdoor)(1)
	CreateDynamicObject(2985,-2078.3205566,3584.3259277,18.7915993,0.0000000,0.0000000,340.0000000); //object(minigun_base)(1)
	CreateDynamicObject(3095,-2093.9331055,3548.2324219,16.9986000,0.0000000,0.0000000,0.0000000); //object(a51_jetdoor)(1)
	CreateDynamicObject(3115,-2086.8032227,3568.8391113,16.7008018,0.0000000,0.0000000,90.0000000); //object(carrier_lift1_sfse)(1)
	CreateDynamicObject(16782,-2088.8171387,3580.3403320,14.1599998,0.0000000,0.0000000,0.0000000); //object(a51_radar_scan)(1)
	CreateDynamicObject(3427,-2052.8159180,3597.6452637,2.7367470,0.0000000,0.0000000,262.0000000); //object(derrick01)(1)
	CreateDynamicObject(5728,-2104.8002930,3547.6811523,5.3502002,0.0000000,0.0000000,270.0000000); //object(dummybuild46_law)(1)
	CreateDynamicObject(1497,-2097.5251465,3566.7849121,10.0854998,0.0000000,0.0000000,0.0000000); //object(gen_doorext02)(2)
	CreateDynamicObject(1497,-2139.9667969,3614.8544922,6.0839000,0.0000000,0.0000000,90.0000000); //object(gen_doorext02)(1)
	CreateDynamicObject(17546,-2112.6354980,3574.1647949,10.0000000,0.0000000,0.0000000,269.5000000); //object(hydro3_lae)(1)
	CreateDynamicObject(5822,-2073.4641113,3538.2924805,11.6899996,0.0000000,0.0000000,183.0000000); //object(lhroofst14)(1)
	CreateDynamicObject(11479,-2094.7810059,3586.3735352,15.9869003,0.0000000,0.0000000,270.0000000); //object(des_nwtfescape)(1)
	CreateDynamicObject(11544,-2069.4277344,3567.2529297,9.0546999,0.0000000,0.0000000,90.0000000); //object(des_ntfrescape2)(1)
	CreateDynamicObject(2985,-2078.1562500,3590.3964844,18.7915993,0.0000000,0.0000000,4.9987793); //object(minigun_base)(2)
	CreateDynamicObject(2985,-2078.2863770,3596.8564453,18.7915993,0.0000000,0.0000000,337.4987793); //object(minigun_base)(3)
	CreateDynamicObject(3279,-2012.3830566,3594.3146973,0.6645000,0.0000000,310.0000000,290.0000000); //object(a51_spottower)(1)
	CreateDynamicObject(3279,-2028.6992188,3546.9218750,0.6645000,9.9975586,9.9975586,339.9938965); //object(a51_spottower)(2)
	CreateDynamicObject(18693,-2085.6037598,3577.9484863,12.4666004,0.0000000,0.0000000,0.0000000); //object(flame99)(1)
	CreateDynamicObject(18690,-2089.8920898,3595.4929199,8.2438002,0.0000000,0.0000000,0.0000000); //object(fire_car)(1)
	CreateDynamicObject(18689,-2087.2939453,3595.1684570,7.4562998,0.0000000,0.0000000,0.0000000); //object(fire_bike)(1)
	CreateDynamicObject(19303,-2099.1789551,3584.1340332,7.4405999,90.0000000,0.0000000,350.0000000); //object(pd_jail_door02)(1)
	CreateDynamicObject(19304,-2095.1181641,3588.2360840,8.0159998,0.0000000,0.0000000,90.0000000); //object(pd_jail_door_top01)(1)
	CreateDynamicObject(19304,-2095.1181641,3588.2351074,9.2410002,0.0000000,0.0000000,90.0000000); //object(pd_jail_door_top01)(2)
	CreateDynamicObject(19304,-2095.1181641,3588.2343750,10.4659996,0.0000000,0.0000000,90.0000000); //object(pd_jail_door_top01)(3)
	CreateDynamicObject(19304,-2096.0490723,3584.9716797,8.0159998,340.0000000,0.0000000,229.9959717); //object(pd_jail_door_top01)(5)
	CreateDynamicObject(19304,-2096.8630371,3586.4687500,10.4910002,0.0000000,0.0000000,0.0000000); //object(pd_jail_door_top01)(6)
	CreateDynamicObject(19304,-2096.8623047,3586.4755859,9.2410002,0.0000000,0.0000000,0.0000000); //object(pd_jail_door_top01)(8)
	CreateDynamicObject(19304,-2102.3999023,3586.4628906,7.9910002,0.0000000,0.0000000,0.0000000); //object(pd_jail_door_top01)(9)
	CreateDynamicObject(19304,-2102.3994141,3586.4628906,9.2410002,0.0000000,0.0000000,0.0000000); //object(pd_jail_door_top01)(10)
	CreateDynamicObject(3798,-2101.7385254,3587.5168457,7.3906002,0.0000000,0.0000000,0.0000000); //object(acbox3_sfs)(1)
	CreateDynamicObject(3800,-2097.2490234,3584.9726562,7.3906002,0.0000000,0.0000000,43.9947510); //object(acbox4_sfs)(1)
	CreateDynamicObject(3092,-2100.3298340,3589.7128906,8.9551001,0.0000000,0.0000000,180.0000000); //object(dead_tied_cop)(1)
	CreateDynamicObject(1219,-2084.2658691,3562.4675293,7.6034999,0.0000000,0.0000000,90.0000000); //object(palette)(1)
	CreateDynamicObject(1558,-2079.8122559,3559.3251953,10.6676998,0.0000000,0.0000000,0.0000000); //object(cj_cardbrd_pickup)(1)
	CreateDynamicObject(17071,-2031.8261719,3551.7912598,4.4538002,0.0000000,0.0000000,157.9998779); //object(cunt_rockgp2_25)(1)
	CreateDynamicObject(2908,-2078.1491699,3585.3610840,18.8689995,0.0000000,0.0000000,60.0000000); //object(kmb_deadhead)(1)
	CreateDynamicObject(2907,-2077.9765625,3595.0234375,19.3015995,279.9975586,0.0000000,83.9959717); //object(kmb_deadtorso)(1)
	CreateDynamicObject(19456,-2099.8979492,3590.7893066,9.1149998,0.0000000,0.0000000,90.0000000); //object(wall096)(1)
	CreateDynamicObject(19377,-2089.9355469,3571.5349121,1.1164000,0.0000000,90.0000000,0.0000000); //object(wall025)(1)
	CreateDynamicObject(19377,-2087.7243652,3571.5170898,1.0914000,0.0000000,90.0000000,0.0000000); //object(wall025)(2)
	CreateDynamicObject(19377,-2087.4267578,3581.1508789,1.0914000,0.0000000,90.0000000,0.0000000); //object(wall025)(3)
	CreateDynamicObject(19377,-2097.8710938,3579.3583984,1.0914000,0.0000000,90.0000000,0.0000000); //object(wall025)(4)
	CreateDynamicObject(3577,-2084.5270996,3568.6774902,1.9598000,0.0000000,0.0000000,0.0000000); //object(dockcrates1_la)(1)
	CreateDynamicObject(3576,-2092.0190430,3568.7363281,2.6700001,0.0000000,0.0000000,5.2500000); //object(dockcrates2_la)(1)
	CreateDynamicObject(18689,-2083.5856934,3567.9504395,1.3313000,0.0000000,0.0000000,0.0000000); //object(fire_bike)(2)
	CreateDynamicObject(18689,-2085.2900391,3569.7316895,0.8813000,0.0000000,0.0000000,0.0000000); //object(fire_bike)(3)
	CreateDynamicObject(18689,-2092.4189453,3567.4562988,0.8813000,0.0000000,0.0000000,0.0000000); //object(fire_bike)(4)
	CreateDynamicObject(18689,-2092.7604980,3568.0778809,2.3563001,0.0000000,0.0000000,0.0000000); //object(fire_bike)(5)
	CreateDynamicObject(18689,-2090.3811035,3569.8356934,0.2813000,0.0000000,0.0000000,0.0000000); //object(fire_bike)(6)
	CreateDynamicObject(19396,-2068.1533203,3567.2392578,11.8402004,0.0000000,0.0000000,0.0000000); //object(wall037)(1)
	CreateDynamicObject(11544,-2096.7451172,3565.2226562,9.0527000,0.0000000,0.0000000,179.9945068); //object(des_ntfrescape2)(2)
	CreateDynamicObject(11544,-2062.1520996,3567.2529297,6.1796999,0.0000000,0.0000000,90.0000000); //object(des_ntfrescape2)(3)
	CreateDynamicObject(18257,-2101.9096680,3588.4804688,15.8119001,0.0000000,0.0000000,270.0000000); //object(crates)(1)
	CreateDynamicObject(8674,-2100.6445312,3537.6201172,18.4655991,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(8674,-2090.3444824,3537.6076660,18.4655991,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(2)
	CreateDynamicObject(8674,-2093.1499023,3597.5227051,17.2514000,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(3)
	CreateDynamicObject(8674,-2073.4084473,3553.0920410,18.4655991,0.0000000,0.0000000,90.0000000); //object(csrsfence02_lvs)(4)
	CreateDynamicObject(8674,-2073.3918457,3542.7993164,18.4655991,0.0000000,0.0000000,90.0000000); //object(csrsfence02_lvs)(5)
	CreateDynamicObject(8674,-2071.4670410,3545.3735352,12.3049002,0.0000000,0.0000000,90.0000000); //object(csrsfence02_lvs)(6)
	CreateDynamicObject(3279,-1981.6744385,3554.9982910,2.0827000,0.0000000,0.0000000,331.9951172); //object(a51_spottower)(3)
	CreateDynamicObject(652,-1984.9050293,3537.6433105,1.7607000,0.0000000,0.0000000,13.4265137); //object(sjmpalmbig)(13)
	CreateDynamicObject(652,-2021.8806152,3553.9560547,2.8606999,0.0000000,0.0000000,63.4252930); //object(sjmpalmbig)(13)
	CreateDynamicObject(652,-2019.5538330,3548.1372070,0.5357000,0.0000000,0.0000000,93.4240723); //object(sjmpalmbig)(13)
	CreateDynamicObject(652,-2070.7646484,3559.4335938,2.4107001,0.0000000,0.0000000,123.4204102); //object(sjmpalmbig)(13)
	CreateDynamicObject(8673,-2127.7014160,3539.8701172,6.6722002,0.0000000,0.0000000,1.0000000); //object(csrsfence03_lvs)(2)
	CreateDynamicObject(8673,-2107.3024902,3540.2355957,6.6722002,0.0000000,0.0000000,0.9997559); //object(csrsfence03_lvs)(4)
	CreateDynamicObject(16613,-2120.9929199,3574.3168945,19.1968994,0.0000000,0.0000000,89.0000000); //object(des_bigtelescope)(1)
	CreateDynamicObject(17546,-2130.1584473,3574.3300781,10.0000000,0.0000000,0.0000000,269.4946289); //object(hydro3_lae)(2)
	CreateDynamicObject(3876,-2093.3627930,3548.2155762,17.5540009,0.0000000,0.0000000,0.0000000); //object(sf_roofmast)(1)
	CreateDynamicObject(5728,-2106.2429199,3581.3000488,4.0752001,0.0000000,0.0000000,90.0000000); //object(dummybuild46_law)(2)
	CreateDynamicObject(3675,-2076.1674805,3572.5759277,10.8470001,0.0000000,0.0000000,90.0000000); //object(laxrf_refinerypipe)(1)
	CreateDynamicObject(3675,-2074.1276855,3581.4904785,10.3970003,20.0000000,5.0000000,90.0000000); //object(laxrf_refinerypipe)(2)
	CreateDynamicObject(3675,-2076.1669922,3576.5751953,10.8470001,0.0000000,0.0000000,90.0000000); //object(laxrf_refinerypipe)(3)
	CreateDynamicObject(3675,-2076.1669922,3584.5751953,10.8470001,0.0000000,0.0000000,90.0000000); //object(laxrf_refinerypipe)(4)
	CreateDynamicObject(8369,-2038.4079590,3596.1904297,3.9749999,0.0000000,0.0000000,270.0000000); //object(vgsselecfence05b)(1)
	CreateDynamicObject(9829,-2127.3945312,3646.0000000,-59.2650986,0.0000000,0.0000000,270.0000000); //object(bumblister_sfw)(1)
	CreateDynamicObject(5728,-2165.3400879,3620.3071289,5.5752001,0.0000000,0.0000000,180.0000000); //object(dummybuild46_law)(3)
	CreateDynamicObject(5728,-2150.0883789,3587.7988281,-0.5998000,0.0000000,0.0000000,359.9945068); //object(dummybuild46_law)(4)
	CreateDynamicObject(8673,-2150.0185547,3619.2373047,12.4656000,0.0000000,0.0000000,359.4946289); //object(csrsfence03_lvs)(5)
	CreateDynamicObject(8674,-2085.2138672,3537.6103516,18.4655991,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(7)
	CreateDynamicObject(8674,-2082.8793945,3597.5227051,17.2514000,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(8)
	CreateDynamicObject(19377,-2099.7666016,3592.7275391,7.2902999,0.0000000,90.0000000,0.0000000); //object(wall025)(5)
	CreateDynamicObject(624,-1978.7164307,3567.6333008,0.1757000,0.0000000,0.0000000,60.0000000); //object(veg_palwee02)(1)
	CreateDynamicObject(624,-2010.6407471,3561.1152344,-5.8143001,0.0000000,0.0000000,19.9963379); //object(veg_palwee02)(1)
	CreateDynamicObject(624,-2036.5555420,3602.8488770,0.1818000,0.0000000,0.0000000,39.9963379); //object(veg_palwee02)(1)
	CreateDynamicObject(624,-2026.7835693,3605.4462891,-3.0682001,0.0000000,0.0000000,49.9957275); //object(veg_palwee02)(1)
	CreateDynamicObject(931,-2096.1315918,3598.4963379,7.1015000,0.0000000,0.0000000,0.0000000); //object(rack3)(1)
	CreateDynamicObject(930,-2095.5444336,3597.9741211,8.6482000,0.0000000,0.0000000,0.0000000); //object(o2_bottles)(1)
	CreateDynamicObject(925,-2093.7231445,3598.4848633,7.1015000,0.0000000,0.0000000,0.0000000); //object(rack2)(1)
	CreateDynamicObject(930,-2140.5683594,3619.5668945,6.5581999,0.0000000,0.0000000,0.0000000); //object(o2_bottles)(2)
	CreateDynamicObject(2567,-2138.7419434,3601.5314941,7.9583998,0.0000000,0.0000000,270.0000000); //object(ab_warehouseshelf)(1)
	CreateDynamicObject(8661,-2088.9287109,3597.5061035,-4.1131001,0.0000000,90.0000000,270.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(11544,-2100.1198730,3596.2524414,6.3044000,0.0000000,0.0000000,180.0000000); //object(des_ntfrescape2)(4)
	CreateDynamicObject(8661,-2107.5417480,3597.6003418,-12.6380997,0.0000000,90.0000000,90.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(8661,-2088.8652344,3597.5878906,-4.1131001,0.0000000,90.0000000,90.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(8661,-2111.2966309,3597.5483398,-4.1131001,0.0000000,90.0000000,90.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(19364,-2102.6877441,3592.7280273,9.1265001,0.0000000,0.0000000,0.0000000); //object(wall012)(1)
	CreateDynamicObject(19364,-2102.6716309,3595.9223633,9.1265001,0.0000000,0.0000000,0.0000000); //object(wall012)(2)
	CreateDynamicObject(19364,-2102.6904297,3592.3522949,9.1265001,0.0000000,0.0000000,0.0000000); //object(wall012)(3)
	CreateDynamicObject(8661,-2087.5654297,3597.5947266,-4.1131001,0.0000000,90.0000000,90.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(8661,-2111.2897949,3597.4736328,-4.1131001,0.0000000,90.0000000,270.0000000); //object(gnhtelgrnd_lvs)(9)
	CreateDynamicObject(18715,-2074.4018555,3581.6752930,13.8257999,0.0000000,0.0000000,0.0000000); //object(prt_smoke_huge)(3)
	CreateDynamicObject(16646,-2085.1169434,3574.0551758,10.3908997,0.0000000,0.0000000,180.0000000); //object(a51_ugstore1a)(1)
	CreateDynamicObject(822,-2073.4580078,3560.7292480,3.2772000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2071.7143555,3559.3779297,3.2772000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2070.6308594,3558.6928711,3.2772000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2065.5136719,3550.7656250,3.2772000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2068.8852539,3546.9660645,2.4022000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2068.3303223,3548.5690918,2.4022000,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2066.8559570,3548.5888672,2.4022000,0.0000000,0.0000000,288.0000000); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2074.0544434,3570.5537109,0.3772000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2075.2919922,3570.3144531,0.3772000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2075.0893555,3569.0095215,0.3772000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2060.1535645,3595.6147461,2.0272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2059.6699219,3596.7175293,2.0272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2056.4194336,3594.1059570,2.0272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2055.6936035,3592.2924805,2.0272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2053.2736816,3590.9838867,3.0522001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2058.7365723,3574.0395508,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2058.8979492,3571.1132812,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2055.3688965,3571.5932617,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2061.4023438,3568.3168945,3.3022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2069.3212891,3572.5966797,1.7272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2071.2236328,3575.3872070,1.7272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2072.0559082,3573.8466797,1.7272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2072.0556641,3573.8466797,1.7272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2074.8146973,3562.7980957,1.7272000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(820,-2074.1245117,3563.8332520,-0.3299000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2075.4548340,3559.3911133,2.0701001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2057.9394531,3569.6828613,3.5201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2059.9204102,3569.9650879,3.5201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2059.3486328,3567.3332520,3.5201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2032.9106445,3578.3666992,4.5201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2033.8066406,3579.8701172,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2036.7674561,3578.9794922,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2038.3032227,3581.5576172,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2034.1855469,3581.9729004,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2034.7585449,3576.0996094,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2034.9742432,3559.3759766,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2031.8433838,3559.4938965,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2033.8580322,3559.4572754,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2036.0046387,3558.1774902,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2038.6180420,3558.6572266,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2038.6171875,3558.6572266,4.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2040.3552246,3558.4504395,2.0201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2010.5821533,3560.1855469,4.7951002,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2009.2662354,3560.4667969,4.7951002,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1985.6882324,3540.0424805,0.5451000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1984.6723633,3541.7836914,0.5451000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1984.4047852,3549.6076660,2.3201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1986.6043701,3552.2856445,2.3201001,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1982.3100586,3557.2495117,1.2701000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-1983.2124023,3555.1333008,1.2701000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2017.2657471,3598.5148926,1.2701000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2012.7375488,3596.1008301,1.2701000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2015.0291748,3596.3457031,1.2701000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2015.5040283,3600.5690918,-0.7299000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(820,-2026.5301514,3604.5908203,-0.7299000,0.0000000,0.0000000,257.9919434); //object(genveg_tallgrass04)(15)
	CreateDynamicObject(822,-2033.2110596,3582.3364258,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2040.8918457,3568.9892578,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2039.9786377,3572.1096191,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2040.8354492,3570.7563477,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2035.0595703,3577.6862793,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2035.0595703,3577.6855469,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2033.0893555,3562.1364746,4.8021998,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2030.1064453,3562.4667969,4.8021998,0.0000000,0.0000000,287.9901123); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2028.8637695,3562.6047363,3.8022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2027.9294434,3554.1542969,3.8022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2027.9287109,3554.1542969,3.8022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-1989.8251953,3551.6188965,3.8022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-1986.5319824,3552.3056641,3.8022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-1986.2065430,3540.9099121,2.8022001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-1998.0179443,3525.5759277,1.8522000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-1998.1629639,3526.9855957,1.8522000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-1998.1622314,3526.9851074,3.1772001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2012.7778320,3514.2355957,3.1772001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2011.3913574,3514.1828613,3.1772001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2011.3104248,3515.9831543,3.1772001,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2019.5520020,3549.2587891,5.3522000,0.0000000,0.0000000,287.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2020.2587891,3548.5051270,5.4271998,0.0000000,0.0000000,337.9956055); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2020.2587891,3548.5048828,5.4271998,0.0000000,0.0000000,337.9943848); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(17030,-1980.9323730,3583.7612305,-13.2425003,0.0000000,0.0000000,184.0000000); //object(cunt_rockgp2_11)(7)
	CreateDynamicObject(1437,-2139.1401367,3607.6223145,6.3541002,0.0000000,0.0000000,90.0000000); //object(dyn_ladder_2)(2)
	CreateDynamicObject(14413,-2157.1862793,3618.4409180,22.8356991,0.0000000,0.0000000,358.0000000); //object(carter-column01)(1)
	CreateDynamicObject(9583,-2072.3784180,3557.4995117,10.7379999,0.0000000,0.0000000,0.0000000); //object(freight_sfw15)(1)
	CreateDynamicObject(3630,-2097.7509766,3654.5539551,7.5247002,0.0000000,0.0000000,181.0000000); //object(crdboxes2_las)(1)
	CreateDynamicObject(7102,-2117.8796387,3690.1455078,9.4146004,0.0000000,0.0000000,0.0000000); //object(plantbox12)(1)
	CreateDynamicObject(7317,-2146.5749512,3631.5656738,12.0923996,0.0000000,0.0000000,180.0000000); //object(plantbox17)(1)
	CreateDynamicObject(19454,-2099.9045410,3592.5527344,10.1815004,0.0000000,90.0000000,90.0000000); //object(wall094)(1)
	CreateDynamicObject(19454,-2099.9028320,3595.7812500,10.1815004,0.0000000,90.0000000,90.0000000); //object(wall094)(2)
	CreateDynamicObject(8673,-2149.9985352,3586.9660645,12.5106001,0.0000000,0.0000000,359.2500000); //object(csrsfence03_lvs)(6)
	CreateDynamicObject(17031,-2007.7275391,3417.8225098,-7.1416998,0.0000000,0.0000000,308.0000000); //object(cunt_rockgp2_13)(1)
	CreateDynamicObject(17031,-2009.6585693,3467.9047852,-8.5616999,0.0000000,0.0000000,193.9962158); //object(cunt_rockgp2_13)(1)
	CreateDynamicObject(19460,-2099.9199219,3597.3911133,11.8385000,0.0000000,180.0000000,90.0000000); //object(wall100)(1)
	CreateDynamicObject(19460,-2099.9199219,3597.3798828,14.0635004,0.0000000,179.9945068,90.0000000); //object(wall100)(2)
	CreateDynamicObject(19463,-2099.9011230,3590.0827637,13.8737001,0.0000000,0.0000000,90.0000000); //object(wall103)(1)
	CreateDynamicObject(19371,-2095.2009277,3591.6843262,13.4340000,0.0000000,0.0000000,0.0000000); //object(wall019)(1)
	CreateDynamicObject(19371,-2095.1789551,3594.8564453,13.4340000,0.0000000,0.0000000,0.0000000); //object(wall019)(2)
	CreateDynamicObject(19371,-2095.1894531,3595.8898926,13.4340000,0.0000000,0.0000000,0.0000000); //object(wall019)(3)
	CreateDynamicObject(1497,-2102.6264648,3592.2495117,7.3618999,0.0000000,0.0000000,90.0000000); //object(gen_doorext02)(1)
	CreateDynamicObject(1294,-2101.4816895,3574.5681152,7.3906002,0.0000000,0.0000000,180.0000000); //object(mlamppost)(1)
	CreateDynamicObject(1294,-2101.3920898,3579.6047363,7.3906002,0.0000000,0.0000000,179.9945068); //object(mlamppost)(2)
	CreateDynamicObject(1294,-2101.3500977,3584.6147461,7.3906002,0.0000000,0.0000000,179.9945068); //object(mlamppost)(3)
	CreateDynamicObject(1294,-2101.3630371,3569.5778809,7.3906002,0.0000000,0.0000000,179.9945068); //object(mlamppost)(4)
	CreateDynamicObject(3398,-1998.2318115,3611.0639648,13.4826002,0.0000000,0.0000000,0.0000000); //object(cxrf_floodlite_)(1)
	CreateDynamicObject(3398,-2169.4033203,3651.3137207,20.2280006,0.0000000,0.0000000,90.0000000); //object(cxrf_floodlite_)(2)
	CreateDynamicObject(8674,-2091.3095703,3609.9892578,6.1065001,90.0000000,0.0000000,44.0000000); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(8674,-2107.3244629,3602.6076660,6.1065001,90.0000000,0.0000000,353.9947510); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(8674,-2109.8122559,3597.9599609,7.5064998,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(8674,-2109.8115234,3597.9599609,10.4315004,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(16662,-2108.7534180,3579.0000000,8.5956001,0.0000000,0.0000000,63.2500000); //object(a51_radar_stuff)(1)
	CreateDynamicObject(1714,-2098.1892090,3577.3623047,7.3906002,0.0000000,0.0000000,240.0000000); //object(kb_swivelchair1)(1)
	CreateDynamicObject(1714,-2096.6176758,3581.2241211,7.4155998,281.0000000,0.0000000,299.9963379); //object(kb_swivelchair1)(2)
	CreateDynamicObject(3763,-2083.7731934,3652.4453125,38.9784012,0.0000000,0.0000000,0.0000000); //object(ce_radarmast3)(1)
	CreateDynamicObject(3928,-2086.6845703,3568.7819824,17.0137005,0.0000000,0.0000000,0.0000000); //object(helipad)(1)
	CreateDynamicObject(2197,-2101.0734863,3580.8413086,7.3906002,0.0000000,0.0000000,88.0000000); //object(filling_cabinet)(1)
	CreateDynamicObject(2197,-2101.0541992,3581.6928711,7.3906002,0.0000000,0.0000000,91.9949951); //object(filling_cabinet)(2)
	CreateDynamicObject(2197,-2101.4558105,3576.8764648,7.6905999,0.0000000,270.0000000,135.9940186); //object(filling_cabinet)(3)
	CreateDynamicObject(2063,-2083.2817383,3598.5087891,7.0735002,0.0000000,0.0000000,0.0000000); //object(cj_greenshelves)(1)
	CreateDynamicObject(355,-2097.5087891,3584.8679199,8.5242996,90.0000000,0.0000000,0.0000000); //object(1)
	CreateDynamicObject(359,-2078.4848633,3588.8789062,18.7915993,90.0000000,0.0000000,64.0000000); //object(2)
	CreateDynamicObject(363,-2099.5200195,3579.8037109,8.8346004,0.0000000,0.0000000,38.0000000); //object(4)
	CreateDynamicObject(356,-2079.0151367,3563.2028809,10.1437998,90.0000000,0.0000000,38.0000000); //object(5)
	CreateDynamicObject(371,-2077.7795410,3570.8278809,11.2687998,0.0000000,0.0000000,270.0000000); //object(6)
	CreateDynamicObject(371,-2077.7792969,3570.3789062,11.2687998,0.0000000,0.0000000,270.0000000); //object(7)
	CreateDynamicObject(371,-2077.7763672,3569.4794922,11.2687998,0.0000000,0.0000000,270.0000000); //object(8)
	CreateDynamicObject(3111,-2095.3017578,3578.8176270,7.4155998,0.0000000,0.0000000,18.0000000); //object(st_arch_plan)(1)
	CreateDynamicObject(3031,-2094.0795898,3559.1477051,11.6188002,0.0000000,0.0000000,24.0000000); //object(wong_dish)(1)
	CreateDynamicObject(8400,-2124.4140625,3601.3701172,10.7329998,0.0000000,0.0000000,180.0000000); //object(nightclub02_lvs)(1)
	CreateDynamicObject(2961,-2098.4924316,3597.6352539,8.9584999,0.0000000,0.0000000,180.0000000); //object(fire_break)(1)
	CreateDynamicObject(2993,-2100.9389648,3577.6188965,8.4122000,0.0000000,0.0000000,22.0000000); //object(kmb_goflag)(1)
	CreateDynamicObject(3042,-2078.6745605,3597.5024414,13.7753000,0.0000000,0.0000000,0.0000000); //object(ct_vent)(1)
	CreateDynamicObject(3067,-2078.3090820,3578.0207520,8.0390997,0.0000000,0.0000000,271.5000000); //object(kmb_atm3)(1)
	CreateDynamicObject(3067,-2078.3730469,3579.0183105,8.0390997,0.0000000,0.0000000,311.4996338); //object(kmb_atm3)(2)
	CreateDynamicObject(3221,-2037.9461670,3574.3603516,5.9232998,0.0000000,0.0000000,0.0000000); //object(drv_in_spkrs)(1)
	CreateDynamicObject(3221,-2016.6131592,3563.2968750,5.7233000,0.0000000,0.0000000,56.0000000); //object(drv_in_spkrs)(2)
	CreateDynamicObject(3221,-2021.0434570,3596.0183105,3.6963999,0.0000000,0.0000000,10.0000000); //object(drv_in_spkrs)(3)
	CreateDynamicObject(17951,-2140.0014648,3611.4675293,7.8617001,0.0000000,0.0000000,359.5000000); //object(cjgaragedoor)(1)
	CreateDynamicObject(9958,-1958.6528320,3603.2187500,4.2771001,0.0000000,0.0000000,40.9945068); //object(submarr_sfe)(1)
	CreateDynamicObject(18980,-2064.4675293,3566.0437012,-5.1673999,0.0000000,0.0000000,0.0000000); //object(concrete1mx1mx25m)(1)
	CreateDynamicObject(18980,-2064.4494629,3568.4255371,-5.1673999,0.0000000,0.0000000,0.0000000); //object(concrete1mx1mx25m)(2)
	CreateDynamicObject(19460,-2072.8789062,3568.9328613,11.8402004,0.0000000,0.0000000,90.0000000); //object(wall091)(1)
	CreateDynamicObject(19460,-2072.8789062,3565.5488281,11.8402004,0.0000000,0.0000000,90.0000000); //object(wall091)(1)
	CreateDynamicObject(19454,-2072.9238281,3567.2556152,12.8999996,352.7999878,90.0000000,90.0000000); //object(wall101)(1)
	CreateDynamicObject(18980,-2068.5639648,3565.9599609,-2.4200001,0.0000000,0.0000000,0.0000000); //object(concrete1mx1mx25m)(5)
	CreateDynamicObject(18980,-2068.5634766,3568.5100098,-2.4200001,0.0000000,0.0000000,0.0000000); //object(concrete1mx1mx25m)(6)
	CreateDynamicObject(8674,-2073.5397949,3568.9479980,2.6073999,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(7)
	CreateDynamicObject(8674,-2073.5390625,3568.9472656,5.5324001,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(7)
	CreateDynamicObject(8674,-2073.5390625,3568.9472656,8.4574003,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(7)
	CreateDynamicObject(8674,-2073.5390625,3568.9472656,-0.2926000,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(7)
	CreateDynamicObject(19461,-2072.9658203,3567.2500000,10.0019999,0.0000000,90.0000000,270.0000000); //object(wall101)(1)
	CreateDynamicObject(1499,-2068.1447754,3566.5080566,10.0874996,0.0000000,0.0000000,90.0000000); //object(gen_doorint05)(1)
	CreateDynamicObject(19454,-2072.8889160,3567.2451172,13.6000004,0.0000000,90.0000000,90.0000000); //object(wall101)(1)
	CreateDynamicObject(3877,-2073.6274414,3588.6862793,5.6371002,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(1)
	CreateDynamicObject(3877,-2138.3898926,3552.3867188,19.5377007,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(2)
	CreateDynamicObject(3877,-2106.7185059,3596.4165039,18.2376995,270.0000000,0.0000000,50.0000000); //object(sf_rooflite)(3)
	CreateDynamicObject(3877,-2104.6162109,3551.9169922,19.5377007,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(4)
	CreateDynamicObject(3877,-2138.1223145,3596.5964355,19.5377007,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(5)
	CreateDynamicObject(19371,-2077.6062012,3567.2451172,14.1899996,90.0000000,0.0000000,0.0000000); //object(wall019)(4)
	CreateDynamicObject(1431,-2089.2373047,3537.9677734,17.5463009,0.0000000,0.0000000,0.0000000); //object(dyn_box_pile)(2)
	CreateDynamicObject(2985,-2027.7242432,3544.1215820,16.4766998,350.0000000,350.0000000,159.9938965); //object(minigun_base)(2)
	CreateDynamicObject(2907,-1981.1214600,3554.1164551,9.8209000,0.0000000,0.0000000,193.9959717); //object(kmb_deadtorso)(1)
	CreateDynamicObject(8674,-2114.4648438,3602.4873047,16.4475994,0.0000000,0.0000000,90.0000000); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(8674,-2119.6174316,3607.6420898,16.4475994,0.0000000,0.0000000,0.0000000); //object(csrsfence02_lvs)(1)
	CreateDynamicObject(822,-2012.8640137,3558.5603027,5.9271998,0.0000000,0.0000000,287.9901123); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2010.1428223,3562.2583008,4.9022002,0.0000000,0.0000000,287.9901123); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(822,-2008.7552490,3560.0583496,5.1522002,0.0000000,0.0000000,287.9901123); //object(genveg_tallgrass06)(36)
	CreateDynamicObject(17076,-2007.7590332,3514.6828613,-5.1166000,0.0000000,0.0000000,219.9981689); //object(cunt_rockgp2_26)(1)

	//prison
	CreateDynamicObject(18310, 3510.38, -2045.51, -29.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(18309, 3333.14, -2003.14, -6.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(18630, 3334.92, -2003.50, -7.13,   -0.18, 0.00, -1.38);
	CreateDynamicObject(18317, 3328.45, -2232.29, -44.08,   0.00, 0.00, 0.00);
	CreateDynamicObject(18319, 3520.12, -2235.39, -65.97,   0.00, 0.00, 0.00);
	CreateDynamicObject(10381, 3440.82, -2108.51, 47.26,   0.00, 0.00, 117.22);
	CreateDynamicObject(7950, 3517.85, -2195.40, 25.61,   0.00, 0.00, 277.26);
	CreateDynamicObject(18850, 3429.35, -2177.56, 28.00,   0.00, 0.00, 116.00);
	CreateDynamicObject(8613, 3445.56, -2164.08, 36.61,   0.00, 0.00, 116.34);
	CreateDynamicObject(615, 3433.86, -2146.28, 31.01,   0.00, 0.00, -126.90);
	CreateDynamicObject(615, 3476.18, -2113.04, 31.87,   0.00, 0.00, -174.42);
	CreateDynamicObject(987, 3479.67, -2223.70, 11.22,   0.00, -20.00, 438.90);
	CreateDynamicObject(987, 3481.78, -2212.39, 15.42,   0.00, -23.00, 441.54);
	CreateDynamicObject(987, 3483.08, -2201.70, 20.00,   -5.00, -20.00, 462.90);
	CreateDynamicObject(987, 3480.22, -2191.15, 23.99,   -5.00, -17.00, 466.20);
	CreateDynamicObject(987, 3476.72, -2180.31, 27.46,   -3.00, -17.00, 460.62);
	CreateDynamicObject(987, 3472.83, -2117.70, 34.46,   0.00, 0.00, 454.68);
	CreateDynamicObject(987, 3470.04, -2129.11, 34.05,   0.00, -2.00, 436.26);
	CreateDynamicObject(987, 3467.21, -2140.70, 33.63,   0.00, -2.00, 436.26);
	CreateDynamicObject(987, 3466.95, -2152.77, 33.63,   0.00, 0.00, 448.86);
	CreateDynamicObject(987, 3447.46, -2156.41, 32.55,   0.00, -3.00, 2.52);
	CreateDynamicObject(987, 3420.56, -2131.16, 33.54,   0.00, 2.00, -31.62);
	CreateDynamicObject(987, 3443.61, -2144.95, 32.70,   3.00, 1.00, -71.04);
	CreateDynamicObject(987, 3433.02, -2151.29, 32.96,   0.00, 1.00, 31.38);
	CreateDynamicObject(987, 3430.94, -2137.50, 33.13,   0.00, 1.00, -90.48);
	CreateDynamicObject(987, 3476.22, -2210.53, 15.39,   0.00, 20.00, 616.14);
	CreateDynamicObject(987, 3478.07, -2199.65, 20.06,   0.00, 23.00, 619.62);
	CreateDynamicObject(987, 3474.88, -2188.93, 24.08,   10.00, 20.00, 643.14);
	CreateDynamicObject(987, 3470.70, -2178.47, 27.50,   10.00, 17.00, 648.12);
	CreateDynamicObject(987, 3466.99, -2167.72, 30.92,   8.00, 17.00, 285.96);
	CreateDynamicObject(987, 3457.36, -2175.17, 28.45,   15.00, -10.00, 762.24);
	CreateDynamicObject(987, 3448.97, -2167.49, 30.38,   0.00, 10.00, 673.20);
	CreateDynamicObject(987, 3430.64, -2149.28, 32.94,   0.00, 3.00, 674.46);
	CreateDynamicObject(987, 3438.81, -2157.95, 32.20,   0.00, 3.00, 674.94);
	CreateDynamicObject(11461, 3494.72, -2162.93, 31.31,   0.00, 0.00, 0.00);
	CreateDynamicObject(3279, 3442.06, -2152.64, 33.10,   0.00, 0.00, -49.74);
	CreateDynamicObject(3279, 3473.51, -2151.26, 32.54,   0.00, 0.00, -34.92);
	CreateDynamicObject(6417, 3472.82, -2300.03, -14.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(9958, 3543.70, -2213.41, 6.50,   0.00, 0.00, 0.00);
	CreateDynamicObject(19454, 3431.26, -2089.91, 35.40,   0.00, 0.00, -63.00);
	CreateDynamicObject(987, 3460.00, -2082.26, 34.20,   0.00, 0.00, -244.44);
	CreateDynamicObject(987, 3454.85, -2071.84, 34.12,   0.00, 3.00, -244.44);
	CreateDynamicObject(987, 3449.69, -2061.34, 33.44,   0.00, 5.00, -244.44);
	CreateDynamicObject(987, 3444.60, -2050.60, 32.38,   0.00, -3.00, -206.28);
	CreateDynamicObject(987, 3433.88, -2045.44, 32.99,   0.00, -3.00, -178.20);
	CreateDynamicObject(987, 3422.29, -2045.82, 33.62,   0.00, 0.00, -115.26);
	CreateDynamicObject(987, 3417.19, -2056.60, 33.62,   0.00, 0.00, -115.26);
	CreateDynamicObject(987, 3412.06, -2067.40, 33.62,   0.00, 0.00, -115.26);
	CreateDynamicObject(987, 3406.96, -2078.21, 33.62,   0.00, 0.00, -97.62);
	CreateDynamicObject(987, 3405.38, -2090.03, 33.62,   0.00, 0.00, -97.62);
	CreateDynamicObject(987, 3403.77, -2101.84, 33.62,   0.00, 0.00, -54.78);
	CreateDynamicObject(3279, 3462.22, -2074.22, 32.69,   0.00, 0.00, -59.10);
	CreateDynamicObject(3279, 3401.76, -2107.45, 34.64,   0.00, 0.00, 124.32);
	CreateDynamicObject(3279, 3410.39, -2048.75, 36.67,   0.00, 0.00, -23.10);
	CreateDynamicObject(7092, 3461.45, -2112.46, 54.97,   0.00, 0.00, 117.10);
	CreateDynamicObject(16093, 3475.98, -2165.04, 35.00,   0.00, 0.00, 286.14);
	CreateDynamicObject(987, 3475.90, -2159.08, 31.45,   0.00, -10.00, 505.74);
	CreateDynamicObject(16638, 3475.13, -2165.33, 33.25,   0.00, 0.00, -74.08);
	CreateDynamicObject(946, 3430.71, -2089.05, 37.03,   0.00, 0.00, 27.00);
	CreateDynamicObject(946, 3422.45, -2072.65, 37.04,   0.00, 0.00, -153.00);
	CreateDynamicObject(615, 3464.10, -2177.35, 25.81,   0.00, 0.00, -126.90);
	CreateDynamicObject(615, 3478.12, -2232.05, 5.94,   0.00, 0.00, -126.90);
	CreateDynamicObject(3257, 3399.98, -2137.55, 34.81,   0.00, 0.00, 0.00);
	CreateDynamicObject(19124, 3459.36, -2156.42, 34.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(19124, 3466.78, -2153.21, 34.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(19124, 3419.96, -2133.86, 56.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(19124, 3406.95, -2108.70, 56.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(19124, 3460.48, -2080.88, 56.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(19124, 3473.48, -2106.11, 56.79,   0.00, 0.00, 0.00);
	CreateDynamicObject(3864, 3411.60, -2059.45, 40.60,   0.00, 0.00, 159.12);
	CreateDynamicObject(3864, 3404.32, -2079.37, 40.60,   0.00, 0.00, 173.46);
	CreateDynamicObject(3864, 3455.15, -2063.27, 37.92,   0.00, 0.00, 29.76);
	CreateDynamicObject(3864, 3433.48, -2041.89, 37.08,   0.00, 0.00, 83.22);
	CreateDynamicObject(16335, 3346.12, -2086.57, 56.32,   0.00, 0.00, -60.84);
	CreateDynamicObject(1280, 3430.29, -2090.98, 36.84,   0.00, 0.00, 118.44);
	CreateDynamicObject(1280, 3432.72, -2089.71, 36.84,   0.00, 0.00, 116.52);
	CreateDynamicObject(5154, 3426.62, -2080.86, 31.70,   0.00, 0.00, 27.00);
	CreateDynamicObject(3819, 3438.42, -2079.37, 35.79,   0.00, 0.00, 27.00);
	CreateDynamicObject(3819, 3434.52, -2071.69, 35.77,   0.00, 0.00, 27.00);
	CreateDynamicObject(615, 3425.89, -2058.85, 32.20,   0.00, 0.00, -174.42);
	CreateDynamicObject(1985, 3450.16, -2086.48, 38.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(2388, 3450.71, -2087.08, 38.22,   -90.00, -27.00, 0.00);
	CreateDynamicObject(2388, 3449.18, -2087.88, 38.22,   -90.00, -27.00, 0.00);
	CreateDynamicObject(1985, 3448.66, -2087.35, 38.47,   0.00, 0.00, 0.00);
	CreateDynamicObject(2628, 3453.22, -2082.76, 34.96,   0.00, 0.00, -66.18);
	CreateDynamicObject(2628, 3454.48, -2082.18, 34.98,   0.00, 0.00, -243.78);
	CreateDynamicObject(2629, 3451.61, -2085.08, 34.93,   0.00, 0.00, -154.00);
	CreateDynamicObject(2629, 3446.66, -2087.53, 34.93,   0.00, 0.00, -154.00);
	CreateDynamicObject(2916, 3453.88, -2085.19, 35.05,   0.00, 0.00, 25.20);
	CreateDynamicObject(2916, 3454.25, -2084.98, 35.05,   0.00, 0.00, 57.96);
	CreateDynamicObject(2916, 3453.52, -2085.37, 35.05,   0.00, 0.00, 25.20);
	CreateDynamicObject(2916, 3453.84, -2084.81, 35.05,   0.00, 0.00, 25.20);
	CreateDynamicObject(2916, 3453.43, -2084.99, 35.05,   0.00, 0.00, 25.20);
	CreateDynamicObject(2916, 3453.18, -2085.32, 35.05,   0.00, 0.00, 101.82);
	CreateDynamicObject(2913, 3452.25, -2085.35, 35.78,   0.00, -90.00, 26.00);
	CreateDynamicObject(2913, 3447.30, -2087.82, 35.78,   0.00, -90.00, 26.00);
	CreateDynamicObject(2913, 3448.26, -2082.68, 35.09,   0.00, -90.00, 85.52);
	CreateDynamicObject(948, 3435.77, -2094.34, 36.51,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 3432.10, -2096.16, 36.51,   0.00, 0.00, 0.00);
	CreateDynamicObject(1432, 3439.50, -2062.37, 34.88,   0.00, 0.00, 0.00);
	CreateDynamicObject(14791, 3413.71, -2097.95, 36.69,   0.00, 0.00, 27.00);
	CreateDynamicObject(1432, 3443.73, -2066.45, 34.88,   0.00, 0.00, 0.00);
	CreateDynamicObject(1432, 3439.53, -2067.14, 34.88,   0.00, 0.00, 0.00);
	CreateDynamicObject(3620, 3486.78, -2252.74, 15.60,   0.00, 0.00, 46.32);
	CreateDynamicObject(3258, 3397.80, -2147.39, 35.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(3282, 3513.79, -2176.97, 31.91,   0.00, 0.00, -46.08);
	CreateDynamicObject(3282, 3506.06, -2168.99, 31.91,   0.00, 0.00, -46.08);
	CreateDynamicObject(3282, 3498.54, -2161.18, 31.91,   0.00, 0.00, -46.08);
	CreateDynamicObject(3282, 3483.70, -2155.11, 32.07,   0.00, 5.00, -46.08);
	CreateDynamicObject(3282, 3475.23, -2139.88, 33.50,   0.00, 2.00, -98.76);
	CreateDynamicObject(3282, 3476.67, -2128.94, 33.78,   0.00, 2.00, -97.08);
	CreateDynamicObject(3282, 3479.79, -2096.58, 33.69,   0.00, -3.00, -94.44);
	CreateDynamicObject(3282, 3466.76, -2060.72, 30.20,   0.00, -3.00, -48.72);


	ArmyGate = CreateDynamicObject(987,-1536.9000244,482.2000122,6.1999998,0.0000000,0.0000000,0.0000000); //object(elecfence_bar) (1)

	Cones[0] = CreateDynamicObject(1238, -2053.74, -136.40, 34.64,   0.00, 0.00, 0.00);
	Cones[1] = CreateDynamicObject(1238, -2047.57, -136.22, 34.64,   0.00, 0.00, 0.00);
	Cones[2] = CreateDynamicObject(1238, -2047.68, -142.15, 34.64,   0.00, 0.00, 0.00);
	Cones[3] = CreateDynamicObject(1238, -2054.59, -141.71, 34.64,   0.00, 0.00, 0.00);
	Cones[4] = CreateDynamicObject(1238, -2049.51, -146.42, 34.64,   0.00, 0.00, 0.00);
	Cones[5] = CreateDynamicObject(1238, -2056.74, -143.60, 34.64,   0.00, 0.00, 0.00);
	Cones[6] = CreateDynamicObject(1238, -2060.01, -144.74, 34.64,   0.00, 0.00, 0.00);
	Cones[7] = CreateDynamicObject(1238, -2053.88, -148.11, 34.64,   0.00, 0.00, 0.00);
	Cones[8] = CreateDynamicObject(1238, -2058.04, -148.73, 34.64,   0.00, 0.00, 0.00);
	Cones[9] = CreateDynamicObject(1238, -2064.75, -147.48, 34.64,   0.00, 0.00, 0.00);
	Cones[10] = CreateDynamicObject(1238, -2060.98, -150.66, 34.64,   0.00, 0.00, 0.00);
	Cones[11] = CreateDynamicObject(1238, -2061.10, -153.60, 34.64,   0.00, 0.00, 0.00);
	Cones[12] = CreateDynamicObject(1238, -2066.99, -151.71, 34.64,   0.00, 0.00, 0.00);
	Cones[13] = CreateDynamicObject(1238, -2061.14, -157.28, 34.64,   0.00, 0.00, 0.00);
	Cones[14] = CreateDynamicObject(1238, -2067.82, -157.28, 34.64,   0.00, 0.00, 0.00);
	Cones[15] = CreateDynamicObject(1238, -2061.05, -159.80, 34.64,   0.00, 0.00, 0.00);
	Cones[16] = CreateDynamicObject(1238, -2066.84, -160.98, 34.64,   0.00, 0.00, 0.00);
	Cones[17] = CreateDynamicObject(1238, -2064.20, -163.79, 34.64,   0.00, 0.00, 0.00);
	Cones[18] = CreateDynamicObject(1238, -2058.75, -161.55, 34.64,   0.00, 0.00, 0.00);
	Cones[19] = CreateDynamicObject(1238, -2060.30, -165.66, 34.64,   0.00, 0.00, 0.00);
	Cones[20] = CreateDynamicObject(1238, -2055.11, -162.48, 34.64,   0.00, 0.00, 0.00);
	Cones[21] = CreateDynamicObject(1238, -2056.53, -166.55, 34.64,   0.00, 0.00, 0.00);
	Cones[22] = CreateDynamicObject(1238, -2052.15, -166.32, 34.64,   0.00, 0.00, 0.00);
	Cones[23] = CreateDynamicObject(1238, -2052.86, -161.11, 34.64,   0.00, 0.00, 0.00);
	Cones[24] = CreateDynamicObject(1238, -2048.63, -164.05, 34.64,   0.00, 0.00, 0.00);
	Cones[25] = CreateDynamicObject(1238, -2051.36, -157.77, 34.64,   0.00, 0.00, 0.00);
	Cones[26] = CreateDynamicObject(1238, -2046.04, -160.46, 34.64,   0.00, 0.00, 0.00);
	Cones[27] = CreateDynamicObject(1238, -2048.64, -154.61, 34.64,   0.00, 0.00, 0.00);
	Cones[28] = CreateDynamicObject(1238, -2043.91, -157.17, 34.64,   0.00, 0.00, 0.00);
	Cones[29] = CreateDynamicObject(1238, -2044.34, -151.58, 34.64,   0.00, 0.00, 0.00);
	Cones[30] = CreateDynamicObject(1238, -2040.86, -155.18, 34.64,   0.00, 0.00, 0.00);
	Cones[31] = CreateDynamicObject(1238, -2039.57, -149.56, 34.64,   0.00, 0.00, 0.00);
	Cones[32] = CreateDynamicObject(1238, -2038.18, -156.20, 34.64,   0.00, 0.00, 0.00);
	Cones[33] = CreateDynamicObject(1238, -2034.97, -151.93, 34.64,   0.00, 0.00, 0.00);
	Cones[34] = CreateDynamicObject(1238, -2034.97, -151.93, 34.64,   0.00, 0.00, 0.00);
	Cones[35] = CreateDynamicObject(1238, -2032.77, -156.18, 34.64,   0.00, 0.00, 0.00);
	Cones[36] = CreateDynamicObject(1238, -2037.02, -158.99, 34.64,   0.00, 0.00, 0.00);
	Cones[37] = CreateDynamicObject(1238, -2032.44, -160.37, 34.64,   0.00, 0.00, 0.00);
	Cones[38] = CreateDynamicObject(1238, -2037.13, -161.51, 34.64,   0.00, 0.00, 0.00);
	Cones[39] = CreateDynamicObject(1238, -2037.35, -164.67, 34.64,   0.00, 0.00, 0.00);
	Cones[40] = CreateDynamicObject(1238, -2032.18, -164.29, 34.64,   0.00, 0.00, 0.00);
	Cones[41] = CreateDynamicObject(1238, -2032.24, -168.02, 34.64,   0.00, 0.00, 0.00);
	Cones[42] = CreateDynamicObject(1238, -2036.97, -168.30, 34.64,   0.00, 0.00, 0.00);
	Cones[43] = CreateDynamicObject(1238, -2036.65, -171.41, 34.64,   0.00, 0.00, 0.00);
	Cones[44] = CreateDynamicObject(1238, -2031.88, -171.54, 34.64,   0.00, 0.00, 0.00);
	Cones[45] = CreateDynamicObject(1238, -2031.74, -175.86, 34.64,   0.00, 0.00, 0.00);
	Cones[46] = CreateDynamicObject(1238, -2036.84, -175.52, 34.64,   0.00, 0.00, 0.00);
	Cones[47] = CreateDynamicObject(1238, -2039.52, -177.54, 34.64,   0.00, 0.00, 0.00);
	Cones[48] = CreateDynamicObject(1238, -2028.89, -178.33, 34.64,   0.00, 0.00, 0.00);
	Cones[49] = CreateDynamicObject(1238, -2026.20, -181.07, 34.64,   0.00, 0.00, 0.00);
	Cones[50] = CreateDynamicObject(1238, -2042.12, -180.71, 34.64,   0.00, 0.00, 0.00);
	Cones[51] = CreateDynamicObject(1238, -2034.25, -182.68, 34.64,   0.00, 0.00, 0.00);
	Cones[52] = CreateDynamicObject(1238, -2042.76, -186.21, 34.64,   0.00, 0.00, 0.00);
	Cones[53] = CreateDynamicObject(1238, -2039.63, -190.42, 34.64,   0.00, 0.00, 0.00);
	Cones[54] = CreateDynamicObject(1238, -2026.45, -186.93, 34.64,   0.00, 0.00, 0.00);
	Cones[55] = CreateDynamicObject(1238, -2029.74, -190.94, 34.64,   0.00, 0.00, 0.00);
	Cones[56] = CreateDynamicObject(1238, -2029.74, -190.94, 34.64,   0.00, 0.00, 0.00);
	Cones[57] = CreateDynamicObject(1238, -2032.53, -193.50, 34.64,   0.00, 0.00, 0.00);
	Cones[58] = CreateDynamicObject(1238, -2038.00, -193.36, 34.64,   0.00, 0.00, 0.00);
	Cones[59] = CreateDynamicObject(1238, -2038.51, -200.12, 34.64,   0.00, 0.00, 0.00);
	Cones[60] = CreateDynamicObject(1238, -2031.88, -200.47, 34.64,   0.00, 0.00, 0.00);
	Cones[61] = CreateDynamicObject(1238, -2032.13, -206.85, 34.64,   0.00, 0.00, 0.00);
	Cones[62] = CreateDynamicObject(1238, -2038.15, -206.77, 34.64,   0.00, 0.00, 0.00);
	Cones[63] = CreateDynamicObject(1660, -2035.25, -226.13, 34.06,   0.00, 0.00, 0.00);
	Cones[64] = CreateDynamicObject(1238, -2038.15, -206.77, 34.64,   0.00, 0.00, 0.00);
	Cones[65] = CreateDynamicObject(1238, -2038.89, -228.74, 34.64,   0.00, 0.00, 0.00);
	Cones[66] = CreateDynamicObject(1238, -2031.61, -229.46, 34.64,   0.00, 0.00, 0.00);
	Cones[67] = CreateDynamicObject(1238, -2038.88, -234.08, 34.64,   0.00, 0.00, 0.00);
	Cones[68] = CreateDynamicObject(1238, -2031.85, -234.53, 34.64,   0.00, 0.00, 0.00);
	Cones[69] = CreateDynamicObject(1238, -2038.76, -239.01, 34.64,   0.00, 0.00, 0.00);
	Cones[70] = CreateDynamicObject(1238, -2032.18, -239.79, 34.64,   0.00, 0.00, 0.00);
	Cones[71] = CreateDynamicObject(1238, -2040.03, -253.75, 34.64,   0.00, 0.00, 0.00);
	Cones[72] = CreateDynamicObject(1238, -2039.43, -242.33, 34.64,   0.00, 0.00, 0.00);
	Cones[73] = CreateDynamicObject(1238, -2031.65, -242.55, 34.64,   0.00, 0.00, 0.00);
	Cones[74] = CreateDynamicObject(1238, -2029.09, -245.39, 34.64,   0.00, 0.00, 0.00);
	Cones[75] = CreateDynamicObject(1238, -2042.90, -245.56, 34.64,   0.00, 0.00, 0.00);
	Cones[76] = CreateDynamicObject(1238, -2031.58, -254.53, 34.64,   0.00, 0.00, 0.00);
	Cones[77] = CreateDynamicObject(1238, -2043.83, -250.92, 34.64,   0.00, 0.00, 0.00);
	Cones[78] = CreateDynamicObject(1238, -2036.14, -248.81, 34.64,   0.00, 0.00, 0.00);
	Cones[79] = CreateDynamicObject(1238, -2028.40, -250.44, 34.64,   0.00, 0.00, 0.00);
	Cones[80] = CreateDynamicObject(1238, -2036.02, -254.95, 34.64,   0.00, 0.00, 0.00);
    printf("Objects: %d", CountDynamicObjects());
    
    #if defined __DEBUG
   
    format(debug_String, 128, "OnGameModeInit() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnGameModeInit()", debug_String);

    #endif

    SendDebugMessage("OnGameModeInit()", "OnGameModeInit End");
	return 1;
}
