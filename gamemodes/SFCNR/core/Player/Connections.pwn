#include <YSI\y_hooks>

new pIP[MAX_PLAYERS][15];

hook OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, PlayerName[playerid], 24);

	format(G_String, 128, "%s has joined San Fierro Cops And Robbers %s", PlayerName[playerid], SERVER_VERSION);
	SendClientMessageToAll(COLOR_GREY, G_String);

	GetPlayerIp(playerid, pIP[playerid], 15);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	switch(reason)//How did they leave?
	{
	    case 0: format(G_String, 128, "%s Has left the server. (Timeout)", PlayerName[playerid]);
	    case 1: format(G_String, 128, "%s Has left the server. (Leaving)", PlayerName[playerid]);
	    case 2: format(G_String, 128, "%s Has left the server. (Kicked/Banned)", PlayerName[playerid]);
	}

	SendClientMessageToAll(COLOR_GREY, G_String);//Lets inform everyone
	return 1;
}

CMD:tppls(playerid, params[])
{
	SetPlayerPos(playerid, 322.2700000,119.8400000,1005.6100000);
	return 1;
}

CMD:createmepickup(playerid, params[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	CreateDynamicPickup(1274, 1, pos[0], pos[1], pos[2]);
	return 1;
}