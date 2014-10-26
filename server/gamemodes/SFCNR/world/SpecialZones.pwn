#include <YSI\y_hooks>

new 
	Zones[10],

	Float:RestrictiveArmy[] = 
	{
		-1547.0,482.0,
		-1480.0,483.0,
		-1481.0,516.0,
		-1221.0,516.0,
		-1227.0,348.0,
		-1282.0,291.0,
		-1408.0,291.0,
		-1412.0,259.0,
		-1735.0,259.0,
		-1690.0,319.0,
		-1646.0,356.0,
		-1603.0,404.0,
		-1580.0,429.0,
		-1547.0,482.0
	}; 


hook OnGameModeInit()
{
	printf("Creating polygon area");
	Zones[0] = CreateDynamicPolygon(RestrictiveArmy, 5.0, 15.0, sizeof(RestrictiveArmy));

	printf("Zones[0] = %d", Zones[0]);
	printf("valid : %d", IsValidDynamicArea(Zones[0]));
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	TogglePlayerDynamicArea(playerid, Zones[0], true);
	return 1;
}

hook OnPlayerEnterDynamicArea(playerid, areaid)
{
	printf("Entered a dynamic area");
	if(areaid == Zones[0])
	{
		SendClientMessage(playerid, -1, "Faggot get out my zone ye twat ill bash ur head in i swear on me mom");
	}
	return 1;
}


CMD:area(playerid, params[])
{
	SetPlayerPos(playerid, -1282.0,291.0, 3.0);
	return 1;
}