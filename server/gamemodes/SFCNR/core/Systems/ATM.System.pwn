#include <YSI\y_hooks>


#define 			ATM_OBJECT 				(19526)
#define 			MAX_ATMS 				(100)

enum E_ATM
{
	sqlID,
	Float:x,
	Float:y,
	Float:z,
	Float:rx,
	Float:ry,
	Float:rz,
	Obj
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

	mysql_format(Gconnection, query, 100, "SELECT * FROM `atm`");

	inline OnReceiveATMs()
	{
		new rows,
			fields;

		cache_get_data(rows, fields, Gconnection);

		if(rows)
		{
			for(new i = 0; i < rows; i++)
			{
				new ID = ATMID();

				if(ID == -1)
				{
					Debug(DEBUG_QUERY, "ATMID() returned -1. Rows : %d Fields : %d", rows, fields);
				}

				ATMInfo[ID][sqlID] = cache_get_row_int(i, 0, Gconnection);
				ATMInfo[ID][x] 	   = cache_get_row_float(i, 1, Gconnection);
				ATMInfo[ID][y] 	   = cache_get_row_float(i, 2, Gconnection);
				ATMInfo[ID][z] 	   = cache_get_row_float(i, 3, Gconnection);
				ATMInfo[ID][rx]    = cache_get_row_float(i, 4, Gconnection);
				ATMInfo[ID][ry]    = cache_get_row_float(i, 5, Gconnection);
				ATMInfo[ID][rz]    = cache_get_row_float(i, 6, Gconnection);

				ATMInfo[ID][Obj]   = CreateDynamicObject(ATM_OBJECT, ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z], ATMInfo[ID][rx], ATMInfo[ID][ry], ATMInfo[ID][rz]);

				Debug(DEBUG_CALLBACK, "Created ATM with the following data:\nID : %d Object ID : %d SQLID : %d", ID, ATMInfo[ID][Obj], ATMInfo[ID][sqlID]);
			}
		}
	}

	mysql_tquery_inline(Gconnection, query, using inline OnReceiveATMs, "");
}

ATMDebug(playerid)
{

	new ID = ATMID();

	ATMInfo[ID][sqlID] = -1;
	GetPlayerPos(playerid, ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][y]);

	ATMInfo[ID][rx]    = 0.0;
	ATMInfo[ID][ry]    = 0.0;
	ATMInfo[ID][rz]    = 0.0;

	ATMInfo[ID][Obj]   = CreateDynamicObject(ATM_OBJECT, ATMInfo[ID][x], ATMInfo[ID][y], ATMInfo[ID][z], ATMInfo[ID][rx], ATMInfo[ID][ry], ATMInfo[ID][rz]);
}

hook OnGameModeInit()
{
	LoadATMS();
	return 1;
}

CMD:atmdebug(playerid, params[])
{
	ATMDebug(playerid);
	return 1;
}