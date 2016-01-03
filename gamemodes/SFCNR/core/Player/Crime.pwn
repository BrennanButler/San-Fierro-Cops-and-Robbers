public OnPlayerCommitCrime(playerid, wantedlevel, CRIME_ID, extraid)
{

	if(0 < wantedlevel < 4) 
	{
	    SetPlayerColor(playerid, COLOR_YELLOW);
	}
	if(4 <= wantedlevel < 6) 
	{
	    SetPlayerColor(playerid, COLOR_ORANGE);
	}
	if(wantedlevel >= 6) 
	{
		SetPlayerColor(playerid, COLOR_RED2);
	}

	foreach(Player, i) 
	{
	    if(wantedlevel > WantedLevel[i]) 
	    {
	        SetPlayerColor(playerid, COLOR_FIRE);
	    }
	}

	SetPlayerWantedLevel(playerid, wantedlevel);
	SetPlayerTeam(playerid, NO_TEAM);

	switch(CRIME_ID)
	{

		case CRIME_ROBBERY:
		{
			LawMsg(COLOR_SKYBLUE, "[DISPATCH] "EMBED_WHITE"Attention all units! "EMBED_RED2"%s "EMBED_WHITE"has robbed "EMBED_GREEN"%s"EMBED_WHITE", all units respond to "EMBED_GREEN"%s"EMBED_WHITE"! Over.", PlayerName[playerid], PlayerName[extraid], PlayerZone(playerid));
			SendRadioToLaw(playerid, 16);
		}
		case CRIME_MURDER:
		{
			LawMsg(COLOR_SKYBLUE, "[DISPATCH] "EMBED_WHITE"Attention all units! "EMBED_RED2"%s "EMBED_WHITE"has murdered "EMBED_GREEN"%s"EMBED_WHITE", proceed with extreme caution, suspect is armed and dangerous, 10-20 "EMBED_GREEN"%s"EMBED_WHITE"! Over.", PlayerName[playerid], PlayerName[extraid], PlayerZone(playerid));
			SendRadioToLaw(playerid, 16);
		}
		case CRIME_ATTEMPTEDROBBERY:
		{
			LawMsg(COLOR_SKYBLUE, "[DISPATCH] "EMBED_WHITE"Attention all units! We have 10-31(Attempted robbery) in progress, all units respond to "EMBED_GREEN"%s"EMBED_WHITE"! Over.", PlayerZone(playerid));
			SendRadioToLaw(playerid, 16);
		}
		case CRIME_ATMROBBERY:
		{
			printf("ATM ROBBERY");
			LawMsg(COLOR_SKYBLUE, "[DISPATCH] "EMBED_WHITE"Attention all units! "EMBED_RED2"%s "EMBED_WHITE"has robbed an ATM, all units respond to "EMBED_GREEN"%s"EMBED_WHITE"! Over.", PlayerName[playerid], PlayerZone(playerid));
			SendRadioToLaw(playerid, 16);
		}
	}

	return 1;
}