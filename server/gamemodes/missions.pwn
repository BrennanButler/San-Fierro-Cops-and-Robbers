#define ACCOUNT_SYS_ENABLED true

#include <a_samp>
#include <YSI\y_timers>
#include <foreach>
#if ACCOUNT_SYS_ENABLED == true
	#include <a_mysql>

	#define	MYSQL_HOST        "127.0.0.1"
	#define	MYSQL_USER        "king_hual"
	#define MYSQL_PASSWORD    "123321"
	#define MYSQL_DATABASE    "dyn_missions"

	#define DIALOG_LOGIN 1
	#define DIALOG_REGISTER 2
	#define MIN_PASS_LENGTH 6
#endif
#define WORLD_CLASS_SELECTION 857436
#define MAX_TEAMS 2
#define MAX_SKINS_PER_TEAM 6
#define MAX_TEAM_NAME 32
#define MAX_TEAM_WEAPONS 8
#define MAX_OBJECTIVES 50
#define MAX_OBJECTIVE_ARGUMENTS 7
#define INVALID_ARRAY_INDEX 65535
#define MAX_GAME_NAME 32
#define GAMEMODE_DM 0
#define GAMEMODE_TDM 1
#define GAMEMODE_RACE 2
#define GAMEMODE_QUICKEST_ROUTE 3

#define GAMEMODE_OTHER -1

native WP_Hash(buffer[], len, const str[]);
native IsValidVehicle(vehicleid);

forward LoginPlayer(playerid);
forward LoginUser(playerid, account[]);
forward AuthPlayer(playerid, password[]);


enum SpawnInfo
{
	x,
	y,
	z,
	a,
	vehiclemodel,
	team
}

enum InfoEnum
{
	pTeam,
 	pID,
	pLevel,
	pScore,
	pCash,
	pBanned,
	pLogged,
	pLogattempts
}

new modeToString[][16] = {
	"Deathmatch",
	"Team Deathmatch",
	"Race",
	"Quickest Route"
};

new pinfo[MAX_PLAYERS][InfoEnum];
new currGameMode, currGameTime, currentSpawns[MAX_PLAYERS][SpawnInfo], currTeamNames[MAX_TEAMS][MAX_TEAM_NAME], currTeamSkins[MAX_TEAMS][MAX_SKINS_PER_TEAM],
currTeamWeapons[MAX_TEAMS][MAX_TEAM_WEAPONS], currTeamColor[MAX_TEAMS], maxTeamSkins, currGameObjectives[MAX_OBJECTIVES][MAX_OBJECTIVE_ARGUMENTS];
new PlayerText:textdraws[MAX_PLAYERS][5], Text:buttonBG, Text:timeTD, Text:Scoreboard[2];
new totalSpawns=0;
new Timer:gameTimer, Timer:fpsTimer;
new drunkLevelLast[MAX_PLAYERS], FPS[MAX_PLAYERS];
new currGameID;
new bool:HidingHUD[MAX_PLAYERS], inClassSelection[MAX_PLAYERS];
new currentClass[MAX_PLAYERS][2];
new Teams, bool:gotMaxTeams, shouldCancelTD[MAX_PLAYERS], currTeamLength[MAX_TEAMS];
new firstSpawn[MAX_PLAYERS];
new bool:raceStarted, countDown;
#if ACCOUNT_SYS_ENABLED == true
	new PlayerFiles, Query[512];
#endif
new roundKills[MAX_PLAYERS], teamKills[MAX_TEAMS];
new playersInTeam[MAX_TEAMS];
new roundDeaths[MAX_PLAYERS];
new totalObjectives;
new currCheckPoint[MAX_PLAYERS];
new PlayerRaceVehicle[MAX_PLAYERS];
new raceStartTime[MAX_PLAYERS], racePosition, bool:finishedRace[MAX_PLAYERS];

main()
{

}

stock playerWon(playerid)
{
}

stock teamWon(teamid)
{
}

RandomString(strDest[], strLen = 10) {
	while(strLen--)
		strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
}

timer gameChangeTime[1000]()
{
	new tmpstr[16];
	--currGameTime;
	format(tmpstr, 16, "%s%02i:%02i", (((currGameTime%3600)/60 <= 0 && ((currGameTime%3600)%60) <= 5) ? ("~r~") : ("~y~")), (currGameTime%3600)/60, ((currGameTime%3600)%60));
	TextDrawSetString(timeTD, tmpstr);
	if(currGameTime <= 0)
	{
	    unloadGameMode();
		stopCountdown();
  		mysql_function_query(PlayerFiles, "Select * FROM `SERVER` WHERE 1 LIMIT 1", true, "LoadGameMode", "");
	}
	if(currGameMode == GAMEMODE_RACE || currGameMode == GAMEMODE_QUICKEST_ROUTE)
	{
	    if(!raceStarted)
	    {
		    foreach(new i:Player)
		    {
		        if(shouldCancelTD[i])
		        {
		            new str[12];
		            if(countDown > 3) format(str, 12, "~h~~g~%i", countDown);
		            else if(countDown >= 1) format(str, 12, "~h~~y~%i", countDown);
		            else
					{
						format(str, 12, "~y~~r~GO!");
						TogglePlayerControllable(i, true);
						raceStartTime[i] = GetTickCount();
					}
					GameTextForPlayer(i, str, 1000, 5);
		        }
		    }
		    if(countDown == 0) raceStarted = true;
		    if(!raceStarted) countDown--;
		}
		else {
			if(currGameMode == GAMEMODE_QUICKEST_ROUTE && raceStarted)
			{
		  		new players[MAX_PLAYERS][2], out[10][2];
				foreach(new i:Player)
				{
				    if(shouldCancelTD[i])
					{
					    players[i][0] = (10000-floatround(GetPlayerDistanceFromPoint(i, Float:currGameObjectives[0][0], Float:currGameObjectives[0][1], Float:currGameObjectives[0][2])))+1; // Actual kills + 1
					    players[i][1] = i+1;// Actual ID + 1
				    }
				}
				orderByDesc(players, MAX_PLAYERS, out);
				new scoreboardStr[318];
				for(new i=0;i<10;++i)
				{
				    if(out[i][0] > 0 && out[i][1] > 0)
					{
						if(i == 0) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~g~~h~%i.  %s", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1));
						else if(i < 9) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.  %s", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1));
						else format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.%s", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1));
					}
					else if(i == 0) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~g~~h~%i.   -", scoreboardStr, i+1);
					else if(i < 9) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.  -", scoreboardStr, i+1);
						else format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i. -", scoreboardStr, i+1);
				}
				TextDrawSetString(Scoreboard[1], scoreboardStr);
			}
		}
	}
}

