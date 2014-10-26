#include <YSI\y_hooks>
#include <YSI\y_dialog>

new pTries[MAX_PLAYERS];


hook OnPlayerRequestClass(playerid, classid)
{
	new mysql[100];

	if(!(PlayerVariables[playerid] & PLAYER_LOGGED_IN) && Dialog_Get(playerid) == -1)
	{
		mysql_format(Gconnection, mysql, 100, "SELECT * FROM `users` WHERE `username` = '%e'", PlayerName[playerid]);
		mysql_tquery(Gconnection, mysql, "OnPlayerJoinServer", "d", playerid);
	}
	return 1;
}

public OnPlayerJoinServer(playerid)
{
	new rows, fields, hPass[250];
	cache_get_data(rows, fields, Gconnection);

	if(rows) // Account was found, attempt to login player.
	{
		printf("User %s exists in the database.", PlayerName[playerid]);

		cache_get_row(0, 1, PlayerInfo[playerid][Ppassword], 1, 250);
		printf(PlayerInfo[playerid][Ppassword]);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Welcome"EMBED_WHITE" back!");
		SendClientMessage(playerid, COLOR_WHITE, "Please enter your"EMBED_LIGHTGREEN" password"EMBED_WHITE" in order to "EMBED_LIGHTGREEN"login.");

		inline Login(pid, dialogid, response, listitem, string:inputtext[])
		{
			#pragma unused pid, dialogid, response, listitem
			format(hPass, 250, "%s%s", PlayerName[playerid], inputtext);

			
			WP_Hash(hPass, 250, hPass);

			if((strcmp(PlayerInfo[playerid][Ppassword], hPass, true)) != 0)
			{
				pTries[playerid]++;
				Dialog_ShowCallback(playerid, using inline Login, DIALOG_STYLE_PASSWORD, "Enter your password", "{FFFFFF}In order to play you need to supply the password you registered with.", "Login", "Quit");
				SendClientMessage(playerid, COLOR_WHITE, "You have provided an "EMBED_RED2"incorrect"EMBED_WHITE" password. Please try again.");
				
				if(pTries[playerid] >= 3)
				{
					SendClientMessage(playerid, COLOR_WHITE, "You have been "EMBED_RED2"kicked"EMBED_WHITE" for using the maximum number of login attempts ("EMBED_RED2"3"EMBED_WHITE").");
					pTries[playerid] = 0;
				}
			} 
			else
			{
				SendClientMessage(playerid, COLOR_WHITE, "You have been "EMBED_LIGHTGREEN"successfully "EMBED_WHITE"logged in. Have "EMBED_LIGHTGREEN"fun!");
				PlayerVariables[playerid] |= PLAYER_LOGGED_IN;

				//load the stats from the cache 

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

			} 
		}
		Dialog_ShowCallback(playerid, using inline Login, DIALOG_STYLE_PASSWORD, "Enter your password", "{FFFFFF}In order to play you need to supply the password you registered with.", "Login", "Quit");
	}
	else // No account was found in the database, try get them to register.
	{
		SendFormattedMessageP(playerid, COLOR_WHITE, "Welcome "EMBED_LIGHTGREEN"%s", PlayerName[playerid]);
		SendClientMessage(playerid, COLOR_WHITE, "It appears that you are not found in our database. Please enter a "EMBED_LIGHTGREEN"password"EMBED_WHITE" to"EMBED_LIGHTGREEN" register"EMBED_WHITE".");

		new mysql[300];

		inline Register(pid, dialogid, response, listitem, string:inputtext[])
		{
			#pragma unused pid, dialogid, response, listitem

			format(hPass, 250, "%s%s", PlayerName[playerid], inputtext);

			WP_Hash(hPass, 250, hPass);
			
			new Year, Month, Day;
			getdate(Year, Month, Day);

			mysql_format(Gconnection, mysql, 300, "INSERT INTO `users` (`username`, `password`, `regdate`, `ip`) VALUES('%e', '%s', '%02d/%02d/%d', '%s')", PlayerName[playerid], hPass, Day, Month, Year, pIP[playerid]);
			mysql_tquery(Gconnection, mysql, "", "");

			SendClientMessage(playerid, COLOR_WHITE, "Your account has"EMBED_LIGHTGREEN" successfully"EMBED_WHITE" been "EMBED_LIGHTGREEN"created!");
			SendClientMessage(playerid, COLOR_WHITE, "Have "EMBED_LIGHTGREEN"fun!"EMBED_WHITE" Remember to follow all rules and use "EMBED_LIGHTGREEN"/help "EMBED_WHITE"and "EMBED_LIGHTGREEN"/commands "EMBED_WHITE"if you're in a pickle.");

			PlayerVariables[playerid] |= PLAYER_LOGGED_IN;
		}
		Dialog_ShowCallback(playerid, using inline Register, DIALOG_STYLE_PASSWORD, "Create an account", "{FFFFFF}In order to play you need to register. Please supply a password in order to register.", "Register", "Quit");

	}
	return 1;
}

CMD:login(playerid, params[])
{
	PlayerVariables[playerid] |= PLAYER_LOGGED_IN;
	return 1;
}