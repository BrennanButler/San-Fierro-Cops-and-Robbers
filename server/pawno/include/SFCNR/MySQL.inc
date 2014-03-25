public Mysql_Register(playerid, password[])
{
	SendDebugMessage("Mysql_Register()", "Mysql_Register Start");

	timing[0] = GetTickCount();

	format(PlayerInfo[playerid][Ppassword], 24, password);
	mysql_real_escape_string(PlayerName(playerid), PlayerName(playerid), Gconnection);

	new HashedPass[429], salt[100];
	new Year, Month, Day;
	getdate(Year, Month, Day);
	RandomString(salt, 100);
	mysql_real_escape_string(password, password, Gconnection);

    format(HashedPass, 429, "%s%s", salt, password);
	for(new i = 0; i < 50; i++)
		WP_Hash(HashedPass, 129, HashedPass);



	new Query[600];
	format(Query, 600, "INSERT INTO `users` (username, password, regdate, salt) VALUES ('%s', '%s', '%02d/%02d/%d', '%s')", PlayerName(playerid), HashedPass, Day, Month, Year, salt);

	mysql_function_query(Gconnection, Query, true, "OnPlayerRegister", "d", playerid);

	#if defined __DEBUG
   
    format(debug_String, 128, "Mysql_Register() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("Mysql_Register()", debug_String);

    #endif

	SendDebugMessage("Mysql_Register()", "Mysql_Register End");
	return 1;
}

public Mysql_Login(playerid, password[])
{
	SendDebugMessage("Mysql_Login()", "Mysql_Login Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);
	if(rows) {
		new HashedPass[429], temp[100], Query[600];
		mysql_real_escape_string(PlayerName(playerid), PlayerName(playerid), Gconnection);
		cache_get_field_content(0, "salt", temp);

		format(HashedPass, 429, "%s%s", temp, password);

        for(new i = 0; i < 50; i++)
			WP_Hash(HashedPass, 500, HashedPass);

		format(Query, 600, "SELECT `score` FROM `users` WHERE `username`='%s' AND `password`='%s'", PlayerName(playerid), HashedPass);
		mysql_function_query(Gconnection, Query, true, "OnPlayerRequestLogin", "d", playerid);
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "Mysql_Login() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("Mysql_Login()", debug_String);

    #endif

	SendDebugMessage("Mysql_Login()", "Mysql_Login End");
	return 1;
}

public OnPlayerRequestLogin(playerid)
{
	SendDebugMessage("OnPlayerRequestLogin()", "OnPlayerRequestLogin Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows) {
	    new Query[500];
		format(Query, 500, "SELECT * FROM `users` WHERE `username`='%s'", PlayerName(playerid));
		mysql_function_query(Gconnection, Query, true, "OnPlayerLogin", "d", playerid);
		SendClientMessage(playerid, COLOR_GREEN, "Logged in!");
		PlayerVariables[playerid] |= PLAYER_IS_REGISTERED;
		PlayerVariables[playerid] |= PLAYER_LOGGED_IN;

	} else {
	    MaxPassAttempts[playerid]++;
	    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Wrong password!");
	    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");
	    if(MaxPassAttempts[playerid] == 4) {
			format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF}%s has been kicked for max password attempts.", PlayerName(playerid));
			SendClientMessageToAll(COLOR_RED2, G_String);
			PlayerVariables[playerid] |= PLAYER_KICKED;
			Kick(playerid);
	    }
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerRequestLogin() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerRequestLogin()", debug_String);

    #endif

	SendDebugMessage("OnPlayerRequestLogin()", "OnPlayerRequestLogin End");
	return 1;
}

public OnPlayerLogin(playerid)
{
	SendDebugMessage("OnPlayerLogin()", "OnPlayerLogin Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);
	if(rows) {

	    new temp[12];
	    cache_get_row(0, 2, temp); SetPlayerScore(playerid, strval(temp));
	    cache_get_row(0, 3, temp); GivePlayerMoney(playerid, strval(temp));
	    cache_get_row(0, 4, temp); PlayerInfo[playerid][Pbank] = strval(temp);
	    cache_get_row(0, 5, temp); PlayerInfo[playerid][Pstat] = strval(temp);
	    cache_get_row(0, 6, temp); PlayerInfo[playerid][Parmy] = strval(temp);
	    cache_get_row(0, 7, temp); PlayerInfo[playerid][Pswat] = strval(temp);
	    cache_get_row(0, 8, temp); PlayerInfo[playerid][Padmin] = strval(temp);
        cache_get_row(0, 9, temp); PlayerInfo[playerid][Pcop] = strval(temp);
        cache_get_row(0, 10, temp); PlayerInfo[playerid][Pscore] = strval(temp);
        cache_get_row(0, 12, temp); PlayerInfo[playerid][Pprison] = strval(temp);
        cache_get_row(0, 13, temp); PlayerInfo[playerid][Pvip] = strval(temp);
        cache_get_row(0, 14, temp); PlayerInfo[playerid][Parrest] = strval(temp);
        cache_get_row(0, 15, temp); PlayerInfo[playerid][Psurender] = strval(temp);
        cache_get_row(0, 16, temp); PlayerInfo[playerid][Prob] = strval(temp);
        cache_get_row(0, 17, temp); PlayerInfo[playerid][Prape] = strval(temp);
        cache_get_row(0, 18, temp); PlayerInfo[playerid][Pheal] = strval(temp);
        cache_get_row(0, 19, temp); PlayerInfo[playerid][Phitman] = strval(temp);
        cache_get_row(0, 20, temp); PlayerInfo[playerid][Psales] = strval(temp);
        cache_get_row(0, 21, temp); PlayerInfo[playerid][Pwep] = strval(temp);
        cache_get_row(0, 22, temp); PlayerInfo[playerid][Pdrug] = strval(temp);
        cache_get_row(0, 23, temp); PlayerInfo[playerid][Ptaze] = strval(temp);
        cache_get_row(0, 24, temp); PlayerInfo[playerid][Ptruck] = strval(temp);
        cache_get_row(0, 25, temp); format(PlayerInfo[playerid][STD], 100, temp);
        cache_get_row(0, 26, temp); PlayerInfo[playerid][PrisonTime] = strval(temp);
        cache_get_row(0, 27, temp); PlayerInfo[playerid][Mayor] = !!strval(temp);
        cache_get_row(0, 28, temp); PlayerInfo[playerid][PTERRORIST] = strval(temp);
		cache_get_row(0, 29, temp); PlayerInfo[playerid][Pfix] = strval(temp);
		cache_get_row(0, 30, temp); PlayerInfo[playerid][Pkidnapper] = strval(temp);
		cache_get_row(0, 31, temp); PlayerInfo[playerid][Ppedo] = strval(temp);
		cache_get_row(0, 32, temp); PlayerInfo[playerid][Ptaxi] = strval(temp);
        cache_get_row(0, 33, temp); PlayerInfo[playerid][Ppilot] = strval(temp);
		cache_get_row(0, 34, temp); PlayerInfo[playerid][Ppizza] = strval(temp);
		cache_get_row(0, 35, temp); PlayerInfo[playerid][Pfarmer] = strval(temp);
		cache_get_row(0, 36, temp); PlayerInfo[playerid][Pminer] = strval(temp);

		format(PlayerInfo[playerid][STD], 100, "%s", "Aids");

		new Query[300];
		format(Query, 300, "SELECT * FROM `vehicle` WHERE `owner`='%s'", PlayerName(playerid));
		mysql_function_query(Gconnection, Query, true, "OnServerLoadVehicles", "i", playerid);
		format(Query, 300, "SELECT * FROM `attachedobject` WHERE `username`='%s'", PlayerName(playerid));
        mysql_function_query(Gconnection, Query, true, "OnServerLoadClothing", "i", playerid);

	} else {
	    printf("Oops something went wrong! callback: OnPlayerLogin Player: %s Rows: %d", PlayerName(playerid), rows);
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerLogin() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerLogin()", debug_String);

    #endif

	SendDebugMessage("OnPlayerLogin()", "OnPlayerLogin End");
	return 1;
}

public OnServerLoadVehicles(playerid)
{
	SendDebugMessage("OnServerLoadVehicles()", "OnServerLoadVehicles Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows) {

	    for(new i =0; i < rows; i++) {
            new temp[100], ID = GetVehID(), X[50], Y[50], Z[50], R[50], H[50];
            cache_get_row(i, 0, temp); VehicleInfo[ID][SQLID] = strval(temp);
           	format(VehicleInfo[ID][Owner], 24, "%s", PlayerName(playerid));
            cache_get_row(i, 2, temp); VehicleInfo[ID][model] = strval(temp);
            cache_get_row(i, 3, temp); format(VehicleInfo[ID][VehName], 100, temp);
            cache_get_row(i, 4, temp); format(VehicleInfo[ID][NumberPlate], 32, temp);
            cache_get_row(i, 5, X);
            cache_get_row(i, 6, Y);
            cache_get_row(i, 7, Z);
            cache_get_row(i, 8, R);
            cache_get_row(i, 9, temp); VehicleInfo[ID][value] = strval(temp);
            cache_get_row(i, 10, temp); VehicleInfo[ID][PannelDamage] = strval(temp);
            cache_get_row(i, 11, temp); VehicleInfo[ID][DoorDamage] = strval(temp);
            cache_get_row(i, 12, temp); VehicleInfo[ID][LightDamage] = strval(temp);
            cache_get_row(i, 13, temp); VehicleInfo[ID][TireDamage] = strval(temp);
            cache_get_row(i, 14, H);
            cache_get_row(i, 15, temp); VehicleInfo[ID][Vcolor1] = strval(temp);
            cache_get_row(i, 16, temp); VehicleInfo[ID][Vcolor2] = strval(temp);
            printf("Owner : %s", VehicleInfo[ID][Owner]);
            VehicleInfo[ID][VID] = CreateVehicle(VehicleInfo[ID][model], floatstr(X), floatstr(Y), floatstr(Z), floatstr(R), VehicleInfo[ID][Vcolor1], VehicleInfo[ID][Vcolor2], -1);
            SetVehicleHealth(VehicleInfo[ID][VID], strval(H));
            UpdateVehicleDamageStatus(VehicleInfo[ID][VID], VehicleInfo[ID][PannelDamage], VehicleInfo[ID][DoorDamage], VehicleInfo[ID][LightDamage], VehicleInfo[ID][TireDamage]);
		}

	} else {
	    printf("no vehicles found.");
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnServerLoadVehicles() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnServerLoadVehicles()", debug_String);

    #endif

	SendDebugMessage("OnServerLoadVehicles()", "OnServerLoadVehicles End");

	return 1;
}


public OnServerLoadClothing(playerid)
{
	SendDebugMessage("OnServerLoadClothing()", "OnServerLoadClothing Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows) {

	    for(new i = 0; i < rows; i++) {

	    	new temp[100];

	    	cache_get_row(i, 1, temp);
	    	ao[playerid][i][amodel] = strval(temp);
			printf("temp = %d", strval(temp));
	    	cache_get_row(i, 2, temp);
	    	ao[playerid][i][abone] = strval(temp);
	    	printf("temp = %d", strval(temp));
	    	cache_get_row(i, 3, temp);
	    	ao[playerid][i][ax] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 4, temp);
	    	ao[playerid][i][ay] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 5, temp);
	    	ao[playerid][i][az] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 6, temp);
	    	ao[playerid][i][arx] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 7, temp);
	    	ao[playerid][i][ary] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 8, temp);
	    	ao[playerid][i][arz] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 9, temp);
	    	ao[playerid][i][asx] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 10, temp);
	    	ao[playerid][i][asy] = floatstr(temp);
	    	printf("temp = %f", floatstr(temp));
	    	cache_get_row(i, 11, temp);
	    	ao[playerid][i][asz] = floatstr(temp);

	    	printf("for(i) = %d", i);
	    	printf("MAX_PLAYER_ATTACHED_OBJECTS = %d", MAX_PLAYER_ATTACHED_OBJECTS);
	    	printf("temp = %f", floatstr(temp));
	    	Aindex[playerid] = i+1;
		}

	} else {
	    printf("no clothing found.");
	    
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnServerLoadClothing() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnServerLoadClothing()", debug_String);

    #endif

	SendDebugMessage("OnServerLoadClothing()", "OnServerLoadClothing End");

	return 1;
}