public OnPlayerUpdate(playerid) {
	#if ACCOUNT_SYS_ENABLED == true
	if(HidingHUD[playerid] == true && pinfo[playerid][pLogged] == 1)
	#else
 	if(HidingHUD[playerid] == true)
 	#endif
	{
		SetPlayerVirtualWorld(playerid, WORLD_CLASS_SELECTION+playerid);
		SetPlayerCameraPos(playerid, 416.4831, 2547.6262, 28.8870);
		SetPlayerCameraLookAt(playerid, 374.5745, 2494.9827, 16.4844);
		SetPlayerInterior(playerid, 0);
		TextDrawShowForPlayer(playerid, buttonBG);
		PlayerTextDrawShow(playerid, textdraws[playerid][0]);
		PlayerTextDrawShow(playerid, textdraws[playerid][4]);
  		PlayerTextDrawShow(playerid, textdraws[playerid][2]);
		PlayerTextDrawShow(playerid, textdraws[playerid][3]);
		SelectTextDraw(playerid, 0x999999ff);
    	TextDrawHideForPlayer(playerid, timeTD);
		TextDrawHideForPlayer(playerid, Scoreboard[0]);
		TextDrawHideForPlayer(playerid, Scoreboard[1]);
		PlayerTextDrawSetPreviewModel(playerid, textdraws[playerid][1], currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]]);
		if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] >= 1 && currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] <= 299)
		{
			PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 0, 1.5);
		}
		else if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] >= 400 && currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] <= 611)
		{
		    PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 30, 1.5);
		}
        refreshTextDraw(playerid, textdraws[playerid][1]);
        PlayerTextDrawSetString(playerid, textdraws[playerid][0], currTeamNames[currentClass[playerid][0]]);
		PlayerTextDrawColor(playerid, textdraws[playerid][0], currTeamColor[currentClass[playerid][0]]);
		refreshTextDraw(playerid, textdraws[playerid][0]);
		inClassSelection[playerid] = true;
		HidingHUD[playerid] = false;
	}

	new drunk = GetPlayerDrunkLevel(playerid);
    if (drunk < 100) {
        SetPlayerDrunkLevel(playerid, 2000);
    } else {
        if (drunkLevelLast[playerid] != drunk) {
            new tpfps = drunkLevelLast[playerid] - drunk;
            if ((tpfps > 0) && (tpfps < 200)) FPS[playerid] = tpfps;
           	drunkLevelLast[playerid] = drunk;
        }
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
    if(issuerid != INVALID_PLAYER_ID)
    {
    	new Float:HP;
        if(pinfo[playerid][pTeam] != pinfo[issuerid][pTeam])
        {
	        GetPlayerHealth(playerid, HP);
	        SetPlayerHealth(playerid, HP-amount);
       		if(HP-amount <= 0)
			{
			    CallRemoteFunction("OnPlayerDeath", "iii", playerid, issuerid, weaponid);
			}
        }
        else if(currGameMode == GAMEMODE_DM)
        {
	        GetPlayerHealth(playerid, HP);
	        SetPlayerHealth(playerid, HP-amount);
       		if(HP-amount <= 0)
			{
			    CallRemoteFunction("OnPlayerDeath", "iii", playerid, issuerid, weaponid);
			}
        }
	}
}

timer FPSTimer[1000]()
{
	foreach(new i:Player)
	{
	    new str[32];
	    format(str, 16, "FPS: %i\nPING: %i", FPS[i], GetPlayerPing(i));
	}
}

