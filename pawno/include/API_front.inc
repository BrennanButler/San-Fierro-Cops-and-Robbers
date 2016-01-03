#include <float>

#define MAX_TEAMS 2
#define MAX_SKINS_PER_TEAM 6
#define MAX_TEAM_NAME 32
#define MAX_TEAM_WEAPONS 8
#define INVALID_ARRAY_INDEX 65535
#define MAX_GAME_NAME 32
#define GAMEMODE_DM 0 //DM
#define GAMEMODE_TDM 1 //Team DM
#define GAMEMODE_RACE 2 //Race
#define GAMEMODE_QUICKEST_ROUTE 3 //Quickest route

#define GAMEMODE_OTHER -1

enum TeamInfo
{
	TeamName[MAX_TEAM_NAME],
	TeamSkins[MAX_SKINS_PER_TEAM],
	TeamWeapons[MAX_TEAM_WEAPONS],
	TeamColor
}

enum SpawnInfo
{
	Float:x,
	Float:y,
	Float:z,
	Float:a,
	vehiclemodel,
	team
}

new gameName[MAX_GAME_NAME] = GAME_NAME;
forward isGameLoaded();
forward getGameName(index);
forward getGameMode();
forward OnGameLoaded();
forward OnGameChange();
forward getSpawns(index, jdex);
forward getTeamName(index, jdex);
forward getTeamSkins(index, jdex);
forward getTeamWeapons(index, jdex);
forward getTeamColor(index);
forward getGameTime();
forward getObjectives(index, jdex);

public getTeamColor(index)
{
	if(index >= sizeof(gameTeams))
	{
	    return INVALID_ARRAY_INDEX;
	}
	else return gameTeams[index][TeamColor];
}

public getTeamWeapons(index, jdex)
{
	if(index >= sizeof(gameTeams))
	{
	    return INVALID_ARRAY_INDEX;
	}
	else return gameTeams[index][TeamWeapons][jdex];
}

public getObjectives(index, jdex)
{
	if(index >= sizeof(gameObjectives))
	{
	    return INVALID_ARRAY_INDEX;
	}
	else return _:gameObjectives[index][jdex];
}

public getTeamSkins(index, jdex)
{
	if(index >= sizeof(gameTeams))
	{
	    return INVALID_ARRAY_INDEX;
	}
	else
	{
		 return (gameTeams[index][TeamSkins][jdex]);
 	}
}

public getTeamName(index, jdex)
{
	if(index >= sizeof(gameTeams))
	{
	    return INVALID_ARRAY_INDEX;
	}
	else return gameTeams[index][TeamName][jdex];
}

public getSpawns(index, jdex)
{
	if(index >= sizeof(gameSpawns))
	{
	    return INVALID_ARRAY_INDEX;
	}
	else
	{
		switch(jdex)
		{
		    case 0:
		        {
		            return _:gameSpawns[index][x];
		        }
		    case 1:
		        {
		            return _:gameSpawns[index][y];
		        }
		    case 2:
		        {
		            return _:gameSpawns[index][z];
		        }
			case 3:
				{
				    return _:gameSpawns[index][a];
				}
		    case 4:
		        {
		            return gameSpawns[index][vehiclemodel];
		        }
		    case 5:
		        {
		            return gameSpawns[index][team];
		        }
			default:
				{
				    return INVALID_ARRAY_INDEX;
				}
		}
	}
	return 0;
}

public isGameLoaded()
{
	return true;
}

public getGameTime()
{
	return GAME_TIME;
}

public getGameName(index)
{
	return gameName[index];
}

public getGameMode()
{
	return GAME_MODE;
}