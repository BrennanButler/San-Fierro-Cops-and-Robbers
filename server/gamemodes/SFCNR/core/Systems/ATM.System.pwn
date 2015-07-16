#include <YSI\y_hooks>


#define 			ATM_OBJECT 				(19526)
#define 			MAX_ATMS 				(100)


new bool:pInATM[MAX_PLAYERS];
new pCurrentATM[MAX_PLAYERS];

enum E_ATM
{
	sqlID,
	Float:x,
	Float:y,
	Float:z,
	Float:rx,
	Float:ry,
	Float:rz,
	Obj,
	cp,
	cooldown
}

new ATMInfo[MAX_ATMS][E_ATM];

ATMID()
{
	for(new i = 0; i < MAX_ATMS; i++)
	{
		if(!IsValidDynamicObject(ATMInfo[i][Obj]))
			return i;
	}

	return -1;
}

LoadATMS()
{
	new query[20];

	// Reset the data

	for(new i = 0; i < MAX_ATMS; i++)
	{
		DestroyDynamicObject(ATMInfo[i][Obj]);
	}

	mysql_format(gConnection, query, 100, "SELECT * FROM `atm`");

	inline OnReceiveATMs()
	{
		new rows,
			fields;

		cache_get_data(rows, fields, gConnection);

		if(rows)
		{
			for(new i = 0; i < rows; i++)
			{
				new ID = ATMID();

				if(ID == -1)
				{
					Debug(DEBUG_QUERY, "ATMID() returned -1. Rows : %d Fields : %d", rows, fields);
				}

				ATMInfo[ID][sqlID] = cache_get_row_int(i, 0, gConnection);
				ATMInfo[ID][x] 	   = cache_get_row_float(i, 1, gConnection);
				ATMInfo[ID][y] 	   = cache_get_row_float(i, 2, gConnection);
				ATMInfo[ID][z] 	   = cache_get_row_float(i, 3, gConnection);
				ATMInfo[ID][rx]    = cache_get_row_float(i, 4, gConnection);
				ATMInfo[ID][ry]    = cache_get_row_float(i, 5, gConnection);
				ATMInfo[ID][rz]    = cache_get_row_float(i, 6, gConnection);

				ATMInfo[ID][Obj]   = CreateDynamicObject(ATM_OBJECT, ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z], ATMInfo[ID][rx], ATMInfo[ID][ry], ATMInfo[ID][rz]);
				ATMInfo[ID][cp]    = CreateDynamicCP(ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z]-1.0, 1.3);
				Debug(DEBUG_CALLBACK, "Created ATM with the following data:\nID : %d Object ID : %d SQLID : %d", ID, ATMInfo[ID][Obj], ATMInfo[ID][sqlID]);
			}
		}
	}

	mysql_tquery_inline(gConnection, query, using inline OnReceiveATMs, "");
}

ATMDebug(playerid)
{

	new ID = ATMID();

	ATMInfo[ID][sqlID] = -1;
	GetPlayerPos(playerid, ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z]);

	ATMInfo[ID][rx]    = 0.0;
	ATMInfo[ID][ry]    = 0.0;
	ATMInfo[ID][rz]    = 0.0;

	ATMInfo[ID][Obj]   = CreateDynamicObject(ATM_OBJECT, ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z]-1.0, ATMInfo[ID][rx], ATMInfo[ID][ry], ATMInfo[ID][rz]);	
	ATMInfo[ID][cp]    = CreateDynamicCP(ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z]-1.0, 1.3);
	ATMInfo[ID][cooldown] = 0;
}

hook OnGameModeInit()
{
	LoadATMS();
	SetPlayerWantedLevel(1, 2);
	return 1;
}

CMD:atmdebug(playerid, params[])
{
	ATMDebug(playerid);
	return 1;
}

public atm_OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	for(new i = 0; i < MAX_ATMS; i++)
	{
		if(ATMInfo[i][cp] == checkpointid)
		{
			//do shizzel
			pInATM[playerid] = true;
			pCurrentATM[playerid] = i;
		}
	}
	return 1;
}

public atm_OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	for(new i = 0; i < MAX_ATMS; i++)
	{
		if(ATMInfo[i][cp] == checkpointid)
		{
			//do shizzel
			pInATM[playerid] = false;
			pCurrentATM[playerid] = -1;
		}
	}
	return 1;
}


CMD:robatm(playerid, params[])
{
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_GREY, "You need to spawn before you use any commands.");
    if(!IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Law enforcements are not allowed to use this command.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Please stop spamming.");
	if(!pInATM[playerid]) return SendClientMessage(playerid, COLOR_GREY, "You need to be close to an ATM to use this command.");
	if((gettime() - ATMInfo[pCurrentATM[playerid]][cooldown]) < 60 * 8) return SendClientMessage(playerid, COLOR_GREY, "This ATM has recently been robbed. Try again later.");

	if((randomEx(1, 100)) < 50)
	{
		SendClientMessage(playerid, COLOR_DARKGREY, "* "EMBED_WHITE"You "EMBED_RED2"failed "EMBED_WHITE"robbing this ATM.");
		ATMInfo[pCurrentATM[playerid]][cooldown] = gettime();
		return 1;
	}

	new money = randomEx(5, 2400);
	GivePlayerMoney(playerid, money);
	MsgP(playerid, COLOR_DARKGREY, "* "EMBED_WHITE"You have successfully robbed "EMBED_GREEN"$%d "EMBED_WHITE"from this ATM!", money);
	ATMInfo[pCurrentATM[playerid]][cooldown] = gettime();
    WantedLevel[playerid] += 2;
    CallLocalFunction("OnPlayerCommitCrime", "iii", playerid, WantedLevel[playerid], CRIME_ATMROBBERY);
	return 1;
}	