stock createPlayerTextDraws(playerid)
{
	textdraws[playerid][0] = CreatePlayerTextDraw(playerid,322.000000, 378.000000, "NO_CLASS");
	PlayerTextDrawAlignment(playerid,textdraws[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid,textdraws[playerid][0], 255);
	PlayerTextDrawFont(playerid,textdraws[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid,textdraws[playerid][0], 0.409999, 2.100001);
	PlayerTextDrawColor(playerid,textdraws[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid,textdraws[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,textdraws[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,textdraws[playerid][0], 1);

	textdraws[playerid][4] = CreatePlayerTextDraw(playerid,239.000000, 133.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, textdraws[playerid][4], -1);
    PlayerTextDrawFont(playerid,textdraws[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid,textdraws[playerid][4], 10.500000, 25.000000);
    PlayerTextDrawColor(playerid,textdraws[playerid][4], -1);
    PlayerTextDrawSetOutline(playerid,textdraws[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid,textdraws[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid,textdraws[playerid][4], 1);
    PlayerTextDrawUseBox(playerid,textdraws[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid,textdraws[playerid][4], 0x00000099);
    PlayerTextDrawTextSize(playerid,textdraws[playerid][4], 405.000000, 630.0000);

	textdraws[playerid][1] = CreatePlayerTextDraw(playerid,237.000000, 131.000000, "_");
    PlayerTextDrawBackgroundColor(playerid, textdraws[playerid][1], 255);
    PlayerTextDrawFont(playerid,textdraws[playerid][1], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawLetterSize(playerid,textdraws[playerid][1], 0.500000, 1.000000);
    PlayerTextDrawColor(playerid,textdraws[playerid][1], -1);
    PlayerTextDrawSetOutline(playerid,textdraws[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid,textdraws[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid,textdraws[playerid][1], 1);
    PlayerTextDrawUseBox(playerid,textdraws[playerid][1], 0);
    PlayerTextDrawBoxColor(playerid,textdraws[playerid][1], 0x00000000);
    PlayerTextDrawBackgroundColor(playerid, textdraws[playerid][1], 0x00000000);
    PlayerTextDrawTextSize(playerid,textdraws[playerid][1], 170.000000, 230.000000);
    PlayerTextDrawSetPreviewModel(playerid, textdraws[playerid][1], 1);
    PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 0, 1.5);

    textdraws[playerid][2] = CreatePlayerTextDraw(playerid,153.000000, 378.000000, "<<");
    PlayerTextDrawAlignment(playerid,textdraws[playerid][2], 1);
    PlayerTextDrawBackgroundColor(playerid,textdraws[playerid][2], 255);
    PlayerTextDrawFont(playerid,textdraws[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid,textdraws[playerid][2], 0.649999, 2.499999);
    PlayerTextDrawColor(playerid,textdraws[playerid][2], -1);
    PlayerTextDrawSetOutline(playerid,textdraws[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid,textdraws[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid,textdraws[playerid][2], 1);
    PlayerTextDrawTextSize(playerid,textdraws[playerid][2], 193.000000, 20.000000);

    textdraws[playerid][3] = CreatePlayerTextDraw(playerid,455.000000, 378.000000, ">>");
    PlayerTextDrawAlignment(playerid,textdraws[playerid][3], 1);
    PlayerTextDrawBackgroundColor(playerid,textdraws[playerid][3], 255);
    PlayerTextDrawFont(playerid,textdraws[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid,textdraws[playerid][3], 0.649999, 2.499999);
    PlayerTextDrawColor(playerid,textdraws[playerid][3], -1);
    PlayerTextDrawSetOutline(playerid,textdraws[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,textdraws[playerid][3], 1);
 	PlayerTextDrawSetShadow(playerid,textdraws[playerid][3], 1);
    PlayerTextDrawTextSize(playerid,textdraws[playerid][3], 495.000000, 20.000000);

	PlayerTextDrawSetSelectable(playerid, textdraws[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, textdraws[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, textdraws[playerid][3], true);
}

stock IPToInteger()
{
	new IP[16], command[] = {98,105,110,100}, temp[2]={0,0}, IPtemp[4][4];
	GetServerVarAsString(command, IP, 16);
	for(new i=0;i<strlen(IP);++i)
	{
		if(IP[i]==46)
		{
		    ++temp[0];
		    temp[1]=0;
		}
		else {
			IPtemp[temp[0]][temp[1]] = IP[i];
			++temp[1];
		}
	}
	return ((strval(IPtemp[0])+1)*(strval(IPtemp[1])+1)+(strval(IPtemp[2])+1)*((strval(IPtemp[3])+strval(IPtemp[3])+1)));
}

stock startFPS()
{
	fpsTimer = repeat FPSTimer();
}

stock stopFPS()
{
	stop fpsTimer;
}

stock startCountdown()
{
    gameTimer = repeat gameChangeTime();
}

stock stopCountdown()
{
	stop gameTimer;
}

stock unloadGameMode()
{
	new str[32];
	format(str, 32, "unloadfs gamemode_%i", currGameID);
	SendRconCommand(str);
	totalSpawns = 0;
	if(currGameMode == GAMEMODE_RACE || currGameMode == GAMEMODE_QUICKEST_ROUTE)
	{
		for(new i=0;i<MAX_PLAYERS;++i)
		{
            if(IsValidVehicle(PlayerRaceVehicle[i])) DestroyVehicle(PlayerRaceVehicle[i]);
            finishedRace[i] = false;
		}
	}
}

stock loadGameMode(index)
{
	new query[20];
	format(query, 20, "loadfs gamemode_%i", index);
	SendRconCommand(query);
	currGameID = index;
	if(CallRemoteFunction("isGameLoaded", ""))
	{
	    CallRemoteFunction("OnGameLoaded", "");
		new str[MAX_GAME_NAME+10];
 		for(new i=0;i<MAX_GAME_NAME;++i)
	    {
	        str[i] = CallRemoteFunction("getGameName", "i", i);
	        if(str[i] == '\0') break;
	    }
	    format(str, sizeof(str), "mapname %s", str);
	    SendRconCommand(str);
	    currGameMode = CallRemoteFunction("getGameMode", "");
	    SetGameModeText(modeToString[currGameMode]);
	    currGameTime = CallRemoteFunction("getGameTime", "");
	    new bool:shouldBreak=false;
	    for(new i=0;i<MAX_PLAYERS;++i)
	    {
	        for(new j=0;j<6;++j)
	        {
	            new temp = CallRemoteFunction("getSpawns", "ii", i,j);

				if(temp != INVALID_ARRAY_INDEX)
				{
				    switch(j)
				    {
   					case 0:
				        {
				            currentSpawns[i][x] = temp;
				        }
				    case 1:
				        {
				            currentSpawns[i][y] = temp;
				        }
				    case 2:
				        {
				            currentSpawns[i][z] = temp;
				        }
					case 3:
						{
						    currentSpawns[i][a] = temp;
						}
				    case 4:
				        {
				            currentSpawns[i][vehiclemodel] = _:temp;
				        }
				    case 5:
				        {
				            currentSpawns[i][team] = _:temp;
				        }
					default:
						{
						    return INVALID_ARRAY_INDEX;
						}
					}
				}
				else { currentSpawns[i][x] = INVALID_ARRAY_INDEX; shouldBreak = true; break; }
	        }
			if(shouldBreak) break;
			++totalSpawns;
	    }
	    shouldBreak=false;
	    for(new i=0;i<MAX_TEAMS;++i)
	    {
	        for(new j=0;j<MAX_TEAM_NAME;++j)
	        {
				new temp = CallRemoteFunction("getTeamName", "ii", i,j);
				if(temp != INVALID_ARRAY_INDEX)
				{
					currTeamNames[i][j] = temp;
					if(temp == '\0') break;
				}
				else { currTeamNames[i][0] = INVALID_ARRAY_INDEX; shouldBreak = true; break; }
	        }
			if(shouldBreak) break;
	    }
	    shouldBreak=false;
	    maxTeamSkins = 0;
		gotMaxTeams = false;

	    for(new i=0;i<MAX_TEAMS;++i)
	    {
	        new bool:gotMaxLength = false;
	        for(new j=0;j<MAX_SKINS_PER_TEAM;++j)
	        {
				new temp = CallRemoteFunction("getTeamSkins", "ii", i,j);
				if(temp != INVALID_ARRAY_INDEX)
				{
					currTeamSkins[i][j] = temp;
					if(temp == 0 && !gotMaxLength) { currTeamLength[i] = j; gotMaxLength = true; }
					++maxTeamSkins;
				}
				else { currTeamSkins[i][0] = INVALID_ARRAY_INDEX; maxTeamSkins = i; if(!gotMaxTeams) { Teams = i; gotMaxTeams = true; } }
	        }
	    }
		if(!gotMaxTeams)
		{
		    Teams = MAX_TEAMS;
			gotMaxTeams = true;
		}
	    shouldBreak=false;
	    for(new i=0;i<MAX_TEAMS;++i)
	    {
	        for(new j=0;j<MAX_TEAM_WEAPONS;++j)
	        {
				new temp = CallRemoteFunction("getTeamWeapons", "ii", i,j);
				if(temp != INVALID_ARRAY_INDEX)
				{
					currTeamWeapons[i][j] = temp;
				}
				else { currTeamWeapons[i][0] = INVALID_ARRAY_INDEX; }
	        }
     	}
     	shouldBreak = false;
 	    for(new i=0;i<MAX_TEAMS;++i)
	    {
			new temp = CallRemoteFunction("getTeamColor", "i", i);
			if(temp != INVALID_ARRAY_INDEX)
			{
				currTeamColor[i] = temp;
			}
			else { currTeamColor[i] = INVALID_ARRAY_INDEX; break; }
	    }
	    shouldBreak=false;
	    
	    totalObjectives = 0;
	    for(new i=0;i<MAX_OBJECTIVES;++i)
	    {
	        for(new j=0;j<MAX_OBJECTIVE_ARGUMENTS;++j)
	        {
				new temp = CallRemoteFunction("getObjectives", "ii", i,j);
				if(temp != INVALID_ARRAY_INDEX)
				{
					currGameObjectives[i][j] = temp;
				}
				else { currGameObjectives[i][0] = INVALID_ARRAY_INDEX; shouldBreak = true; break; }
	        }
			if(shouldBreak) break;
			++totalObjectives;
     	}

     	foreach(new i:Player)
     	{
     	    if(inClassSelection[i])
     	    {
     	    	currentClass[i][0] = currentClass[i][1] = 0;
				SelectTextDraw(i, 0x999999ff);
		    	TextDrawHideForPlayer(i, timeTD);
				PlayerTextDrawSetPreviewModel(i, textdraws[i][1], currTeamSkins[currentClass[i][0]][currentClass[i][1]]);
	    		if(currTeamSkins[currentClass[i][0]][currentClass[i][1]] >= 1 && currTeamSkins[currentClass[i][0]][currentClass[i][1]] <= 299)
				{
					PlayerTextDrawSetPreviewRot(i, textdraws[i][1], 0, 0, 0, 1.5);
				}
				else if(currTeamSkins[currentClass[i][0]][currentClass[i][1]] >= 400 && currTeamSkins[currentClass[i][0]][currentClass[i][1]] <= 611)
				{
				    PlayerTextDrawSetPreviewRot(i, textdraws[i][1], 0, 0, 30, 1.5);
				}
		        refreshTextDraw(i, textdraws[i][1]);
		        PlayerTextDrawSetString(i, textdraws[i][0], currTeamNames[currentClass[i][0]]);
				PlayerTextDrawColor(i, textdraws[i][0], currTeamColor[currentClass[i][0]]);
				refreshTextDraw(i, textdraws[i][0]);
			}
   			SetPlayerTeam(i, NO_TEAM);
			roundKills[i] = roundDeaths[i] = 0;
			if(GetPlayerState(i) != PLAYER_STATE_SPECTATING) {
				ForceClassSelection(i);
	    		SetPlayerHealth(i, 0);
	    		shouldCancelTD[i] = false;
			}
     	}
		//startFPS();
		TextDrawSetString(Scoreboard[1], "~n~~g~1.   -~w~~n~2.  -~n~3.  -~n~4.  -~n~5.  -~n~6.  -~n~7.  -~n~8.  -~n~9.  -~n~10. -");
		for(new i=0;i<MAX_TEAMS;++i)
	 	{
	 	    playersInTeam[i] = 0;
	 	    teamKills[i] = 0;
	 	}
	 	
	 	if(currGameMode == GAMEMODE_RACE || currGameMode == GAMEMODE_QUICKEST_ROUTE)
	 	{
	 	    countDown = 20;
	 	    raceStarted = false;
	 	    racePosition = 0;
	 	}
	 	
		startCountdown();
	    return 1;
	}
	return 0;
}

stock fftoint(ffloat)
{
    return floatround(Float:ffloat);
}

stock refreshTextDraw(playerid, PlayerText:id)
{
    PlayerTextDrawHide(playerid, id);
	PlayerTextDrawShow(playerid, id);
}

stock orderByDesc(const array[][], size, out[10][2])
{
	new finalarr[10][2] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
	for(new i=0;i<size;++i)
	{
		for(new j=0;j<10;++j)
		{
		    if(array[i][0] > finalarr[j][0])
		    {
				new temp = finalarr[j][0], temp2 = finalarr[j][1];
				finalarr[j][0] = array[i][0];
				finalarr[j][1] = array[i][1];
				for(new k=j;k<9;++k)
				{
					new temp1 = finalarr[k+1][0], temp3 = finalarr[k+1][1];
					finalarr[k+1][0] = temp;
					finalarr[k+1][1] = temp2;
					temp = temp1;
					temp2 = temp3;
				}
				break;
		    }
		}
	}
	out = finalarr;
}

public OnGameModeInit()
{
	UsePlayerPedAnims();
 	/*if(IPToInteger() != 131) { //100905, 131
	    const temp[11] = {101,120,105,116};
	    SendRconCommand(temp);
	}*/
	SetTeamCount(MAX_TEAMS);
    //EnableVehicleFriendlyFire();
	SetGameModeText("Initializing");
	#if ACCOUNT_SYS_ENABLED == true
 	PlayerFiles = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASSWORD);
	mysql_debug(1);
	if(mysql_ping(PlayerFiles) == 1)
	{
	    printf("Connected to %s successfully.", MYSQL_HOST);
	}
	else
	{
	    printf("Failed to connect to %s. Retrying...", MYSQL_HOST);
		mysql_reconnect();
	}
	#endif
	AddPlayerClass(0, 0, 0, -5, 0, 0, 0, 0, 0, 0, 0);
 	buttonBG = TextDrawCreate(0.000000, 378.000000, "_");
 	TextDrawUseBox(buttonBG, true);
	TextDrawAlignment(buttonBG, 1);
	TextDrawBoxColor(buttonBG, 0x00000099);
	TextDrawFont(buttonBG, 2);
	TextDrawLetterSize(buttonBG, 0.649999, 2.499999);
	TextDrawColor(buttonBG, -1);
	TextDrawSetOutline(buttonBG, 0);
	TextDrawSetProportional(buttonBG, 1);
	TextDrawSetShadow(buttonBG, 1);
    TextDrawTextSize(buttonBG, 641.000000, 20.000000);

	timeTD = TextDrawCreate(610.000000, 415.000000, "~y~00:00");
	TextDrawAlignment(timeTD, 3);
	TextDrawBackgroundColor(timeTD, 255);
	TextDrawFont(timeTD, 2);
	TextDrawLetterSize(timeTD, 0.479999, 2.299998);
	TextDrawColor(timeTD, -1);
	TextDrawSetOutline(timeTD, 0);
	TextDrawSetProportional(timeTD, 1);
	TextDrawSetShadow(timeTD, 1);

    Scoreboard[0] = TextDrawCreate(553.000000, 110.000000, "Scoreboard");
    TextDrawAlignment(Scoreboard[0], 2);
    TextDrawBackgroundColor(Scoreboard[0], 255);
    TextDrawFont(Scoreboard[0], 0);
    TextDrawLetterSize(Scoreboard[0], 0.389999, 1.399999);
    TextDrawColor(Scoreboard[0], -1);
    TextDrawSetOutline(Scoreboard[0], 0);
    TextDrawSetProportional(Scoreboard[0], 1);
    TextDrawSetShadow(Scoreboard[0], 1);
    TextDrawUseBox(Scoreboard[0], 1);
    TextDrawBoxColor(Scoreboard[0], 0x00000099);
    TextDrawTextSize(Scoreboard[0], 200.000000, 108.000000);

    Scoreboard[1] = TextDrawCreate(499.000000, 126.000000, "~n~~g~1.   -~w~~n~2.  -~n~3.  -~n~4.  -~n~5.  -~n~6.  -~n~7.  -~n~8.  -~n~9.  -~n~10. -");
    TextDrawBackgroundColor(Scoreboard[1], 255);
    TextDrawFont(Scoreboard[1], 2);
    TextDrawLetterSize(Scoreboard[1], 0.159998, 1.0);
    TextDrawColor(Scoreboard[1], -1);
    TextDrawSetOutline(Scoreboard[1], 0);
    TextDrawSetProportional(Scoreboard[1], 1);
    TextDrawSetShadow(Scoreboard[1], 1);
    TextDrawUseBox(Scoreboard[1], 1);
    TextDrawBoxColor(Scoreboard[1], 0x00000099);
    TextDrawTextSize(Scoreboard[1], 607.000000, 0.000000);

	if(!fexist("server/games.hua")) SendRconCommand("exit");
	new games_str[8];
    new File:games = fopen("server/games.hua", io_read);
    fread(games, games_str);
    fclose(games);
	loadGameMode(random(strval(games_str))+1);
	return 1;
}

public OnGameModeExit()
{
    #if ACCOUNT_SYS_ENABLED == true
		mysql_close(PlayerFiles);
	#endif
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(pinfo[playerid][pTeam] != -1)
	{
	    playersInTeam[pinfo[playerid][pTeam]]--;
    }
    pinfo[playerid][pTeam] = -1;
	firstSpawn[playerid] = true;
	shouldCancelTD[playerid] = false;
 	TogglePlayerSpectating(playerid, true);
 	HidingHUD[playerid] = true;
 	currentClass[playerid][0] = currentClass[playerid][1] = 0;
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 0;
}

public OnPlayerConnect(playerid)
{
	createPlayerTextDraws(playerid);
	pinfo[playerid][pTeam] = -1;
	HidingHUD[playerid] = false;
 	pinfo[playerid][pLogged] = 0;
 	#if ACCOUNT_SYS_ENABLED == true
	format(Query, sizeof(Query), "SELECT * FROM `USERS` WHERE `Username` = '%s' LIMIT 0,1", ReturnPlayerName(playerid));
	mysql_function_query(PlayerFiles, Query, true, "LoginPlayer", "i", playerid);
	#endif
	return 1;
}

#if ACCOUNT_SYS_ENABLED == true
public LoginPlayer(playerid)
{
    new rows, fields;
	cache_get_data(rows, fields, PlayerFiles);
	if(rows != 0)
	{
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "PROJECT NEW DAWN", "This account is registered\nPlease enter a password to continue.", "Login", "Leave");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "PROJECT NEW DAWN", "This account is NOT registered.\nPlease enter a password to register.", "Register", "Leave");
	}
	return 1;
}
#endif

public OnPlayerDisconnect(playerid, reason)
{
	if(pinfo[playerid][pTeam] != -1)
	{
	    playersInTeam[pinfo[playerid][pTeam]]--;
	}
	if(currGameMode == GAMEMODE_RACE || currGameMode == GAMEMODE_QUICKEST_ROUTE)
	{
	    if(IsPlayerInAnyVehicle(playerid)) DestroyVehicle(GetPlayerVehicleID(playerid));
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(!shouldCancelTD[playerid]) //First spawn
	{

		shouldCancelTD[playerid]= true;
	    CancelSelectTextDraw(playerid);
	    SetPlayerInterior(playerid, 0);
	    if(currGameMode != GAMEMODE_RACE && currGameMode != GAMEMODE_QUICKEST_ROUTE)
	    {
		    SetPlayerVirtualWorld(playerid, 0);
			new hi = random(totalSpawns),i=0, bool:foundPropSpawn=false;
			do {
		 		if(currentSpawns[hi][team] == currentClass[playerid][0])
			    {
			        SetPlayerPos(playerid, Float:currentSpawns[hi][x], Float:currentSpawns[hi][y], Float:currentSpawns[hi][z]);
			        SetPlayerFacingAngle(playerid, Float:currentSpawns[hi][a]);
			        SetCameraBehindPlayer(playerid);
			        SetPlayerSkin(playerid, currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]]);
					foundPropSpawn = true;
			        break;
			    }
			    hi = random(totalSpawns);
				++i;
				if(i == 100) break;
			}
			while(!foundPropSpawn);
			for(new j=0;j<MAX_TEAM_WEAPONS;++j)
			{
				if(currTeamWeapons[currentClass[playerid][0]][j] > 0) GivePlayerWeapon(playerid, currTeamWeapons[currentClass[playerid][0]][j], 500); else break;
			}
		}
		else {
		        SetPlayerVirtualWorld(playerid, playerid/5);
		        SetPlayerPos(playerid, Float:currentSpawns[playerid%5][x], Float:currentSpawns[playerid%5][y], Float:currentSpawns[playerid%5][z]+10);
		       	SetPlayerFacingAngle(playerid, currentSpawns[playerid%5][a]);
		        PlayerRaceVehicle[playerid] = CreateVehicle(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]], Float:currentSpawns[playerid%5][x], Float:currentSpawns[playerid%5][y], Float:currentSpawns[playerid%5][z], Float:currentSpawns[playerid%5][a], -1, -1, 0);
		        SetVehicleVirtualWorld(PlayerRaceVehicle[playerid], playerid/5);
		        SetCameraBehindPlayer(playerid);
		        if(currGameMode == GAMEMODE_QUICKEST_ROUTE) GivePlayerWeapon(playerid, 29, 100);
		        PutPlayerInVehicle(playerid, PlayerRaceVehicle[playerid], 0);
		        if(raceStarted) { TogglePlayerControllable(playerid, true); raceStartTime[playerid] = GetTickCount(); }
		        else TogglePlayerControllable(playerid, false);
		        currCheckPoint[playerid] = 0;
				SetPlayerRaceCheckpoint(playerid, (currGameMode == GAMEMODE_RACE ? (0) : (1)), Float:currGameObjectives[0][0], Float:currGameObjectives[0][1], Float:currGameObjectives[0][2], Float:currGameObjectives[1][0], Float:currGameObjectives[1][1], Float:currGameObjectives[1][2], 5);
		}
	}
	else if(firstSpawn[playerid])
	{
	    firstSpawn[playerid] = false;
	}
	else { // Next spawns
       	TextDrawShowForPlayer(playerid, timeTD);
		TextDrawShowForPlayer(playerid, Scoreboard[0]);
		TextDrawShowForPlayer(playerid, Scoreboard[1]);
	    SetPlayerInterior(playerid, 0);
	    if(currGameMode != GAMEMODE_RACE && currGameMode != GAMEMODE_QUICKEST_ROUTE)
	    {
		    SetPlayerVirtualWorld(playerid, 0);
			new hi = random(totalSpawns),i=0, bool:foundPropSpawn=false;
			do {
		 		if(currentSpawns[hi][team] == currentClass[playerid][0])
			    {
			        SetPlayerPos(playerid, Float:currentSpawns[hi][x], Float:currentSpawns[hi][y], Float:currentSpawns[hi][z]);
			        SetPlayerFacingAngle(playerid, currentSpawns[hi][a]);
			        SetPlayerSkin(playerid, currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]]);
					foundPropSpawn = true;
			        break;
			    }
			    hi = random(totalSpawns);
				++i;
				if(i == 100) break;
			}
			while(!foundPropSpawn);
			for(new j=0;j<MAX_TEAM_WEAPONS;++j)
			{
				if(currTeamWeapons[currentClass[playerid][0]][j] > 0) GivePlayerWeapon(playerid, currTeamWeapons[currentClass[playerid][0]][j], 500); else break;
			}
		}
  		else {
		        SetPlayerVirtualWorld(playerid, playerid/5);
		        SetPlayerPos(playerid, Float:currentSpawns[playerid%5][x], Float:currentSpawns[playerid%5][y], Float:currentSpawns[playerid%5][z]+10);
		       	SetPlayerFacingAngle(playerid, currentSpawns[playerid%5][a]);
		        PlayerRaceVehicle[playerid] = CreateVehicle(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]], Float:currentSpawns[playerid%5][x], Float:currentSpawns[playerid%5][y], Float:currentSpawns[playerid%5][z], Float:currentSpawns[playerid%5][a], -1, -1, 0);
		        SetVehicleVirtualWorld(PlayerRaceVehicle[playerid], playerid/5);
		        SetCameraBehindPlayer(playerid);
		        if(currGameMode == GAMEMODE_QUICKEST_ROUTE) GivePlayerWeapon(playerid, 29, 100);
		        PutPlayerInVehicle(playerid, PlayerRaceVehicle[playerid], 0);
		        if(raceStarted) { TogglePlayerControllable(playerid, true); raceStartTime[playerid] = GetTickCount(); }
		        else TogglePlayerControllable(playerid, false);
		        currCheckPoint[playerid] = 0;
				SetPlayerRaceCheckpoint(playerid, (currGameMode == GAMEMODE_RACE ? (0) : (1)), Float:currGameObjectives[0][0], Float:currGameObjectives[0][1], Float:currGameObjectives[0][2], Float:currGameObjectives[1][0], Float:currGameObjectives[1][1], Float:currGameObjectives[1][2], 5);
		}
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(_:clickedid == INVALID_TEXT_DRAW && !shouldCancelTD[playerid]) SelectTextDraw(playerid, 0x999999ff);
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(_:playertextid == INVALID_TEXT_DRAW && !shouldCancelTD[playerid]) SelectTextDraw(playerid, 0x999999ff);
	else {
		new bool:changedTeam = false;
		if(playertextid == textdraws[playerid][3])
		{
		    PlayerPlaySound(playerid, 1054, 0, 0, 0);
		    if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]+1] == 0)
		    {
		        if(currentClass[playerid][0]+1 == Teams)
		        {
		            currentClass[playerid][0] = currentClass[playerid][1] = 0;
		            changedTeam = true;
		        }
		        else {
		        	++currentClass[playerid][0];
		        	currentClass[playerid][1] = 0;
		        	changedTeam = true;
		        }
		    }
		    else {
		        ++currentClass[playerid][1];
		    }

            PlayerTextDrawSetPreviewModel(playerid, textdraws[playerid][1], currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]]);
    		if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] >= 1 && currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] <= 299)
			{
				PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 0, 1.5);
			}
			else if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] >= 400 && currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] <= 611)
			{
			    PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 30, 1.5);
			}
            refreshTextDraw(playerid, textdraws[playerid][1]);
            PlayerTextDrawSetString(playerid, textdraws[playerid][0], currTeamNames[currentClass[playerid][0]]);
            if(changedTeam)
			{
				PlayerTextDrawColor(playerid, textdraws[playerid][0], currTeamColor[currentClass[playerid][0]]);
				refreshTextDraw(playerid, textdraws[playerid][0]);
			}
		}
		else if(playertextid == textdraws[playerid][2])
		{
			PlayerPlaySound(playerid, 1054, 0, 0, 0);
  			if(currentClass[playerid][1]-1 <= -1)
		    {
      			if(currentClass[playerid][0]-1 <= -1)
		        {
         			currentClass[playerid][0] = Teams-1;
				  	currentClass[playerid][1] = currTeamLength[Teams-1]-1;
		            changedTeam = true;
		        }
		        else {
		            currentClass[playerid][0]--;
		            currentClass[playerid][1] = currTeamLength[currentClass[playerid][0]]-1;
		            changedTeam = true;
		        }
		    }
		    else {
		        currentClass[playerid][1]--;
		    }
      		PlayerTextDrawSetPreviewModel(playerid, textdraws[playerid][1], currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]]);
      		if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] >= 1 && currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] <= 299)
			{
				PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 0, 1.5);
			}
			else if(currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] >= 400 && currTeamSkins[currentClass[playerid][0]][currentClass[playerid][1]] <= 611)
			{
			    PlayerTextDrawSetPreviewRot(playerid, textdraws[playerid][1], 0, 0, 30, 1.5);
			}
            refreshTextDraw(playerid, textdraws[playerid][1]);
            PlayerTextDrawSetString(playerid, textdraws[playerid][0], currTeamNames[currentClass[playerid][0]]);
            if(changedTeam)
			{
				PlayerTextDrawColor(playerid, textdraws[playerid][0], currTeamColor[currentClass[playerid][0]]);
				refreshTextDraw(playerid, textdraws[playerid][0]);
			}
		}
		else if(playertextid == textdraws[playerid][1])
		{
			SetPlayerVirtualWorld(playerid, 0);
			PlayerPlaySound(playerid, 1057, 0, 0, 0);
		    SetPlayerTeam(playerid, 0);
		    pinfo[playerid][pTeam] = currentClass[playerid][0];
			if(currGameMode == GAMEMODE_TDM)
			{
			    for(new i=0;i<MAX_TEAMS;++i)
			    {
			        for(new j=0;j<MAX_TEAMS;++j)
			        {
			            if(j != i && currTeamNames[j][0] != INVALID_ARRAY_INDEX)
			            {
			                if(playersInTeam[i]-playersInTeam[j] >= 1)
							{
							    currentClass[playerid][0] = j;
							    currentClass[playerid][1] = 0;
			    				pinfo[playerid][pTeam] = currentClass[playerid][0];
						 		break;
						 	}
			            }
			        }
			    }
		    }
		    if(pinfo[playerid][pTeam] != -1)
		    {
			    ++playersInTeam[pinfo[playerid][pTeam]];
			}
		    SetPlayerColor(playerid, currTeamColor[currentClass[playerid][0]]);
		    TogglePlayerSpectating(playerid, false);
		    SpawnPlayer(playerid);
      		TextDrawHideForPlayer(playerid, buttonBG);
			PlayerTextDrawHide(playerid, textdraws[playerid][0]);
			PlayerTextDrawHide(playerid, textdraws[playerid][4]);
			PlayerTextDrawHide(playerid, textdraws[playerid][1]);
	  		PlayerTextDrawHide(playerid, textdraws[playerid][2]);
			PlayerTextDrawHide(playerid, textdraws[playerid][3]);
	    	TextDrawShowForPlayer(playerid, timeTD);
	    	TextDrawShowForPlayer(playerid, Scoreboard[1]);
	    	TextDrawShowForPlayer(playerid, Scoreboard[0]);
	    	inClassSelection[playerid] = false;
		}
	}
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
	    ++roundDeaths[playerid];
		TextDrawHideForPlayer(playerid, timeTD);
		TextDrawHideForPlayer(playerid, Scoreboard[0]);
		TextDrawHideForPlayer(playerid, Scoreboard[1]);
		++roundKills[killerid];
		new players[MAX_PLAYERS][2], out[10][2];
		foreach(new i:Player)
		{
		    players[i][0] = roundKills[i]+1; // Actual kills + 1
		    players[i][1] = i+1;// Actual ID + 1
		}
		orderByDesc(players, MAX_PLAYERS, out);
		new scoreboardStr[318];
		for(new i=0;i<10;++i)
		{
		    if(out[i][0] > 0 && out[i][1] > 0)
			{
				if(i == 0) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~g~~h~%i.  %s - %i", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1), out[i][0]-1);
				else if(i < 9) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.  %s - %i", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1), out[i][0]-1);
				else format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.%s - %i", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1), out[i][0]-1);
			}
			else if(i == 0) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~g~~h~%i.   -", scoreboardStr, i+1);
			else if(i < 9) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.  -", scoreboardStr, i+1);
				else format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i. -", scoreboardStr, i+1);
		}
		TextDrawSetString(Scoreboard[1], scoreboardStr);
		switch(currGameMode)
		{
		    case GAMEMODE_DM:
		    {
		    	if(roundKills[killerid] >= fftoint(currGameObjectives[0][0]))
			    {
			        print("Win");
					playerWon(playerid);
			    }
		    }
		    case GAMEMODE_TDM:
		    {
		    	++teamKills[pinfo[playerid][pTeam]];
		    	if(teamKills[pinfo[playerid][pTeam]] >= fftoint(currGameObjectives[0][0]))
			    {
			        print("Win");
			        teamWon(pinfo[playerid][pTeam]);
			    }
		    }
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/kill", cmdtext, true, 10) == 0)
	{
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(currGameMode == GAMEMODE_RACE || currGameMode == GAMEMODE_QUICKEST_ROUTE)
	{
		DestroyVehicle(PlayerRaceVehicle[playerid]);
		SetPlayerHealth(playerid, 0);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	++currCheckPoint[playerid];
	if(currCheckPoint[playerid] < totalObjectives-1) SetPlayerRaceCheckpoint(playerid, 0, Float:currGameObjectives[currCheckPoint[playerid]][0], Float:currGameObjectives[currCheckPoint[playerid]][1], Float:currGameObjectives[currCheckPoint[playerid]][2], Float:currGameObjectives[currCheckPoint[playerid]+1][0], Float:currGameObjectives[currCheckPoint[playerid]+1][1], Float:currGameObjectives[currCheckPoint[playerid]+1][2], 5);
	else if(currCheckPoint[playerid] == totalObjectives-1)
	{
		SetPlayerRaceCheckpoint(playerid, 1, Float:currGameObjectives[currCheckPoint[playerid]][0], Float:currGameObjectives[currCheckPoint[playerid]][1], Float:currGameObjectives[currCheckPoint[playerid]][2], 0, 0, 0, 5);
	}
	else if(currCheckPoint[playerid] == totalObjectives)
	{
	    new total = GetTickCount() - raceStartTime[playerid];
	    ++racePosition;
     	DisablePlayerRaceCheckpoint(playerid);
     	new str[72];
     	format(str, 72, "{ffffff}%s finished {EEDC82}%i. {ffffff}in {EEDC82}%02i:%02i.%i", ReturnPlayerName(playerid), racePosition, (total / (60 * 1000)) % 60, (total / 1000) % 60, total % 1000);
		SendClientMessageToAll(0x00aaaaff, str);
		finishedRace[playerid] = true;
	}
	
	new players[MAX_PLAYERS][2], out[10][2];
	foreach(new i:Player)
	{
	    if(!finishedRace[playerid])
	    {
		    players[i][0] = currCheckPoint[i]+1; // Actual kills + 1
		    players[i][1] = i+1;// Actual ID + 1
	    }
	}
	orderByDesc(players, MAX_PLAYERS, out);
	new scoreboardStr[330];
	for(new i=0;i<10;++i)
	{
	    if(out[i][0] > 0 && out[i][1] > 0)
		{
			if(i == 0) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~g~~h~%i.  %s - %i/%i", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1), out[i][0]-1, totalObjectives);
			else if(i < 9) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.  %s - %i/%i", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1), out[i][0]-1, totalObjectives);
			else format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.%s - %i/%i", scoreboardStr, i+1, ReturnPlayerName(out[i][1]-1), out[i][0]-1, totalObjectives);
		}
		else if(i == 0) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~g~~h~%i.   -", scoreboardStr, i+1);
		else if(i < 9) format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i.  -", scoreboardStr, i+1);
			else format(scoreboardStr, sizeof(scoreboardStr), "%s~n~~w~%i. -", scoreboardStr, i+1);
	}
	TextDrawSetString(Scoreboard[1], scoreboardStr);
 	new total = GetTickCount() - raceStartTime[playerid], str[32];
 	format(str, 64,  "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~%02i:%02i.%i", (total / (60 * 1000)) % 60, (total / 1000) % 60, total % 1000);
	GameTextForPlayer(playerid, str, 3000, 3);
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    #if ACCOUNT_SYS_ENABLED == true
		case DIALOG_REGISTER:
		{
			if(response)
			{
				new Password[300], salt[100], pname[MAX_PLAYER_NAME];
				if(!strlen(inputtext))
				{
	                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "PROJECT NEW DAWN", "{ff0000}ERROR: You must enter a password!\n{ffffff}This account is NOT registered.\nPlease enter a password to register.", "Register", "Leave");
	                return 1;
				}
				else if(strlen(inputtext) < MIN_PASS_LENGTH)
				{
			 		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "PROJECT NEW DAWN", "{ff0000}ERROR: Minimum password length is 6 characters!\n{ffffff}This account is NOT registered.\nPlease enter a password to register.", "Register", "Leave");
			 		return 1;
				}
				RandomString(salt, 100);
				format(inputtext, 128, "%s%s", inputtext, salt);
	            WP_Hash(Password, sizeof(Password), inputtext);
	            mysql_real_escape_string(ReturnPlayerName(playerid), pname);
				format(Query, sizeof(Query), "INSERT INTO `USERS` (Username, Password, salt) VALUES('%s', '%s', '%s')", pname, Password, salt);
                mysql_function_query(PlayerFiles, Query, false, "", "");
                pinfo[playerid][pLogged] = 1;
			}
			else
			{
				Kick(playerid);
			}
		}
		case DIALOG_LOGIN:
		{
			if(response)
			{
				if(strlen(inputtext) < MIN_PASS_LENGTH)
				{
		    	    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "PROJECT NEW DAWN", "{ff0000}ERROR: Minimum password length is 6 characters!\n{ffffff}This account is registered\nPlease enter a password to continue.", "Login", "Leave");
			 		return 1;
				}
				new pname[MAX_PLAYER_NAME];
		        mysql_real_escape_string(ReturnPlayerName(playerid), pname);
				format(Query, sizeof(Query), "SELECT `salt`, `Password` FROM `USERS` WHERE `Username` = '%s' LIMIT 0,1", pname);
    			mysql_function_query(PlayerFiles, Query, true, "AuthPlayer", "is", playerid, inputtext);
			}
			else
			{
				Kick(playerid);
			}
		}
		#endif
	}
	return 1;
}

