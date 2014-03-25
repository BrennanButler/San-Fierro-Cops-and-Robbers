IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
    {
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

public Float:PlayersDistance(P1, P2)
{
    if(!IsPlayerConnected(P1) || !IsPlayerConnected(P2)) return -1.0;
    new Float:XYZ[6];
    GetPlayerPos(P1,XYZ[0],XYZ[1],XYZ[2]);
    GetPlayerPos(P2,XYZ[3],XYZ[4],XYZ[5]);
    return floatsqroot(floatpower(
	floatabs(
	floatsub(XYZ[3],XYZ[0]))
	,2)+floatpower(floatabs(floatsub(XYZ[4],XYZ[1])),2)+floatpower(floatabs(floatsub(XYZ[5],XYZ[2])),2));
}

CMD:ticket(playerid, params[])
{
	if(gTeam[playerid] == ARMY || gTeam[playerid] == SWAT || gTeam[playerid] == POLICE || gTeam[playerid] == STAT)
	{
	    new id;
	    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_GREEN, "/ticket <id>");
	    if(id == playerid) return SendClientMessage(playerid, COLOR_RED, "You cannot ticket yourself");
	    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "This player is not connected");
	    if(WantedLevel[id] > 0 && WantedLevel[id] < 3)
	    {
	        if(PlayersDistance(playerid, id) < 6)
	        {
	        	GivePlayerMoney(playerid, 1500);
	        	GivePlayerMoney(id, -1500);
	        	GameTextForPlayer(playerid, "~b~Ticket issued", 2000, 4);
	        	GameTextForPlayer(id, "~r~-$1500", 2000, 4);
	        	SendClientMessage(playerid, COLOR_GREEN, "You have issued a ticket to a suspect, by doing so you have earned $1500");
	        	SendClientMessage(playerid, COLOR_RED, "You have been issued a ticket! -$1500");
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "You are not near this player!");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "This player is ethier not wanted or has a wanted level higher than 3, in which case you need to /ar them");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "This command is only for law enforcements!");
	}
	return 1;
}

CMD:armybase(playerid, params[])
{
	new string[128];
	if(gTeam[playerid] == ARMY)
	{
	    if(ArmyBase[playerid] < 3)
	    {
	    	SetPlayerPos(playerid, -1345.5194,500.1661,18.2344);
	    	ArmyBase[playerid] ++;
	    	format(string, sizeof(string), "Welcome back to the base. %i/3", ArmyBase[playerid]);
	    	SendClientMessage(playerid, COLOR_GREEN, string);
	    	return 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, "You have used all 3 of your uses. You must wait till you have died before your uses reset");

		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "This is a army only command");
	}
	return 1;
}

CMD:fix(playerid, params[])
{
	new id, idcar, string[2][128];
	if(gTeam[playerid] == MECHANIC)
	{
		if(PlayersDistance(playerid, id) < 6)
		{
			if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /fix <id/name>");
			if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "This player is not connected");
			if(id == playerid) return SendClientMessage(playerid, COLOR_RED, "You cant use this command on youself");
			idcar = GetPlayerVehicleID(id);
			SetVehicleHealth(idcar, 1000.0);
			RepairVehicle(idcar);
			format(string[0], sizeof(string[]), "You have fixed %s car", GetName(id));
			format(string[1], sizeof(string[]), "%s has fixed your car", GetName(playerid));
			SendClientMessage(playerid, COLOR_GREEN, string[0]);
			SendClientMessage(id, COLOR_GREEN, string[1]);
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You are not near enough to use this command on the player");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "This command is only for mechanics");
	}
	return 1;
}

CMD:fixme(playerid, params[])
{
	if(gTeam[playerid] == MECHANIC)
	{
        new veh;
		veh = GetPlayerVehicleID(playerid);
		RepairVehicle(veh);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "You have fixed your car");
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "This command is only for mechanics");
	}
	return 1;
}

CMD:grab(playerid, params[])
{
	if(gTeam[playerid] == STAT || gTeam[playerid] == SWAT || gTeam[playerid] == ARMY)
	{
		new id, string[2][128], Float:X, Float:Y, Float:Z;
		if(Lastveh[playerid] == -1) return SendClientMessage(playerid, COLOR_RED, "You need have been in a vehicle before using this command.");
		GetVehiclePos(Lastveh[playerid], X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 50, X, Y, Z))
		{
		    if(PlayersDistance(playerid, id) < 10)
		    {
				if(WantedLevel[id] >=1)
				{
					if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_GREEN, "USAGE: /grab <id>");
					if(id == playerid) return SendClientMessage(playerid, COLOR_RED, "You cannot grab yourself");
					if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "This player is not connected");
					for(new i, b = MAX_PLAYERS; i != b;i++)
					{
						if(IsPlayerInVehicle(i, Lastveh[playerid]))
						{
							if(GetPlayerVehicleSeat(i) == 1)
							{
							    SendClientMessage(playerid, COLOR_RED, "Error: Passenger seat doesnt exist/ocupied.");
							}
						}
					}
					format(string[0], sizeof(string[]), "You have grabed and draged %s to your vehicle", GetName(id));
					format(string[1], sizeof(string[]), "You have been grabed and draged into a vehicle by %s", GetName(playerid));
					SendClientMessage(playerid, COLOR_GREEN, string[0]);
					SendClientMessage(id, COLOR_GREEN, string[1]);
					PutPlayerInVehicle(playerid, Lastveh[playerid], 1);
					return 1;
				}
				else
				{
				    SendClientMessage(playerid, COLOR_RED, "This player is not wanted!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED, "You are not in range of this player");
			}
		}
		else
		{
 			SendClientMessage(playerid, COLOR_RED, "You are not in range of your vehicle");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_RED, "This command is only for swat, army and stat");
	}
	return 1;
}