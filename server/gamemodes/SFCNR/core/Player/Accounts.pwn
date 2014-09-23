#include <YSI\y_hooks>
#include <YSI\y_dialog>

enum PInfo
{
	Ppassword[250],
	Pusername[24],
	Padminlvl,
	Pmoney,
	Float:Health,
	Float:Armour,
	Pscore,
	Pcop,
	Pvip,
	Pbank,
	Pip[16],
	Parrest,
	BizID,
	Pstat,
	Parmy,
	Pswat,
	Pprison,
	Prob,
	Prape,
	Pheal,
	Phitman,
	Psales,
	Pwep,
	Pdrug,
	Ptaze,
	Ptruck,
	Psurender,
	STD[100],
	PrisonTime,
	bool:Mayor,
	GroupID,
	PTERRORIST,
	Pfix,
	Pkidnapper,
	Ppedo,
	Ptaxi,
	Ppilot,
	Ppizza,
	Pfarmer,
	Pminer,
	Ptaxirate,
	totalvehs,
	LangRoom,
	Pkills,
	Parrests
}

new PlayerInfo[MAX_PLAYERS][PInfo];

enum PlayerVars:(<<=1)
{
	PLAYER_SPAWNED = 1,
	PLAYER_LOGGED_IN,
	PLAYER_IN_LEISURE,
	PLAYER_FROZEN,
	PLAYER_MUTED,
	PLAYER_RAPED,
	PLAYER_EDITING_HOUSE,
	PLAYER_REQUESTED_TOYS,
	PLAYER_CUFFED,
	PLAYER_IN_JAIL,
	PLAYER_KICKED,
	PLAYER_TAZED,
	PLAYER_REQUESTED_WEAPONS,
	PLAYER_REQUESTED_ITEMS,
	PLAYER_IN_BUSINESS,
	PLAYER_IN_CLASS_SELECTION,
	PLAYER_PM_OFF,
	PLAYER_HAS_BOMB,
	PLAYER_HAS_VEHICLE_ARMOUR,
	PLAYER_HAS_ARMOUR,
	PLAYER_IN_MOVIE_MODE,
	PLAYER_ON_PICKUP,
	PLAYER_READING_RULES,
	PLAYER_FORCED_READ_RULES,
	PLAYER_IS_REGISTERED,
	PLAYER_IN_ARMY,
	PLAYER_IN_SWAT,
	PLAYER_IN_STAT,
	PLAYER_IN_JOB,
	PLAYER_BANNED,
	PLAYER_HAS_PRIVATE_DRIVER,
	PLAYER_REQUESTED_PIZZA,
	IN_HOTEL
}

new PlayerVars:PlayerVariables[MAX_PLAYERS];

hook OnPlayerRequestClass(playerid, classid)
{
	static mysql[100];
	printf("dialog %d", Dialog_Get(playerid));
	if(!(PlayerVariables[playerid] & PLAYER_LOGGED_IN) && Dialog_Get(playerid) == -1)
	{
		mysql_format(Gconnection, mysql, 100, "SELECT * FROM `users` WHERE `username` = '%e'", PlayerName[playerid]);
		mysql_tquery(Gconnection, mysql, "OnPlayerJoinServer", "d", playerid);
		return 0;
	}
	return 1;
}

public OnPlayerJoinServer(playerid)
{
	new rows, fields, hPass[250];
	cache_get_data(rows, fields, Gconnection);

	if(rows)
	{
		printf("User %s exists in the database.", PlayerName[playerid]);

		cache_get_row(0, 1, PlayerInfo[playerid][Ppassword], 1, 250);
		printf(PlayerInfo[playerid][Ppassword]);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Welcome"EMBED_WHITE" back!");
		SendClientMessage(playerid, COLOR_WHITE, "Please enter your"EMBED_LIGHTGREEN" password"EMBED_WHITE" in order to "EMBED_LIGHTGREEN"login.");
		
		

		inline Login(pid, dialogid, response, listitem, string:inputtext[])
		{
			format(hPass, 250, "%s%s", PlayerName[playerid], inputtext);

			
			WP_Hash(hPass, 250, hPass);

			printf("hPass: %s", hPass);
			printf("Pinfo : %s", PlayerInfo[playerid][Ppassword]);

			if((strcmp(PlayerInfo[playerid][Ppassword], hPass, true)) != 0)
			{
				SendClientMessage(playerid, -1, "Wrong pass");
			} 
			else
			{
				SendClientMessage(playerid, -1, "Correct passs");
				PlayerVariables[playerid] |= PLAYER_LOGGED_IN;
			} 
		}

		Dialog_ShowCallback(playerid, using inline Login, DIALOG_STYLE_PASSWORD, "Enter your password", "In order to play you need to supply the password you registered with.", "Login", "Quit");
	}
	return 1;
}