public OnPlayerBanned(playerid)
{
	SendDebugMessage("OnPlayerBanned()", "OnPlayerBanned Start");

	timing[0] = GetTickCount();

	PlayerVariables[playerid] &= ~PLAYER_BANNED;
	PlayerVariables[playerid] |= PLAYER_KICKED;

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerBanned() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerBanned()", debug_String);

    #endif

    SendDebugMessage("OnPlayerBanned()", "OnPlayerBanned End");

	return 1;
}

public OnBanChecked(playerid)
{
	SendDebugMessage("OnBanChecked()", "OnBanChecked Start");

	timing[0] = GetTickCount();

	new rows, fields, active[2], day, month, year;
    cache_get_data(rows, fields, Gconnection);
    getdate(year, month, day);
    if(rows) {

    	for(new i = 0; i < rows; i++) {
	    	cache_get_row(i, 7, active);
	    	printf("active == %s", active);
	    	if(strval(active) == 1) {
	    		printf("gets here 1");
	    		new string[5][128], temp[100];
	    		cache_get_row(i, 0, temp);
	    		format(string[0], 128, "%s You have been banned.", temp);
	    		cache_get_row(i, 1, temp);
				format(string[1], 128, "UNBAN DATE\t: {FFFFFF}%s", temp);
				printf("gets here 2");
				new Date[3][10];


				format(Date[0], 10, "%s%s", temp[0], temp[1]);
				format(Date[1], 10, "%s%s", temp[3], temp[4]);
				format(Date[2], 10, "%c%c%c%c", temp[6], temp[7], temp[8], temp[9]);
				
				if(month > strval(Date[1]) && year <= strval(Date[2])) {
					printf("gets here 3");
					cache_get_row(i, 5, temp);
					new Query[100];
					format(Query, 100, "UPDATE `bans` SET `active`='0' WHERE `id`='%d'", strval(temp));
					return mysql_function_query (Gconnection, Query, false, "", "");
				}
				if(year > strval(Date[2])) {
					cache_get_row(i, 5, temp);
					new Query[100];
					format(Query, 100, "UPDATE `bans` SET `active`='0' WHERE `id`='%d'", strval(temp));
					return mysql_function_query (Gconnection, Query, false, "", ""); 
				}
				if(day >= strval(Date[0]) && month >= strval(Date[1]) && year <= strval(Date[2])) {
					cache_get_row(i, 5, temp);
					printf("gets here 4");
					new Query[100];
					format(Query, 100, "UPDATE `bans` SET `active`='0' WHERE `id`='%d'", strval(temp));
					return mysql_function_query (Gconnection, Query, false, "", "");
				}

				cache_get_row(i, 2, temp);
				format(string[2], 128, "BAN REASON\t: {FFFFFF}%s", temp);
				cache_get_row(i, 3, temp);
				format(string[3], 128, "BAN ADMIN\t: {FFFFFF}%s", temp);
				cache_get_row(i, 6, temp);
				format(string[4], 128, "BAN ISSUED\t: {FFFFFF}%s", temp);
				printf("gets here 5");
				
				SendClientMessage(playerid, COLOR_RED2, string[0]);
				SendClientMessage(playerid, COLOR_RED2, string[1]);
				SendClientMessage(playerid, COLOR_RED2, string[2]);
				SendClientMessage(playerid, COLOR_RED2, string[3]);
				SendClientMessage(playerid, COLOR_RED2, string[4]);
				printf("gets here 6");
			}
			
    	}
    	

		
    }

    #if defined __DEBUG
   
    format(debug_String, 128, "OnBanChecked() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnBanChecked()", debug_String);

    #endif

    SendDebugMessage("OnBanChecked()", "OnBanChecked End");

	return 1;
}

public OnPlayerAirbreak(playerid)
{
	/*new day, month, year, ip[16];
	GetPlayerIp(playerid, ip, 16);
	getdate(year, month, day);
	format(BanInfo[playerid][issued], 50, "%02d/%02d/%d", day, month, year);
	format(BanInfo[playerid][BanReason], 50, "Airbreaking");
	format(BanInfo[playerid][UnbanDate], 50, "Never");
	format(BanInfo[playerid][BanAdmin], 24, "Anti Cheat");
	format(BanInfo[playerid][BanIP], 24, ip);
	PlayerVariables[playerid] |= PLAYER_BANNED;*/

	//to re do.
	return 1;
}