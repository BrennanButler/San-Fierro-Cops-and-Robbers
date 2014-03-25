public OnGameModeExit()
{
	timing[0] = GetTickCount();

	SendDebugMessage("OnGameModeExit()", "OnGameModeExit Start");

	mysql_close(Gconnection);
	IRC_DestroyGroup(BGroupID);
	IRC_Quit(BotID[0], "Server has shutdown! Goodbye folks!");
	for(new f = 0; f < MAX_FIRES; f++) {
		if(IsValidDynamicObject(FireInfo[f][object])) {
			DestroyDynamicObject(FireInfo[f][object]);
			FireInfo[f][pos1] = 0.0;
		}

	}

	SendDebugMessage("OnGameModeExit()", "OnGameModeExit End");

	#if defined __DEBUG
   
    format(debug_String, 128, "OnGameModeExit() took %ims to execute", (GetTickCount() - timing[0]));

    SendDebugMessage("OnGameModeExit()", debug_String);

    #endif

	return 1;
}