public OnPlayerStartSweeperJob(playerid) 
{
	SendDebugMessage("OnPlayerStartSweeperJob()", "OnPlayerStartSweeperJob Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);
	TotalSweeps = 0;
	if(rows) {

			for(new i = 0; i < rows; i++) {

				new temp[60], ID = SweeperID();
				cache_get_row(i, 0, temp); SweeperInfo[ID][Weight] = floatstr(temp);
				cache_get_row(i, 1, temp); SweeperInfo[ID][Xpos] = floatstr(temp);
				cache_get_row(i, 2, temp); SweeperInfo[ID][Ypos] = floatstr(temp);
				cache_get_row(i, 3, temp); SweeperInfo[ID][Zpos] = floatstr(temp);
				SweeperInfo[ID][Obj] = CreateDynamicObject(854, SweeperInfo[ID][Xpos], SweeperInfo[ID][Ypos], SweeperInfo[ID][Zpos], 0.0, 0.0, 0.0, -1, -1, playerid);
				SweepCreated[ID] = true;
				TotalSweeps++;
				SweeperInfo[ID][Player] = playerid;
				SweeperInfo[ID][MapIcon] = CreateDynamicMapIcon(SweeperInfo[ID][Xpos], SweeperInfo[ID][Ypos], SweeperInfo[ID][Zpos], 0, COLOR_YELLOW, -1, -1, playerid);
			}
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerStartSweeperJob() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerStartSweeperJob()", debug_String);

    #endif

	SendDebugMessage("OnPlayerStartSweeperJob()", "OnPlayerStartSweeperJob End");

	return 1;
}


public OnPlayerRegister(playerid)
{
	SendDebugMessage("OnPlayerRegister()", "OnPlayerRegister Start");

	timing[0] = GetTickCount();

	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Thanks for registering at our server! Please use /commands and /help for any help you need");
	PlayerVariables[playerid] |= PLAYER_LOGGED_IN;
	PlayerVariables[playerid] |= PLAYER_IS_REGISTERED;
	SendClientMessage(playerid, COLOR_GREEN, "This server is currently in BETA stages and some features may not be finished / done.");
	SendClientMessage(playerid, COLOR_GREEN, "As this server is in BETA it is subject to bugs. If you find any bugs you can report them on the forum!");
	if(!fexist(SettingsPath(playerid))) {
		CreateSettingsFile(playerid);
	} else {
		//something went wrong. somehow a file has be left over from a player that wasn't in the database. Cleaning went wrong perhaps?
		SendClientMessage(playerid, COLOR_RED2, "ERROR: The server has encountered an error! Please report the message below on the forums.");
		SendClientMessage(playerid, -1, "ERROR 101. SETTINGS_PATH_TAKEN");
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerRegister() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerRegister()", debug_String);

    #endif

	SendDebugMessage("OnPlayerRegister()", "OnPlayerRegister End");

	return 1;
}

public OnPlayerRequestLoginRegister(playerid)
{
	SendDebugMessage("OnPlayerRequestLoginRegister()", "OnPlayerRequestLoginRegister Start");

	timing[0] = GetTickCount();

	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows != 0) { // query returned no rows = player is not registered
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");

	} else { // query returned 1 row = player is registered.
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are not registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");

	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerRequestLoginRegister() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerRequestLoginRegister()", debug_String);

    #endif

	SendDebugMessage("OnPlayerRequestLoginRegister()", "OnPlayerRequestLoginRegister End");

	return 1;
}

public OnHousesLoaded()
{
	SendDebugMessage("OnHousesLoaded()", "OnHousesLoaded Start");

	timing[0] = GetTickCount();

    new rows, fields, houses = 0;
    cache_get_data(rows, fields, Gconnection);

    if(rows) {
        for(new i = 0; i < rows; i++) {
        new owner[24], Intname[100], X[50], Y[50], Z[50], SQL[50], create;
        cache_get_row(i, 1, owner);
        cache_get_row(i, 3, Intname);
        cache_get_row(i, 5, X);
        cache_get_row(i, 6, Y);
        cache_get_row(i, 7, Z);
        cache_get_row(i, 0, SQL);

        create = HouseCreate(owner, Intname, floatstr(X), floatstr(Y), floatstr(Z));
        HouseInfo[create][SqlID] = strval(SQL);
        houses++;
        }
    }
    printf("Houses loaded: %d", houses);

    #if defined __DEBUG
   
    format(debug_String, 128, "OnHousesLoaded() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnHousesLoaded()", debug_String);

    #endif

    SendDebugMessage("OnHousesLoaded()", "OnHousesLoaded End");

    return 1;
}

public OnHouseCreated(houseid)
{

	return 1;
}