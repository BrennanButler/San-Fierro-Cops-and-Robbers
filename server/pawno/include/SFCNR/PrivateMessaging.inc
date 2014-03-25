public OnPlayerPM(playerid, pmto, message[])
{
	SendDebugMessage("OnPlayerPM()", "OnPlayerPM Start");

	timing[0] = GetTickCount();

	new Query[400], Year, Month, Day;
	getdate(Year, Month, Day);
	format(Query, 400, "INSERT INTO pm(`pm_from`, `pm_to`, `message`, `date`) VALUES('%s', '%s', '%s', '%02d/%02d/%02d')", PlayerName(playerid), PlayerName(pmto), message, Day, Month, Year);
	mysql_function_query (Gconnection, Query, false, "", "");

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerStartSweeperJob() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerStartSweeperJob()", debug_String);

    #endif

	SendDebugMessage("OnPlayerPM()", "OnPlayerPM End");

	return 1;
}

public OnPlayerLeavePMGroup(playerid, groupid)
{
	SendDebugMessage("OnPlayerLeavePMGroup()", "OnPlayerLeavePMGroup Start");

	timing[0] = GetTickCount();

	format(G_String, 128, "%s has left the pm group.", PlayerName(playerid));
	SendMessageToPMGroup(groupid, COLOR_ORANGE, G_String);

	if(groupid == PlayerInfo[playerid][GroupID]) {
	    SendMessageToPMGroup(groupid, COLOR_ORANGE, "The leader of the group has left and therefore the group messaging session is over.");
	    for(new i = 0; i < MAX_PLAYERS; ++i) {
			if(PlayerInfo[i][GroupID] == PlayerInfo[playerid][GroupID]) {
			    PlayerInfo[i][GroupID] = -1;
			}
	    }
	}

	#if defined __DEBUG
   
    format(debug_String, 128, "OnPlayerLeavePMGroup() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnPlayerLeavePMGroup()", debug_String);

    #endif

    SendDebugMessage("OnPlayerLeavePMGroup()", "OnPlayerLeavePMGroup End");

	return 1;
}