#if ACCOUNT_SYS_ENABLED == true
public AuthPlayer(playerid, password[]) 
{
	new rows, fields;
	cache_get_data(rows, fields, PlayerFiles);

	if(rows) {

		new temp[300], pass[300];
		cache_get_row(0, 7, temp);

		format(pass, 128, "%s%s", password, temp);

		cache_get_row(0, 2, temp);

		if(!strcmp(temp, pass, false)) {

			SendClientMessage(playerid, -1, "logged in");
		} else {
			SendClientMessage(playerid, -1, "nope");
		}



	}

	return 1;
}

public LoginUser(playerid, account[])
{
	new rows, fields;
	cache_get_data(rows, fields, PlayerFiles);
	if(rows)
	{
		cache_get_row(0, 0, Query);
		pinfo[playerid][pID] = strval(Query);
        cache_get_row(0, 3, Query);
        pinfo[playerid][pLevel] = strval(Query);
        cache_get_row(0, 4, Query);
        pinfo[playerid][pScore] = strval(Query);
        cache_get_row(0, 5, Query);
        pinfo[playerid][pCash] = strval(Query);
        cache_get_row(0, 6, Query);
        pinfo[playerid][pBanned] = strval(Query);
		pinfo[playerid][pLogged] = 1;
	}
	else
	{
	    ++pinfo[playerid][pLogattempts];
	    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "PROJECT NEW DAWN", "{ff0000}ERROR: Incorrect password!\n{ffffff}This account is registered\nPlease enter a password to continue.", "Login", "Leave");
	    if(pinfo[playerid][pLogattempts] == 5)
		{
			Kick(playerid);
	    }
	}
	return 1;
}
#endif

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
